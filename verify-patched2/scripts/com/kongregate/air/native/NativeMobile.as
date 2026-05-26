package com.kongregate.air.native
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.base.Mobile;
   
   public class NativeMobile extends Mobile
   {
      
      protected var mExtensionContext:*;
      
      public function NativeMobile(api:KongregateAPI, extensionContext:*)
      {
         super(api);
         this.mExtensionContext = extensionContext;
      }
      
      override public function openKongregateWindow(target:String = "", id:String = "") : void
      {
         this.mExtensionContext.call("call","KongregateAPIMobileOpenKongregateWindow",target,id);
      }
   }
}

