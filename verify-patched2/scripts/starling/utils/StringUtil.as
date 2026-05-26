package starling.utils
{
   import starling.errors.*;
   
   public class StringUtil
   {
      
      public function StringUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function format(format:String, ... args) : String
      {
         for(var i:int = 0; i < args.length; i++)
         {
            format = format.replace(new RegExp("\\{" + i + "\\}","g"),args[i]);
         }
         return format;
      }
      
      public static function clean(string:String) : String
      {
         return ("_" + string).substr(1);
      }
      
      public static function trimStart(string:String) : String
      {
         var pos:int = 0;
         var length:int = string.length;
         for(pos = 0; pos < length; pos++)
         {
            if(string.charCodeAt(pos) > 32)
            {
               break;
            }
         }
         return string.substring(pos,length);
      }
      
      public static function trimEnd(string:String) : String
      {
         for(var pos:* = int(string.length - 1); pos >= 0; pos--)
         {
            if(string.charCodeAt(pos) > 32)
            {
               break;
            }
         }
         return string.substring(0,pos + 1);
      }
      
      public static function trim(string:String) : String
      {
         var startPos:int = 0;
         var endPos:* = 0;
         var length:int = string.length;
         for(startPos = 0; startPos < length; startPos++)
         {
            if(string.charCodeAt(startPos) > 32)
            {
               break;
            }
         }
         for(endPos = int(string.length - 1); endPos >= startPos; endPos--)
         {
            if(string.charCodeAt(endPos) > 32)
            {
               break;
            }
         }
         return string.substring(startPos,endPos + 1);
      }
      
      public static function parseBoolean(value:String) : Boolean
      {
         return value == "true" || value == "TRUE" || value == "True" || value == "1";
      }
   }
}

