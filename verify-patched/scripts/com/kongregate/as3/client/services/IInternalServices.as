package com.kongregate.as3.client.services
{
   public interface IInternalServices
   {
      
      function getUserId() : Number;
      
      function getGameID() : Number;
      
      function getApiHost() : String;
      
      function get isKongregate() : Boolean;
      
      function get isExternal() : Boolean;
      
      function get javascriptApiEnabled() : Boolean;
      
      function getAnalyticsMode() : String;
      
      function getGameVersion() : String;
      
      function getUsername() : String;
      
      function getExternalConfigValue(param1:String, param2:*) : *;
   }
}

