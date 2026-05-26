package com.kongregate.as3.client.analytics
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import com.kongregate.as3.client.services.AnalyticsServices;
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
   
   public class SwrveClient extends AbstractAnalyticsClient
   {
      
      public static const SWRVE_EVENT_IDENTIFIER:String = "swrve.";
      
      public static const SWRVE_BARE_EVENT_IDENTIFIER:String = SWRVE_EVENT_IDENTIFIER + "__bare_";
      
      public static const SWRVE_SESSION_START_IDENTIFIER:String = SWRVE_BARE_EVENT_IDENTIFIER + "session_start";
      
      public static const SWRVE_USER_IDENTIFIER:String = SWRVE_BARE_EVENT_IDENTIFIER + "user";
      
      public static const SWRVE_IAP_IDENTIFIER:String = SWRVE_BARE_EVENT_IDENTIFIER + "iap";
      
      public static const SWRVE_HEARTBEAT_EVENT:String = "swrve.heartbeat";
      
      public static const SWRVE_USER_PROPERTIES:Array = [AnalyticsServices.KONG_ANALYTICS_TOTAL_SPENT_IN_USD,AnalyticsServices.KONG_ANALYTICS_FIRST_PLAY_TIME,AnalyticsServices.KONG_ANALYTICS_NUM_SESSIONS,AnalyticsServices.KONG_ANALYTICS_DAYS_RETAINED,AnalyticsServices.KONG_ANALYTICS_DEVICE_TYPE,AnalyticsServices.KONG_ANALYTICS_CLIENT_OS_TYPE,AnalyticsServices.KONG_ANALYTICS_CLIENT_OS_VERSION,AnalyticsServices.KONG_ANALYTICS_COUNTRY_CODE,AnalyticsServices.KONG_ANALYTICS_KONG_USERNAME,AnalyticsServices.KONG_ANALYTICS_SESSION_ID,AnalyticsServices.KONG_ANALYTICS_IDFA,AnalyticsServices.KONG_ANALYTICS_IDFV,AnalyticsServices.KONG_ANALYTICS_CLIENT_VERSION];
      
      private var mApiKey:String;
      
      private var mApplicationId:String;
      
      private var mUserId:String;
      
      private var mSessionToken:String;
      
      private var mClientVersion:String;
      
      private var mUseSSL:Boolean;
      
      public function SwrveClient(applicationId:String, apiKey:String, uuid:String, clientVersion:String)
      {
         super();
         this.mApiKey = apiKey;
         this.mApplicationId = applicationId;
         this.mUserId = uuid;
         this.mClientVersion = clientVersion;
         this.mUseSSL = true;
         Log.debug("SWRVE using SSL: " + this.mUseSSL);
      }
      
      override public function sendEvents(events:Array, complete:Function) : void
      {
         var timestamp:int;
         var sessionToken:String;
         var payload:Object;
         var data:Array;
         var request:URLRequest;
         var errorHandler:Function;
         var time:int = 0;
         var pendingEvent:Object = null;
         var contentType:URLRequestHeader = null;
         var url:String = null;
         var loader:URLLoader = null;
         var numEvents:int = 0;
         var eventName:String = null;
         var event:Object = null;
         super.sendEvents(events,complete);
         timestamp = int(new Date().getTime() / 1000);
         sessionToken = this.mApplicationId + "=" + this.mUserId + "=" + String(timestamp);
         sessionToken += "=" + MD5.hash(this.mUserId + String(timestamp) + this.mApiKey);
         payload = {
            "app_version":this.mClientVersion,
            "session_token":sessionToken,
            "user":this.mUserId
         };
         data = [];
         for each(pendingEvent in events)
         {
            eventName = pendingEvent.name;
            event = Utils.merge({},pendingEvent.event);
            removeTransientProperties(event);
            if(SWRVE_SESSION_START_IDENTIFIER == eventName)
            {
               data.push({
                  "type":"session_start",
                  "time":this.getTime(event)
               });
            }
            else if(SWRVE_USER_IDENTIFIER == eventName)
            {
               data.push({
                  "type":"user",
                  "time":this.getTime(event),
                  "attributes":event
               });
            }
            else if(SWRVE_IAP_IDENTIFIER == eventName)
            {
               data.push(Utils.merge({
                  "type":"iap",
                  "time":this.getTime(event)
               },event));
            }
            else if(eventName.indexOf("swrve.") == 0)
            {
               eventName = eventName.replace("swrve.","Kongregate.");
               data.push({
                  "type":"event",
                  "name":eventName,
                  "time":this.getTime(event),
                  "payload":event
               });
            }
            else
            {
               eventName = "Kongregate.RawData." + eventName;
               data.push({
                  "type":"event",
                  "name":eventName,
                  "time":this.getTime(event),
                  "payload":{"data":com.adobe.serialization.json.JSON.encode(event)}
               });
            }
         }
         payload.data = data;
         contentType = new URLRequestHeader("Content-type","application/json");
         url = (this.mUseSSL ? "https" : "http") + "://" + this.mApplicationId + ".api.swrve.com/1/batch";
         request = new URLRequest(url);
         request.requestHeaders.push(contentType);
         request.method = URLRequestMethod.POST;
         request.data = com.adobe.serialization.json.JSON.encode(payload);
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
            var data:Object = null;
            var success:Boolean = loader.data.length == 0;
            if(!success)
            {
               data = com.adobe.serialization.json.JSON.decode(loader.data);
               success = data.code == 200;
            }
            if(success)
            {
               Log.debug("SWRVE submission complete, " + numEvents + " event(s)");
               events.splice(0,numEvents);
               complete({"success":true});
            }
            else
            {
               Log.error("Error while parsing swrve result: " + loader.data + ", removing " + numEvents + " event(s)");
               handleFatalError(events,complete,numEvents);
            }
         });
      }
      
      private function getTime(event:Object) : int
      {
         var timeString:String = event[AnalyticsServices.KONG_ANALYTICS_EVENT_TIME];
         var date:Date = Utils.parseDate(timeString,new Date());
         return int(date.getTime() / 1000);
      }
   }
}

