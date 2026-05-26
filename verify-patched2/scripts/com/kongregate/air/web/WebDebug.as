package com.kongregate.air.web
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.base.Debug;
   
   public class WebDebug extends Debug
   {
      
      private static const EVENT_LOGIN:String = "login";
      
      protected var mWebAPI:*;
      
      public function WebDebug(api:KongregateAPI)
      {
         super(api);
         this.mWebAPI = api.webAPI;
      }
   }
}

