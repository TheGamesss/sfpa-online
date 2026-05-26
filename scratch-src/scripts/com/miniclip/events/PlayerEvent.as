package com.miniclip.events
{
   import flash.events.Event;
   
   public class PlayerEvent extends Event
   {
      
      public static const AVATAR_STATUS:String = "player_avatar_status";
      
      public static const ERROR:String = "player_error";
      
      private var _data:*;
      
      public function PlayerEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
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
         return new PlayerEvent(type,this.data,bubbles,cancelable);
      }
   }
}

