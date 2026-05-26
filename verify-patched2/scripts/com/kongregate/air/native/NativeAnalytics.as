package com.kongregate.air.native
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.PlatformType;
   import com.kongregate.air.base.Analytics;
   
   public class NativeAnalytics extends Analytics
   {
      
      protected var mExtensionContext:*;
      
      public function NativeAnalytics(api:KongregateAPI, extensionContext:*)
      {
         super(api);
         this.mExtensionContext = extensionContext;
      }
      
      override public function addFilterType(filterType:String) : void
      {
         this.mExtensionContext.call("call","KongregateAPIAnalyticsAddFilterType",filterType);
      }
      
      override public function getInstallReferrer() : String
      {
         if(mAPI.platform == PlatformType.ANDROID)
         {
            return this.mExtensionContext.call("call","KongregateAPIAnalyticsGetInstallReferrer") as String;
         }
         mAPI.debug.debugLog("getInstallReferrer is Android only.");
         return "";
      }
      
      override public function getResourceNames() : Array
      {
         var json:String = this.mExtensionContext.call("call","KongregateAPIAnalyticsGetResourceNames") as String;
         var jsonResult:Object = JSON.parse("{ \"values\": " + json + " }");
         return jsonResult.values;
      }
      
      override public function getResourceAsString(resourceId:String, attributeId:String, defValue:String) : String
      {
         return this.mExtensionContext.call("call","KongregateAPIAnalyticsGetResourceAsString",resourceId,attributeId,defValue) as String;
      }
      
      override public function start() : void
      {
         this.mExtensionContext.call("call","KongregateAPIAnalyticsStart");
      }
      
      override public function finishPromoAward(item:String) : void
      {
         this.mExtensionContext.call("call","KongregateAPIAnalyticsFinishPromoAward",item);
      }
      
      override protected function gameUserUpdateFromJson(propsJson:String) : void
      {
         this.mExtensionContext.call("call","KongregateAPIAnalyticsGameUserUpdate",propsJson);
      }
      
      override protected function addEventFromJson(collection:String, jsonMap:String, commonPropsJson:String) : void
      {
         this.mExtensionContext.call("call","KongregateAPIAnalyticsAddEvent",collection,jsonMap,commonPropsJson);
      }
      
      override protected function startPurchaseFromJson(productID:String, quantity:int, gameFieldsJson:String) : void
      {
         mAPI.debug.debugLog("Starting purchase!\n" + "productID: " + productID + "\n" + "quantity: " + quantity + "\n" + "gameFieldsJson: " + gameFieldsJson);
         this.mExtensionContext.call("call","KongregateAPIAnalyticsStartPurchase",productID,quantity,gameFieldsJson);
      }
      
      override protected function finishPurchaseFromJson(resultCode:String, transactionId:String, gameFieldsJson:String, dataSignature:String) : void
      {
         mAPI.debug.debugLog("Finishing purchase!\n" + "responseInfo (Android)/transactionId (iOS): " + transactionId + "\n" + "gameFieldsJson: " + gameFieldsJson + "\n" + "dataSignature: " + dataSignature);
         if(mAPI.platform == PlatformType.IOS)
         {
            this.mExtensionContext.call("call","KongregateAPIAnalyticsFinishPurchase",resultCode,transactionId,gameFieldsJson);
         }
         else if(mAPI.platform == PlatformType.ANDROID)
         {
            this.mExtensionContext.call("call","KongregateAPIAnalyticsFinishPurchase",resultCode,transactionId,gameFieldsJson,dataSignature);
         }
         else
         {
            mAPI.debug.debugLog("finishPurchaseFromJson not supported for plaform type: " + mAPI.platform);
         }
      }
      
      override protected function finishPurchaseWithProductIdFromJson(resultCode:String, productId:String, receipt:String, gameFieldsJson:String) : void
      {
         mAPI.debug.debugLog("Finishing purchase (with product id)!\n" + "productId: " + productId + "\n" + "receipt: " + productId + "\n" + "gameFieldsJson: " + gameFieldsJson + "\n");
         if(mAPI.platform == PlatformType.IOS)
         {
            this.mExtensionContext.call("call","KongregateAPIAnalyticsFinishPurchaseWithProductId",resultCode,productId,receipt,gameFieldsJson);
         }
         else
         {
            mAPI.debug.debugLog("finishPurchaseWithProductId is iOS only.");
         }
      }
      
      override protected function getAutoPropertiesJSON() : String
      {
         return this.mExtensionContext.call("call","KongregateAPIAnalyticsGetAutoPropertiesJSON") as String;
      }
      
      override protected function updateCommonPropsFromJson(json:String) : void
      {
         this.mExtensionContext.call("call","KongregateAPIAnalyticsUpdateCommonProps",json);
      }
   }
}

