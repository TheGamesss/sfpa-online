package com.kongregate.as3.client.analytics;


interface AnalyticsClient
{

    
    function handlesEvent(param1 : String) : Bool
    ;
    
    function sendEvents(param1 : Array<Dynamic>, param2 : Dynamic) : Void
    ;
}


