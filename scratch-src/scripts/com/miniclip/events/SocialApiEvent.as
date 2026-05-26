package com.miniclip.events
{
   import flash.events.Event;
   
   public class SocialApiEvent extends Event
   {
      
      public static const API_CALL_COMPLETE:String = "social_api_call_complete";
      
      private var _methodCalled:String;
      
      private var _success:Boolean;
      
      private var _data:Object;
      
      public function SocialApiEvent(method:String, success:Boolean, data:Object = null)
      {
         super(SocialApiEvent.API_CALL_COMPLETE,false,false);
         this._methodCalled = method;
         this._success = success;
         this._data = data;
      }
      
      public function get methodCalled() : String
      {
         return this._methodCalled;
      }
      
      public function get success() : Boolean
      {
         return this._success;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}

