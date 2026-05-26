package com.miniclip.events
{
   import flash.events.Event;
   
   public class LoginBoxEvent extends Event
   {
      
      public static const READY:String = "ready";
      
      public static const ERROR:String = "error";
      
      public function LoginBoxEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new LoginBoxEvent(type,bubbles,cancelable);
      }
   }
}

