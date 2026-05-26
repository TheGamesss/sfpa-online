package com.kongregate.air.web;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.base.Analytics;
import com.kongregate.air.event.*;

class WebAnalytics extends Analytics
{
    
    private var mWebAPI : Dynamic;
    
    private var api : KongregateAPI;
    
    public function new(api : KongregateAPI)
    {
        super(api);
        this.mWebAPI = api.webAPI;
    }
    
    override public function addFilterType(filterType : String) : Void
    {
        this.mWebAPI.addFilterType(filterType);
    }
    
    override public function getAutoProperties() : Dynamic
    {
        return haxe.Json.parse(this.mWebAPI.analytics.getAutoPropertiesJSON());
    }
    
    override public function startPurchase(productID : String, quantity : Int = 1, gameFields : Dynamic = null) : Void
    {
        if (quantity != 1)
        {
            trace("Quantities other than 1 not supported for web");
        }
        trace("Starting purhcase!");
        trace("Product ID: " + productID);
        trace("Quantity: " + quantity);
        trace("Game Fields: " + haxe.Json.stringify(gameFields));
        this.mWebAPI.analytics.startPurchase(productID, gameFields);
    }
    
    override public function finishPurchase(resultCode : String, transactionId : String, gameFields : Dynamic = null, dataSignature : String = null) : Void
    {
        trace("Finishing purhcase!");
        trace("Result Code: " + resultCode);
        trace("Transaction ID: " + transactionId);
        trace("Game Fields: " + haxe.Json.stringify(gameFields));
        this.mWebAPI.analytics.finishPurchase(resultCode, transactionId, gameFields);
    }
    
    override public function addEvent(collection : String, event : Dynamic) : Void
    {
        this.mWebAPI.analytics.addEvent(collection, event);
    }
    
    override public function setCommonPropsCallback(callback : Dynamic) : Void
    {
        this.mWebAPI.analytics.setCommonPropsCallback(callback);
    }
    
    override public function updateCommonProps() : Void
    {
        this.mWebAPI.analytics.updateCommonProperties();
    }
    
    override public function setCommonProperties(props : Dynamic) : Void
    {
        this.mWebAPI.analytics.setCommonProperties(props);
    }
    
    override public function finishPromoAward(item : String) : Void
    {
        trace("Not supported on web.");
    }
    
    override public function start() : Void
    {
        this.mWebAPI.analytics.start();
    }
    
    override public function getResourceNames() : Array<Dynamic>
    {
        trace("getResourceNames is not supported on web!");
        return [];
    }
}


