package com.kongregate.air.base
{
   import com.kongregate.air.IStats;
   import com.kongregate.air.KongregateAPI;
   
   public class Stats implements IStats
   {
      
      protected var mAPI:KongregateAPI;
      
      public function Stats(api:KongregateAPI)
      {
         super();
         this.mAPI = api;
      }
      
      public function submit(name:String, value:Number) : void
      {
      }
   }
}

