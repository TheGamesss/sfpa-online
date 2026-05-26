package com.kongregate.air.standalone;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.base.Analytics;
import com.kongregate.air.event.InternalEvent;

class StandaloneAnalyticsAdapter extends Analytics
{
    
    private var mAnalytics : StandaloneAnalyticsServices;
    
    private var mInternal : StandaloneInternal;
    
    private var mStarted : Bool = false;
    
    public function new(api : KongregateAPI, internalApi : StandaloneInternal)
    {
        super(api);
        this.mInternal = internalApi;
        this.mAnalytics = new StandaloneAnalyticsServices(internalApi);
        internalApi.addEventListener(InternalEvent.INTERNAL_EVENT, this.onInternalEvent);
    }
    
    private function onInternalEvent(evt : InternalEvent) : Void
    {
        if (evt.name == InternalEvent.ACTIVE_USER_INITIALIZED)
        {
            if (!KongregateAPI.settings.deferAnalytics)
            {
                this.start();
            }
        }
        if (evt.name == InternalEvent.USER_INFO)
        {
            this.processAnalyticsPayload(evt.bundle);
        }
    }
    
    private function processAnalyticsPayload(info : Dynamic) : Void
    {
        this.mAnalytics.processAnalyticsPayload(info);
    }
    
    override public function addFilterType(filterType : String) : Void
    {
        this.mAnalytics.addFilterType(filterType);
    }
    
    override public function startPurchase(productID : String, quantity : Int = 1, gameFields : Dynamic = null) : Void
    {
        if (quantity != 1)
        {
            trace("Quantities other than 1 not supported for Steam");
        }
        this.mAnalytics.startPurchase(productID, gameFields);
    }
    
    override public function finishPurchase(resultCode : String, transactionId : String, gameFields : Dynamic = null, dataSignature : String = null) : Void
    {
        if (dataSignature != null)
        {
            trace("Data signature not supported for Steam.");
        }
        this.mAnalytics.finishPurchase(resultCode, transactionId, gameFields);
    }
    
    override public function addEvent(collection : String, event : Dynamic) : Void
    {
        this.mAnalytics.addEvent(collection, event);
    }
    
    override public function setCommonPropsCallback(callback : Dynamic) : Void
    {
        this.mAnalytics.setCommonPropsCallback(callback);
    }
    
    override public function updateCommonProps() : Void
    {
        this.mAnalytics.updateCommonProperties();
    }
    
    override public function setCommonProperties(props : Dynamic) : Void
    {
        this.mAnalytics.setCommonProperties(props);
    }
    
    override public function start() : Void
    {
        if (!this.mStarted)
        {
            trace("StandaloneAnalytics: starting");
            this.mStarted = true;
            this.mAnalytics.start();
            this.mInternal.dispatchEvent(new InternalEvent(InternalEvent.ANALYTICS_INITIALIZED, { }));
        }
        else
        {
            trace("StandaloneAnalytics: aready started");
        }
    }
    
    override private function getAutoPropertiesJSON() : String
    {
        return this.mAnalytics.getAutoPropertiesJSON();
    }
}


