package com.amanitadesign.steam
{
   import flash.events.Event;
   
   public class SteamEvent extends Event
   {
      
      public static var STEAM_RESPONSE:String = "steamResponse";
      
      private var _req_type:int = -1;
      
      private var _response:int = -1;
      
      private var _data:* = null;
      
      public function SteamEvent(type:String, req_type:int, response:int, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this._response = response;
         this._req_type = req_type;
      }
      
      public function get response() : int
      {
         return this._response;
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function set data(value:*) : void
      {
         this._data = value;
      }
      
      public function get req_type() : int
      {
         return this._req_type;
      }
      
      override public function clone() : Event
      {
         var event:SteamEvent = new SteamEvent(type,this.req_type,this.response,bubbles,cancelable);
         event.data = this.data;
         return event;
      }
   }
}

