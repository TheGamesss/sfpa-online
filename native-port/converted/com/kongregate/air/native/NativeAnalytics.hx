package com.kongregate.air.native;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.PlatformType;
import com.kongregate.air.base.Analytics;

class NativeAnalytics extends Analytics
{
    
    private var mExtensionContext : Dynamic;
    
    public function new(api : KongregateAPI, extensionContext : Dynamic)
    {
        super(api);
        this.mExtensionContext = extensionContext;
    }
    
    override public function addFilterType(filterType : String) : Void
    {
        this.mExtensionContext.call("call", "KongregateAPIAnalyticsAddFilterType", filterType);
    }
    
    override public function getInstallReferrer() : String
    {
        if (mAPI.platform == PlatformType.ANDROID)
        {
            return Std.string(this.mExtensionContext.call("call", "KongregateAPIAnalyticsGetInstallReferrer"));
        }
        mAPI.debug.debugLog("getInstallReferrer is Android only.");
        return "";
    }
    
    override public function getResourceNames() : Array<Dynamic>
    {
        var json : String = Std.string(this.mExtensionContext.call("call", "KongregateAPIAnalyticsGetResourceNames"));
        var jsonResult : Dynamic = haxe.Json.parse("{ \"values\": " + json + " }");
        return jsonResult.values;
    }
    
    override public function getResourceAsString(resourceId : String, attributeId : String, defValue : String) : String
    {
        return Std.string(this.mExtensionContext.call("call", "KongregateAPIAnalyticsGetResourceAsString", resourceId, attributeId, defValue));
    }
    
    override public function start() : Void
    {
        this.mExtensionContext.call("call", "KongregateAPIAnalyticsStart");
    }
    
    override public function finishPromoAward(item : String) : Void
    {
        this.mExtensionContext.call("call", "KongregateAPIAnalyticsFinishPromoAward", item);
    }
    
    override private function gameUserUpdateFromJson(propsJson : String) : Void
    {
        this.mExtensionContext.call("call", "KongregateAPIAnalyticsGameUserUpdate", propsJson);
    }
    
    override private function addEventFromJson(collection : String, jsonMap : String, commonPropsJson : String) : Void
    {
        this.mExtensionContext.call("call", "KongregateAPIAnalyticsAddEvent", collection, jsonMap, commonPropsJson);
    }
    
    override private function startPurchaseFromJson(productID : String, quantity : Int, gameFieldsJson : String) : Void
    {
        mAPI.debug.debugLog("Starting purchase!\n" + "productID: " + productID + "\n" + "quantity: " + quantity + "\n" + "gameFieldsJson: " + gameFieldsJson);
        this.mExtensionContext.call("call", "KongregateAPIAnalyticsStartPurchase", productID, quantity, gameFieldsJson);
    }
    
    override private function finishPurchaseFromJson(resultCode : String, transactionId : String, gameFieldsJson : String, dataSignature : String) : Void
    {
        mAPI.debug.debugLog("Finishing purchase!\n" + "responseInfo (Android)/transactionId (iOS): " + transactionId + "\n" + "gameFieldsJson: " + gameFieldsJson + "\n" + "dataSignature: " + dataSignature);
        if (mAPI.platform == PlatformType.IOS)
        {
            this.mExtensionContext.call("call", "KongregateAPIAnalyticsFinishPurchase", resultCode, transactionId, gameFieldsJson);
        }
        else if (mAPI.platform == PlatformType.ANDROID)
        {
            this.mExtensionContext.call("call", "KongregateAPIAnalyticsFinishPurchase", resultCode, transactionId, gameFieldsJson, dataSignature);
        }
        else
        {
            mAPI.debug.debugLog("finishPurchaseFromJson not supported for plaform type: " + mAPI.platform);
        }
    }
    
    override private function finishPurchaseWithProductIdFromJson(resultCode : String, productId : String, receipt : String, gameFieldsJson : String) : Void
    {
        mAPI.debug.debugLog("Finishing purchase (with product id)!\n" + "productId: " + productId + "\n" + "receipt: " + productId + "\n" + "gameFieldsJson: " + gameFieldsJson + "\n");
        if (mAPI.platform == PlatformType.IOS)
        {
            this.mExtensionContext.call("call", "KongregateAPIAnalyticsFinishPurchaseWithProductId", resultCode, productId, receipt, gameFieldsJson);
        }
        else
        {
            mAPI.debug.debugLog("finishPurchaseWithProductId is iOS only.");
        }
    }
    
    override private function getAutoPropertiesJSON() : String
    {
        return Std.string(this.mExtensionContext.call("call", "KongregateAPIAnalyticsGetAutoPropertiesJSON"));
    }
    
    override private function updateCommonPropsFromJson(json : String) : Void
    {
        this.mExtensionContext.call("call", "KongregateAPIAnalyticsUpdateCommonProps", json);
    }
}


