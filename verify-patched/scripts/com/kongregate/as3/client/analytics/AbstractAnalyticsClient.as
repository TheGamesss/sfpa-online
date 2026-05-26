package com.kongregate.as3.client.analytics
{
   import com.kongregate.as3.client.services.AnalyticsServices;
   import com.kongregate.as3.common.util.Log;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   
   public class AbstractAnalyticsClient implements AnalyticsClient
   {
      
      private static const MAX_EVENT_BACKLOG:int = 100;
      
      private static const MAX_RETRIES:int = 2;
      
      private static const TRANSIENT_PROPERTIES:Array = [AnalyticsServices.KONG_ANALYTICS_RETRY_COUNT,AnalyticsServices.KONG_ANALYTICS_AUTO_EVENT];
      
      protected var mErrorHandled:Boolean = false;
      
      public function AbstractAnalyticsClient()
      {
         super();
      }
      
      public function handlesEvent(eventName:String) : Boolean
      {
         return true;
      }
      
      public function sendEvents(events:Array, complete:Function) : void
      {
         this.pruneEvents(events);
      }
      
      protected function pruneEvents(events:Array) : void
      {
         if(Boolean(events) && events.length > MAX_EVENT_BACKLOG)
         {
            events.splice(0,events.length - MAX_EVENT_BACKLOG);
         }
      }
      
      protected function createErrorHandler(pendingEvents:Array, callback:Function, numEvents:int) : Function
      {
         this.mErrorHandled = false;
         return function(e:Event):void
         {
            var statusEvent:* = e as HTTPStatusEvent;
            if(statusEvent)
            {
               if(statusEvent.status >= 200 && statusEvent.status < 300 || statusEvent.status == 0)
               {
                  return;
               }
               Log.debug("HTTP status: " + statusEvent.status);
            }
            Log.error("Error while processing analytics event: " + e.toString());
            handleError(pendingEvents,callback,numEvents);
         };
      }
      
      protected function handleFatalError(pendingEvents:Array, callback:Function, numEvents:int) : void
      {
         this.handleError(pendingEvents,callback,numEvents,true);
      }
      
      protected function handleError(pendingEvents:Array, callback:Function, numEvents:int, fatal:Boolean = false) : void
      {
         var pendingEvent:Object = null;
         var retryCount:int = 0;
         if(this.mErrorHandled)
         {
            Log.debug("Analtyics error already handled, ignoring");
            return;
         }
         this.mErrorHandled = true;
         var i:int = 0;
         while(i < numEvents && i < pendingEvents.length)
         {
            pendingEvent = pendingEvents[i];
            if(pendingEvent)
            {
               retryCount = (pendingEvent.event.retry_count || 0) + (fatal ? MAX_RETRIES + 1 : 1);
               pendingEvent.event.retry_count = retryCount;
            }
            i++;
         }
         this.cleanupEvents(pendingEvents);
         callback && callback({"success":false});
      }
      
      protected function cleanupEvents(pendingEvents:Array, indexesToRemove:Array = null) : void
      {
         for(var i:* = int(pendingEvents.length - 1); i >= 0; i--)
         {
            if(pendingEvents[i].event.retry_count > MAX_RETRIES)
            {
               Log.debug("Event " + pendingEvents[i].name + " is over max retry count, deleting it");
               pendingEvents.splice(i,1);
            }
            else if(Boolean(indexesToRemove) && indexesToRemove.indexOf(i) >= 0)
            {
               pendingEvents.splice(i,1);
            }
         }
      }
      
      protected function removeTransientProperties(evt:Object) : void
      {
         var transientProperty:String = null;
         for each(transientProperty in TRANSIENT_PROPERTIES)
         {
            if(evt[transientProperty] != undefined)
            {
               delete evt[transientProperty];
            }
         }
      }
   }
}

