package com.miniclip.serialization.json
{
   public class MC_JSON
   {
      
      public function MC_JSON()
      {
         super();
         throw new Error("not allowed");
      }
      
      public static function parse(string:String) : Object
      {
         var decoder:JSONDecoder = new JSONDecoder(string,true);
         return decoder.getValue();
      }
      
      public static function stringify(object:Object) : String
      {
         var encoder:JSONEncoder = new JSONEncoder(object);
         return encoder.getString();
      }
   }
}

