package com.miniclip.loggers.logs
{
   import com.miniclip.loggers.Loggable;
   
   public class FlashTracer implements Loggable
   {
      
      private var _name:String;
      
      public function FlashTracer()
      {
         super();
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get available() : Boolean
      {
         return true;
      }
      
      public function log(message:String) : void
      {
         trace(message);
      }
      
      public function info(message:String) : void
      {
         trace(message);
      }
      
      public function debug(message:String) : void
      {
         trace(message);
      }
      
      public function warn(message:String) : void
      {
         trace(message);
      }
      
      public function error(message:String) : void
      {
         trace(message);
      }
   }
}

