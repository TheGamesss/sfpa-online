package com.kongregate.as3.client.analytics
{
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
   
   public class KeenClient extends AbstractAnalyticsClient
   {
      
      private var mWriteKey:String;
      
      private var mProjectId:String;
      
      public function KeenClient(projectId:String, writeKey:String)
      {
         super();
         this.mWriteKey = writeKey;
         this.mProjectId = projectId;
      }
      
      override public function handlesEvent(event:String) : Boolean
      {
         return event.indexOf("swrve.") != 0;
      }
      
      override public function sendEvents(events:Array, complete:Function) : void
      {
         var contentType:URLRequestHeader;
         var authorization:URLRequestHeader;
         var request:URLRequest;
         var data:Object;
         var i:int;
         var errorHandler:Function;
         var mappings:Object = null;
         var loader:URLLoader = null;
         var numEvents:int = 0;
         var event:Object = null;
         var e:Object = null;
         super.sendEvents(events,complete);
         contentType = new URLRequestHeader("Content-type","application/json");
         authorization = new URLRequestHeader("Authorization",this.mWriteKey);
         request = new URLRequest("https://api.keen.io/3.0/projects/" + this.mProjectId + "/events");
         request.requestHeaders.push(contentType);
         request.requestHeaders.push(authorization);
         data = {};
         mappings = {};
         for(i = 0; i < events.length; i++)
         {
            event = events[i];
            data[event.name] = data[event.name] || [];
            mappings[event.name] = mappings[event.name] || [];
            e = Utils.merge({},event.event);
            removeTransientProperties(e);
            data[event.name].push(e);
            mappings[event.name].push(i);
         }
         request.data = com.adobe.serialization.json.JSON.encode(data);
         request.method = URLRequestMethod.POST;
         loader = new BetterURLLoader();
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.load(request);
         numEvents = int(events.length);
         errorHandler = createErrorHandler(events,complete,numEvents);
         loader.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,errorHandler);
         loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,errorHandler);
         loader.addEventListener(Event.COMPLETE,function(e:Event):void
         {
            try
            {
               Log.debug("Keen submission complete");
               processResponse(events,mappings,com.adobe.serialization.json.JSON.decode(loader.data));
               complete({"success":true});
            }
            catch(e:Error)
            {
               Log.error("Error while processing keen result: " + e + ", deleting " + numEvents + " event(s), data:" + loader.data);
               handleFatalError(events,complete,numEvents);
            }
         });
      }
      
      private function processResponse(events:Array, mappings:Object, response:Object) : void
      {
         var eventName:String = null;
         var results:Array = null;
         var indexesToRemove:Array = null;
         var i:int = 0;
         var idx:int = 0;
         var pendingEvent:Object = null;
         if(Boolean(response.error_code) && Boolean(response.message))
         {
            throw new Error("Keen response had error_code and message");
         }
         for(eventName in response)
         {
            results = response[eventName];
            indexesToRemove = [];
            for(i = 0; i < results.length; i++)
            {
               idx = int(mappings[eventName][i]);
               if(!results[i].success)
               {
                  pendingEvent = events[idx];
                  Log.debug("Keen submission failed for " + pendingEvent.name + ", destroying event");
               }
               indexesToRemove.push(idx);
            }
            cleanupEvents(events,indexesToRemove);
         }
      }
   }
}

