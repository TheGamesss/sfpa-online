package com.kongregate.air.base;

import com.kongregate.air.IAnalytics;
import com.kongregate.air.KongregateAPI;
import flash.events.EventDispatcher;

class Analytics extends EventDispatcher implements IAnalytics
{
    
    public static inline var FIELD_AD_TRACKING : String = "ad_tracking";
    
    public static inline var FIELD_ANDROID_ID : String = "android_id";
    
    public static inline var FIELD_CARRIER : String = "carrier";
    
    public static inline var FIELD_CLIENT_OS_TYPE : String = "client_os_type";
    
    public static inline var FIELD_CLIENT_OS_VERSION : String = "client_os_version";
    
    public static inline var FIELD_CLIENT_VERSION : String = "client_version";
    
    public static inline var FIELD_COUNTRY_CODE : String = "country_code";
    
    public static inline var FIELD_DATA_CONNECTION_TYPE : String = "data_connection_type";
    
    public static inline var FIELD_DAYS_RETAINED : String = "days_retained";
    
    public static inline var FIELD_DEV_CLIENT_VERSION : String = "dev_client_version";
    
    public static inline var FIELD_DEVICE_TYPE : String = "device_type";
    
    public static inline var FIELD_EVENT_TIME : String = "event_time";
    
    public static inline var FIELD_EVENT_TIME_OFFSET : String = "event_time_offset";
    
    public static inline var FIELD_EXTERNAL_IP_ADDRESS : String = "external_ip_address";
    
    public static inline var FIELD_FILTER_TYPE : String = "filter_type";
    
    public static inline var FIELD_FIRST_CLIENT_VERSION : String = "first_client_version";
    
    public static inline var FIELD_FIRST_PLAY_TIME : String = "first_play_time";
    
    public static inline var FIELD_FIRST_SDK_VERSION : String = "first_sdk_version";
    
    public static inline var FIELD_FIRST_SERVER_VERSION : String = "first_server_version";
    
    public static inline var FIELD_GAMECENTER_ID : String = "gamecenter_id";
    
    public static inline var FIELD_GAMECENTER_ALIAS : String = "gamecenter_alias";
    
    public static inline var FIELD_GOOGLE_AD_ID : String = "google_ad_id";
    
    public static inline var FIELD_GS_REWARDS_TIER : String = "gs_rewards_tier";
    
    public static inline var FIELD_IDFA : String = "idfa";
    
    public static inline var FIELD_IDFV : String = "idfv";
    
    public static inline var FIELD_IP_ADDRESS : String = "ip_address";
    
    public static inline var FIELD_IS_FROM_BACKGROUND : String = "is_from_background";
    
    public static inline var FIELD_KONG_PLUS : String = "kong_plus";
    
    public static inline var FIELD_KONG_USER_ID : String = "kong_user_id";
    
    public static inline var FIELD_KONG_USERNAME : String = "kong_username";
    
    public static inline var FIELD_LANG_CODE : String = "lang_code";
    
    public static inline var FIELD_MAC_ADDRESS : String = "mac_address";
    
    public static inline var FIELD_NUM_SESSIONS : String = "num_sessions";
    
    public static inline var FIELD_PLAYER_ID : String = "player_id";
    
    public static inline var FIELD_SDK_VERSION : String = "sdk_version";
    
    public static inline var FIELD_SESSION_ID : String = "session_id";
    
    public static inline var FIELD_TIME_SKEW : String = "time_skew";
    
    public static inline var PLAYER_INFO_EVENT : String = "player_info";
    
    public static inline var TWITTER_ID : String = "twitter_id";
    
    public static inline var FB_USER_ID : String = "fb_user_id";
    
    public static inline var FB_USERNAME : String = "fb_username";
    
    public static inline var FB_EMAIL : String = "fb_email";
    
    public static inline var EMAIL : String = "email";
    
    public static inline var SWRVE_VIRTUAL_ECONOMY_EVENT_PURCHASE : String = "swrve.ve.purchase";
    
    public static inline var SWRVE_VIRTUAL_ECONOMY_EVENT_GIFT : String = "swrve.ve.gift";
    
    public static inline var SWRVE_VIRTUAL_ECONOMY_PARAM_ITEM : String = "item";
    
