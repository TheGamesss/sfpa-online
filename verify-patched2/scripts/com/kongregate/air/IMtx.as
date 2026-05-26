package com.kongregate.air
{
   public interface IMtx
   {
      
      function verifyTransactionId(param1:String) : void;
      
      function verifyGoogleReceipt(param1:String, param2:String) : void;
      
      function receiptVerificationStatus(param1:String) : void;
      
      function requestUserItemList() : void;
      
      function hasItem(param1:String) : Boolean;
   }
}

