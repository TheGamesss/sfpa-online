package com.miniclip.loggers
{
   import com.miniclip.loggers.logs.LoggerConfig;
   import flash.utils.getDefinitionByName;
   
   public class LogsHandler
   {
      
      private static var filerFrases:Array;
      
      private static var _instance:LogsHandler;
      
      private static var appDoaminId:String = "";
      
      private var entryIndex:int = -1;
      
      private var loggers:Vector.<Loggable>;
      
      private var filter:Vector.<String>;
      
      public function LogsHandler(key:Lock)
      {
         var i:* = undefined;
         super();
         if(key)
         {
            this.identyAppDoamin();
            this.entryIndex = -1;
            this.addLoggers();
            if(Boolean(filerFrases) && filerFrases.length > 0)
            {
               if(!this.filter)
               {
                  this.filter = new Vector.<String>();
               }
               for each(i in filerFrases)
               {
                  this.filter.push(String(i));
               }
            }
            return;
         }
         throw new Error("You don\'t have permission to call this constructor");
      }
      
      public static function addFilter(filterFrase:String) : void
      {
         if(!instance.filter)
         {
            instance.filter = new Vector.<String>();
         }
         instance.filter.push(filterFrase);
      }
      
      public static function resetFilters() : void
      {
         instance.filter = null;
      }
      
      public static function addLogger(logger:Loggable) : void
      {
         instance.loggers.push(logger);
      }
      
      public static function removeLogger(logger:Loggable) : void
      {
         instance.loggers.splice(instance.loggers.indexOf(logger),1);
      }
      
      public static function log(arg0:*, ... rest) : void
      {
         rest.unshift(arg0);
         instance.processLog.apply(instance,rest);
      }
      
      public static function debug(arg0:*, ... rest) : void
      {
         rest.unshift(arg0);
         LogsHandler.log.apply(null,rest);
      }
      
      public static function error(arg0:*, ... rest) : void
      {
         rest.unshift(arg0);
         LogsHandler.log.apply(null,rest);
      }
      
      public static function fatal(arg0:*, ... rest) : void
      {
         rest.unshift(arg0);
         LogsHandler.log.apply(null,rest);
      }
      
      public static function info(arg0:*, ... rest) : void
      {
         rest.unshift(arg0);
         LogsHandler.log.apply(null,rest);
      }
      
      public static function warn(arg0:*, ... rest) : void
      {
         rest.unshift(arg0);
         LogsHandler.log.apply(null,rest);
      }
      
      private static function get instance() : LogsHandler
      {
         if(!_instance)
         {
            _instance = new LogsHandler(new Lock());
         }
         return _instance;
      }
      
      public function processLog(arg0:*, ... rest) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Deobfuscate code" option in Settings
          * Error type: IndexOutOfBoundsException (Index -1 out of bounds for length 0)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function addLoggers() : void
      {
         var def:Class = null;
         this.loggers = new Vector.<Loggable>();
         for each(def in LoggerConfig.loggers)
         {
            this.loggers.push(new def());
         }
      }
      
      private function brodcastLog(msg:String) : void
      {
         ++this.entryIndex;
         this.loggers.forEach(function(arg:Loggable, index:int, v:Vector.<Loggable>):void
         {
            if(arg)
            {
               arg.log(appDoaminId + String(entryIndex) + ":\r\t" + msg);
            }
         });
      }
      
      private function formatArg(arg:*) : String
      {
         if(arg is String)
         {
            return arg;
         }
         if(!isNaN(arg))
         {
            return String(arg);
         }
         if(Boolean(arg) && Boolean(arg["toString"]) && arg["toString"] is Function)
         {
            return arg["toString"]();
         }
         return String(arg);
      }
      
      private function identyAppDoamin() : void
      {
         var info:* = undefined;
         try
         {
            info = getDefinitionByName("info.AppDomainID");
            appDoaminId = "[" + info["ID"] + "] ";
         }
         catch(er:Error)
         {
            appDoaminId = "";
         }
      }
   }
}

class Lock
{
   
   public function Lock()
   {
      super();
   }
}
