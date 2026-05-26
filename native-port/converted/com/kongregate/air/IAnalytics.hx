package com.kongregate.air;


interface IAnalytics
{

    
    function setCommonPropsCallback(param1 : Dynamic) : Void
    ;
    
    function setCommonProperties(param1 : Dynamic) : Void
    ;
    
    function updateCommonProps() : Void
    ;
    
    function gameUserUpdate(param1 : Dynamic) : Void
    ;
    
    function addEvent(param1 : String, param2 : Dynamic) : Void
    ;
    
    function addFilterType(param1 : String) : Void
    ;
    
    function getInstallReferrer() : String
    ;
    
    function getAutoProperties() : Dynamic
    ;
    
    function startPurchase(param1 : String, param2 : Int = 1, param3 : Dynamic = null) : Void
    ;
    
    function finishPurchaseWithProductId(param1 : String, param2 : String, param3 : String, param4 : Dynamic = null) : Void
    ;
    
    function finishPurchase(param1 : String, param2 : String, param3 : Dynamic = null, param4 : String = null) : Void
    ;
    
    function getResourceNames() : Array<Dynamic>
    ;
    
    function getResourceAsString(param1 : String, param2 : String, param3 : String) : String
    ;
    
    function finishPromoAward(param1 : String) : Void
    ;
    
    function start() : Void
    ;
}


