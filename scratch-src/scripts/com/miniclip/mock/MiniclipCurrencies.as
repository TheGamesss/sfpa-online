package com.miniclip.mock
{
   import com.miniclip.events.CurrenciesEvent;
   import com.miniclip.gamemanager.GameCurrencies;
   import com.miniclip.gamemanager.ui.VendorIcon;
   import flash.events.EventDispatcher;
   
   public class MiniclipCurrencies extends EventDispatcher implements GameCurrencies
   {
      
      public function MiniclipCurrencies()
      {
         super(null);
      }
      
      public function init() : void
      {
         trace("MiniclipCurrencies::init();");
      }
      
      public function getConvertedAmount(src_id:int, des_id:int, src_amount:int) : Number
      {
         trace("MiniclipCurrencies::getConvertedAmount(); src_id, des_id, src_amount: " + src_id + ", " + des_id + ", " + src_amount);
         return NaN;
      }
      
      public function getCurrencyIcon(currencyID:int, iconType:int) : VendorIcon
      {
         return new VendorIcon("",45,45);
      }
      
      public function convertCurrency(src_id:int, des_id:int, src_amount:int) : void
      {
         trace("MiniclipCurrencies::convertCurrency(); src_id, des_id, src_amount: " + src_id + ", " + des_id + ", " + src_amount);
      }
      
      public function getBalance(currency_id:int) : void
      {
         trace("MiniclipCurrencies::getBalance(); currency_id: " + currency_id);
      }
      
      public function getBalances() : void
      {
         trace("MiniclipCurrencies::getBalances();");
      }
      
      public function getUserItemQuantity(item_id:int) : void
      {
         trace("MiniclipCurrencies::getUserItemQuantity();");
      }
      
      public function getUserItemsByGameId() : void
      {
         trace("MiniclipCurrencies::getUserItemsByGameId();");
      }
      
      public function getItemById(item_id:int) : void
      {
         trace("MiniclipCurrencies::getItemById();");
      }
      
      public function getItemsByGameId() : void
      {
         trace("MiniclipCurrencies::getItemsByGameId();");
      }
      
      public function getBundles(currency_id:int, currencies:Array) : void
      {
         trace("MiniclipCurrencies::getBundles();");
      }
      
      public function getCurrencyById(currency_id:int) : void
      {
         trace("MiniclipCurrencies::getCurrencyById();");
      }
      
      public function getAvailableCurrencies() : void
      {
         trace("MiniclipCurrencies::getAvailableCurrencies();");
      }
      
      public function purchaseBundle(bundle_id:int, currency_id:int) : void
      {
         trace("MiniclipCurrencies::purchaseBundle();");
      }
      
      public function purchaseItem(item_id:int, currency_id:int, skip_max:Boolean) : void
      {
         trace("MiniclipCurrencies::purchaseItem();");
      }
      
      public function purchaseItems(item_ids:Array, currency_id:int, skip_max:Boolean) : void
      {
         trace("MiniclipCurrencies::purchaseItems();");
      }
      
      public function adjustCurrencyBalance(currency_id:int, amount:Number) : void
      {
         trace("MiniclipCurrencies::adjustCurrencyBalance();");
      }
      
      public function decrementItemBalance(item_id:int, amount:int) : void
      {
         trace("MiniclipCurrencies::decrementItemBalance();");
      }
      
      public function giveItem(item_id:int, amount:int) : void
      {
         trace("MiniclipCurrencies::giveItem();");
      }
      
      public function topupCurrency() : void
      {
         trace("MiniclipCurrencies::topupCurrency();");
      }
      
      public function currenciesOfferAvailable(currencyID:int, offerType:String) : void
      {
         trace("MiniclipCurrencies::creditsOfferAvailable(); currencyID:",currencyID,"offerType:",offerType);
         dispatchEvent(new CurrenciesEvent(CurrenciesEvent.CURRENCIES_OFFER_UNAVAILABLE));
      }
      
      public function showOffer(currencyID:int, offerType:String) : void
      {
         dispatchEvent(new CurrenciesEvent(CurrenciesEvent.CREDITS_OFFER_CLOSED));
      }
   }
}

import com.miniclip.gamemanager.currencies.CurrencyPromotion;

CurrencyPromotion;

