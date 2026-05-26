package com.kongregate.as3.client.services
{
   public interface IAnalyticsServices
   {
      
      function addEvent(param1:String, param2:Object) : void;
      
      function setCommonPropsCallback(param1:Function) : void;
      
      function setCommonProperties(param1:Object) : void;
      
      function updateCommonProperties() : void;
      
      function setAutomaticVariablesListener(param1:Function) : void;
      
      function addFilterType(param1:String) : void;
      
      function getAutoLongProperty(param1:String) : Number;
      
      function getAutoLongLongProperty(param1:String) : Number;
      
      function getAutoStringProperty(param1:String) : String;
      
      function getAutoBoolProperty(param1:String) : Boolean;
      
      function getAutoDoubleProperty(param1:String) : Number;
      
      function getAutoIntProperty(param1:String) : int;
      
      function getAutoUTCProperty(param1:String) : String;
      
      function getAutoPropertiesJSON() : String;
      
      function startPurchase(param1:*, param2:Object) : void;
      
      function finishPurchase(param1:String, param2:String, param3:Object) : void;
      
      function start() : void;
   }
}

