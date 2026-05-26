package com.miniclip.gamemanager
{
   import com.miniclip.gamemanager.utils.absoluteURI;
   
   public class Utils
   {
      
      private static var _instance:Utils;
      
      public function Utils(key:Key)
      {
         super();
         if(!key)
         {
            throw new Error("Singelton!");
         }
      }
      
      public static function get instance() : Utils
      {
         if(!_instance)
         {
            _instance = new Utils(new Key());
         }
         return _instance;
      }
      
      public function getAbsoluteURI(path:String) : String
      {
         return absoluteURI(path,null);
      }
   }
}

class Key
{
   
   public function Key()
   {
      super();
   }
}
