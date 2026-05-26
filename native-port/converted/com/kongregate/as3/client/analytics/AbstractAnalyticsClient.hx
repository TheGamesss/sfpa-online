package com.kongregate.as3.client.analytics;

import com.kongregate.as3.client.services.AnalyticsServices;
import com.kongregate.as3.common.util.Log;
import flash.events.Event;
import flash.events.HTTPStatusEvent;

class AbstractAnalyticsClient implements AnalyticsClient
{
    
    private static inline var MAX_EVENT_BACKLOG : Int = 100;
    
    private static inline var MAX_RETRIES : Int = 2;
    
    private static var TRANSIENT_PROPERTIES : Array<Dynamic> = [AnalyticsServices.KONG_ANALYTICS_RETRY_COUNT, AnalyticsServices.KONG_ANALYTICS_AUTO_EVENT];
    
    private var mErrorHandled : Bool = false;
    
    public function new()
    {
        super();
    }
    
    public function handlesEvent(eventName : String) : Bool
    {
        return true;
    }
    
    public function sendEvents(events : Array<Dynamic>, complete : Dynamic) : Void
    {
        this.pruneEvents(events);
    }
    
    private function pruneEvents(events : Array<Dynamic>) : Void
    {
        if (cast(events, Bool) && events.length > MAX_EVENT_BACKLOG)
        {
            events.splice(0, events.length - MAX_EVENT_BACKLOG);
        }
    }
    
    private function createErrorHandler(pendingEvents : Array<Dynamic>, callback : Dynamic, numEvents : Int) : Dynamic
    {
        this.mErrorHandled = false;
        return function(e : Event) : Void
        {
            var statusEvent : Dynamic = try cast(e, HTTPStatusEvent) catch(e:Dynamic) null;
            if (statusEvent != null)
            {
                if (statusEvent.status >= 200 && statusEvent.status < 300 || statusEvent.status == 0)
                {
                    return;
                }
                Log.debug("HTTP status: " + statusEvent.status);
            }
            Log.error("Error while processing analytics event: " + Std.string(e));
            handleError(pendingEvents, callback, numEvents);
        };
    }
    
    private function handleFatalError(pendingEvents : Array<Dynamic>, callback : Dynamic, numEvents : Int) : Void
    {
        this.handleError(pendingEvents, callback, numEvents, true);
    }
    
    private function handleError(pendingEvents : Array<Dynamic>, callback : Dynamic, numEvents : Int, fatal : Bool = false) : Void
    {
        var pendingEvent : Dynamic = null;
        var retryCount : Int = 0;
        if (this.mErrorHandled)
        {
            Log.debug("Analtyics error already handled, ignoring");
            return;
        }
        this.mErrorHandled = true;
        var i : Int = 0;
        while (i < numEvents && i < pendingEvents.length)
        {
            pendingEvent = pendingEvents[i];
            if (pendingEvent != null)
            {
                retryCount = as3hx.Compat.parseInt((pendingEvent.event.retry_count || 0) + ((fatal) ? MAX_RETRIES + 1 : 1));
                pendingEvent.event.retry_count = retryCount;
            }
            i++;
        }
        this.cleanupEvents(pendingEvents);
        callback && callback({
                    success : false
                });
    }
    
    private function cleanupEvents(pendingEvents : Array<Dynamic>, indexesToRemove : Array<Dynamic> = null) : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(pendingEvents.length - 1);
        while (i >= 0)
        {
            if (Reflect.field(pendingEvents, Std.string(i)).event.retry_count > MAX_RETRIES)
            {
                Log.debug("Event " + Reflect.field(pendingEvents, Std.string(i)).name + " is over max retry count, deleting it");
                pendingEvents.splice(i, 1);
            }
            else if (cast(indexesToRemove, Bool) && Lambda.indexOf(indexesToRemove, i) >= 0)
            {
                pendingEvents.splice(i, 1);
            }
            i--;
        }
    }
    
    private function removeTransientProperties(evt : Dynamic) : Void
    {
        var transientProperty : String = null;
        for (transientProperty in TRANSIENT_PROPERTIES)
        {
            if (Reflect.field(evt, Std.string(transientProperty)) != null)
            {
                Reflect.deleteField(evt, Std.string(transientProperty));
            }
        }
    }
}


