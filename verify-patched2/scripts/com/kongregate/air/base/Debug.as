package com.kongregate.air.base
{
   import com.kongregate.air.IDebug;
   import com.kongregate.air.KongregateAPI;
   
   public class Debug implements IDebug
   {
      
      protected var mAPI:KongregateAPI;
      
      public function Debug(api:KongregateAPI)
      {
         super();
         this.mAPI = api;
      }
      
      public function debugLog(msg:String) : void
      {
         trace(msg);
      }
   }
}

