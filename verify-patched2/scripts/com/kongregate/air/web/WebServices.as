package com.kongregate.air.web
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.base.Services;
   import com.kongregate.air.event.APIEvent;
   import flash.events.Event;
   
   public class WebServices extends Services
   {
      
      private static const EVENT_LOGIN:String = "login";
      
      protected var mWebAPI:*;
      
      public function WebServices(api:KongregateAPI)
      {
         super(api);
         this.mWebAPI = api.webAPI;
         this.mWebAPI.services.addEventListener(EVENT_LOGIN,this.onLogin);
      }
      
      override public function getUsername() : String
      {
         return this.mWebAPI.services.getUsername();
      }
      
      override public function getGameAuthToken() : String
      {
         return this.mWebAPI.services.getGameAuthToken();
      }
      
      override public function getUserId() : Number
      {
         return this.mWebAPI.services.isGuest() ? 0 : Number(this.mWebAPI.services.getUserId());
      }
      
      private function onLogin(e:Event) : void
      {
         mAPI.dispatchEvent(new APIEvent(KongregateAPI.KONGREGATE_EVENT_USER_CHANGED,{}));
         mAPI.dispatchEvent(new APIEvent(KongregateAPI.KONGREGATE_EVENT_GAME_AUTH_CHANGED,{}));
      }
   }
}

