package com.miniclip.events
{
   import flash.events.Event;
   
   public class GameChatEvent extends Event
   {
      
      public static const LOADED:String = "chat_loaded";
      
      public static const LOAD_ERROR:String = "chat_loaderror";
      
      public static const SUBMITTED:String = "chat_submitted";
      
      public static const SUBMIT_ERROR:String = "chat_submiterror";
      
      public function GameChatEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new GameChatEvent(type,bubbles,cancelable);
      }
   }
}

