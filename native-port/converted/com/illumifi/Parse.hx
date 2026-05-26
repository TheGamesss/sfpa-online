package com.illumifi;

import flash.events.*;
import flash.net.*;
import flash.utils.Timer;

class Parse
{
    
    private static var ldr : URLLoader;
    
    private static var req : URLRequest;
    
    private static var loadDelay : Timer;
    
    public static inline var api : Dynamic = "https://api.parse.com/1/";
    
    public static inline var app : Dynamic = "h8ETEmYwKBHxeiJ9aMS5X2GQFsNLc2oYbFho6CUa";
    
    public static inline var key : Dynamic = "4ov33VaqJh80xIo8KIGTJ8GaR9ZF52rMB4NxAYTt";
    
    public static inline var typ : Dynamic = "application/json";
    
    public static var User : Dynamic = {
            Delete : function(objectId : String, success : Dynamic = null, error : Dynamic = null) : Void
            {
                var url : Dynamic = Parse.api + "users/" + objectId;
                Parse.Call(url, URLRequestMethod.DELETE, null, null, success, error);
            },
            Get : function(objectId : String, success : Dynamic = null, error : Dynamic = null) : Void
            {
                var url : Dynamic = Parse.api + "users/" + objectId;
                Parse.Call(url, URLRequestMethod.GET, null, null, success, error);
            },
            Post : function(params : Dynamic, success : Dynamic = null, error : Dynamic = null) : Void
            {
                var url : Dynamic = Parse.api + "users";
                Parse.Call(url, URLRequestMethod.POST, params, null, success, error);
            },
            Put : function(objectId : String, params : Dynamic, success : Dynamic = null, error : Dynamic = null) : Void
            {
                var url : Dynamic = Parse.api + "users/" + objectId;
                Parse.Call(url, URLRequestMethod.PUT, params, null, success, error);
            },
            Search : function(where : Dynamic, success : Dynamic = null, error : Dynamic = null) : Void
            {
                var url : Dynamic = Parse.api + "users";
                Parse.Call(url, URLRequestMethod.GET, null, where, success, error);
            }
        };
    
    public function new()
    {
        super();
    }
    
    private static function Call(url : String, method : String, params : Dynamic = null, where : Dynamic = null, success : Dynamic = null, error : Dynamic = null) : Void
    {
        var superURL : String = null;
        var b : Int = 0;
        var p : Dynamic = null;
        ldr = new URLLoader();
        if (method == URLRequestMethod.GET)
        {
            superURL = url;
            b = 0;
            if (where != null)
            {
                b++;
                superURL += "?where=" + encodeURI(haxe.Json.stringify(where));
            }
            if (params != null)
            {
                for (p in Reflect.fields(params))
                {
                    if (b == 0)
                    {
                        b++;
                        superURL += "?" + encodeURI(p + "=" + Reflect.field(params, Std.string(p)));
                    }
                    else
                    {
                        superURL += "&" + encodeURI(p + "=" + Reflect.field(params, Std.string(p)));
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
            req.data = haxe.Json.stringify(params);
        }
        if (method == "GET")
        {
            req.method = URLRequestMethod.POST;
            req.requestHeaders.push(new URLRequestHeader("X-HTTP-Method-Override", URLRequestMethod.GET));
        }
        else if (method == "PUT")
        {
            req.method = URLRequestMethod.POST;
            req.requestHeaders.push(new URLRequestHeader("X-HTTP-Method-Override", URLRequestMethod.PUT));
        }
        else
        {
            req.method = method;
        }
        req.requestHeaders.push(new URLRequestHeader("X-Parse-Application-Id", Parse.app));
        req.requestHeaders.push(new URLRequestHeader("X-Parse-REST-API-Key", Parse.key));
        if (success != null)
        {
            trace("request " + url);
            ldr.addEventListener(Event.COMPLETE, function(e : Dynamic) : Dynamic
                    {
                        trace("return");
                        e.target.removeEventListener(Event.COMPLETE, arguments.callee);
                        var data : Dynamic = haxe.Json.parse(e.target.data);
                        ldr = null;
                        success(data);
                    });
        }
        if (error != null)
        {
            ldr.addEventListener(IOErrorEvent.IO_ERROR, error, false, 0, true);
        }
        ldr.load(req);
    }
    
    public static function Delete(className : String, objectId : String, success : Dynamic = null, error : Dynamic = null) : Void
    {
        var url : String = Parse.api + "classes/" + className + "/" + objectId;
        Parse.Call(url, URLRequestMethod.DELETE, null, null, success, error);
    }
    
    public static function Get(className : String, params : Dynamic = null, where : Dynamic = null, success : Dynamic = null, error : Dynamic = null) : Void
    {
        var url : String = Parse.api + "classes/" + className;
        Parse.Call(url, URLRequestMethod.GET, params, where, success, error);
    }
    
    public static function Post(className : String, params : Dynamic = null, success : Dynamic = null, error : Dynamic = null) : Void
    {
        var url : String = Parse.api + "classes/" + className;
        Parse.Call(url, URLRequestMethod.POST, params, null, success, error);
    }
    
    public static function Put(className : String, objectId : String, params : Dynamic = null, success : Dynamic = null, error : Dynamic = null) : Void
    {
        var url : String = Parse.api + "classes/" + className + "/" + objectId;
        Parse.Call(url, URLRequestMethod.PUT, params, null, success, error);
    }
    
    public static function ResetPassword(email : String, success : Dynamic = null, error : Dynamic = null) : Void
    {
        var params : Dynamic = {
            email : email
        };
        var url : String = Parse.api + "requestPasswordReset";
        Parse.Call(url, URLRequestMethod.POST, params, null, success, error);
    }
    
    public static function SignIn(username : String, password : String, success : Dynamic = null, error : Dynamic = null) : Void
    {
        var params : Dynamic = {
            username : username,
            password : password
        };
        var url : String = Parse.api + "login";
        Parse.Call(url, URLRequestMethod.GET, params, null, success, error);
    }
    
    public static function SignUp(params : Dynamic, success : Dynamic = null, error : Dynamic = null) : Void
    {
        Parse.User.Post(params, success, error);
    }
    
    public static function Batch(requests : Array<Dynamic>, success : Dynamic, error : Dynamic) : Dynamic
    {
        var params : Dynamic = {
            requests : requests
        };
        var url : String = Parse.api + "batch";
        Parse.Call(url, URLRequestMethod.POST, params, null, success, error);
    }
}


