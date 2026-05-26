package com.kongregate.air.web
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.base.Mtx;
   import com.kongregate.air.event.*;
   
   public class WebMtx extends Mtx
   {
      
      protected var mWebAPI:*;
      
      protected var mUserItems:Array = [];
      
      public function WebMtx(api:KongregateAPI)
      {
         super(api);
         this.mWebAPI = api.webAPI;
      }
      
      override public function requestUserItemList() : void
      {
         this.mWebAPI.mtx.requestUserItemList(null,function(result:Object):void
         {
            var i:int = 0;
            if(result.success)
            {
               mUserItems = [];
               for(i = 0; i < result.data.length; i++)
               {
                  mUserItems.push(result.data[i].identifier);
               }
               mAPI.dispatchEvent(new APIEvent(KongregateAPI.KONGREGATE_EVENT_USER_INVENTORY,{}));
            }
         });
      }
      
      override public function hasItem(identifier:String) : Boolean
      {
         return this.mUserItems.indexOf(identifier) >= 0;
      }
   }
}

