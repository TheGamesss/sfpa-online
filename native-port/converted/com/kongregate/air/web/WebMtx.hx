package com.kongregate.air.web;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.base.Mtx;
import com.kongregate.air.event.*;

class WebMtx extends Mtx
{
    
    private var mWebAPI : Dynamic;
    
    private var mUserItems : Array<Dynamic> = [];
    
    public function new(api : KongregateAPI)
    {
        super(api);
        this.mWebAPI = api.webAPI;
    }
    
    override public function requestUserItemList() : Void
    {
        this.mWebAPI.mtx.requestUserItemList(null, function(result : Dynamic) : Void
                {
                    var i : Int = 0;
                    if (result.success)
                    {
                        mUserItems = [];
                        for (i in 0...result.data.length)
                        {
                            mUserItems.push(result.data[i].identifier);
                        }
                        mAPI.dispatchEvent(new APIEvent(KongregateAPI.KONGREGATE_EVENT_USER_INVENTORY, { }));
                    }
                });
    }
    
    override public function hasItem(identifier : String) : Bool
    {
        return this.mUserItems.indexOf(identifier) >= 0;
    }
}


