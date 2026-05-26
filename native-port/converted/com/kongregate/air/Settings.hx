package com.kongregate.air;

import flash.errors.Error;
import com.kongregate.air.standalone.steam.ISteamAdapter;

class Settings
{
    public static var instance(get, never) : Settings;
    public var values(get, never) : Dynamic;

    
    private static var _instance : Settings;
    
    public var bundleID : String = "";
    
    public var appVersion : String = "";
    
    public var debug : Bool = true;
    
    public var enabled : Bool = true;
    
    public var apiDomain : String = "m.kongregate.com";
    
    public var showSystemUi : Bool = false;
    
    public var allowImmersiveMode : Bool = false;
    
    public var keenProjectId : String = "";
    
    public var keenWriteKey : String = "";
    
    public var appleId : String = "";
    
    public var autoAnalyticsMode : String = KongregateAPI.AUTO_ANALYTICS_MODE_ENABLE_ALL;
    
    public var autoAnalyticsFilter : String = "";
    
    public var manageSharedCache : Bool = true;
    
    public var swrveAppId : Int = 0;
    
    public var swrveApiKey : String = "";
    
    public var swrveConfig : Dynamic = null;
    
    public var deferAnalytics : Bool = false;
    
    public var manageLifecycle : Bool = true;
    
    public var adjustAppToken : String = "";
    
    public var adjustEnvironment : String = "";
    
    public var adjustEventTokenMap : Dynamic = null;
    
    public var persistentWebView : Bool = true;
    
    public var guildChat : Bool = false;
    
    public var panelOrientationOverride : String = "";
    
    public var supportedPanelEvents : String = "";
    
    public var panelTransitionOverride : String = "";
    
    public var steamAdapter : ISteamAdapter = null;
    
    public var externalApi : Dynamic = null;
    
    public function new()
    {
        super();
        if (_instance != null)
        {
            throw new Error("Settings is a singleton. Do not try to initialize it.");
        }
    }
    
    private static function get_instance() : Settings
    {
        if (_instance == null)
        {
            _instance = new Settings();
        }
        return _instance;
    }
    
    private function get_values() : Dynamic
    {
        var option : String = null;
        var evt : String = null;
        var values : Dynamic = { };
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_ENABLED), this.enabled);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_DOMAIN), this.apiDomain);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_DEBUG), this.debug);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_SHOW_SYSTEM_UI), this.showSystemUi);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_ALLOW_IMMERSIVE_MODE), this.allowImmersiveMode);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_KEEN_PROJECT_ID), this.keenProjectId);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_KEEN_WRITE_KEY), this.keenWriteKey);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_ANALYTICS_MODE), this.autoAnalyticsMode);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_AUTO_ANALYTICS_FILTER), this.autoAnalyticsFilter);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_MANAGE_SHARED_CACHE), this.manageSharedCache);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_SWRVE_APP_ID), this.swrveAppId);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_SWRVE_API_KEY), this.swrveApiKey);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_DEFER_ANALYTICS), this.deferAnalytics);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_MANAGE_LIFECYCLE), this.manageLifecycle);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_ADJUST_APP_TOKEN), this.adjustAppToken);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_ADJUST_ENVIRONMENT), this.adjustEnvironment);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_PERSISTENT_WEBVIEW), this.persistentWebView);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_GUILD_CHAT), this.guildChat);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_PANEL_ORIENTATION_OVERRIDE), this.panelOrientationOverride);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_SUPPORTED_PANEL_EVENTS), this.supportedPanelEvents);
        Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_OPTION_DEFAULT_PANEL_TRANSITION), this.panelTransitionOverride);
        if (this.swrveConfig != null)
        {
            for (option in Reflect.fields(this.swrveConfig))
            {
                Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_SWRVE_PREFIX + option), option);
            }
        }
        if (this.adjustEventTokenMap != null)
        {
            for (evt in Reflect.fields(this.adjustEventTokenMap))
            {
                Reflect.setField(values, Std.string(KongregateAPI.KONGREGATE_ADJUST_PREFIX + evt), evt);
            }
        }
        return values;
    }
}


