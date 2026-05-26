package com.kongregate.as3.client.storage;

import flash.errors.Error;
import com.kongregate.as3.common.util.Log;
import flash.net.SharedObject;
import flash.net.SharedObjectFlushStatus;

class PersistentStore
{
    
    private var mName : String;
    
    private var mSharedObject : SharedObject;
    
    private var mFailed : Bool = false;
    
    public function new(name : String, localPath : String)
    {
        super();
        this.mName = name;
        this.mSharedObject = SharedObject.getLocal(name, localPath, false);
    }
    
    public function putObject(name : String, value : Dynamic) : Void
    {
        this.mSharedObject.data[name] = value;
    }
    
    public function get(name : String, def : Dynamic = null) : Dynamic
    {
        var value : Dynamic = this.mSharedObject.data[name];
        if (cast(value, Bool) || def == null)
        {
            return value;
        }
        this.mSharedObject.data[name] = def;
        return def;
    }
    
    public function flush() : Bool
    {
        var state : String = null;
        try
        {
            state = this.mSharedObject.flush(65536);
            if (state == SharedObjectFlushStatus.FLUSHED)
            {
                return true;
            }
        }
        catch (e : Error)
        {
            Log.error("Error while flushing shared object: " + e);
        }
        this.mFailed = true;
        return false;
    }
    
    public function hasFailed() : Bool
    {
        return this.mFailed;
    }
    
    public function destroy() : Void
    {
        this.mSharedObject.clear();
        this.flush();
    }
}


