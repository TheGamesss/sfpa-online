package com.kongregate.air.native
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.PlatformType;
   import com.kongregate.air.base.Mtx;
   import flash.errors.IllegalOperationError;
   
   public class NativeMtx extends Mtx
   {
      
      protected var mExtensionContext:*;
      
      public function NativeMtx(api:KongregateAPI, extensionContext:*)
      {
         super(api);
         this.mExtensionContext = extensionContext;
      }
      
      override public function verifyTransactionId(transactionIdentifier:String) : void
      {
         super.verifyTransactionId(transactionIdentifier);
         if(mAPI.platform == PlatformType.ANDROID)
         {
            throw new IllegalOperationError("verifyTransactionId is not supported on Android. Use verifyGoogleReceipt(receipt, signature)");
         }
         this.mExtensionContext.call("call","KongregateAPIMtxVerifyTransactionId",transactionIdentifier);
      }
      
      override public function verifyGoogleReceipt(receipt:String, signature:String) : void
      {
         super.verifyGoogleReceipt(receipt,signature);
         if(mAPI.platform == PlatformType.IOS)
         {
            throw new IllegalOperationError("verifyGoogleReceipt is not supported on iOS. Use verifyTransactionId(transactionIdentifier)");
         }
         this.mExtensionContext.call("call","KongregateAPIMtxVerifyGooglePurchase",receipt,signature);
      }
      
      override public function receiptVerificationStatus(transactionIdentifier:String) : void
      {
         this.mExtensionContext.call("call","KongregateAPIMtxReceiptVerificationStatus",transactionIdentifier);
      }
      
      override public function requestUserItemList() : void
      {
         this.mExtensionContext.call("call","KongregateAPIMtxRequestUserItemList");
      }
      
      override public function hasItem(identifier:String) : Boolean
      {
         return this.mExtensionContext.call("call","KongregateAPIMtxHasItem",identifier) as Boolean;
      }
   }
}

