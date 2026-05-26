package com.kongregate.air
{
   import flash.utils.getDefinitionByName;
   
   public class ExtensionContextWrapper
   {
      
      public function ExtensionContextWrapper()
      {
         super();
      }
      
      public static function createExtensionContext(extensionID:String, contextType:String) : *
      {
         var wrapperClass:Class = null;
         try
         {
            wrapperClass = getDefinitionByName("flash.external.ExtensionContext") as Class;
            if(wrapperClass)
            {
               return wrapperClass.createExtensionContext.call(undefined,extensionID,contextType);
            }
         }
         catch(e:Error)
         {
            trace("Error while creating ExtensionContext: " + e);
         }
      }
   }
}

