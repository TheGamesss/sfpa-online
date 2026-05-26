package com.kongregate.air
{
   public interface IAnalytics
   {
      
      function setCommonPropsCallback(param1:Function) : void;
      
      function setCommonProperties(param1:Object) : void;
      
      function updateCommonProps() : void;
      
      function gameUserUpdate(param1:Object) : void;
      
      function addEvent(param1:String, param2:Object) : void;
      
      function addFilterType(param1:String) : void;
      
      function getInstallReferrer() : String;
      
      function getAutoProperties() : Object;
      
      function startPurchase(param1:String, param2:int = 1, param3:Object = null) : void;
      
      function finishPurchaseWithProductId(param1:String, param2:String, param3:String, param4:Object = null) : void;
      
      function finishPurchase(param1:String, param2:String, param3:Object = null, param4:String = null) : void;
      
      function getResourceNames() : Array;
      
      function getResourceAsString(param1:String, param2:String, param3:String) : String;
      
      function finishPromoAward(param1:String) : void;
      
      function start() : void;
   }
}

