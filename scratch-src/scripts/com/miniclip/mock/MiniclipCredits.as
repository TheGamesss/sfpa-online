package com.miniclip.mock
{
   import com.miniclip.events.CreditsEvent;
   import com.miniclip.gamemanager.CreditsCapabilities;
   import com.miniclip.gamemanager.GameCredits;
   import com.miniclip.gamemanager.ui.VendorIcon;
   import flash.events.EventDispatcher;
   
   public class MiniclipCredits extends EventDispatcher implements GameCredits
   {
      
      public function MiniclipCredits()
      {
         super();
      }
      
      public function topupCredits() : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.TOPUP_WINDOW_OPENED,null));
         dispatchEvent(new CreditsEvent(CreditsEvent.TOPUP_WINDOW_CLOSED,{
            "success":true,
            "result":1000,
            "description":""
         }));
      }
      
      public function getBalance(promptLogin:Boolean = false) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.BALANCE,{
            "success":true,
            "result":0
         }));
      }
      
      public function getUserItemsByGameId(promptLogin:Boolean = false) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.USER_ITEMS_BY_GAME_ID,{
            "success":true,
            "result":null
         }));
      }
      
      public function getTotalUserItemBalance(item_id:int, promptLogin:Boolean = false) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.ITEM_TOTAL_USER_BALANCE,{
            "success":true,
            "result":0
         }));
      }
      
      public function getItemInfo(item_id:int) : void
      {
         var obj:Object = {
            "description":"A test widget",
            "enabled":"1",
            "game_id":"0",
            "id":"0",
            "max_qty":"0",
            "name":"Widget"
         };
         dispatchEvent(new CreditsEvent(CreditsEvent.ITEM_INFO,{
            "success":true,
            "result":obj
         }));
      }
      
      public function decrementUserItemQuantity(item_id:int, qty:int) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.ITEM_QTY_DECREMENTED,{
            "success":false,
            "result":113
         }));
      }
      
      public function purchaseProduct(product_id:int, price:int, product_name:String = null, promptLogin:Boolean = false) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.PURCHASE_FAILED,{
            "success":false,
            "result":100
         }));
      }
      
      public function purchaseProducts(productsArray:Array, price:int, product_name:String = null, promptLogin:Boolean = false) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.PURCHASE_FAILED,{
            "success":false,
            "result":100
         }));
      }
      
      public function getProductsByGameId(forceUpdate:Boolean = true) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.GET_PRODUCT_BY_GAME_ID,{
            "success":false,
            "result":117
         }));
      }
      
      public function getProductById(product_id:int) : void
      {
         var obj:Object = {
            "credit_cost":"0",
            "description":"test product",
            "enabled":"1",
            "game_id":"0",
            "id":"0",
            "items":[{
               "enabled":1,
               "game_id":0,
               "item_id":0,
               "lifetime":0,
               "max_qty":0,
               "name":"Widget",
               "qty":"1",
               "name":"Test name"
            }]
         };
         dispatchEvent(new CreditsEvent(CreditsEvent.GET_PRODUCT_BY_ID,{
            "success":true,
            "result":obj
         }));
      }
      
      public function getVendorIcon() : VendorIcon
      {
         return new VendorIcon("",45,45);
      }
      
      public function getSecondaryVendorIcon() : VendorIcon
      {
         return new VendorIcon("",45,45);
      }
      
      public function getVendorLogo() : VendorIcon
      {
         return new VendorIcon("",200,45);
      }
      
      public function get capabilities() : CreditsCapabilities
      {
         return new CreditsCapabilities({});
      }
   }
}

