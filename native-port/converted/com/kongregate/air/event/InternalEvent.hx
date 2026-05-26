package com.kongregate.air.event;

import flash.events.Event;

class InternalEvent extends Event
{
    public var name(get, never) : String;
    public var bundle(get, never) : Dynamic;

    
    public static inline var INTERNAL_EVENT : String = "KONGREGATE_INTERNAL_EVENT";
    
    public static inline var ACTIVE_USER_INITIALIZED : String = "active_user_init";
    
    public static inline var ANALYTICS_INITIALIZED : String = "analytics_init";
    
    public static inline var USER_INFO : String = "active_user_info";
    
    private var mName : String;
    
    private var mBundle : Dynamic;
    
    public function new(name : String, bundle : Dynamic)
    {
        super(InternalEvent.INTERNAL_EVENT);
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


