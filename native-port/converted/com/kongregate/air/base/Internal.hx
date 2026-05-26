package com.kongregate.air.base;

import com.kongregate.air.KongregateAPI;
import flash.events.EventDispatcher;

class Internal extends EventDispatcher
{
    
    private var mAPI : KongregateAPI;
    
    public function new(api : KongregateAPI)
    {
        super();
        this.mAPI = api;
    }
}


