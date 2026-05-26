package com.kongregate.air.native;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.base.Mobile;

class NativeMobile extends Mobile
{
    
    private var mExtensionContext : Dynamic;
    
    public function new(api : KongregateAPI, extensionContext : Dynamic)
    {
        super(api);
        this.mExtensionContext = extensionContext;
    }
    
    override public function openKongregateWindow(target : String = "", id : String = "") : Void
    {
        this.mExtensionContext.call("call", "KongregateAPIMobileOpenKongregateWindow", target, id);
    }
}


