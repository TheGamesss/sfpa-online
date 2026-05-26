package com.kongregate.air;


interface IMtx
{

    
    function verifyTransactionId(param1 : String) : Void
    ;
    
    function verifyGoogleReceipt(param1 : String, param2 : String) : Void
    ;
    
    function receiptVerificationStatus(param1 : String) : Void
    ;
    
    function requestUserItemList() : Void
    ;
    
    function hasItem(param1 : String) : Bool
    ;
}


