package com.kongregate.air.base;

import com.kongregate.air.IStats;
import com.kongregate.air.KongregateAPI;

class Stats implements IStats
{
    
    private var mAPI : KongregateAPI;
    
    public function new(api : KongregateAPI)
    {
        super();
        this.mAPI = api;
    }
    
    public function submit(name : String, value : Float) : Void
    {
    }
}


