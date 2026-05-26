package com.kongregate.air.standalone
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.base.Services;
   
   public class StandaloneServices extends Services
   {
      
      private var mInternal:StandaloneInternal;
      
      public function StandaloneServices(api:KongregateAPI, §internal§:StandaloneInternal)
      {
         super(api);
         this.mInternal = §internal§;
      }
      
      override public function isGuest() : Boolean
      {
         return this.mInternal.activeUser.userID == 0;
      }
      
      override public function getUsername() : String
      {
         return this.mInternal.activeUser.username;
      }
      
      override public function getGameAuthToken() : String
      {
         return this.mInternal.activeUser.gameAuthToken;
      }
      
      override public function getUserId() : Number
      {
         return this.mInternal.activeUser.userID;
      }
      
      override public function hasKongPlus() : Boolean
      {
         return this.mInternal.activeUser.hasKongPlus;
      }
   }
}

