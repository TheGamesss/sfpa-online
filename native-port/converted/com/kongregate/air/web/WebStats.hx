package com.kongregate.air.web;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.base.Stats;

class WebStats extends Stats
{
    
    private var mWebAPI : Dynamic;
    
    public function new(api : KongregateAPI)
    {
        super(api);
        this.mWebAPI = api.webAPI;
    }
    
    override public function submit(name : String, value : Float) : Void
    {
        this.mWebAPI.stats.submit(name, value);
    }
}


