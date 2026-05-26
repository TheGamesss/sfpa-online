package com.kongregate.air.web;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.base.Services;
import com.kongregate.air.event.APIEvent;
import flash.events.Event;

class WebServices extends Services
{
    
    private static inline var EVENT_LOGIN : String = "login";
    
    private var mWebAPI : Dynamic;
    
    public function new(api : KongregateAPI)
    {
        super(api);
        this.mWebAPI = api.webAPI;
        this.mWebAPI.services.addEventListener(EVENT_LOGIN, this.onLogin);
    }
    
    override public function getUsername() : String
    {
        return this.mWebAPI.services.getUsername();
    }
    
    override public function getGameAuthToken() : String
    {
        return this.mWebAPI.services.getGameAuthToken();
    }
    
    override public function getUserId() : Float
    {
        return (this.mWebAPI.services.isGuest()) ? 0 : as3hx.Compat.parseFloat(this.mWebAPI.services.getUserId());
    }
    
    private function onLogin(e : Event) : Void
    {
        mAPI.dispatchEvent(new APIEvent(KongregateAPI.KONGREGATE_EVENT_USER_CHANGED, { }));
        mAPI.dispatchEvent(new APIEvent(KongregateAPI.KONGREGATE_EVENT_GAME_AUTH_CHANGED, { }));
    }
}