    public static inline var SWRVE_VIRTUAL_ECONOMY_PARAM_CURRENCY : String = "currency";
    
    public static inline var SWRVE_VIRTUAL_ECONOMY_PARAM_COST : String = "cost";
    
    public static inline var SWRVE_VIRTUAL_ECONOMY_PARAM_QUANTITY : String = "quantity";
    
    public static inline var SWRVE_VIRTUAL_ECONOMY_PARAM_AMOUNT : String = "amount";
    
    private var commonPropsCallback : Dynamic;
    
    private var commonPropsJson : String;
    
    private var mAPI : KongregateAPI;
    
    public function new(api : KongregateAPI)
    {
        super();
        this.mAPI = api;
    }
    
    public function setCommonPropsCallback(callback : Dynamic) : Void
    {
        this.commonPropsJson = null;
        this.commonPropsCallback = callback;
        this.updateCommonProps();
    }
    
    public function setCommonProperties(props : Dynamic) : Void
    {
        this.commonPropsJson = haxe.Json.stringify(props);
        this.commonPropsCallback = null;
        this.updateCommonProps();
    }
    
    public function updateCommonProps() : Void
    {
        this.updateCommonPropsFromJson(this.getCommonPropsJSON());
    }
    
    public function gameUserUpdate(props : Dynamic) : Void
    {
        this.gameUserUpdateFromJson(haxe.Json.stringify(props));
    }
    
    public function addEvent(collection : String, evt : Dynamic) : Void
    {
        this.addEventFromJson(collection, haxe.Json.stringify(evt), this.getCommonPropsJSON());
    }
    
    public function startPurchase(productID : String, quantity : Int = 1, gameFields : Dynamic = null) : Void
    {
        this.updateCommonProps();
        this.startPurchaseFromJson(productID, quantity, haxe.Json.stringify(gameFields));
    }
    
    public function finishPurchase(resultCode : String, transactionId : String, gameFields : Dynamic = null, dataSignature : String = null) : Void
    {
        this.updateCommonProps();
        this.finishPurchaseFromJson(resultCode, transactionId, haxe.Json.stringify((gameFields == null) ? "{}" : gameFields), (dataSignature == null) ? "" : dataSignature);
    }
    
    public function finishPurchaseWithProductId(resultCode : String, productId : String, receipt : String, gameFields : Dynamic = null) : Void
    {
        this.finishPurchaseWithProductIdFromJson(resultCode, productId, receipt, haxe.Json.stringify((gameFields == null) ? "" : gameFields));
    }
    
    public function getAutoProperties() : Dynamic
    {
        return haxe.Json.parse(this.getAutoPropertiesJSON());
    }
    
    public function start() : Void
    {
    }
    
    private function getCommonPropsJSON() : String
    {
        if (this.commonPropsJson != null)
        {
            trace("using SetCommonProps json");
            return this.commonPropsJson;
        }
        if (this.commonPropsCallback != null)
        {
            trace("using CommonPropsCallback");
            return haxe.Json.stringify(this.commonPropsCallback());
        }
        trace("common props not set");
        return "{ }";
    }
    
    public function addFilterType(filterType : String) : Void
    {
    }
    
    public function finishPromoAward(promoId : String) : Void
    {
    }
    
    public function getInstallReferrer() : String
    {
        return "";
    }
    
    public function getResourceNames() : Array<Dynamic>
    {
        return null;
    }
    
    public function getResourceAsString(resourceId : String, attributeId : String, defValue : String) : String
    {
        return defValue;
    }
    
    private function gameUserUpdateFromJson(propsJson : String) : Void
    {
    }
    
    private function addEventFromJson(collection : String, jsonMap : String, commonPropsJson : String) : Void
    {
    }
    
    private function updateCommonPropsFromJson(mapJson : String) : Void
    {
    }
    
    private function startPurchaseFromJson(productID : String, quantity : Int, gameFieldsJson : String) : Void
    {
    }
    
    private function finishPurchaseFromJson(resultCode : String, transactionId : String, gameFieldsJson : String, dataSignature : String) : Void
    {
    }
    
    private function finishPurchaseWithProductIdFromJson(resultCode : String, productId : String, receipt : String, gameFieldsJson : String) : Void
    {
    }
    
    private function getAutoPropertiesJSON() : String
    {
        return "{}";
    }
}


