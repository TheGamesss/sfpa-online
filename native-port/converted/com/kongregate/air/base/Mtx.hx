package com.kongregate.air.base;

import com.kongregate.air.IMtx;
import com.kongregate.air.KongregateAPI;
import flash.events.EventDispatcher;

class Mtx extends EventDispatcher implements IMtx
{
    
    private var mAPI : KongregateAPI;
    
    public function new(api : KongregateAPI)
    {
        super();
        this.mAPI = api;
    }
    
    public function verifyTransactionId(transactionIdentifier : String) : Void
    {
        trace("Verifying transaction id: " + transactionIdentifier);
    }
    
    public function verifyGoogleReceipt(receipt : String, signature : String) : Void
    {
        trace("Verifying Google purchase");
    }
    
    public function receiptVerificationStatus(transactionIdentifier : String) : Void
    {
    }
    
    public function requestUserItemList() : Void
    {
    }
    
    public function hasItem(identifier : String) : Bool
    {
        return false;
    }
}


