package com.miniclip.events
{
   import flash.events.Event;
   
   public class HighscoreEvent extends Event
   {
      
      public static const CLOSE:String = "highscore_close";
      
      public function HighscoreEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new HighscoreEvent(type,bubbles,cancelable);
      }
   }
}

