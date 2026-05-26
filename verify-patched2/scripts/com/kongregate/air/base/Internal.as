package com.kongregate.air.base
{
   import com.kongregate.air.KongregateAPI;
   import flash.events.EventDispatcher;
   
   public class Internal extends EventDispatcher
   {
      
      protected var mAPI:KongregateAPI;
      
      public function Internal(api:KongregateAPI)
      {
         super();
         this.mAPI = api;
      }
   }
}

