package com.kongregate.as3.common.util
{
   import com.adobe.serialization.json.JSON;
   import com.adobe.utils.DateUtil;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class Utils
   {
      
      private static const KONGREGATE_PREFIXES:Array = ["a","assets","www","chat","internal","ssl"];
      
      private static const INSTART_DOMAINS:Array = ["insnw.net"];
      
      private static const INSTART_DOMAIN_DIVISIONS:Number = 4;
      
      private static var ALLOWED_DOMAINS:Array = [];
      
      public function Utils()
      {
         super();
      }
      
      public static function allowKongregateDomains(baseDomain:String) : void
      {
         var subdomain:String = null;
         var i:Number = NaN;
         var domain:String = null;
         var instartDomain:String = null;
         var name:String = null;
         ALLOWED_DOMAINS.push(baseDomain);
         ALLOWED_DOMAINS.push("ssl.kongcdn.com");
         for each(subdomain in KONGREGATE_PREFIXES)
         {
            ALLOWED_DOMAINS.push(subdomain + "." + baseDomain);
         }
         for(i = 1; i <= INSTART_DOMAIN_DIVISIONS; i++)
         {
            for each(instartDomain in INSTART_DOMAINS)
            {
               name = baseDomain.split(".",2)[0];
               ALLOWED_DOMAINS.push(name + i + "." + instartDomain);
            }
         }
         for each(domain in getAllowedDomains())
         {
            Security.allowDomain(domain);
            Security.allowInsecureDomain(domain);
         }
      }
      
      public static function getAllowedDomains() : Array
      {
         return ALLOWED_DOMAINS;
      }
      
      public static function allowDomains() : void
      {
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
      }
      
      public static function bind(functionToApply:Function, object:Object) : *
      {
         var temporaryFunction:Function = function():Function
         {
            return function():*
            {
               return functionToApply.apply(object,arguments);
            };
         };
         return temporaryFunction.apply(undefined);
      }
      
      public static function getFlashMajorVersion() : Number
      {
         var versionArray:Array = null;
         var idxSpace:Number = NaN;
         var version:String = Capabilities.version;
         if(!version || version.length == 0)
         {
            return 5;
         }
         versionArray = version.split(",");
         idxSpace = Number(versionArray[0].indexOf(" "));
         return Number(versionArray[0].substr(idxSpace));
      }
      
      public static function submitAlert(body:String, type:String, username:String, reportName:String, game_id:Number, automatic:Number, onComplete:Function = null) : void
      {
         var logObj:Object = Log.getErrorReport();
         var variables:URLVariables = new URLVariables("name=Franklin");
         if(body)
         {
            variables.body = body;
         }
         if(game_id)
         {
            variables.game_id = game_id;
         }
         variables.automatic = automatic == 1 ? 1 : 0;
         variables.report_name = reportName;
         variables.username = username;
         variables.version = logObj.version;
         variables[type] = com.adobe.serialization.json.JSON.encode(logObj.log);
         sendHttpRequest("/alerts",variables,onComplete,0);
      }
      
      public static function submitGameAlert(username:String, gameID:int, channelID:String) : void
      {
         Utils.submitAlert("Automatically generated game alert","game_log",username,channelID,gameID,1);
      }
      
      public static function crudUpdate(url:String, dataObj:Object, resultCallback:Function = undefined, timeout:Number = 0) : void
      {
         dataObj._method = "put";
         sendHttpRequest(url,dataObj,resultCallback,timeout);
      }
      
      public static function crudDestroy(url:String, resultCallback:Function, timeout:Number = 0) : void
      {
         sendHttpRequest(url,{"_method":"delete"},resultCallback,timeout);
      }
      
      public static function crudCreate(url:String, dataObj:Object, resultCallback:Function, timeout:Number = 0) : void
      {
         dataObj._method = "post";
         sendHttpRequest(url,dataObj,resultCallback,timeout);
      }
      
      private static function populateURLVariablesWithObject(container:*, val:*, base_property_name:String = null) : void
      {
         var element:* = undefined;
         var property_name:String = null;
         var i:String = null;
         if("function" == typeof val)
         {
            return;
         }
         if("object" != typeof val)
         {
            container[base_property_name] = val;
         }
         for(i in val)
         {
            element = val[i];
            if(!(undefined == element || "function" == typeof element))
            {
               if(!base_property_name)
               {
                  property_name = i;
               }
               else
               {
                  property_name = base_property_name + "[" + i + "]";
               }
               populateURLVariablesWithObject(container,element,property_name);
            }
         }
      }
      
      public static function sendHttpRequest(url:String, dataObj:Object, resultCallback:Function, timeout:Number) : void
      {
         dataObj.ts = getTimeStamp();
         var request:URLRequest = new URLRequest(url);
         request.method = URLRequestMethod.POST;
         var variables:URLVariables = new URLVariables();
         populateURLVariablesWithObject(variables,dataObj);
         request.data = variables;
         var loader:URLLoader = new URLLoader();
         if("function" == typeof resultCallback)
         {
            loader.addEventListener(Event.COMPLETE,resultCallback);
         }
         if(timeout > 0)
         {
            loader.addEventListener(IOErrorEvent.IO_ERROR,resultCallback);
         }
         try
         {
            loader.load(request);
         }
         catch(error:Error)
         {
         }
      }
      
      public static function getTimeStamp() : String
      {
         return Math.floor(Math.random() * 10000000).toString() + "_" + getTimer();
      }
      
      public static function httpGet(url:String, dataObj:Object, resultCallback:Function, timeout:Number) : void
      {
         doHttpRequest(URLRequestMethod.GET,url,dataObj,resultCallback,timeout);
      }
      
      public static function httpPost(url:String, dataObj:Object, resultCallback:Function, timeout:Number) : void
      {
         doHttpRequest(URLRequestMethod.POST,url,dataObj,resultCallback,timeout);
      }
      
      public static function doHttpRequest(method:String, url:String, dataObj:Object, resultCallback:Function, timeout:Number) : void
      {
         var loader:URLLoader;
         var internalCallback:Function;
         var request:URLRequest = new URLRequest(url);
         request.method = method;
         dataObj.ts = getTimeStamp();
         request.data = createURLVariables(dataObj);
         loader = new URLLoader();
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         internalCallback = function(e:Event):void
         {
            if(resultCallback != null)
            {
               resultCallback(processHttpResponse(e));
            }
         };
         loader.addEventListener(Event.COMPLETE,internalCallback);
         loader.addEventListener(IOErrorEvent.IO_ERROR,internalCallback);
         try
         {
            loader.load(request);
         }
         catch(error:Error)
         {
            internalCallback(null);
         }
      }
      
      private static function processHttpResponse(e:Event) : Object
      {
         var response:Object = null;
         if(e == null || e.type != Event.COMPLETE)
         {
            return {
               "success":false,
               "response":null,
               "parsed_response":null
            };
         }
         var target:URLLoader = e.target as URLLoader;
         var data:String = target.data as String;
         try
         {
            response = com.adobe.serialization.json.JSON.decode(data);
            return {
               "success":true,
               "response":data,
               "parsed_response":response
            };
         }
         catch(e:Error)
         {
         }
         return {
            "success":true,
            "response":data,
            "parsed_response":null
         };
      }
      
      private static function createURLVariables(dataObject:Object) : URLVariables
      {
         var key:String = null;
         var vars:URLVariables = new URLVariables();
         for(key in dataObject)
         {
            vars[key] = dataObject[key];
         }
         return vars;
      }
      
      public static function sendImageToServer(image:ByteArray, server:String, callback:Function) : void
      {
         var loader:URLLoader;
         var header:URLRequestHeader = new URLRequestHeader("Content-type","application/octet-stream");
         var request:URLRequest = new URLRequest(server + "/image_importer");
         request.requestHeaders.push(header);
         request.method = URLRequestMethod.POST;
         request.data = image;
         loader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,function(e:Event):void
         {
            callback(e.target.data);
         });
         loader.load(request);
      }
      
      public static function merge(dest:Object, src:Object) : Object
      {
         var key:String = null;
         if(!dest || !src)
         {
            return dest;
         }
         for(key in src)
         {
            dest[key] = src[key];
         }
         return dest;
      }
      
      public static function isEmpty(object:Object) : Boolean
      {
         var key:String = null;
         if(!object)
         {
            return true;
         }
         var _loc3_:int = 0;
         var _loc4_:* = object;
         for(key in _loc4_)
         {
            return false;
         }
         return true;
      }
      
      public static function clear(object:*) : void
      {
         var key:* = undefined;
         if(object is Object)
         {
            for(key in object)
            {
               delete object[key];
            }
         }
         else if(object is Array && object.length > 0)
         {
            object.splice(0,object.length);
         }
      }
      
      public static function getTimeSeconds() : int
      {
         return int(new Date().getTime() / 1000);
      }
      
      public static function parseDate(s:String, def:Date = null) : Date
      {
         try
         {
            if(!s || s.length == 0)
            {
               return def;
            }
            return DateUtil.parseW3CDTF(s);
         }
         catch(e:Error)
         {
            Log.warn("Failed to parse date: " + s);
         }
         return def;
      }
   }
}

