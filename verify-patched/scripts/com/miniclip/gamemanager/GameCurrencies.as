package com.miniclip.gamemanager
{
   import com.miniclip.gamemanager.ui.VendorIcon;
   import flash.events.IEventDispatcher;
   
   public interface GameCurrencies extends IEventDispatcher
   {
      
      function init() : void;
      
      function getCurrencyIcon(param1:int, param2:int) : VendorIcon;
      
      function getConvertedAmount(param1:int, param2:int, param3:int) : Number;
      
      function convertCurrency(param1:int, param2:int, param3:int) : void;
      
      function getBalance(param1:int) : void;
      
      function getBalances() : void;
      
      function getUserItemQuantity(param1:int) : void;
      
      function getUserItemsByGameId() : void;
      
      function getItemById(param1:int) : void;
      
      function getItemsByGameId() : void;
      
      function getBundles(param1:int, param2:Array) : void;
      
      function getCurrencyById(param1:int) : void;
      
      function getAvailableCurrencies() : void;
      
      function purchaseBundle(param1:int, param2:int) : void;
      
      function purchaseItem(param1:int, param2:int, param3:Boolean) : void;
      
      function purchaseItems(param1:Array, param2:int, param3:Boolean) : void;
      
      function adjustCurrencyBalance(param1:int, param2:Number) : void;
      
      function decrementItemBalance(param1:int, param2:int) : void;
      
      function giveItem(param1:int, param2:int) : void;
      
      function currenciesOfferAvailable(param1:int, param2:String) : void;
      
      function showOffer(param1:int, param2:String) : void;
      
      function topupCurrency() : void;
   }
}

