package com.miniclip.gamemanager
{
   public class CreditsCapabilities
   {
      
      private var _capabilities:Object;
      
      public function CreditsCapabilities(capabilities:Object)
      {
         super();
         this._capabilities = capabilities;
      }
      
      public function get getBalance() : Boolean
      {
         return Boolean(this._capabilities["getBalance"] != null ? this._capabilities["getBalance"] : true);
      }
      
      public function get purchaseProducts() : Boolean
      {
         return Boolean(this._capabilities["purchaseProducts"] != null ? this._capabilities["purchaseProducts"] : true);
      }
      
      public function get obj() : Object
      {
         var i:String = null;
         var o:Object = new Object();
         for(i in this._capabilities)
         {
            o[i] = this._capabilities[i];
         }
         return o;
      }
   }
}

