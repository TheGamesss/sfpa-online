package com.kongregate.air.native
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.PlatformType;
   import com.kongregate.air.base.Debug;
   
   public class NativeDebug extends Debug
   {
      
      protected var mExtensionContext:*;
      
      public function NativeDebug(api:KongregateAPI, extensionContext:*)
      {
         super(api);
         this.mExtensionContext = extensionContext;
      }
      
      override public function debugLog(msg:String) : void
      {
         if(mAPI.platform == PlatformType.IOS)
         {
            this.mExtensionContext.call("call","KongregateAPILog",msg);
         }
         else
         {
            trace(msg);
         }
      }
   }
}

