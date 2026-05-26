package com.kongregate.as3.common.util
{
   import com.adobe.serialization.json.JSON;
   import com.kongregate.as3.common.events.LogEvent;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   
   public class Log extends EventDispatcher
   {
      
      private static var gInstance:Log;
      
      public static const MAX_LOG_ENTRIES:Number = 250;
      
      public static var LEVELS:Array = ["Error","Warn","Info","Debug","Spam"];
      
      public static var LEVELS_MAP:Object = {
         "Error":1,
         "Warn":2,
         "Info":3,
         "Debug":4,
         "Spam":5
      };
      
      private var mLogLevel:Number = 0;
      
      private var mLogEntries:Array;
      
      private var mLogName:String = "";
      
      private var mInitialized:Boolean = false;
      
      public function Log()
      {
         super();
      }
      
      public static function init() : void
      {
         getInstance().init();
      }
      
      public static function getInstance() : Log
      {
         if(gInstance == null)
         {
            gInstance = new Log();
            gInstance.init();
         }
         return gInstance;
      }
      
      public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         getInstance().addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         getInstance().removeEventListener(type,listener,useCapture);
      }
      
      public static function hasEventListener(type:String) : Boolean
      {
         return getInstance().hasEventListener(type);
      }
      
      public static function debug(text:*) : void
      {
         getInstance().log(4,text);
      }
      
      public static function spam(text:*) : void
      {
         getInstance().log(5,text);
      }
      
      public static function info(text:*) : void
      {
         getInstance().log(3,text);
      }
      
      public static function warn(text:*) : void
      {
         getInstance().log(2,text);
      }
      
      public static function error(text:*) : void
      {
         getInstance().log(1,text);
      }
      
      public static function setLogLevel(level:Number) : void
      {
         getInstance().setLogLevel(level);
      }
      
      public static function getLogLevel() : Number
      {
         return getInstance().mLogLevel;
      }
      
      public static function isDebug() : Boolean
      {
         return getInstance().isDebug();
      }
      
      public static function getErrorReport() : Array
      {
         return getInstance().getErrorReport();
      }
      
      public static function setName(name:String) : void
      {
         getInstance().setName(name);
      }
      
      public static function getName() : String
      {
         return getInstance().getName();
      }
      
      private function init() : void
      {
         if(!this.mInitialized)
         {
            this.mInitialized = true;
            this.addEventListener(LogEvent.DEBUG,this.onDebugMessage);
            this.addEventListener(LogEvent.INFO,this.onInfoMessage);
            this.addEventListener(LogEvent.WARN,this.onWarnMessage);
            this.addEventListener(LogEvent.ERROR,this.onErrorMessage);
            this.addEventListener(LogEvent.SPAM,this.onSpamMessage);
            this.mLogEntries = new Array();
            Log.info("kongregate log initialized.");
            Log.info(this.getOSInfo());
         }
      }
      
      private function log(level:int, text:*) : void
      {
         var levelString:String = null;
         if(level < LEVELS_MAP.Spam)
         {
            this.addLogEntry(levelString,text);
         }
         if(this.mLogLevel >= level)
         {
            levelString = this.getLevelString(level);
            this.dispatch(levelString,text);
            trace("[" + levelString + "] " + text);
         }
      }
      
      private function dispatch(type:String, text:*) : Boolean
      {
         if(this.mLogName != null && this.mLogName.length > 0)
         {
            if(text is String)
            {
               text = "[" + this.mLogName + "] " + text;
            }
         }
         return dispatchEvent(new LogEvent(type,text));
      }
      
      public function setLogLevel(level:Number) : void
      {
         this.mLogLevel = level;
      }
      
      private function isDebug() : Boolean
      {
         return this.mLogLevel >= 4;
      }
      
      private function getTimestamp() : String
      {
         var date:Date = new Date();
         return date.toString().split("GMT")[0];
      }
      
      private function getErrorReport() : Array
      {
         return this.mLogEntries;
      }
      
      public function getOSInfo() : String
      {
         return "OS: " + Capabilities.os + ", " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + ", current version: " + Capabilities.version;
      }
      
      public function addLogEntry(type:String, text:*) : void
      {
         if(text is String)
         {
            if(this.mLogEntries.length > MAX_LOG_ENTRIES)
            {
               this.mLogEntries.splice(0,1);
            }
            this.mLogEntries.push({
               "type":type,
               "time":this.getTimestamp(),
               "text":this.sanitize(text)
            });
         }
      }
      
      private function setName(name:String) : void
      {
         this.mLogName = name;
      }
      
      private function getName() : String
      {
         return this.mLogName;
      }
      
      private function sanitize(text:String) : String
      {
         return text.split("<").join("&lt;");
      }
      
      private function onDebugMessage(e:LogEvent) : void
      {
         this.logToFirebug("log",e.text);
      }
      
      private function onSpamMessage(e:LogEvent) : void
      {
         this.logToFirebug("log",e.text);
      }
      
      private function onInfoMessage(e:LogEvent) : void
      {
         this.logToFirebug("info",e.text);
      }
      
      private function onWarnMessage(e:LogEvent) : void
      {
         this.logToFirebug("warn",e.text);
      }
      
      private function onErrorMessage(e:LogEvent) : void
      {
         var error:* = e.text;
         if(error is Error)
         {
            error = error.message + "\n" + error.getStackTrace();
            this.logToFirebug("warn",error);
         }
         else
         {
            error = e.text;
            this.logToFirebug("warn",error);
         }
      }
      
      private function logToFirebug(type:String, text:*) : void
      {
         var json:String = null;
         var f:String = null;
         var oldMarshalExceptions:Boolean = ExternalInterface.marshallExceptions;
         ExternalInterface.marshallExceptions = true;
         try
         {
            if(text is String)
            {
               text = text.replace(/\\/g,"\\\\");
            }
            else
            {
               try
               {
                  json = escape(com.adobe.serialization.json.JSON.encode(text));
                  f = "function(s,l){try{console[l].apply(console, [JSON.parse(unescape(s))]);}catch(e){}}";
                  ExternalInterface.call(f,json,type);
                  §§goto(addr00c9);
               }
               catch(e:Error)
               {
                  ExternalInterface.call("window.console.error","Error while logging: failed to convert to JSON");
               }
               ExternalInterface.marshallExceptions = oldMarshalExceptions;
               switch(§§pop())
               {
                  case 0:
                     addr00c9:
                     return;
                  case 1:
                  default:
                     §§goto(addr0165);
               }
            }
            ExternalInterface.call("window.console." + type,text);
         }
         catch(e:Error)
         {
         }
         finally
         {
            ExternalInterface.marshallExceptions = oldMarshalExceptions;
         }
         addr0165:
      }
      
      private function getLevelString(level:int) : String
      {
         return LEVELS[level - 1];
      }
   }
}

