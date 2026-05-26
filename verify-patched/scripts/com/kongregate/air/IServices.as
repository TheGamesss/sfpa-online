package com.kongregate.air
{
   public interface IServices
   {
      
      function isGuest() : Boolean;
      
      function getUsername() : String;
      
      function getGameAuthToken() : String;
      
      function getUserId() : Number;
      
      function hasKongPlus() : Boolean;
      
      function getNotificationCount() : Number;
      
      function hasUnreadGuildMessages() : Boolean;
      
      function setCharacterToken(param1:String) : void;
   }
}

