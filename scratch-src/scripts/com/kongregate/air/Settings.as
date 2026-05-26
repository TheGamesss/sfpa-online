package com.kongregate.air
{
   import com.kongregate.air.standalone.steam.ISteamAdapter;
   
   public class Settings
   {
      
      private static var _instance:Settings;
      
      public var bundleID:String = "";
      
      public var appVersion:String = "";
      
      public var debug:Boolean = true;
      
      public var enabled:Boolean = true;
      
      public var apiDomain:String = "m.kongregate.com";
      
      public var showSystemUi:Boolean = false;
      
      public var allowImmersiveMode:Boolean = false;
      
      public var keenProjectId:String = "";
      
      public var keenWriteKey:String = "";
      
      public var appleId:String = "";
      
      public var autoAnalyticsMode:String = KongregateAPI.AUTO_ANALYTICS_MODE_ENABLE_ALL;
      
      public var autoAnalyticsFilter:String = "";
      
      public var manageSharedCache:Boolean = true;
      
      public var swrveAppId:int = 0;
      
      public var swrveApiKey:String = "";
      
      public var swrveConfig:Object = null;
      
      public var deferAnalytics:Boolean = false;
      
      public var manageLifecycle:Boolean = true;
      
      public var adjustAppToken:String = "";
      
      public var adjustEnvironment:String = "";
      
      public var adjustEventTokenMap:Object = null;
      
      public var persistentWebView:Boolean = true;
      
      public var guildChat:Boolean = false;
      
      public var panelOrientationOverride:String = "";
      
      public var supportedPanelEvents:String = "";
      
      public var panelTransitionOverride:String = "";
      
      public var steamAdapter:ISteamAdapter = null;
      
      public var externalApi:Object = null;
      
      public function Settings()
      {
         super();
         if(_instance != null)
         {
            throw new Error("Settings is a singleton. Do not try to initialize it.");
         }
      }
      
      public static function get instance() : Settings
      {
         if(_instance == null)
         {
            _instance = new Settings();
         }
         return _instance;
      }
      
      public function get values() : Object
      {
         var option:String = null;
         var evt:String = null;
         var values:Object = {};
         values[KongregateAPI.KONGREGATE_OPTION_ENABLED] = this.enabled;
         values[KongregateAPI.KONGREGATE_OPTION_DOMAIN] = this.apiDomain;
         values[KongregateAPI.KONGREGATE_OPTION_DEBUG] = this.debug;
         values[KongregateAPI.KONGREGATE_OPTION_SHOW_SYSTEM_UI] = this.showSystemUi;
         values[KongregateAPI.KONGREGATE_OPTION_ALLOW_IMMERSIVE_MODE] = this.allowImmersiveMode;
         values[KongregateAPI.KONGREGATE_OPTION_KEEN_PROJECT_ID] = this.keenProjectId;
         values[KongregateAPI.KONGREGATE_OPTION_KEEN_WRITE_KEY] = this.keenWriteKey;
         values[KongregateAPI.KONGREGATE_OPTION_ANALYTICS_MODE] = this.autoAnalyticsMode;
         values[KongregateAPI.KONGREGATE_OPTION_AUTO_ANALYTICS_FILTER] = this.autoAnalyticsFilter;
         values[KongregateAPI.KONGREGATE_OPTION_MANAGE_SHARED_CACHE] = this.manageSharedCache;
         values[KongregateAPI.KONGREGATE_OPTION_SWRVE_APP_ID] = this.swrveAppId;
         values[KongregateAPI.KONGREGATE_OPTION_SWRVE_API_KEY] = this.swrveApiKey;
         values[KongregateAPI.KONGREGATE_OPTION_DEFER_ANALYTICS] = this.deferAnalytics;
         values[KongregateAPI.KONGREGATE_OPTION_MANAGE_LIFECYCLE] = this.manageLifecycle;
         values[KongregateAPI.KONGREGATE_OPTION_ADJUST_APP_TOKEN] = this.adjustAppToken;
         values[KongregateAPI.KONGREGATE_OPTION_ADJUST_ENVIRONMENT] = this.adjustEnvironment;
         values[KongregateAPI.KONGREGATE_OPTION_PERSISTENT_WEBVIEW] = this.persistentWebView;
         values[KongregateAPI.KONGREGATE_OPTION_GUILD_CHAT] = this.guildChat;
         values[KongregateAPI.KONGREGATE_OPTION_PANEL_ORIENTATION_OVERRIDE] = this.panelOrientationOverride;
         values[KongregateAPI.KONGREGATE_OPTION_SUPPORTED_PANEL_EVENTS] = this.supportedPanelEvents;
         values[KongregateAPI.KONGREGATE_OPTION_DEFAULT_PANEL_TRANSITION] = this.panelTransitionOverride;
         if(this.swrveConfig != null)
         {
            for(option in this.swrveConfig)
            {
               values[KongregateAPI.KONGREGATE_SWRVE_PREFIX + option] = this.swrveConfig[option];
            }
         }
         if(this.adjustEventTokenMap != null)
         {
            for(evt in this.adjustEventTokenMap)
            {
               values[KongregateAPI.KONGREGATE_ADJUST_PREFIX + evt] = this.adjustEventTokenMap[evt];
            }
         }
         return values;
      }
   }
}

