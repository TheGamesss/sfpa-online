package com.kongregate.air.base;

import com.kongregate.air.IServices;
import com.kongregate.air.KongregateAPI;

class Services implements IServices
{
    
    private var mAPI : KongregateAPI;
    
    public function new(api : KongregateAPI)
    {
        super();
        this.mAPI = api;
    }
    
    public function isGuest() : Bool
    {
        return this.getUserId() == 0;
    }
    
    public function getUsername() : String
    {
        return "Guest";
    }
    
    public function getGameAuthToken() : String
    {
        return "GuestGameAuthToken";
    }
    
    public function getUserId() : Float
    {
        return 0;
    }
    
    public function hasKongPlus() : Bool
    {
        return false;
    }
    
    public function getNotificationCount() : Float
    {
        return 0;
    }
    
    public function hasUnreadGuildMessages() : Bool
    {
        return false;
    }
    
    public function setCharacterToken(characterToken : String) : Void
    {
    }
}


