package com.miniclip.events
{
   import flash.events.Event;
   
   public class AwardsEvent extends Event
   {
      
      public static const SUCCESS:String = "awards_success";
      
      public static const STATUS:String = "awards_status";
      
      public static const FAIL:String = "awards_fail";
      
      public static const ERROR:String = "awards_error";
      
      public static const USER_GAME_AWARDS:String = "user_gme_awards";
      
      private var _data:*;
      
      public function AwardsEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
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
         return new AwardsEvent(type,this.data,bubbles,cancelable);
      }
   }
}

