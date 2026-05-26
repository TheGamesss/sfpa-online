package com.kongregate.as3.client.analytics;

import flash.errors.Error;
import com.adobe.serialization.json.JSON;
import com.kongregate.as3.common.util.BetterURLLoader;
import com.kongregate.as3.common.util.Log;
import com.kongregate.as3.common.util.Utils;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.net.URLRequestMethod;

class KeenClient extends AbstractAnalyticsClient
{
    
    private var mWriteKey : String;
    
    private var mProjectId : String;
    
    public function new(projectId : String, writeKey : String)
    {
        super();
        this.mWriteKey = writeKey;
        this.mProjectId = projectId;
    }
    
    override public function handlesEvent(event : String) : Bool
    {
        return event.indexOf("swrve.") != 0;
    }
    
    override public function sendEvents(events : Array<Dynamic>, complete : Dynamic) : Void
    {
        var contentType : URLRequestHeader;
        var authorization : URLRequestHeader;
        var request : URLRequest;
        var data : Dynamic;
        var i : Int;
        var errorHandler : Dynamic;
        var mappings : Dynamic = null;
        var loader : URLLoader = null;
        var numEvents : Int = 0;
        var event : Dynamic = null;
        var e : Dynamic = null;
        super.sendEvents(events, complete);
        contentType = new URLRequestHeader("Content-type", "application/json");
        authorization = new URLRequestHeader("Authorization", this.mWriteKey);
        request = new URLRequest("https://api.keen.io/3.0/projects/" + this.mProjectId + "/events");
        request.requestHeaders.push(contentType);
        request.requestHeaders.push(authorization);
        data = { };
        mappings = { };
        for (i in 0...events.length)
        {
            event = events[i];
            Reflect.setField(data, Std.string(event.name), Reflect.field(data, Std.string(event.name)) || []);
            Reflect.setField(mappings, Std.string(event.name), Reflect.field(mappings, Std.string(event.name)) || []);
            e = Utils.merge({ }, event.event);
            removeTransientProperties(e);
            Reflect.field(data, Std.string(event.name)).push(e);
            Reflect.field(mappings, Std.string(event.name)).push(i);
        }
        request.data = com.adobe.serialization.json.JSON.encode(data);
        request.method = URLRequestMethod.POST;
        loader = new BetterURLLoader();
        loader.dataFormat = URLLoaderDataFormat.TEXT;
        loader.load(request);
        numEvents = as3hx.Compat.parseInt(events.length);
        errorHandler = createErrorHandler(events, complete, numEvents);
        loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
        loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, errorHandler);
        loader.addEventListener(Event.COMPLETE, function(e : Event) : Void
                {
                    try
                    {
                        Log.debug("Keen submission complete");
                        processResponse(events, mappings, com.adobe.serialization.json.JSON.decode(loader.data));
                        complete({
                                    success : true
                                });
                    }
                    catch (e : Error)
                    {
                        Log.error("Error while processing keen result: " + e + ", deleting " + numEvents + " event(s), data:" + loader.data);
                        handleFatalError(events, complete, numEvents);
                    }
                });
    }
    
    private function processResponse(events : Array<Dynamic>, mappings : Dynamic, response : Dynamic) : Void
    {
        var eventName : String = null;
        var results : Array<Dynamic> = null;
        var indexesToRemove : Array<Dynamic> = null;
        var i : Int = 0;
        var idx : Int = 0;
        var pendingEvent : Dynamic = null;
        if (cast(response.error_code, Bool) && cast(response.message, Bool))
        {
            throw new Error("Keen response had error_code and message");
        }
        for (eventName in Reflect.fields(response))
        {
            results = Reflect.field(response, eventName);
            indexesToRemove = [];
            for (i in 0...results.length)
            {
                idx = as3hx.Compat.parseInt(Reflect.field(Reflect.field(mappings, eventName), Std.string(i)));
                if (!results[i].success)
                {
                    pendingEvent = events[idx];
                    Log.debug("Keen submission failed for " + pendingEvent.name + ", destroying event");
                }
                indexesToRemove.push(idx);
            }
            cleanupEvents(events, indexesToRemove);
        }
    }
}


