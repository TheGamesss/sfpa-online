package com.kongregate.air.web;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.base.Debug;

class WebDebug extends Debug
{
    
    private static inline var EVENT_LOGIN : String = "login";
    
    private var mWebAPI : Dynamic;
    
    public function new(api : KongregateAPI)
    {
        super(api);
        this.mWebAPI = api.webAPI;
    }
}


