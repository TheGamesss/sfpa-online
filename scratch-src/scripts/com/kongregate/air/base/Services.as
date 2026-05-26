package com.kongregate.air.base
{
   import com.kongregate.air.IServices;
   import com.kongregate.air.KongregateAPI;
   
   public class Services implements IServices
   {
      
      protected var mAPI:KongregateAPI;
      
      public function Services(api:KongregateAPI)
      {
         super();
         this.mAPI = api;
      }
      
      public function isGuest() : Boolean
      {
         return this.getUserId() == 0;
      }
      
      public function getUsername() : String
      {
         return "Guest";
      }
      
      public function getGameAuthToken() : String
      {
         return "GuestGameAuthToken";
      }
      
      public function getUserId() : Number
      {
         return 0;
      }
      
      public function hasKongPlus() : Boolean
      {
         return false;
      }
      
      public function getNotificationCount() : Number
      {
         return 0;
      }
      
      public function hasUnreadGuildMessages() : Boolean
      {
         return false;
      }
      
      public function setCharacterToken(characterToken:String) : void
      {
      }
   }
}

