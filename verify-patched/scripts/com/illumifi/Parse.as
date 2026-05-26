package com.illumifi
{
   import flash.events.*;
   import flash.net.*;
   import flash.utils.Timer;
   
   public class Parse
   {
      
      private static var ldr:URLLoader;
      
      private static var req:URLRequest;
      
      private static var loadDelay:Timer;
      
      public static const api:* = "https://api.parse.com/1/";
      
      public static const app:* = "h8ETEmYwKBHxeiJ9aMS5X2GQFsNLc2oYbFho6CUa";
      
      public static const key:* = "4ov33VaqJh80xIo8KIGTJ8GaR9ZF52rMB4NxAYTt";
      
      public static const typ:* = "application/json";
      
      public static var User:Object = {
         "Delete":function(objectId:String, success:Function = null, error:Function = null):void
         {
            var url:* = Parse.api + "users/" + objectId;
            Parse.Call(url,URLRequestMethod.DELETE,null,null,success,error);
         },
         "Get":function(objectId:String, success:Function = null, error:Function = null):void
         {
            var url:* = Parse.api + "users/" + objectId;
            Parse.Call(url,URLRequestMethod.GET,null,null,success,error);
         },
         "Post":function(params:Object, success:Function = null, error:Function = null):void
         {
            var url:* = Parse.api + "users";
            Parse.Call(url,URLRequestMethod.POST,params,null,success,error);
         },
         "Put":function(objectId:String, params:Object, success:Function = null, error:Function = null):void
         {
            var url:* = Parse.api + "users/" + objectId;
            Parse.Call(url,URLRequestMethod.PUT,params,null,success,error);
         },
         "Search":function(where:Object, success:Function = null, error:Function = null):void
         {
            var url:* = Parse.api + "users";
            Parse.Call(url,URLRequestMethod.GET,null,where,success,error);
         }
      };
      
      public function Parse()
      {
         super();
      }
      
      private static function Call(url:String, method:String, params:Object = null, where:Object = null, success:Function = null, error:Function = null) : void
      {
         var superURL:String = null;
         var b:int = 0;
         var p:* = undefined;
         ldr = new URLLoader();
         if(method == URLRequestMethod.GET)
         {
            superURL = url;
            b = 0;
            if(where != null)
            {
               b++;
               superURL += "?where=" + encodeURI(JSON.stringify(where));
            }
            if(params != null)
            {
               for(p in params)
               {
                  if(b == 0)
                  {
                     b++;
                     superURL += "?" + encodeURI(p + "=" + params[p]);
                  }
                  else
                  {
                     superURL += "&" + encodeURI(p + "=" + params[p]);
                  }
               }
            }
            req = new URLRequest(superURL);
            req.contentType = Parse.typ;
            req.data = "bob";
         }
         else
         {
            req = new URLRequest(url);
            req.contentType = Parse.typ;
            req.data = JSON.stringify(params);
         }
         if(method == "GET")
         {
            req.method = URLRequestMethod.POST;
            req.requestHeaders.push(new URLRequestHeader("X-HTTP-Method-Override",URLRequestMethod.GET));
         }
         else if(method == "PUT")
         {
            req.method = URLRequestMethod.POST;
            req.requestHeaders.push(new URLRequestHeader("X-HTTP-Method-Override",URLRequestMethod.PUT));
         }
         else
         {
            req.method = method;
         }
         req.requestHeaders.push(new URLRequestHeader("X-Parse-Application-Id",Parse.app));
         req.requestHeaders.push(new URLRequestHeader("X-Parse-REST-API-Key",Parse.key));
         if(success != null)
         {
            trace("request " + url);
            ldr.addEventListener(Event.COMPLETE,function(e:*):*
            {
               trace("return");
               e.target.removeEventListener(Event.COMPLETE,arguments.callee);
               var data:* = JSON.parse(e.target.data);
               ldr = null;
               success(data);
            });
         }
         if(error != null)
         {
            ldr.addEventListener(IOErrorEvent.IO_ERROR,error,false,0,true);
         }
         ldr.load(req);
      }
      
      public static function Delete(className:String, objectId:String, success:Function = null, error:Function = null) : void
      {
         var url:String = Parse.api + "classes/" + className + "/" + objectId;
         Parse.Call(url,URLRequestMethod.DELETE,null,null,success,error);
      }
      
      public static function Get(className:String, params:Object = null, where:Object = null, success:Function = null, error:Function = null) : void
      {
         var url:String = Parse.api + "classes/" + className;
         Parse.Call(url,URLRequestMethod.GET,params,where,success,error);
      }
      
      public static function Post(className:String, params:Object = null, success:Function = null, error:Function = null) : void
      {
         var url:String = Parse.api + "classes/" + className;
         Parse.Call(url,URLRequestMethod.POST,params,null,success,error);
      }
      
      public static function Put(className:String, objectId:String, params:Object = null, success:Function = null, error:Function = null) : void
      {
         var url:String = Parse.api + "classes/" + className + "/" + objectId;
         Parse.Call(url,URLRequestMethod.PUT,params,null,success,error);
      }
      
      public static function ResetPassword(email:String, success:Function = null, error:Function = null) : void
      {
         var params:Object = {"email":email};
         var url:String = Parse.api + "requestPasswordReset";
         Parse.Call(url,URLRequestMethod.POST,params,null,success,error);
      }
      
      public static function SignIn(username:String, password:String, success:Function = null, error:Function = null) : void
      {
         var params:Object = {
            "username":username,
            "password":password
         };
         var url:String = Parse.api + "login";
         Parse.Call(url,URLRequestMethod.GET,params,null,success,error);
      }
      
      public static function SignUp(params:Object, success:Function = null, error:Function = null) : void
      {
         Parse.User.Post(params,success,error);
      }
      
      public static function Batch(requests:Array, success:Function, error:Function) : *
      {
         var params:Object = {"requests":requests};
         var url:String = Parse.api + "batch";
         Parse.Call(url,URLRequestMethod.POST,params,null,success,error);
      }
   }
}

