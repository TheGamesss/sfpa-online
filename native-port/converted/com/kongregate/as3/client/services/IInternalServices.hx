package com.kongregate.as3.client.services;


interface IInternalServices
{
    
    
    var isKongregate(get, never) : Bool;    
    
    var isExternal(get, never) : Bool;    
    
    var javascriptApiEnabled(get, never) : Bool;

    
    function getUserId() : Float
    ;
    
    function getGameID() : Float
    ;
    
    function getApiHost() : String
    ;
    
    function getAnalyticsMode() : String
    ;
    
    function getGameVersion() : String
    ;
    
    function getUsername() : String
    ;
    
    function getExternalConfigValue(param1 : String, param2 : Dynamic) : Dynamic
    ;
}


