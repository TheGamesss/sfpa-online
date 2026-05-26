package com.kongregate.air.event;

import com.kongregate.air.KongregateAPI;
import flash.events.Event;

class AnalyticsEvent extends Event
{
    public var name(get, never) : String;
    public var bundle(get, never) : Dynamic;

    
    private var mName : String;
    
    private var mBundle : Dynamic;
    
    public function new(name : String, bundle : Dynamic)
    {
        super(KongregateAPI.ANALYTICS_AUTO_EVENT);
        this.mName = name;
        this.mBundle = (bundle != null) ? bundle : { };
    }
    
    private function get_name() : String
    {
        return this.mName;
    }
    
    private function get_bundle() : Dynamic
    {
        return this.mBundle;
    }
}


