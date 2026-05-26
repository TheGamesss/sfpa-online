package com.kongregate.air.standalone;

import flash.errors.Error;
import com.kongregate.air.KongregateAPI;
import com.kongregate.air.base.Internal;
import com.kongregate.air.event.APIEvent;
import com.kongregate.air.event.InternalEvent;
import com.kongregate.air.standalone.steam.ISteamAdapter;
import com.kongregate.as3.client.services.IInternalServices;
import flash.desktop.NativeApplication;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.ByteArray;
import flash.utils.Timer;

class StandaloneInternal extends Internal implements IInternalServices
{
    private var activeUser(get, never) : ActiveUser;
    private var gameID(get, never) : Float;
    public var isKongregate(get, never) : Bool;
    public var isExternal(get, never) : Bool;
    public var javascriptApiEnabled(get, never) : Bool;

    
    private static var DOMAIN_PREFIX_REGEX : as3hx.Compat.Regex = new as3hx.Compat.Regex('^([^.])+', "");
    
    private static var ANALYTICS_MODE_MAP : Dynamic = {
            ENABLE_ALL : "all",
            CLOUD : "cloud",
            DISABLE_ALL : "none"
        };
    
    private var mSteamAdapter : ISteamAdapter;
    
    private var mActiveUser : ActiveUser;
    
    private var mGameID : Float;
    
    private var mExternalConfig : Dynamic;
    
    public function new(api : KongregateAPI, gameID : Float)
    {
        super(api);
        this.mExternalConfig = {
                    swrve_app_id : KongregateAPI.settings.swrveAppId,
                    swrve_api_key : KongregateAPI.settings.swrveApiKey
                };
        this.mGameID = gameID;
        this.mSteamAdapter = KongregateAPI.settings.steamAdapter;
        this.mActiveUser = new ActiveUser(this);
        NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, this.onActivate);
        this.authenticateSteam();
        addEventListener(InternalEvent.INTERNAL_EVENT, this.onInternalEvent);
    }
    
    @:allow(com.kongregate.air.standalone)
    private static function getKongregateURL(path : String, subdomain : String = "www") : String
    {
        var domain : String = KongregateAPI.settings.apiDomain;
        if (subdomain != null)
        {
            domain = DOMAIN_PREFIX_REGEX.replace(domain, subdomain);
        }
        return "https://" + domain + path;
    }
    
    @:allow(com.kongregate.air.standalone)
    private static function bytesToHexString(bytes : ByteArray) : String
    {
        var n : String = null;
        var s : String = "";
        for (i in 0...bytes.length)
        {
            n = Std.string(bytes[i]);
            s += ((n.length < 2) ? "0" : "") + n;
        }
        return s;
    }
    
    @:allow(com.kongregate.air.standalone)
    private static function nextTick(callback : Dynamic) : Void
    {
        var timer : Timer;
        if (callback == null)
        {
            return;
        }
        timer = new Timer(0, 1);
        timer.addEventListener(TimerEvent.TIMER, function(e : TimerEvent) : Void
                {
                    callback();
                });
        timer.start();
    }
    
    @:allow(com.kongregate.air.standalone)
    private static function parseJSON(data : String) : Dynamic
    {
        var json : Dynamic = null;
        try
        {
            json = haxe.Json.parse(data);
        }
        catch (e : Error)
        {
            trace("Error parsing JSON: " + data);
        }
        return json;
    }
    
    private function onInternalEvent(evt : InternalEvent) : Void
    {
        if (KongregateAPI.settings.deferAnalytics && evt.name == InternalEvent.ACTIVE_USER_INITIALIZED)
        {
            this.fireReadyEvents();
        }
        else if (!KongregateAPI.settings.deferAnalytics && evt.name == InternalEvent.ANALYTICS_INITIALIZED)
        {
            this.fireReadyEvents();
        }
    }
    
    private function fireReadyEvents() : Void
    {
        trace("KongregateAPI is ready!");
        mAPI.dispatchEvent(new APIEvent(KongregateAPI.KONGREGATE_EVENT_READY, { }));
        mAPI.dispatchEvent(new APIEvent(KongregateAPI.KONGREGATE_EVENT_USER_CHANGED, { }));
        mAPI.dispatchEvent(new APIEvent(KongregateAPI.KONGREGATE_EVENT_GAME_AUTH_CHANGED, { }));
    }
    
    @:allow(com.kongregate.air.standalone)
    private function get_activeUser() : ActiveUser
    {
        return this.mActiveUser;
    }
    
    @:allow(com.kongregate.air.standalone)
    private function get_gameID() : Float
    {
        return this.mGameID;
    }
    
    @:allow(com.kongregate.air.standalone)
    private function fireAPIEvent(eventName : String) : Void
    {
        mAPI.dispatchEvent(new APIEvent(eventName, { }));
    }
    
    private function onActivate(e : Event) : Void
    {
        this.authenticateSteam();
    }
    
    private function authenticateSteam() : Void
    {
        trace("StandaloneInternal - authenticateSteam");
        if (this.mSteamAdapter == null)
        {
            trace("WARNING: No Steam Adapter. Unable to authenticate.");
            return;
        }
        this.mSteamAdapter.getAuthSessionTicket(function(ticketRaw : ByteArray) : Void
                {
                    var ticketHex : String = bytesToHexString(ticketRaw);
                    mActiveUser.authenticateSteam(mSteamAdapter.steamID, ticketHex);
                });
    }
    
    public function getUserId() : Float
    {
        return this.activeUser.userID;
    }
    
    public function getGameID() : Float
    {
        return this.mGameID;
    }
    
    public function getApiHost() : String
    {
        return KongregateAPI.settings.apiDomain;
    }
    
    private function get_isKongregate() : Bool
    {
        return false;
    }
    
    private function get_isExternal() : Bool
    {
        return true;
    }
    
    private function get_javascriptApiEnabled() : Bool
    {
        return false;
    }
    
    public function getAnalyticsMode() : String
    {
        return Reflect.field(ANALYTICS_MODE_MAP, Std.string(KongregateAPI.settings.autoAnalyticsMode));
    }
    
    public function getGameVersion() : String
    {
        return KongregateAPI.settings.appVersion;
    }
    
    public function getUsername() : String
    {
        return this.mActiveUser.username;
    }
    
    public function getExternalConfigValue(name : String, defaultValue : Dynamic) : Dynamic
    {
        return this.mExternalConfig[name] || defaultValue;
    }
}


