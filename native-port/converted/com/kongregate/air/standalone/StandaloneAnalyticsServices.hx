package com.kongregate.air.standalone;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.Version;
import com.kongregate.as3.client.services.AnalyticsServices;
import flash.system.Capabilities;

class StandaloneAnalyticsServices extends AnalyticsServices
{
    
    public function new(api : StandaloneInternal)
    {
        super(api);
    }
    
    override private function getSDKVersion() : String
    {
        return Version.SDK_VERSION;
    }
    
    override private function updateKongStaticVars(payload : Dynamic) : Void
    {
        super.updateKongStaticVars(payload);
        if (autoAnalyticsDisabled())
        {
            return;
        }
        mKongStaticVariables[KONG_ANALYTICS_SITE_VISITOR_ID] = payload.site_visitor_uid;
        mKongStaticVariables[KONG_ANALYTICS_BUNDLE_ID] = KongregateAPI.settings.bundleID;
        mKongStaticVariables[KONG_ANALYTICS_PLATFORM] = "air";
        mKongStaticVariables[KONG_ANALYTICS_DEVICE_TYPE] = Capabilities.cpuArchitecture;
        mKongStaticVariables[KONG_ANALYTICS_BROWSER] = null;
        mKongStaticVariables[KONG_ANALYTICS_BROWSER_VERSION] = null;
        mKongStaticVariables[KONG_ANALYTICS_PKG_SRC] = null;
    }
}


