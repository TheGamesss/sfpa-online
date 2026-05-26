package com.kongregate.as3.client.services;


interface IAnalyticsServices
{

    
    function addEvent(param1 : String, param2 : Dynamic) : Void
    ;
    
    function setCommonPropsCallback(param1 : Dynamic) : Void
    ;
    
    function setCommonProperties(param1 : Dynamic) : Void
    ;
    
    function updateCommonProperties() : Void
    ;
    
    function setAutomaticVariablesListener(param1 : Dynamic) : Void
    ;
    
    function addFilterType(param1 : String) : Void
    ;
    
    function getAutoLongProperty(param1 : String) : Float
    ;
    
    function getAutoLongLongProperty(param1 : String) : Float
    ;
    
    function getAutoStringProperty(param1 : String) : String
    ;
    
    function getAutoBoolProperty(param1 : String) : Bool
    ;
    
    function getAutoDoubleProperty(param1 : String) : Float
    ;
    
    function getAutoIntProperty(param1 : String) : Int
    ;
    
    function getAutoUTCProperty(param1 : String) : String
    ;
    
    function getAutoPropertiesJSON() : String
    ;
    
    function startPurchase(param1 : Dynamic, param2 : Dynamic) : Void
    ;
    
    function finishPurchase(param1 : String, param2 : String, param3 : Dynamic) : Void
    ;
    
    function start() : Void
    ;
}


