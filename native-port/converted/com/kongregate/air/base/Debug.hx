package com.kongregate.air.base;

import com.kongregate.air.IDebug;
import com.kongregate.air.KongregateAPI;

class Debug implements IDebug
{
    
    private var mAPI : KongregateAPI;
    
    public function new(api : KongregateAPI)
    {
        super();
        this.mAPI = api;
    }
    
    public function debugLog(msg : String) : Void
    {
        trace(msg);
    }
}


