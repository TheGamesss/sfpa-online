package com.kongregate.air.native;

import com.kongregate.air.KongregateAPI;
import com.kongregate.air.PlatformType;
import com.kongregate.air.base.Mtx;
import flash.errors.IllegalOperationError;

class NativeMtx extends Mtx
{
    
    private var mExtensionContext : Dynamic;
    
    public function new(api : KongregateAPI, extensionContext : Dynamic)
    {
        super(api);
        this.mExtensionContext = extensionContext;
    }
    
    override public function verifyTransactionId(transactionIdentifier : String) : Void
    {
        super.verifyTransactionId(transactionIdentifier);
        if (mAPI.platform == PlatformType.ANDROID)
        {
            throw new IllegalOperationError("verifyTransactionId is not supported on Android. Use verifyGoogleReceipt(receipt, signature)");
        }
        this.mExtensionContext.call("call", "KongregateAPIMtxVerifyTransactionId", transactionIdentifier);
    }
    
    override public function verifyGoogleReceipt(receipt : String, signature : String) : Void
    {
        super.verifyGoogleReceipt(receipt, signature);
        if (mAPI.platform == PlatformType.IOS)
        {
            throw new IllegalOperationError("verifyGoogleReceipt is not supported on iOS. Use verifyTransactionId(transactionIdentifier)");
        }
        this.mExtensionContext.call("call", "KongregateAPIMtxVerifyGooglePurchase", receipt, signature);
    }
    
    override public function receiptVerificationStatus(transactionIdentifier : String) : Void
    {
        this.mExtensionContext.call("call", "KongregateAPIMtxReceiptVerificationStatus", transactionIdentifier);
    }
    
    override public function requestUserItemList() : Void
    {
        this.mExtensionContext.call("call", "KongregateAPIMtxRequestUserItemList");
    }
    
    override public function hasItem(identifier : String) : Bool
    {
        return try cast(this.mExtensionContext.call("call", "KongregateAPIMtxHasItem", identifier), Bool) catch(e:Dynamic) null;
    }
}


