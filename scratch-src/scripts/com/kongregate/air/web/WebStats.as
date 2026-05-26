package com.kongregate.air.web
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.base.Stats;
   
   public class WebStats extends Stats
   {
      
      protected var mWebAPI:*;
      
      public function WebStats(api:KongregateAPI)
      {
         super(api);
         this.mWebAPI = api.webAPI;
      }
      
      override public function submit(name:String, value:Number) : void
      {
         this.mWebAPI.stats.submit(name,value);
      }
   }
}

