package com.kongregate.as3.client.analytics
{
   public interface AnalyticsClient
   {
      
      function handlesEvent(param1:String) : Boolean;
      
      function sendEvents(param1:Array, param2:Function) : void;
   }
}

