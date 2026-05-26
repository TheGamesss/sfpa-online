package com.kongregate.air.base
{
   import com.kongregate.air.IMtx;
   import com.kongregate.air.KongregateAPI;
   import flash.events.EventDispatcher;
   
   public class Mtx extends EventDispatcher implements IMtx
   {
      
      protected var mAPI:KongregateAPI;
      
      public function Mtx(api:KongregateAPI)
      {
         super();
         this.mAPI = api;
      }
      
      public function verifyTransactionId(transactionIdentifier:String) : void
      {
         trace("Verifying transaction id: " + transactionIdentifier);
      }
      
      public function verifyGoogleReceipt(receipt:String, signature:String) : void
      {
         trace("Verifying Google purchase");
      }
      
      public function receiptVerificationStatus(transactionIdentifier:String) : void
      {
      }
      
      public function requestUserItemList() : void
      {
      }
      
      public function hasItem(identifier:String) : Boolean
      {
         return false;
      }
   }
}

