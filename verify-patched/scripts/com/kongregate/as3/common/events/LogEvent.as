package com.kongregate.as3.common.events
{
   import flash.events.Event;
   
   public class LogEvent extends Event
   {
      
      public static const ERROR:String = "Error";
      
      public static const INFO:String = "Info";
      
      public static const WARN:String = "Warn";
      
      public static const DEBUG:String = "Debug";
      
      public static const SPAM:String = "Spam";
      
      public static const TYPE_ALL:String = "All";
      
      private var _text:*;
      
      public function LogEvent(type:String, text:*)
      {
         super(type);
         this._text = text;
      }
      
      public function get text() : *
      {
         return this._text;
      }
   }
}

