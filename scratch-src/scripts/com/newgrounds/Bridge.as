package com.newgrounds
{
   import com.newgrounds.encoders.json.JSON;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.StatusEvent;
   import flash.net.LocalConnection;
   
   public class Bridge extends EventDispatcher
   {
      
      private var _inConnection:LocalConnection;
      
      private var _outConnection:LocalConnection;
      
      private var _widgetId:String;
      
      public function Bridge(param1:String)
      {
         super();
         this._widgetId = param1;
         this._inConnection = new LocalConnection();
         this._outConnection = new LocalConnection();
         this._inConnection.client = this;
         this._inConnection.allowDomain("www.newgrounds.com");
         this._inConnection.allowInsecureDomain("www.newgrounds.com");
         this._inConnection.connect("_rec_" + this._widgetId);
         this._outConnection.addEventListener(StatusEvent.STATUS,this.onStatus);
         Logger.addEventListener(APIEvent.LOG,this.onLogMessage);
      }
      
      public function get widgetId() : String
      {
         return this._widgetId;
      }
      
      private function onLogMessage(param1:APIEvent) : void
      {
         try
         {
            this._outConnection.send(this._widgetId,"sendEvent","trace",String(param1.data));
         }
         catch(error:*)
         {
         }
      }
      
      public function sendEvent(param1:String, param2:Object) : void
      {
         if(this._outConnection)
         {
            param2 = {"data":param2};
            try
            {
               this._outConnection.send(this._widgetId,"sendEvent",param1,param2);
            }
            catch(error:*)
            {
            }
         }
      }
      
      public function receiveEvent(param1:String) : void
      {
         var _loc2_:Object = null;
         try
         {
            _loc2_ = com.newgrounds.encoders.json.JSON.decode(param1);
         }
         catch(error:*)
         {
         }
         dispatchEvent(new APIEvent(APIEvent.BRIDGE_EVENT_RECEIVED,_loc2_,_loc2_ == null ? APIEvent.ERROR_UNKNOWN : null));
      }
      
      private function onStatus(param1:Event) : void
      {
      }
   }
}

