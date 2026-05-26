package starling.utils
{
   import starling.errors.*;
   
   public final class Align
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const TOP:String = "top";
      
      public static const BOTTOM:String = "bottom";
      
      public static const CENTER:String = "center";
      
      public function Align()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function isValid(align:String) : Boolean
      {
         return align == LEFT || align == RIGHT || align == CENTER || align == TOP || align == BOTTOM;
      }
      
      public static function isValidHorizontal(align:String) : Boolean
      {
         return align == LEFT || align == CENTER || align == RIGHT;
      }
      
      public static function isValidVertical(align:String) : Boolean
      {
         return align == TOP || align == CENTER || align == BOTTOM;
      }
   }
}

