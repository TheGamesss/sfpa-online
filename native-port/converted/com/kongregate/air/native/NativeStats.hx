package com.kongregate.air.native;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.base.Stats;

class NativeStats extends Stats
{
    
    private var mExtensionContext : Dynamic;
    
    public function new(api : KongregateAPI, extensionContext : Dynamic)
    {
        super(api);
        this.mExtensionContext = extensionContext;
    }
    
    override public function submit(name : String, value : Float) : Void
    {
        this.mExtensionContext.call("call", "KongregateAPIStatsSubmit", name, value);
    }
}


