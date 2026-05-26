package com.miniclip.gamemanager.currencies
{
   public class CurrencyPromotion
   {
      
      private var _currency_id:int = 0;
      
      private var _starts_at:String;
      
      private var _expires_at:String;
      
      private var _standard_amount:String;
      
      private var _standard_price:String;
      
      private var _standard_free_amount:String;
      
      private var _standard_display_price:String;
      
      public function CurrencyPromotion(src:Object)
      {
         var propName:String = null;
         super();
         trace("CurrencyPromotion");
         for(propName in src)
         {
            trace("property: " + propName + " : " + src[propName]);
         }
         if(src)
         {
            this._starts_at = src["starts_at"];
            this._expires_at = src["expires_at"];
            this._standard_amount = src["standard_amount"];
            this._standard_price = src["standard_price"];
            this._standard_free_amount = src["standard_free_amount"];
            this._standard_display_price = src["standard_display_price"];
            this._currency_id = int(src["currency_id"]);
            trace("_starts_at: " + this._starts_at,"\r_expires_at: " + this._expires_at,"\r_currency_id: " + this._currency_id,"\r_standard_amount: " + this._standard_amount + " as number: " + String(this.standardAmount),"\r_standard_price: " + this._standard_price,"\r_standard_free_amount: " + this._standard_free_amount + " as number: " + String(this.standardFreeAmount),"\r_standard_display_price: " + this._standard_display_price);
         }
      }
      
      public function get startsAt() : String
      {
         return this._starts_at;
      }
      
      public function get expiresAt() : String
      {
         return this._expires_at;
      }
      
      public function get currencyId() : int
      {
         return this._currency_id;
      }
      
      public function get standardAmount() : Number
      {
         return Number(this._standard_amount);
      }
      
      public function get standardPrice() : Number
      {
         return Number(this._standard_price);
      }
      
      public function get standardFreeAmount() : Number
      {
         return Number(this._standard_free_amount);
      }
      
      public function get standardDisplayPrice() : String
      {
         return this._standard_display_price;
      }
      
      public function toString() : String
      {
         return "";
      }
   }
}

