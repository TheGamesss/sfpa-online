package com.kongregate.air.base
{
   import com.kongregate.air.IAnalytics;
   import com.kongregate.air.KongregateAPI;
   import flash.events.EventDispatcher;
   
   public class Analytics extends EventDispatcher implements IAnalytics
   {
      
      public static const FIELD_AD_TRACKING:String = "ad_tracking";
      
      public static const FIELD_ANDROID_ID:String = "android_id";
      
      public static const FIELD_CARRIER:String = "carrier";
      
      public static const FIELD_CLIENT_OS_TYPE:String = "client_os_type";
      
      public static const FIELD_CLIENT_OS_VERSION:String = "client_os_version";
      
      public static const FIELD_CLIENT_VERSION:String = "client_version";
      
      public static const FIELD_COUNTRY_CODE:String = "country_code";
      
      public static const FIELD_DATA_CONNECTION_TYPE:String = "data_connection_type";
      
      public static const FIELD_DAYS_RETAINED:String = "days_retained";
      
      public static const FIELD_DEV_CLIENT_VERSION:String = "dev_client_version";
      
      public static const FIELD_DEVICE_TYPE:String = "device_type";
      
      public static const FIELD_EVENT_TIME:String = "event_time";
      
      public static const FIELD_EVENT_TIME_OFFSET:String = "event_time_offset";
      
      public static const FIELD_EXTERNAL_IP_ADDRESS:String = "external_ip_address";
      
      public static const FIELD_FILTER_TYPE:String = "filter_type";
      
      public static const FIELD_FIRST_CLIENT_VERSION:String = "first_client_version";
      
      public static const FIELD_FIRST_PLAY_TIME:String = "first_play_time";
      
      public static const FIELD_FIRST_SDK_VERSION:String = "first_sdk_version";
      
      public static const FIELD_FIRST_SERVER_VERSION:String = "first_server_version";
      
      public static const FIELD_GAMECENTER_ID:String = "gamecenter_id";
      
      public static const FIELD_GAMECENTER_ALIAS:String = "gamecenter_alias";
      
      public static const FIELD_GOOGLE_AD_ID:String = "google_ad_id";
      
      public static const FIELD_GS_REWARDS_TIER:String = "gs_rewards_tier";
      
      public static const FIELD_IDFA:String = "idfa";
      
      public static const FIELD_IDFV:String = "idfv";
      
      public static const FIELD_IP_ADDRESS:String = "ip_address";
      
      public static const FIELD_IS_FROM_BACKGROUND:String = "is_from_background";
      
      public static const FIELD_KONG_PLUS:String = "kong_plus";
      
      public static const FIELD_KONG_USER_ID:String = "kong_user_id";
      
      public static const FIELD_KONG_USERNAME:String = "kong_username";
      
      public static const FIELD_LANG_CODE:String = "lang_code";
      
      public static const FIELD_MAC_ADDRESS:String = "mac_address";
      
      public static const FIELD_NUM_SESSIONS:String = "num_sessions";
      
      public static const FIELD_PLAYER_ID:String = "player_id";
      
      public static const FIELD_SDK_VERSION:String = "sdk_version";
      
      public static const FIELD_SESSION_ID:String = "session_id";
      
      public static const FIELD_TIME_SKEW:String = "time_skew";
      
      public static const PLAYER_INFO_EVENT:String = "player_info";
      
      public static const TWITTER_ID:String = "twitter_id";
      
      public static const FB_USER_ID:String = "fb_user_id";
      
      public static const FB_USERNAME:String = "fb_username";
      
      public static const FB_EMAIL:String = "fb_email";
      
      public static const EMAIL:String = "email";
      
      public static const SWRVE_VIRTUAL_ECONOMY_EVENT_PURCHASE:String = "swrve.ve.purchase";
      
      public static const SWRVE_VIRTUAL_ECONOMY_EVENT_GIFT:String = "swrve.ve.gift";
      
      public static const SWRVE_VIRTUAL_ECONOMY_PARAM_ITEM:String = "item";
      
      public static const SWRVE_VIRTUAL_ECONOMY_PARAM_CURRENCY:String = "currency";
      
      public static const SWRVE_VIRTUAL_ECONOMY_PARAM_COST:String = "cost";
      
      public static const SWRVE_VIRTUAL_ECONOMY_PARAM_QUANTITY:String = "quantity";
      
      public static const SWRVE_VIRTUAL_ECONOMY_PARAM_AMOUNT:String = "amount";
      
      protected var commonPropsCallback:Function;
      
      protected var commonPropsJson:String;
      
      protected var mAPI:KongregateAPI;
      
      public function Analytics(api:KongregateAPI)
      {
         super();
         this.mAPI = api;
      }
      
      public function setCommonPropsCallback(callback:Function) : void
      {
         this.commonPropsJson = null;
         this.commonPropsCallback = callback;
         this.updateCommonProps();
      }
      
      public function setCommonProperties(props:Object) : void
      {
         this.commonPropsJson = JSON.stringify(props);
         this.commonPropsCallback = null;
         this.updateCommonProps();
      }
      
      public function updateCommonProps() : void
      {
         this.updateCommonPropsFromJson(this.getCommonPropsJSON());
      }
      
      public function gameUserUpdate(props:Object) : void
      {
         this.gameUserUpdateFromJson(JSON.stringify(props));
      }
      
      public function addEvent(collection:String, evt:Object) : void
      {
         this.addEventFromJson(collection,JSON.stringify(evt),this.getCommonPropsJSON());
      }
      
      public function startPurchase(productID:String, quantity:int = 1, gameFields:Object = null) : void
      {
         this.updateCommonProps();
         this.startPurchaseFromJson(productID,quantity,JSON.stringify(gameFields));
      }
      
      public function finishPurchase(resultCode:String, transactionId:String, gameFields:Object = null, dataSignature:String = null) : void
      {
         this.updateCommonProps();
         this.finishPurchaseFromJson(resultCode,transactionId,JSON.stringify(gameFields == null ? "{}" : gameFields),dataSignature == null ? "" : dataSignature);
      }
      
      public function finishPurchaseWithProductId(resultCode:String, productId:String, receipt:String, gameFields:Object = null) : void
      {
         this.finishPurchaseWithProductIdFromJson(resultCode,productId,receipt,JSON.stringify(gameFields == null ? "" : gameFields));
      }
      
      public function getAutoProperties() : Object
      {
         return JSON.parse(this.getAutoPropertiesJSON());
      }
      
      public function start() : void
      {
      }
      
      private function getCommonPropsJSON() : String
      {
         if(this.commonPropsJson != null)
         {
            trace("using SetCommonProps json");
            return this.commonPropsJson;
         }
         if(this.commonPropsCallback != null)
         {
            trace("using CommonPropsCallback");
            return JSON.stringify(this.commonPropsCallback());
         }
         trace("common props not set");
         return "{ }";
      }
      
      public function addFilterType(filterType:String) : void
      {
      }
      
      public function finishPromoAward(promoId:String) : void
      {
      }
      
      public function getInstallReferrer() : String
      {
         return "";
      }
      
      public function getResourceNames() : Array
      {
         return null;
      }
      
      public function getResourceAsString(resourceId:String, attributeId:String, defValue:String) : String
      {
         return defValue;
      }
      
      protected function gameUserUpdateFromJson(propsJson:String) : void
      {
      }
      
      protected function addEventFromJson(collection:String, jsonMap:String, commonPropsJson:String) : void
      {
      }
      
      protected function updateCommonPropsFromJson(mapJson:String) : void
      {
      }
      
      protected function startPurchaseFromJson(productID:String, quantity:int, gameFieldsJson:String) : void
      {
      }
      
      protected function finishPurchaseFromJson(resultCode:String, transactionId:String, gameFieldsJson:String, dataSignature:String) : void
      {
      }
      
      protected function finishPurchaseWithProductIdFromJson(resultCode:String, productId:String, receipt:String, gameFieldsJson:String) : void
      {
      }
      
      protected function getAutoPropertiesJSON() : String
      {
         return "{}";
      }
   }
}

