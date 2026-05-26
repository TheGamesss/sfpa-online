package com.miniclip.events
{
   import flash.events.Event;
   
   public class CurrenciesEvent extends Event
   {
      
      public static const ERROR:String = "currencies_error";
      
      public static const READY:String = "currencies_ready";
      
      public static const CURRENCIES_INIT_FAILED:String = "currencies_init_failed";
      
      public static const BALANCE:String = "currencies_balance";
      
      public static const BALANCES:String = "currencies_balances";
      
      public static const ITEM_QTY_DECREMENTED:String = "currencies_itemqnt_decremented";
      
      public static const PURCHASE_CANCELLED_BY_USER:String = "currencies_purchase_cancelled";
      
      public static const PURCHASE_ACCEPTED_BY_USER:String = "currencies_purchase_accepted";
      
      public static const GET_ITEM_BY_ID:String = "currencies_item_byid";
      
      public static const GET_ITEMS_BY_GAME_ID:String = "currencies_items_gameid";
      
      public static const GET_BUNDLES:String = "currencies_bundles";
      
      public static const GET_AVAILABLE_CURRENCIES:String = "currencies_available_currencies";
      
      public static const GET_CURRENCY_BY_ID:String = "currencies_currency_byid";
      
      public static const ADJUST_CURRENCY_BALANCE:String = "currencies_adjust_Currency_Balance";
      
      public static const DECREMENT_ITEM_BALANCE:String = "currencies_decrement_Item_Balance";
      
      public static const GIVE_ITEM:String = "currencies_give_item";
      
      public static const USER_ITEM_QUANTITY:String = "currencies_user_item_quantity";
      
      public static const USER_ITEMS_BY_GAME_ID:String = "currencies_user_items_by_gameid";
      
      public static const PURCHASED:String = "currencies_purchased";
      
      public static const BUNDLE_PURCHASED:String = "currencies_bundle_purchased";
      
      public static const PURCHASE_FAILED:String = "currencies_purchase_failed";
      
      public static const PURCHASE_BUNDLE_FAILED:String = "currencies_purchase_bundle_failed";
      
      public static const CURRENCY_CONVERTED:String = "currencies_currency_converted";
      
      public static const CONVERT_CANCELLED_BY_USER:String = "currencies_convert_cancelled";
      
      public static const CONVERT_ACCEPTED_BY_USER:String = "currencies_convert_accepted";
      
      public static const CONVERSION_FAILED:String = "currencies_conversion_failed";
      
      public static const TOPUP_WINDOW_CLOSED:String = "currencies_topup_window_closed";
      
      public static const CURRENCIES_OFFER_AVAILABLE:String = "currencies_offer_available";
      
      public static const CURRENCIES_OFFER_UNAVAILABLE:String = "currencies_offer_unavailable";
      
      public static const CREDITS_OFFER_CLOSED:String = "currencies_offer_closed";
      
      private var _data:*;
      
      public function CurrenciesEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this._data = data;
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      override public function clone() : Event
      {
         return new CurrenciesEvent(type,this.data,bubbles,cancelable);
      }
   }
}

