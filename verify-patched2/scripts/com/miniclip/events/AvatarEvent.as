package com.miniclip.events
{
   import flash.events.Event;
   
   public class AvatarEvent extends Event
   {
      
      public static const READY:String = "ready";
      
      public static const ERROR:String = "error";
      
      private var _data:*;
      
      public function AvatarEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this._data = data;
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      override public function clone() : Event
      {
         return new AvatarEvent(type,this.data,bubbles,cancelable);
      }
   }
}

