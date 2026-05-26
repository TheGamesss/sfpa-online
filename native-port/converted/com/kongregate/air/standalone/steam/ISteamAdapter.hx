package com.kongregate.air.standalone.steam;


interface ISteamAdapter
{
    
    
    var initialized(get, never) : Bool;    
    
    var personaName(get, never) : String;    
    
    var steamID(get, never) : String;

    
    function getAuthSessionTicket(param1 : Dynamic) : Void
    ;
}


