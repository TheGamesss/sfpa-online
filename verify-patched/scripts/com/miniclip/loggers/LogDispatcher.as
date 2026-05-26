package com.miniclip.loggers
{
   public class LogDispatcher implements Logger
   {
      
      private var _name:String;
      
      private var _level:LoggingLevel;
      
      private var _listeners:Array;
      
      public function LogDispatcher(name:String, level:LoggingLevel = null)
      {
         super();
         if(level == null)
         {
            level = LoggingLevel.everything;
         }
         this._name = name;
         this._level = level;
         this.removeAll();
      }
      
      private function _addListener(listener:Loggable) : void
      {
         var pos:int = this._listeners.indexOf(listener);
         if(pos == -1)
         {
            this._listeners.push(listener);
         }
      }
      
      private function _removeListener(listener:Loggable) : void
      {
         var pos:int = this._listeners.indexOf(listener);
         if(pos > -1)
         {
            this._listeners.splice(pos,1);
         }
      }
      
      private function _removeListenerByName(name:String) : void
      {
         var i:uint = 0;
         var listener:Loggable = null;
         for(i = 0; i < this._listeners.length; i++)
         {
            listener = this._listeners[i];
            if(listener.name == name)
            {
               this._listeners.splice(i,1);
            }
         }
      }
      
      private function _callEvery(method:String, message:String = "") : void
      {
         var i:uint = 0;
         for(i = 0; i < this._listeners.length; i++)
         {
            this._listeners[i][method](message);
         }
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function log(message:String) : void
      {
         LogsHandler.log(message);
      }
      
      public function info(message:String) : void
      {
         LogsHandler.info(message);
      }
      
      public function debug(message:String) : void
      {
         LogsHandler.debug(message);
      }
      
      public function warn(message:String) : void
      {
         LogsHandler.warn(message);
      }
      
      public function error(message:String) : void
      {
         LogsHandler.error(message);
      }
      
      public function add(... loggers) : void
      {
         var logger:* = undefined;
         for each(logger in loggers)
         {
            if(logger is Loggable)
            {
               LogsHandler.addLogger(logger);
            }
         }
      }
      
      public function remove(... loggers) : void
      {
      }
      
      public function removeByName(... names) : void
      {
      }
      
      public function removeAll() : void
      {
      }
      
      public function get level() : LoggingLevel
      {
         return this._level;
      }
      
      public function set level(value:LoggingLevel) : void
      {
         this._level = value;
      }
      
      public function get length() : uint
      {
         return 0;
      }
      
      public function get list() : Array
      {
         return [];
      }
      
      public function get listByName() : Array
      {
         return [];
      }
   }
}

