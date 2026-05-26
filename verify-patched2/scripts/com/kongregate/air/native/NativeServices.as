package com.kongregate.air.native
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.base.Services;
   
   public class NativeServices extends Services
   {
      
      protected var mExtensionContext:*;
      
      public function NativeServices(api:KongregateAPI, extensionContext:*)
      {
         super(api);
         this.mExtensionContext = extensionContext;
      }
      
      override public function isGuest() : Boolean
      {
         return this.mExtensionContext.call("call","KongregateAPIServicesIsGuest") as Boolean;
      }
      
      override public function getUsername() : String
      {
         return this.mExtensionContext.call("call","KongregateAPIServicesGetUsername") as String;
      }
      
      override public function getGameAuthToken() : String
      {
         return this.mExtensionContext.call("call","KongregateAPIServicesGetGameAuthToken") as String;
      }
      
      override public function getUserId() : Number
      {
         return this.mExtensionContext.call("call","KongregateAPIServicesGetUserId") as Number;
      }
      
      override public function hasKongPlus() : Boolean
      {
         return this.mExtensionContext.call("call","KongregateAPIServicesHasKongPlus") as Boolean;
      }
      
      override public function getNotificationCount() : Number
      {
         return this.mExtensionContext.call("call","KongregateAPIServicesGetNotificationCount") as Number;
      }
      
      override public function hasUnreadGuildMessages() : Boolean
      {
         return this.mExtensionContext.call("call","KongregateAPIServicesHasUnreadGuildMessages") as Boolean;
      }
      
      override public function setCharacterToken(characterToken:String) : void
      {
         this.mExtensionContext.call("call","KongregateAPIServicesSetCharacterToken",characterToken);
      }
   }
}

