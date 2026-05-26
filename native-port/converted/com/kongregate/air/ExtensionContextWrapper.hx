package com.kongregate.air;

import flash.errors.Error;

class ExtensionContextWrapper
{
    
    public function new()
    {
        super();
    }
    
    public static function createExtensionContext(extensionID : String, contextType : String) : Dynamic
    {
        var wrapperClass : Class<Dynamic> = null;
        try
        {
            wrapperClass = Type.getClass(Type.resolveClass("flash.external.ExtensionContext"));
            if (wrapperClass != null)
            {
                return wrapperClass.createExtensionContext.call(null, extensionID, contextType);
            }
        }
        catch (e : Error)
        {
            trace("Error while creating ExtensionContext: " + e);
        }
    }
}


