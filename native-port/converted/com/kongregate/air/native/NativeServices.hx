package com.kongregate.air.native;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.base.Services;

class NativeServices extends Services
{
    
    private var mExtensionContext : Dynamic;
    
    public function new(api : KongregateAPI, extensionContext : Dynamic)
    {
        super(api);
        this.mExtensionContext = extensionContext;
    }
    
    override public function isGuest() : Bool
    {
        return try cast(this.mExtensionContext.call("call", "KongregateAPIServicesIsGuest"), Bool) catch(e:Dynamic) null;
    }
    
    override public function getUsername() : String
    {
        return Std.string(this.mExtensionContext.call("call", "KongregateAPIServicesGetUsername"));
    }
    
    override public function getGameAuthToken() : String
    {
        return Std.string(this.mExtensionContext.call("call", "KongregateAPIServicesGetGameAuthToken"));
    }
    
    override public function getUserId() : Float
    {
        return as3hx.Compat.parseFloat(this.mExtensionContext.call("call", "KongregateAPIServicesGetUserId"));
    }
    
    override public function hasKongPlus() : Bool
    {
        return try cast(this.mExtensionContext.call("call", "KongregateAPIServicesHasKongPlus"), Bool) catch(e:Dynamic) null;
    }
    
    override public function getNotificationCount() : Float
    {
        return as3hx.Compat.parseFloat(this.mExtensionContext.call("call", "KongregateAPIServicesGetNotificationCount"));
    }
    
    override public function hasUnreadGuildMessages() : Bool
    {
        return try cast(this.mExtensionContext.call("call", "KongregateAPIServicesHasUnreadGuildMessages"), Bool) catch(e:Dynamic) null;
    }
    
    override public function setCharacterToken(characterToken : String) : Void
    {
        this.mExtensionContext.call("call", "KongregateAPIServicesSetCharacterToken", characterToken);
    }
}


