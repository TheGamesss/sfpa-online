package com.miniclip.events
{
   import flash.events.Event;
   
   public class StorageErrorEvent extends Event
   {
      
      public static const DATABASE:String = "database";
      
      public static const LOGIN:String = "login";
      
      public static const VALIDATION:String = "validation";
      
      public static const SERVICES:String = "services";
      
      public static const TIMEOUT:String = "timeout";
      
      public static const ERROR:String = "error";
      
      private var _message:String;
      
      public function StorageErrorEvent(type:String, message:String = "", bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this._message = message;
      }
      
      public function get message() : String
      {
         return this._message;
      }
      
      override public function clone() : Event
      {
         return new StorageErrorEvent(type,this.message,bubbles,cancelable);
      }
   }
}

