package com.kongregate.air.native;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.PlatformType;
import com.kongregate.air.base.Debug;

class NativeDebug extends Debug
{
    
    private var mExtensionContext : Dynamic;
    
    public function new(api : KongregateAPI, extensionContext : Dynamic)
    {
        super(api);
        this.mExtensionContext = extensionContext;
    }
    
    override public function debugLog(msg : String) : Void
    {
        if (mAPI.platform == PlatformType.IOS)
        {
            this.mExtensionContext.call("call", "KongregateAPILog", msg);
        }
        else
        {
            trace(msg);
        }
    }
}


