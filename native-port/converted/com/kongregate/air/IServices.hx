package com.kongregate.air;


interface IServices
{

    
    function isGuest() : Bool
    ;
    
    function getUsername() : String
    ;
    
    function getGameAuthToken() : String
    ;
    
    function getUserId() : Float
    ;
    
    function hasKongPlus() : Bool
    ;
    
    function getNotificationCount() : Float
    ;
    
    function hasUnreadGuildMessages() : Bool
    ;
    
    function setCharacterToken(param1 : String) : Void
    ;
}


