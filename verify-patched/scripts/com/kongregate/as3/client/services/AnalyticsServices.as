package com.kongregate.as3.client.services
{
   import com.adobe.serialization.json.JSON;
   import com.adobe.utils.DateUtil;
   import com.kongregate.as3.client.analytics.AnalyticsClient;
   import com.kongregate.as3.client.analytics.KeenClient;
   import com.kongregate.as3.client.analytics.SwrveClient;
   import com.kongregate.as3.client.storage.PersistentStore;
   import com.kongregate.as3.common.comm.IMessageHandler;
   import com.kongregate.as3.common.comm.Message;
   import com.kongregate.as3.common.comm.Opcode;
   import com.kongregate.as3.common.util.Log;
   import com.kongregate.as3.common.util.Utils;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import mx.utils.UIDUtil;
   
   public class AnalyticsServices implements IMessageHandler, IAnalyticsServices
   {
      
      private static const KONG_SDK_VERSION:String = "2.0.3";
      
      private static const KONG_SESSION_END_THRESHOLD_SECONDS:int = 5 * 60;
      
      private static const ANALYTICS_MODE_ALL:String = "all";
      
      private static const ANALYTICS_MODE_CLOUD:String = "cloud";
      
      private static const ANALYTICS_MODE_NONE:String = "none";
      
      private static const FOCUS_EVENTS_ENABLED:Boolean = false;
      
      public static const KONG_ANALYTICS_AD_TRACKING:String = "ad_tracking";
      
      public static const KONG_ANALYTICS_BUNDLE_ID:String = "bundle_id";
      
      public static const KONG_ANALYTICS_BROWSER:String = "browser";
      
      public static const KONG_ANALYTICS_BROWSER_VERSION:String = "browser_version";
      
      public static const KONG_ANALYTICS_CARRIER:String = "carrier";
      
      public static const KONG_ANALYTICS_CLIENT_OS_TYPE:String = "client_os_type";
      
      public static const KONG_ANALYTICS_CLIENT_OS_VERSION:String = "client_os_version";
      
      public static const KONG_ANALYTICS_CLIENT_VERSION:String = "client_version";
      
      public static const KONG_ANALYTICS_COUNTRY_CODE:String = "country_code";
      
      public static const KONG_ANALYTICS_DATA_CONNECTION_TYPE:String = "data_connection_type";
      
      public static const KONG_ANALYTICS_DAYS_RETAINED:String = "days_retained";
      
      public static const KONG_ANALYTICS_DEV_CLIENT_VERSION:String = "dev_client_version";
      
      public static const KONG_ANALYTICS_DEVICE_EVENT_ID:String = "device_event_id";
      
      public static const KONG_ANALYTICS_DEVICE_TYPE:String = "device_type";
      
      public static const KONG_ANALYTICS_EVENT_TIME:String = "event_time";
      
      public static const KONG_ANALYTICS_EXTERNAL_IP_ADDRESS:String = "external_ip_address";
      
      public static const KONG_ANALYTICS_FILTER_TYPE:String = "filter_type";
      
      public static const KONG_ANALYTICS_FIRST_CLIENT_VERSION:String = "first_client_version";
      
      public static const KONG_ANALYTICS_FIRST_PLAY_TIME_OFFSET:String = "first_play_time_offset";
      
      public static const KONG_ANALYTICS_FIRST_PLAY_TIME:String = "first_play_time";
      
      public static const KONG_ANALYTICS_FIRST_SDK_VERSION:String = "first_sdk_version";
      
      public static const KONG_ANALYTICS_FIRST_SERVER_VERSION:String = "first_server_version";
      
      public static const KONG_ANALYTICS_GAMECENTER_ID:String = "gamecenter_id";
      
      public static const KONG_ANALYTICS_GAMECENTER_ALIAS:String = "gamecenter_alias";
      
      public static const KONG_ANALYTICS_PUR_TIER:String = "pur_tier";
      
      public static const KONG_ANALYTICS_IDFA:String = "idfa";
      
      public static const KONG_ANALYTICS_IDFV:String = "idfv";
      
      public static const KONG_ANALYTICS_IMEI:String = "imei";
      
      public static const KONG_ANALYTICS_ANDROID_ID:String = "android_id";
      
      public static const KONG_ANALYTICS_IP_ADDRESS:String = "ip_address";
      
      public static const KONG_ANALYTICS_IS_VALID:String = "is_valid";
      
      public static const KONG_ANALYTICS_KONG_USER_ID:String = "kong_user_id";
      
      public static const KONG_ANALYTICS_KONG_USERNAME:String = "kong_username";
      
      public static const KONG_ANALYTICS_KONG_PLUS:String = "kong_plus";
      
      public static const KONG_ANALYTICS_LANG_CODE:String = "lang_code";
      
      public static const KONG_ANALYTICS_LAST_SKEW_REFRESH:String = "last_skew_refresh_time";
      
      public static const KONG_ANALYTICS_NUM_PURCHASES:String = "num_purchases";
      
      public static const KONG_ANALYTICS_NUM_SESSIONS:String = "num_sessions";
      
      public static const KONG_ANALYTICS_MAC_ADDRESS:String = "mac_address";
      
      public static const KONG_ANALYTICS_PLAYER_ID:String = "player_id";
      
      public static const KONG_ANALYTICS_SDK_VERSION:String = "sdk_version";
      
      public static const KONG_ANALYTICS_SERVER_VERSION:String = "server_version";
      
      public static const KONG_ANALYTICS_SESSION_ID:String = "session_id";
      
      public static const KONG_ANALYTICS_TIME_SKEW:String = "time_skew";
      
      public static const KONG_ANALYTICS_TOTAL_SPENT_IN_USD:String = "total_spent_in_usd";
      
      public static const KONG_ANALYTICS_EVENT_TIME_OFFSET:String = "event_time_offset";
      
      public static const KONG_ANALYTICS_SITE_VISITOR_ID:String = "site_visitor_id";
      
      public static const KONG_ANALYTICS_USD_SPENT_ON_KREDS:String = "usd_spent_on_kreds";
      
      public static const KONG_ANALYTICS_PLATFORM:String = "platform";
      
      public static const KONG_ANALYTICS_PKG_SRC:String = "pkg_src";
      
      public static const KONG_ANALYTICS_RETRY_COUNT:String = "retry_count";
      
      public static const KONG_ANALYTICS_AUTO_EVENT:String = "auto_event";
      
      public static const KONG_ANALYTICS_EVENT_SESSION_START:String = "session_starts";
      
      public static const KONG_ANALYTICS_IS_FROM_BACKGROUND:String = "is_from_background";
      
      public static const KONG_ANALYTICS_EVENT_SESSION_END:String = "session_ends";
      
      public static const KONG_ANALYTICS_SESSION_LENGTH:String = "session_length_seconds";
      
      public static const KONG_ANALYTICS_SESSION_END_TIME:String = "session_end_time";
      
      public static const KONG_ANALYTICS_DID_CRASH:String = "did_crash";
      
      public static const KONG_ANALYTICS_EVENT_FOREGROUND_VISITS:String = "foreground_visits";
      
      public static const KONG_ANALYTICS_BACKGROUND_TIME:String = "background_time";
      
      public static const KONG_ANALYTICS_EVENT_BACKGROUND_VISITS:String = "background_visits";
      
      public static const KONG_ANALYTICS_FOREGROUND_TIME:String = "foreground_time";
      
      public static const KONG_ANALYTICS_EVENT_INSTALLS:String = "installs";
      
      public static const KONG_ANALYTICS_STUB_FIELD:String = "stub_field";
      
      public static const KONG_ANALYTICS_UTM_SOURCE:String = "utm_source";
      
      public static const KONG_ANALYTICS_UTM_MEDIUM:String = "utm_medium";
      
      public static const KONG_ANALYTICS_UTM_TERM:String = "utm_term";
      
      public static const KONG_ANALYTICS_UTM_CONTENT:String = "utm_content";
      
      public static const KONG_ANALYTICS_UTM_CAMPAIGN:String = "utm_campaign";
      
      public static const KONG_ANALYTICS_EVENT_IAP_ATTEMPTS:String = "iap_attempts";
      
      public static const KONG_ANALYTICS_EVENT_IAP_TRANSACTIONS:String = "iap_transactions";
      
      public static const KONG_ANALYTICS_EVENT_IAP_FAILS:String = "iap_fails";
      
      public static const KONG_ANALYTICS_USD_COST:String = "usd_cost";
      
      public static const KONG_ANALYTICS_PRODUCT_ID:String = "product_id";
      
      public static const KONG_ANALYTICS_IAP_ID:String = "iap_id";
      
      public static const KONG_ANALYTICS_FAIL_REASON:String = "fail_reason";
      
      public static const KONG_ANALYTICS_RECEIPT_ID:String = "receipt_id";
      
      public static const KONG_ANALYTICS_LOCAL_CURRENCY_TYPE:String = "local_currency_type";
      
      public static const KONG_ANALYTICS_LOCAL_CURRENCY_COST:String = "local_currency_cost";
      
      public static const KONG_PURCHASE_SUCCESS:String = "SUCCESS";
      
      public static const KONG_PURCHASE_FAIL:String = "FAIL";
      
      public static const KONG_PURCHASE_RECEIPT_FAIL:String = "RECEIPT_FAIL";
      
      public static const KONG_RECEIPT_IP_NONE:String = "none";
      
      public static const KONG_ANALYTICS_EVENT_PLAYER_INFO:String = "player_info";
      
      public static const KONG_ANALYTICS_KONG_JOIN_DATE:String = "kong_join_date";
      
      public static const KONG_ANALYTICS_PUR_LINK_DATE:String = "pur_link_date";
      
      public static const KONG_ANALYTICS_TWITTER_ID:String = "twitter_id";
      
      public static const KONG_ANALYTICS_FB_USER_ID:String = "fb_user_id";
      
      public static const KONG_ANALYTICS_FB_USERNAME:String = "fb_username";
      
      public static const KONG_ANALYTICS_FB_EMAIL:String = "fb_email";
      
      public static const KONG_ANALYTICS_EMAIL:String = "email";
      
      public static const KONG_ANALYTICS_EVENT_INVALID_STATES:String = "invalid_states";
      
      public static const KONG_ANALYTICS_FILTER_TYPE_BAD_STORAGE:String = "BadStorage";
      
      private static const AUTO_EVENTS:Array = [KONG_ANALYTICS_EVENT_INSTALLS,KONG_ANALYTICS_EVENT_SESSION_START,KONG_ANALYTICS_EVENT_SESSION_END,KONG_ANALYTICS_EVENT_FOREGROUND_VISITS,KONG_ANALYTICS_EVENT_BACKGROUND_VISITS,KONG_ANALYTICS_EVENT_IAP_ATTEMPTS,KONG_ANALYTICS_EVENT_IAP_FAILS,KONG_ANALYTICS_EVENT_IAP_TRANSACTIONS,KONG_ANALYTICS_EVENT_INVALID_STATES];
      
      private static const PLAYER_INFO_SCRAPED_FIELDS:Array = [KONG_ANALYTICS_TWITTER_ID,KONG_ANALYTICS_FB_USER_ID,KONG_ANALYTICS_FB_USERNAME,KONG_ANALYTICS_FB_EMAIL,KONG_ANALYTICS_EMAIL];
      
      private static const PRICING_TIERS:Array = [0.99,1.99,2.99,3.99,4.99,5.99,6.99,7.99,8.99,9.99,10.99,11.99,12.99,13.99,14.99,15.99,16.99,17.99,18.99,19.99,20.99,21.99,22.99,23.99,24.99,25.99,26.99,27.99,28.99,29.99,30.99,31.99,32.99,33.99,34.99,35.99,36.99,37.99,38.99,39.99,40.99,41.99,42.99,43.99,44.99,45.99,46.99,47.99,48.99,49.99,54.99,59.99,64.99,69.99,74.99,79.99,84.99,89.99,94.99,99.99,109.99,119.99,124.99,129.99,139.99,149.99,159.99,169.99,174.99,179.99,189.99,199.99,209.99,219.99,229.99,239.99,249.99,299.99,349.99,399.99,449.99,499.99,599.99,699.99,799.99,899.99,999.99];
      
      private static const COMMON_PROPERTIES:String = "common_properties";
      
      private static var sInstance:AnalyticsServices = null;
      
      private static var mItemListRetries:int = 0;
      
      private var mKongServices:IInternalServices = null;
      
      private var mBundleId:String = "unknown";
      
      private var mInitialized:Boolean = false;
      
      private var mAnalyticsEnabled:Boolean = false;
      
      private var mEnabled:Boolean = false;
      
      private var mConfig:Object = null;
      
      private var mSvid:String;
      
      private var mClientVersion:String;
      
      private var mPreviousSession:Object = null;
      
      private var mSession:Object = null;
      
      protected var mKongStaticVariables:Object = {};
      
      private var mKongAutomaticVariables:Object = {};
      
      private var mTotalSpentUSD:Number = 0;
      
      private var mNumPurchases:Number = 0;
      
      private var mBackgroundTime:int = 0;
      
      private var mForegroundTime:int = Utils.getTimeSeconds();
      
      private var mThrottled:Boolean = false;
      
      private var mAutoAnalyticsMode:String = "all";
      
      private var mKredExchangeRate:Number = 0.092;
      
      private var mClients:Object = {};
      
      private var mPersistentStore:PersistentStore;
      
      private var mPendingEvents:Array;
      
      private var mEventQueues:Object;
      
      protected var mSavedData:Object;
      
      private var mItems:Array;
      
      private var mProductId:String = null;
      
      private var mPriceUSD:Number = 0;
      
      private var mSubmitLocks:Object = {};
      
      private var mHeartbeatTimer:Timer = new Timer(15000);
      
      private var mCommonProperties:Object = {};
      
      private var mCommonPropertiesCallback:Function = null;
      
      private var mAutomaticVariablesListener:Function = null;
      
      public function AnalyticsServices(services:IInternalServices)
      {
         super();
         this.mKongServices = services;
         if(services.isKongregate && !services.javascriptApiEnabled)
         {
            this.setup();
         }
      }
      
      public static function getInstance(services:IInternalServices = null) : AnalyticsServices
      {
         if(sInstance == null)
         {
            sInstance = new AnalyticsServices(services);
         }
         return sInstance;
      }
      
      internal function setup() : void
      {
         var time:Date = null;
         var firstPlay:Boolean = false;
         if(this.mPersistentStore)
         {
            return;
         }
         try
         {
            this.mAutoAnalyticsMode = this.mKongServices.getAnalyticsMode();
            this.mAnalyticsEnabled = this.mAutoAnalyticsMode != null;
            if(!this.mAnalyticsEnabled)
            {
               Log.debug("Analytics API not enabled");
               return;
            }
            Log.debug("Analytics mode: " + this.mAutoAnalyticsMode);
            this.requestAnalyticsPayload();
            this.mClientVersion = this.mKongServices.getGameVersion();
            this.mPersistentStore = this.getPersistentStore();
            this.mPendingEvents = this.mPersistentStore.get("pending_events",[]);
            this.mEventQueues = this.mPersistentStore.get("event_queues",{});
            this.mSavedData = this.mPersistentStore.get("saved_data",{});
            this.mSavedData[COMMON_PROPERTIES] = this.mSavedData[COMMON_PROPERTIES] || {};
            this.mCommonProperties = this.mSavedData[COMMON_PROPERTIES];
            this.mItems = this.mPersistentStore.get("items",[]);
            if(this.autoAnalyticsDisabled())
            {
               Log.debug("Auto analytics disabled");
            }
            else if(this.autoAnalyticsExcludesServer())
            {
               Log.debug("Game has a server, only tracking a subset of analytics automatically");
            }
            else
            {
               Log.debug("Automatic analytics enabled");
            }
            if(this.mKongServices.isExternal)
            {
               this.mSavedData[KONG_ANALYTICS_PLAYER_ID] = this.mSavedData[KONG_ANALYTICS_PLAYER_ID] || UIDUtil.createUID();
            }
            this.requestItems(this.mKongServices);
            time = new Date();
            firstPlay = !this.mSavedData[KONG_ANALYTICS_FIRST_PLAY_TIME];
            this.mSavedData[KONG_ANALYTICS_FIRST_PLAY_TIME] = this.mSavedData[KONG_ANALYTICS_FIRST_PLAY_TIME] || DateUtil.toW3CDTF(time,true);
            this.mSavedData[KONG_ANALYTICS_FIRST_SDK_VERSION] = this.mSavedData[KONG_ANALYTICS_FIRST_SDK_VERSION] || this.getSDKVersion();
            this.mSavedData[KONG_ANALYTICS_FIRST_CLIENT_VERSION] = this.mSavedData[KONG_ANALYTICS_FIRST_CLIENT_VERSION] || this.mClientVersion;
            if(this.mSavedData[KONG_ANALYTICS_FIRST_PLAY_TIME_OFFSET] == undefined)
            {
               this.mSavedData[KONG_ANALYTICS_FIRST_PLAY_TIME_OFFSET] = this.timeZoneOffset();
            }
            if(this.mSavedData[KONG_ANALYTICS_BUNDLE_ID])
            {
               this.mBundleId = this.mSavedData[KONG_ANALYTICS_BUNDLE_ID];
            }
            if(firstPlay)
            {
               Log.debug("Analytics: First play");
               this.installEvent();
            }
            this.startSession();
            this.foregroundEvent();
            this.buildKongStaticVars();
         }
         catch(e:Error)
         {
            Log.error("Error initializing analytics service: " + e.toString());
            Log.error(e.getStackTrace());
         }
      }
      
      public function handleMessage(msg:Message) : void
      {
         var data:Object = null;
         if(msg.getOpcode() == Opcode.OP_ANALYTICS_PAYLOAD)
         {
            data = msg.getParam(Opcode.PARAM_DATA);
            this.initialize(data.info,data.payload);
         }
         else if(msg.getOpcode() == Opcode.OP_THROTTLE)
         {
            this.onApplicationThrottled(true);
         }
         else if(msg.getOpcode() == Opcode.OP_RESUME)
         {
            this.onApplicationThrottled(false);
         }
      }
      
      public function addEvent(collection:String, evt:Object) : void
      {
         if(this.mAnalyticsEnabled)
         {
            if(!this.autoAnalyticsDisabled() && AUTO_EVENTS.indexOf(collection) >= 0)
            {
               Log.warn("Ignoring analytics event: " + collection + " since it is a kong-automatic event.");
               return;
            }
            this.addEventInternal(collection,this.objectify(evt));
         }
      }
      
      private function addAutoEvent(collection:String, evt:Object) : void
      {
         if(this.autoAnalyticsDisabled())
         {
            return;
         }
         evt = this.objectify(evt);
         evt[KONG_ANALYTICS_AUTO_EVENT] = true;
         this.addEventInternal(collection,evt);
      }
      
      public function setCommonPropsCallback(callback:Function) : void
      {
         this.mCommonPropertiesCallback = callback;
         this.updateCommonProperties();
      }
      
      public function setCommonProperties(props:Object) : void
      {
         props = this.objectify(props);
         this.setCommonPropsCallback(function():Object
         {
            return props;
         });
      }
      
      public function updateCommonProperties() : void
      {
         if(!this.mAnalyticsEnabled)
         {
            return;
         }
         try
         {
            if(this.mCommonPropertiesCallback != null)
            {
               this.mCommonProperties = this.objectify(this.mCommonPropertiesCallback());
               this.mSavedData[COMMON_PROPERTIES] = this.mCommonProperties;
               if(Boolean(this.mCommonProperties[KONG_ANALYTICS_SERVER_VERSION]) && !this.mSavedData[KONG_ANALYTICS_FIRST_SERVER_VERSION])
               {
                  this.mSavedData[KONG_ANALYTICS_FIRST_SERVER_VERSION] = this.mCommonProperties[KONG_ANALYTICS_SERVER_VERSION];
               }
            }
         }
         catch(e:Error)
         {
            Log.error("Error updating common properties: " + e);
         }
      }
      
      public function addFilterType(filterType:String) : void
      {
         var validation:RegExp;
         var filter:String;
         var filters:Array;
         if(!this.mAnalyticsEnabled)
         {
            return;
         }
         validation = /^[a-zA-Z0-9_]+$/;
         if(!filterType || !validation.test(filterType))
         {
            Log.warn("Invalid filterType: " + filterType + ", must be alpha_numeric");
            return;
         }
         filter = this.mSavedData[KONG_ANALYTICS_FILTER_TYPE] || "";
         filters = filter.split(",");
         if(filters.indexOf(filterType) < 0)
         {
            filters.push(filterType);
            filters.sort();
            this.mSavedData[KONG_ANALYTICS_FILTER_TYPE] = filters.filter(function(e:String, index:int, array:Array):Boolean
            {
               return e.length > 0;
            }).join(",");
            this.mPersistentStore.flush();
            Log.info("Filter type added: " + filterType);
         }
      }
      
      public function getAutoLongProperty(field:String) : Number
      {
         if(!this.mAnalyticsEnabled)
         {
            return NaN;
         }
         return this.getAutoDoubleProperty(field);
      }
      
      public function getAutoLongLongProperty(field:String) : Number
      {
         if(!this.mAnalyticsEnabled)
         {
            return NaN;
         }
         return this.getAutoDoubleProperty(field);
      }
      
      public function getAutoStringProperty(field:String) : String
      {
         if(!this.mAnalyticsEnabled)
         {
            return null;
         }
         var autoProperties:Object = this.getKongAutomaticVariables();
         if(autoProperties[field] is String)
         {
            return autoProperties[field] as String;
         }
         Log.warn("Property is not a string: " + field);
         return null;
      }
      
      public function getAutoBoolProperty(field:String) : Boolean
      {
         if(!this.mAnalyticsEnabled)
         {
            return false;
         }
         var autoProperties:Object = this.getKongAutomaticVariables();
         return autoProperties[field] as Boolean;
      }
      
      public function getAutoDoubleProperty(field:String) : Number
      {
         if(!this.mAnalyticsEnabled)
         {
            return NaN;
         }
         var autoProperties:Object = this.getKongAutomaticVariables();
         return autoProperties[field] as Number;
      }
      
      public function getAutoIntProperty(field:String) : int
      {
         if(!this.mAnalyticsEnabled)
         {
            return NaN;
         }
         var autoProperties:Object = this.getKongAutomaticVariables();
         return autoProperties[field] as int;
      }
      
      public function getAutoUTCProperty(field:String) : String
      {
         return this.getAutoStringProperty(field);
      }
      
      public function getAutoPropertiesJSON() : String
      {
         if(!this.mAnalyticsEnabled)
         {
            return null;
         }
         this.buildKongAutomaticVariables();
         return com.adobe.serialization.json.JSON.encode(this.mKongAutomaticVariables);
      }
      
      public function startPurchase(product:*, gameFields:Object) : void
      {
         if(this.autoAnalyticsDisabled())
         {
            return;
         }
         var productId:String = this.getProductId(product);
         if(!productId)
         {
            Log.warn("startPurchase: Can\'t start purchase with null productId, param was: " + product);
            return;
         }
         this.mPriceUSD = this.getUSDPrice(productId,gameFields);
         if(this.mSavedData[KONG_ANALYTICS_IAP_ID])
         {
            Log.warn("startPurchase: invoked before active transaction finished. iap_ids may mismatch.");
         }
         this.mSavedData[KONG_ANALYTICS_IAP_ID] = UIDUtil.createUID();
         this.mProductId = productId;
         Log.debug("IAP FLOW STEP: startPurchase(): " + productId);
         this.addIAPEvent(null,this.objectify(gameFields),KONG_ANALYTICS_EVENT_IAP_ATTEMPTS);
      }
      
      public function finishPurchase(resultCode:String, transactionId:String, gameFields:Object) : void
      {
         if(this.autoAnalyticsDisabled())
         {
            return;
         }
         Log.debug("IAP FLOW STEP: finishPurchase(): " + this.mProductId + ", transactionId: " + transactionId + ", resultCode: " + resultCode);
         if(KONG_PURCHASE_SUCCESS == resultCode)
         {
            ++this.mNumPurchases;
            this.mTotalSpentUSD += this.mPriceUSD;
            this.addIAPEvent(transactionId,this.objectify(gameFields),KONG_ANALYTICS_EVENT_IAP_TRANSACTIONS);
            if(this.mKongServices.isExternal)
            {
               this.mSavedData[KONG_ANALYTICS_NUM_PURCHASES] = this.mNumPurchases;
               this.mSavedData[KONG_ANALYTICS_TOTAL_SPENT_IN_USD] = this.mTotalSpentUSD;
            }
         }
         else
         {
            this.addIAPFailEvent(transactionId,this.objectify(gameFields));
         }
      }
      
      public function setAutomaticVariablesListener(listener:Function) : void
      {
         if(!this.mAnalyticsEnabled)
         {
            return;
         }
         this.mAutomaticVariablesListener = listener;
         this.getKongAutomaticVariables();
      }
      
      private function initialize(info:Object, payload:Object) : void
      {
         var playerID:String = null;
         var service:String = null;
         var pendingEvent:Object = null;
         Log.info("Analytics payload received");
         if(!this.mAnalyticsEnabled)
         {
            return;
         }
         if(payload.browser.browser.toLowerCase() == "safari" && this.isExternalInterfaceAvailable())
         {
            Log.warn("Analytics disabled on Safari for iframe games");
            this.mAnalyticsEnabled = false;
            return;
         }
         this.mConfig = info;
         var keenConfig:Object = this.mConfig.keen;
         var swrveConfig:Object = this.mConfig.swrve;
         this.mSvid = payload.site_visitor_uid;
         if(payload.kger)
         {
            this.mKredExchangeRate = payload.kger;
         }
         this.updateKongStaticVars(payload);
         if(this.mInitialized)
         {
            return;
         }
         this.mInitialized = true;
         if(Boolean(keenConfig) && Boolean(keenConfig.application_id) && Boolean(keenConfig.key))
         {
            Log.debug("Keen initialized");
            this.mClients.keen = new KeenClient(keenConfig.application_id,keenConfig.key);
         }
         if(Boolean(swrveConfig) && Boolean(swrveConfig.application_id) && Boolean(swrveConfig.key))
         {
            playerID = this.mKongServices.isKongregate ? this.mSvid : this.mSavedData[KONG_ANALYTICS_PLAYER_ID];
            this.mClients.swrve = new SwrveClient(swrveConfig.application_id,swrveConfig.key,playerID,this.mClientVersion);
            Log.debug("Swrve initialized: " + playerID);
         }
         if(!this.mClients.keen && !this.mClients.swrve)
         {
            Log.debug("Analytics not initialized, no services configured");
            this.mPersistentStore.destroy();
         }
         else
         {
            this.mEnabled = true;
            this.mHeartbeatTimer.addEventListener(TimerEvent.TIMER,this.onHeartbeatTimer);
            this.mHeartbeatTimer.start();
            for(service in this.mClients)
            {
               this.mEventQueues[service] = this.mEventQueues[service] || [];
               this.mSubmitLocks[service] = false;
            }
            if(this.mPendingEvents.length > 0)
            {
               Log.debug("Flushing " + this.mPendingEvents.length + " pending event(s)");
               for each(pendingEvent in this.mPendingEvents)
               {
                  this.addEventInternal(pendingEvent.name,pendingEvent.event,false);
               }
               Utils.clear(this.mPendingEvents);
            }
            for(service in this.mClients)
            {
               this.flushQueue(service);
            }
            this.sendSwrveUserEvent();
            this.addEvent(KONG_ANALYTICS_EVENT_PLAYER_INFO,{});
         }
      }
      
      private function enqueueEvent(collection:String, evt:Object) : Boolean
      {
         if(!this.mConfig)
         {
            if(!this.autoAnalyticsDisabled() || !evt[KONG_ANALYTICS_AUTO_EVENT])
            {
               Log.debug("Queueing pending event: " + collection);
               this.mPendingEvents.push({
                  "name":collection,
                  "event":evt
               });
            }
            return true;
         }
         return false;
      }
      
      private function addEventInternal(collection:String, evt:Object, flush:Boolean = true) : void
      {
         var service:String = null;
         var client:AnalyticsClient = null;
         var queue:Array = null;
         var swrveEvent:Boolean = collection.indexOf(SwrveClient.SWRVE_EVENT_IDENTIFIER) == 0;
         if(!swrveEvent && !evt[KONG_ANALYTICS_RETRY_COUNT])
         {
            evt = Utils.merge(this.buildEventSpecificVariables(),evt);
         }
         if(this.enqueueEvent(collection,evt))
         {
            return;
         }
         if(!this.mEnabled)
         {
            return;
         }
         if(AnalyticsServices.KONG_ANALYTICS_EVENT_PLAYER_INFO == collection)
         {
            this.refreshPlayerInfoFields(evt);
         }
         var autoVariables:Object = this.getKongAutomaticVariables();
         var mergedEvent:Object = {};
         if(swrveEvent)
         {
            mergedEvent = evt;
         }
         else
         {
            Utils.merge(mergedEvent,this.objectify(this.mCommonProperties));
            if(evt[AnalyticsServices.KONG_ANALYTICS_AUTO_EVENT])
            {
               Utils.merge(mergedEvent,autoVariables);
               Utils.merge(mergedEvent,evt);
            }
            else
            {
               Utils.merge(mergedEvent,evt);
               Utils.merge(mergedEvent,autoVariables);
            }
         }
         if(SwrveClient.SWRVE_SESSION_START_IDENTIFIER == collection)
         {
            flush = true;
         }
         Log.debug("Adding event: " + collection + ", flush=" + flush);
         for(service in this.mClients)
         {
            client = this.mClients[service];
            if(client.handlesEvent(collection))
            {
               queue = this.mEventQueues[service];
               queue.push({
                  "name":collection,
                  "event":mergedEvent
               });
               if(flush)
               {
                  this.flushQueue(service);
               }
            }
         }
         if(flush)
         {
            this.mPersistentStore.flush();
         }
      }
      
      private function flushQueue(service:String) : void
      {
         var client:AnalyticsClient = this.mClients[service];
         var events:Array = this.mEventQueues[service];
         if(client)
         {
            if(!Utils.isEmpty(events) && !this.mSubmitLocks[service])
            {
               Log.debug("Flushing event queue for " + service);
               client.sendEvents(events,function(result:Object):void
               {
                  mSubmitLocks[service] = false;
                  mPersistentStore.flush();
                  setTimeout(function():void
                  {
                     flushQueue(service);
                  },result.success ? 1000 : 10000);
               });
               this.mSubmitLocks[service] = true;
            }
         }
         else
         {
            Log.error("No client for service " + service);
         }
      }
      
      private function buildEventSpecificVariables() : Object
      {
         var eventSpecificVariables:Object = {};
         eventSpecificVariables[KONG_ANALYTICS_RETRY_COUNT] = 0;
         if(this.autoAnalyticsDisabled())
         {
            return eventSpecificVariables;
         }
         eventSpecificVariables[KONG_ANALYTICS_DEVICE_EVENT_ID] = UIDUtil.createUID();
         eventSpecificVariables[KONG_ANALYTICS_EVENT_TIME] = DateUtil.toW3CDTF(new Date(),true);
         eventSpecificVariables[KONG_ANALYTICS_EVENT_TIME_OFFSET] = this.timeZoneOffset();
         return eventSpecificVariables;
      }
      
      private function buildKongAutomaticVariables() : void
      {
         if(this.mPersistentStore.hasFailed())
         {
            this.addFilterType(KONG_ANALYTICS_FILTER_TYPE_BAD_STORAGE);
         }
         if(this.autoAnalyticsDisabled())
         {
            this.mKongAutomaticVariables = {};
            return;
         }
         var automaticVariables:Object = {};
         automaticVariables[KONG_ANALYTICS_FILTER_TYPE] = this.mSavedData[KONG_ANALYTICS_FILTER_TYPE] || "";
         automaticVariables[KONG_ANALYTICS_NUM_PURCHASES] = this.mNumPurchases;
         automaticVariables[KONG_ANALYTICS_DAYS_RETAINED] = this.daysRetained();
         if(!this.autoAnalyticsExcludesServer())
         {
            automaticVariables[KONG_ANALYTICS_TOTAL_SPENT_IN_USD] = this.mTotalSpentUSD;
         }
         this.mKongAutomaticVariables = Utils.merge(automaticVariables,this.mKongStaticVariables);
      }
      
      private function getKongAutomaticVariables() : Object
      {
         if(!this.mAnalyticsEnabled)
         {
            return {};
         }
         this.updateCommonProperties();
         this.buildKongAutomaticVariables();
         this.mAutomaticVariablesListener && this.mAutomaticVariablesListener(this.mKongAutomaticVariables);
         return this.mKongAutomaticVariables;
      }
      
      private function timeZoneOffset() : int
      {
         return new Date().getTimezoneOffset() / -60;
      }
      
      private function buildKongStaticVars() : void
      {
         var osType:String;
         var osVersion:String;
         var playerID:String = null;
         var os:Array = null;
         if(this.autoAnalyticsDisabled())
         {
            return;
         }
         this.mKongStaticVariables[KONG_ANALYTICS_BUNDLE_ID] = this.mBundleId;
         this.mKongStaticVariables[KONG_ANALYTICS_KONG_USERNAME] = this.mKongServices.getUsername();
         this.mKongStaticVariables[KONG_ANALYTICS_KONG_USER_ID] = this.mKongServices.getUserId();
         this.mKongStaticVariables[KONG_ANALYTICS_SITE_VISITOR_ID] = this.mKongServices.isKongregate ? this.mSvid : "";
         this.mKongStaticVariables[KONG_ANALYTICS_SESSION_ID] = this.mSession.id;
         this.mKongStaticVariables[KONG_ANALYTICS_SDK_VERSION] = this.getSDKVersion();
         this.mKongStaticVariables[KONG_ANALYTICS_NUM_SESSIONS] = this.getNumSessions();
         this.mKongStaticVariables[KONG_ANALYTICS_CLIENT_VERSION] = this.mClientVersion;
         this.mKongStaticVariables[KONG_ANALYTICS_DEV_CLIENT_VERSION] = this.mClientVersion;
         this.mKongStaticVariables[KONG_ANALYTICS_FIRST_CLIENT_VERSION] = this.mSavedData[KONG_ANALYTICS_FIRST_CLIENT_VERSION];
         this.mKongStaticVariables[KONG_ANALYTICS_FIRST_SERVER_VERSION] = this.mSavedData[KONG_ANALYTICS_FIRST_SERVER_VERSION] || null;
         if(this.mKongServices.isKongregate)
         {
            this.mKongStaticVariables[KONG_ANALYTICS_PLATFORM] = "kongregate_web";
         }
         else
         {
            this.mKongStaticVariables[KONG_ANALYTICS_PLATFORM] = this.mKongServices.getExternalConfigValue("platform","external_web");
         }
         if(!this.autoAnalyticsExcludesServer())
         {
            playerID = this.mKongServices.isKongregate ? this.mSvid : this.mSavedData[KONG_ANALYTICS_PLAYER_ID];
            this.mKongStaticVariables[KONG_ANALYTICS_PLAYER_ID] = playerID;
         }
         osType = "Unknown";
         osVersion = "Unknown";
         try
         {
            os = Capabilities.os.split(" ");
            osType = os.shift();
            if(os[0] == "OS")
            {
               osType += "OS";
               os.shift();
            }
            osVersion = os.join(" ");
         }
         catch(e:Error)
         {
            Log.error("Error parsing OS version: " + e.toString());
         }
         this.mKongStaticVariables[KONG_ANALYTICS_CLIENT_OS_TYPE] = osType;
         this.mKongStaticVariables[KONG_ANALYTICS_CLIENT_OS_VERSION] = osVersion;
         this.mKongStaticVariables[KONG_ANALYTICS_DEVICE_TYPE] = "browser";
         this.mKongStaticVariables[KONG_ANALYTICS_MAC_ADDRESS] = null;
         this.mKongStaticVariables[KONG_ANALYTICS_FIRST_PLAY_TIME] = this.mSavedData[KONG_ANALYTICS_FIRST_PLAY_TIME];
         this.mKongStaticVariables[KONG_ANALYTICS_FIRST_SDK_VERSION] = this.mSavedData[KONG_ANALYTICS_FIRST_SDK_VERSION];
         this.mKongStaticVariables[KONG_ANALYTICS_FIRST_PLAY_TIME_OFFSET] = this.mSavedData[KONG_ANALYTICS_FIRST_PLAY_TIME_OFFSET];
         this.mKongStaticVariables[KONG_ANALYTICS_LANG_CODE] = Capabilities.language;
         this.mKongStaticVariables[KONG_ANALYTICS_IDFA] = null;
         this.mKongStaticVariables[KONG_ANALYTICS_IDFV] = null;
         this.mKongStaticVariables[KONG_ANALYTICS_ANDROID_ID] = null;
         this.mKongStaticVariables[KONG_ANALYTICS_IMEI] = null;
         this.mKongStaticVariables[KONG_ANALYTICS_AD_TRACKING] = false;
         this.mKongStaticVariables[KONG_ANALYTICS_DATA_CONNECTION_TYPE] = "wifi";
         this.mKongStaticVariables[KONG_ANALYTICS_CARRIER] = null;
         this.mKongStaticVariables[KONG_ANALYTICS_GAMECENTER_ID] = null;
         this.mKongStaticVariables[KONG_ANALYTICS_GAMECENTER_ALIAS] = null;
         this.mKongStaticVariables[KONG_ANALYTICS_IS_VALID] = true;
         this.mKongStaticVariables[KONG_ANALYTICS_PKG_SRC] = "web";
      }
      
      public function processAnalyticsPayload(payload:Object) : void
      {
         this.updateKongStaticVars(payload);
      }
      
      protected function getSDKVersion() : String
      {
         return KONG_SDK_VERSION;
      }
      
      protected function updateKongStaticVars(payload:Object) : void
      {
         if(this.autoAnalyticsDisabled())
         {
            return;
         }
         this.mBundleId = "com.kongregate.web." + payload.game_permalink;
         if(this.mKongServices.isExternal)
         {
            this.mBundleId += ".external";
         }
         this.mSavedData[KONG_ANALYTICS_BUNDLE_ID] = this.mBundleId;
         this.buildKongStaticVars();
         this.mKongStaticVariables[KONG_ANALYTICS_KONG_PLUS] = payload.premium;
         this.mKongStaticVariables[KONG_ANALYTICS_PUR_TIER] = payload.powerup_rewards_tier;
         this.mSavedData[KONG_ANALYTICS_PUR_LINK_DATE] = payload.pur_link_date || null;
         this.mSavedData[KONG_ANALYTICS_KONG_JOIN_DATE] = payload.join_date || null;
         this.mKongStaticVariables[KONG_ANALYTICS_USD_SPENT_ON_KREDS] = Number(payload.spent_on_kreds);
         if(this.mKongServices.isExternal)
         {
            this.mTotalSpentUSD = Number(this.mSavedData[KONG_ANALYTICS_TOTAL_SPENT_IN_USD]) || 0;
            this.mNumPurchases = Number(this.mSavedData[KONG_ANALYTICS_NUM_PURCHASES]) || 0;
         }
         else
         {
            this.mTotalSpentUSD = payload.spent_usd;
            this.mNumPurchases = payload.num_purchases;
         }
         this.mKongStaticVariables[KONG_ANALYTICS_BROWSER] = payload.browser.browser;
         this.mKongStaticVariables[KONG_ANALYTICS_BROWSER_VERSION] = payload.browser.version;
         this.mKongStaticVariables[KONG_ANALYTICS_IP_ADDRESS] = payload.ip_address;
         this.mKongStaticVariables[KONG_ANALYTICS_EXTERNAL_IP_ADDRESS] = payload.ip_address;
         var skew:uint = Math.abs(new Date().getTime() - Utils.parseDate(payload.server_time,new Date()).getTime()) / 1000;
         this.mKongStaticVariables[KONG_ANALYTICS_TIME_SKEW] = skew;
         this.mSavedData[KONG_ANALYTICS_LAST_SKEW_REFRESH] = payload.server_time;
         this.mKongStaticVariables[KONG_ANALYTICS_COUNTRY_CODE] = payload.country_code;
         this.getKongAutomaticVariables();
      }
      
      private function onHeartbeatTimer(e:Event) : void
      {
         this.mSession.active = new Date();
         if(this.mHeartbeatTimer.currentCount % 4 == 0)
         {
            this.addEvent(SwrveClient.SWRVE_HEARTBEAT_EVENT,{});
         }
      }
      
      private function getNumSessions() : int
      {
         return int(this.mSavedData[KONG_ANALYTICS_NUM_SESSIONS]) || 1;
      }
      
      private function startSession() : void
      {
         var end:Object = null;
         var numSessions:int = 0;
         var start:Object = null;
         var time:Date = new Date();
         this.mPreviousSession = this.mSavedData.current_session;
         var inactiveFor:int = this.mPreviousSession ? int((time.getTime() - this.mPreviousSession.active.getTime()) / 1000) : 0;
         var length:int = this.mPreviousSession ? int((time.getTime() - this.mPreviousSession.start.getTime()) / 1000) : 0;
         if(inactiveFor > KONG_SESSION_END_THRESHOLD_SECONDS)
         {
            Log.debug("Terminating previous session (" + this.mPreviousSession.id + "), inactiveFor=" + inactiveFor + ", length=" + length);
            end = {};
            end[KONG_ANALYTICS_SESSION_ID] = this.mPreviousSession.id;
            end[KONG_ANALYTICS_NUM_SESSIONS] = this.getNumSessions();
            end[KONG_ANALYTICS_SESSION_END_TIME] = DateUtil.toW3CDTF(this.mPreviousSession.active,true);
            end[KONG_ANALYTICS_SESSION_LENGTH] = length;
            end[KONG_ANALYTICS_DID_CRASH] = false;
            this.addAutoEvent(KONG_ANALYTICS_EVENT_SESSION_END,end);
         }
         else if(this.mPreviousSession)
         {
            Log.debug("Reopening previous session (" + this.mPreviousSession.id + "), inactiveFor=" + inactiveFor + ", length=" + length);
            this.mSession = this.mPreviousSession;
         }
         if(!this.mSession)
         {
            this.mSession = {
               "id":UIDUtil.createUID(),
               "start":time,
               "active":time
            };
            this.mSavedData.current_session = this.mSession;
            numSessions = this.mSavedData[KONG_ANALYTICS_NUM_SESSIONS] ? int(this.mSavedData[KONG_ANALYTICS_NUM_SESSIONS] + 1) : 1;
            this.mSavedData[KONG_ANALYTICS_NUM_SESSIONS] = numSessions;
            Log.debug("Created new session: " + this.mSession.id);
         }
         if(this.mSession != this.mPreviousSession)
         {
            this.addEvent(SwrveClient.SWRVE_SESSION_START_IDENTIFIER,{});
            start = {};
            start[KONG_ANALYTICS_IS_FROM_BACKGROUND] = false;
            this.addAutoEvent(KONG_ANALYTICS_EVENT_SESSION_START,start);
         }
      }
      
      private function foregroundEvent() : void
      {
         if(!FOCUS_EVENTS_ENABLED)
         {
            return;
         }
         this.mForegroundTime = Utils.getTimeSeconds();
         var evt:Object = {};
         evt[KONG_ANALYTICS_BACKGROUND_TIME] = this.mBackgroundTime == 0 ? 0 : Utils.getTimeSeconds() - this.mBackgroundTime;
         evt[KONG_ANALYTICS_LAST_SKEW_REFRESH] = this.mSavedData[KONG_ANALYTICS_LAST_SKEW_REFRESH];
         this.addAutoEvent(KONG_ANALYTICS_EVENT_FOREGROUND_VISITS,evt);
      }
      
      private function backgroundEvent() : void
      {
         if(!FOCUS_EVENTS_ENABLED)
         {
            return;
         }
         this.mBackgroundTime = Utils.getTimeSeconds();
         var evt:Object = {};
         evt[KONG_ANALYTICS_FOREGROUND_TIME] = Utils.getTimeSeconds() - this.mForegroundTime;
         evt[KONG_ANALYTICS_LAST_SKEW_REFRESH] = this.mSavedData[KONG_ANALYTICS_LAST_SKEW_REFRESH];
         this.addAutoEvent(KONG_ANALYTICS_EVENT_BACKGROUND_VISITS,evt);
      }
      
      private function refreshPlayerInfoFields(evt:Object) : void
      {
         var field:String = null;
         evt[KONG_ANALYTICS_PUR_LINK_DATE] = this.mSavedData[KONG_ANALYTICS_PUR_LINK_DATE];
         evt[KONG_ANALYTICS_KONG_JOIN_DATE] = this.mSavedData[KONG_ANALYTICS_KONG_JOIN_DATE];
         for each(field in PLAYER_INFO_SCRAPED_FIELDS)
         {
            if(evt[field])
            {
               this.mSavedData[field] = evt[field];
            }
            else
            {
               evt[field] = this.mSavedData[field] ? this.mSavedData[field] : null;
            }
         }
      }
      
      private function installEvent() : void
      {
         if(!this.autoAnalyticsAllEnabled())
         {
            Log.debug("Not firing installs event since analytics mode is not all auto");
            return;
         }
         var evt:Object = {};
         evt[KONG_ANALYTICS_STUB_FIELD] = null;
         evt[KONG_ANALYTICS_UTM_SOURCE] = null;
         evt[KONG_ANALYTICS_UTM_MEDIUM] = null;
         evt[KONG_ANALYTICS_UTM_TERM] = null;
         evt[KONG_ANALYTICS_UTM_CONTENT] = null;
         evt[KONG_ANALYTICS_UTM_CAMPAIGN] = null;
         this.addAutoEvent(KONG_ANALYTICS_EVENT_INSTALLS,evt);
      }
      
      private function sendSwrveUserEvent() : void
      {
         var prop:String = null;
         if(this.autoAnalyticsDisabled())
         {
            return;
         }
         var autoVars:Object = this.getKongAutomaticVariables();
         var evt:Object = {};
         for each(prop in SwrveClient.SWRVE_USER_PROPERTIES)
         {
            evt["kong." + prop] = autoVars[prop];
         }
         this.addAutoEvent(SwrveClient.SWRVE_USER_IDENTIFIER,evt);
      }
      
      private function sendSwrveIAPEvent(productId:String, transactionId:String, usd:Number, fields:Object) : void
      {
         var field:String = null;
         var evt:Object = {
            "product_id":productId,
            "quantity":1,
            "local_cost":usd,
            "local_currency":"USD",
            "app_store":"unknown_store"
         };
         var rewards:Object = {};
         rewards[productId] = {
            "type":"item",
            "amount":1
         };
         for each(field in ["soft_currency_change","hard_currency_change"])
         {
            if(Boolean(fields[field]) && fields[field] > 0)
            {
               rewards[field] = {
                  "type":"currency",
                  "amount":fields[field]
               };
            }
         }
         if(fields.type)
         {
            rewards[fields.type] = {
               "type":"item",
               "amount":1
            };
         }
         evt.rewards = rewards;
         this.addEvent(SwrveClient.SWRVE_IAP_IDENTIFIER,evt);
      }
      
      private function addIAPEvent(transactionId:String, gameFields:Object, collection:String) : void
      {
         if(this.autoAnalyticsDisabled())
         {
            return;
         }
         var evt:Object = {};
         Utils.merge(evt,this.objectify(gameFields));
         evt[KONG_ANALYTICS_USD_COST] = this.mPriceUSD;
         evt[KONG_ANALYTICS_PRODUCT_ID] = this.mProductId;
         evt[KONG_ANALYTICS_IAP_ID] = this.mSavedData[KONG_ANALYTICS_IAP_ID];
         if(KONG_ANALYTICS_EVENT_IAP_ATTEMPTS != collection)
         {
            evt[KONG_ANALYTICS_RECEIPT_ID] = transactionId || KONG_RECEIPT_IP_NONE;
         }
         if(this.mKongServices.isKongregate)
         {
            evt[KONG_ANALYTICS_LOCAL_CURRENCY_COST] = this.getKredPrice(this.mProductId);
            evt[KONG_ANALYTICS_LOCAL_CURRENCY_TYPE] = "KRED";
         }
         else
         {
            evt[KONG_ANALYTICS_LOCAL_CURRENCY_COST] = gameFields[KONG_ANALYTICS_LOCAL_CURRENCY_COST] || this.mPriceUSD;
            evt[KONG_ANALYTICS_LOCAL_CURRENCY_TYPE] = gameFields[KONG_ANALYTICS_LOCAL_CURRENCY_TYPE] || "USD";
         }
         if(KONG_ANALYTICS_EVENT_IAP_TRANSACTIONS == collection)
         {
            this.sendSwrveIAPEvent(this.mProductId,transactionId,this.mPriceUSD,gameFields);
            delete this.mSavedData[KONG_ANALYTICS_IAP_ID];
            this.mProductId = null;
            this.mPriceUSD = 0;
         }
         this.addEventInternal(collection,evt);
      }
      
      private function addIAPFailEvent(transactionId:String, gameFields:Object) : void
      {
         var evt:Object = {};
         Utils.merge(evt,this.objectify(gameFields));
         evt[KONG_ANALYTICS_FAIL_REASON] = "SKErrorPaymentCancelled";
         evt[KONG_ANALYTICS_RECEIPT_ID] = transactionId || KONG_RECEIPT_IP_NONE;
         evt[KONG_ANALYTICS_IAP_ID] = this.mSavedData[KONG_ANALYTICS_IAP_ID];
         delete this.mSavedData[KONG_ANALYTICS_IAP_ID];
         this.addEventInternal(KONG_ANALYTICS_EVENT_IAP_FAILS,evt);
      }
      
      private function getUSDPrice(sku:String, gameFields:Object) : Number
      {
         var kreds:Number = NaN;
         var usd:Number = NaN;
         var tier:int = 0;
         if(this.mKongServices.isKongregate)
         {
            kreds = this.getKredPrice(sku);
            if(kreds != 0)
            {
               usd = kreds * this.mKredExchangeRate;
               return int(usd * 100) / 100;
            }
         }
         else if(Boolean(gameFields) && Boolean(gameFields[KONG_ANALYTICS_USD_COST]))
         {
            return gameFields[KONG_ANALYTICS_USD_COST];
         }
         var regex:RegExp = /^.*t([0-9][0-9])_.*$/;
         var match:Array = sku.match(regex);
         if(Boolean(match) && match.length == 2)
         {
            tier = parseInt(match[1],10);
            if(tier > 0 && tier <= PRICING_TIERS.length)
            {
               return PRICING_TIERS[tier - 1];
            }
         }
         Log.warn("Couldn\'t calculate USD price for sku: " + sku);
         return 0;
      }
      
      private function getKredPrice(sku:String) : Number
      {
         var item:Object = null;
         for each(item in this.mItems)
         {
            if(sku == item.identifier)
            {
               return item.price;
            }
         }
         Log.warn("Couldn\'t get kred price for identifier: " + sku);
         return 0;
      }
      
      private function objectify(o:Object) : Object
      {
         if(o is String)
         {
            if(o.length == 0)
            {
               return {};
            }
            o = com.adobe.serialization.json.JSON.decode(o as String) || {};
         }
         return o;
      }
      
      private function requestItems(services:IInternalServices) : void
      {
         var itemsURL:String;
         if(this.mKongServices.isExternal)
         {
            return;
         }
         itemsURL = services.getApiHost() + "/api/items.json?game_id=" + services.getGameID();
         Log.debug("Requesting items from: " + itemsURL);
         Utils.httpGet(itemsURL,{},function(result:Object):void
         {
            var item:Object = null;
            if(Boolean(result.success) && Boolean(result.parsed_response.success))
            {
               Log.debug("Item list received: " + result.parsed_response.items.length + " item(s)");
               Utils.clear(mItems);
               for each(item in result.parsed_response.items)
               {
                  mItems.push(item);
               }
               mPersistentStore.flush();
            }
            else
            {
               ++mItemListRetries;
               Log.debug("Item list retrieval failed, retry #" + mItemListRetries);
               if(mItemListRetries < 5)
               {
                  setTimeout(function():void
                  {
                     requestItems(services);
                  },30000);
               }
            }
         },30000);
      }
      
      private function requestAnalyticsPayload(numRetries:int = 0) : void
      {
         var url:String;
         var swrveAppId:String = null;
         var swrveApiKey:String = null;
         if(!this.mKongServices.isExternal)
         {
            return;
         }
         swrveAppId = this.mKongServices.getExternalConfigValue("swrve_app_id",null);
         swrveApiKey = this.mKongServices.getExternalConfigValue("swrve_api_key",null);
         if(!swrveAppId || !swrveApiKey)
         {
            return;
         }
         url = "https://" + this.mKongServices.getApiHost() + "/games_redirect/" + this.mKongServices.getGameID();
         Log.debug("Requesting analytics payload");
         Utils.httpGet(url,{"path":"/analytics_payload.json"},function(result:Object):void
         {
            if(Boolean(result.success) && Boolean(result.parsed_response))
            {
               Log.debug("Analytics payload received!");
               initialize({"swrve":{
                  "application_id":swrveAppId,
                  "key":swrveApiKey
               }},result.parsed_response);
            }
            else
            {
               ++numRetries;
               if(numRetries < 10)
               {
                  Log.debug("Analytics payload request failed, retry #" + numRetries);
                  setTimeout(function():void
                  {
                     requestAnalyticsPayload(numRetries);
                  },numRetries * 15000);
               }
               else
               {
                  Log.warn("Could not retrieve analytics payload, will try again in 10 minutes");
                  setTimeout(function():void
                  {
                     requestAnalyticsPayload();
                  },60 * 10 * 1000);
               }
            }
         },30000);
      }
      
      private function onApplicationThrottled(throttled:Boolean) : void
      {
         if(!throttled)
         {
            if(this.mThrottled)
            {
               this.foregroundEvent();
            }
            this.mThrottled = false;
         }
         else
         {
            if(!this.mThrottled)
            {
               this.backgroundEvent();
            }
            this.mThrottled = true;
         }
      }
      
      private function dayOfEra(utcTime:int, timeZoneOffset:int) : int
      {
         timeZoneOffset *= 60 * 60;
         return int((utcTime + timeZoneOffset) / (24 * 60 * 60));
      }
      
      private function daysSince(utcTime:int, offset:int) : int
      {
         return this.dayOfEra(Utils.getTimeSeconds(),this.timeZoneOffset()) - this.dayOfEra(utcTime,offset);
      }
      
      private function daysRetained() : int
      {
         var firstPlayDate:Date = new Date();
         var tzOffset:int = this.timeZoneOffset();
         var firstPlayString:String = this.mKongStaticVariables[KONG_ANALYTICS_FIRST_PLAY_TIME];
         if(Boolean(firstPlayString) && firstPlayString.length > 0)
         {
            firstPlayDate = Utils.parseDate(firstPlayString);
            if(firstPlayDate == null)
            {
               Log.warn("Failed to parse first play date: " + firstPlayString + ", resetting");
               firstPlayDate = new Date();
               this.mSavedData[KONG_ANALYTICS_FIRST_PLAY_TIME] = DateUtil.toW3CDTF(firstPlayDate,true);
               this.mPersistentStore.flush();
            }
         }
         if(this.mKongStaticVariables[KONG_ANALYTICS_FIRST_PLAY_TIME_OFFSET] != undefined)
         {
            tzOffset = int(this.mKongStaticVariables[KONG_ANALYTICS_FIRST_PLAY_TIME_OFFSET]);
         }
         var firstPlaySeconds:int = firstPlayDate.getTime() / 1000;
         return this.daysSince(firstPlaySeconds,tzOffset);
      }
      
      protected function autoAnalyticsDisabled() : Boolean
      {
         return !this.mAnalyticsEnabled || this.mAutoAnalyticsMode == ANALYTICS_MODE_NONE;
      }
      
      protected function autoAnalyticsAllEnabled() : Boolean
      {
         return this.mAutoAnalyticsMode == ANALYTICS_MODE_ALL;
      }
      
      private function autoAnalyticsExcludesServer() : Boolean
      {
         return this.mAutoAnalyticsMode == ANALYTICS_MODE_CLOUD;
      }
      
      private function getProductId(product:*) : String
      {
         var products:Array = null;
         try
         {
            if(product is String)
            {
               return product as String;
            }
            if(product is Number)
            {
               return product.toString();
            }
            if(product is Array)
            {
               products = product as Array;
               if(products.length > 0)
               {
                  return this.getProductId(products[0]);
               }
            }
            else if(product is Object && product.identifier is String)
            {
               return product.identifier as String;
            }
         }
         catch(e:Error)
         {
            Log.warn("Error calculating product ID from type: " + typeof product);
         }
         Log.warn("Couldn\'t get product ID from: " + product);
         return null;
      }
      
      private function getPersistentStore() : PersistentStore
      {
         var localPath:String = Security.sandboxType == "application" ? "/" : "/flash";
         return new PersistentStore(this.getDataStoreName(),localPath);
      }
      
      private function getDataStoreName() : String
      {
         var dataStoreName:String = "game-analytics-" + this.mKongServices.getGameID();
         if(this.mKongServices.isExternal)
         {
            dataStoreName = this.mKongServices.getExternalConfigValue("platform","external") + "-" + dataStoreName;
         }
         return dataStoreName;
      }
      
      public function isExternalInterfaceAvailable() : Boolean
      {
         try
         {
            return ExternalInterface.available && Boolean(ExternalInterface.call("function(){return true;}"));
         }
         catch(e:Error)
         {
            Log.error("No external interface available");
         }
         return false;
      }
      
      public function start() : void
      {
         this.setup();
      }
      
      public function getPersistentDataJSON(destroy:Boolean = false) : String
      {
         var session:Object = null;
         var store:PersistentStore = this.getPersistentStore();
         var export:Object = {
            "pending_events":store.get("pending_events",[]),
            "event_queues":{},
            "saved_data":{}
         };
         Utils.merge(export.event_queues,store.get("event_queues",{"swrve":[]}));
         Utils.merge(export.saved_data,store.get("saved_data",{}));
         delete export.event_queues.keen;
         if(export.saved_data.current_session)
         {
            session = {};
            Utils.merge(session,export.saved_data.current_session);
            session.start = session.start.getTime();
            session.active = session.active.getTime();
            export.saved_data.current_session = session;
         }
         if(destroy)
         {
            Log.debug("Destroying legacy persistent store");
            store.destroy();
         }
         return com.adobe.serialization.json.JSON.encode(export);
      }
   }
}

