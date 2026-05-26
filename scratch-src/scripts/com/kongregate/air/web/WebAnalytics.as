package com.kongregate.air.web
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.base.Analytics;
   import com.kongregate.air.event.*;
   
   public class WebAnalytics extends Analytics
   {
      
      private var mWebAPI:*;
      
      private var api:KongregateAPI;
      
      public function WebAnalytics(api:KongregateAPI)
      {
         super(api);
         this.mWebAPI = api.webAPI;
      }
      
      override public function addFilterType(filterType:String) : void
      {
         this.mWebAPI.addFilterType(filterType);
      }
      
      override public function getAutoProperties() : Object
      {
         return JSON.parse(this.mWebAPI.analytics.getAutoPropertiesJSON());
      }
      
      override public function startPurchase(productID:String, quantity:int = 1, gameFields:Object = null) : void
      {
         if(quantity != 1)
         {
            trace("Quantities other than 1 not supported for web");
         }
         trace("Starting purhcase!");
         trace("Product ID: " + productID);
         trace("Quantity: " + quantity);
         trace("Game Fields: " + JSON.stringify(gameFields));
         this.mWebAPI.analytics.startPurchase(productID,gameFields);
      }
      
      override public function finishPurchase(resultCode:String, transactionId:String, gameFields:Object = null, dataSignature:String = null) : void
      {
         trace("Finishing purhcase!");
         trace("Result Code: " + resultCode);
         trace("Transaction ID: " + transactionId);
         trace("Game Fields: " + JSON.stringify(gameFields));
         this.mWebAPI.analytics.finishPurchase(resultCode,transactionId,gameFields);
      }
      
      override public function addEvent(collection:String, event:Object) : void
      {
         this.mWebAPI.analytics.addEvent(collection,event);
      }
      
      override public function setCommonPropsCallback(callback:Function) : void
      {
         this.mWebAPI.analytics.setCommonPropsCallback(callback);
      }
      
      override public function updateCommonProps() : void
      {
         this.mWebAPI.analytics.updateCommonProperties();
      }
      
      override public function setCommonProperties(props:Object) : void
      {
         this.mWebAPI.analytics.setCommonProperties(props);
      }
      
      override public function finishPromoAward(item:String) : void
      {
         trace("Not supported on web.");
      }
      
      override public function start() : void
      {
         this.mWebAPI.analytics.start();
      }
      
      override public function getResourceNames() : Array
      {
         trace("getResourceNames is not supported on web!");
         return [];
      }
   }
}

