package com.kongregate.air.native
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.base.Stats;
   
   public class NativeStats extends Stats
   {
      
      protected var mExtensionContext:*;
      
      public function NativeStats(api:KongregateAPI, extensionContext:*)
      {
         super(api);
         this.mExtensionContext = extensionContext;
      }
      
      override public function submit(name:String, value:Number) : void
      {
         this.mExtensionContext.call("call","KongregateAPIStatsSubmit",name,value);
      }
   }
}

