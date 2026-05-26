package starling.utils
{
   import starling.errors.*;
   
   public class Color
   {
      
      public static const WHITE:uint = 16777215;
      
      public static const SILVER:uint = 12632256;
      
      public static const GRAY:uint = 8421504;
      
      public static const BLACK:uint = 0;
      
      public static const RED:uint = 16711680;
      
      public static const MAROON:uint = 8388608;
      
      public static const YELLOW:uint = 16776960;
      
      public static const OLIVE:uint = 8421376;
      
      public static const LIME:uint = 65280;
      
      public static const GREEN:uint = 32768;
      
      public static const AQUA:uint = 65535;
      
      public static const TEAL:uint = 32896;
      
      public static const BLUE:uint = 255;
      
      public static const NAVY:uint = 128;
      
      public static const FUCHSIA:uint = 16711935;
      
      public static const PURPLE:uint = 8388736;
      
      public function Color()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function getAlpha(color:uint) : int
      {
         return color >> 24 & 0xFF;
      }
      
      public static function getRed(color:uint) : int
      {
         return color >> 16 & 0xFF;
      }
      
      public static function getGreen(color:uint) : int
      {
         return color >> 8 & 0xFF;
      }
      
      public static function getBlue(color:uint) : int
      {
         return color & 0xFF;
      }
      
      public static function setAlpha(color:uint, alpha:int) : uint
      {
         return color & 0xFFFFFF | (alpha & 0xFF) << 24;
      }
      
      public static function setRed(color:uint, red:int) : uint
      {
         return color & 0xFF00FFFF | (red & 0xFF) << 16;
      }
      
      public static function setGreen(color:uint, green:int) : uint
      {
         return color & 0xFFFF00FF | (green & 0xFF) << 8;
      }
      
      public static function setBlue(color:uint, blue:int) : uint
      {
         return color & 0xFFFFFF00 | blue & 0xFF;
      }
      
      public static function rgb(red:int, green:int, blue:int) : uint
      {
         return red << 16 | green << 8 | blue;
      }
      
      public static function argb(alpha:int, red:int, green:int, blue:int) : uint
      {
         return alpha << 24 | red << 16 | green << 8 | blue;
      }
      
      public static function toVector(color:uint, out:Vector.<Number> = null) : Vector.<Number>
      {
         if(out == null)
         {
            out = new Vector.<Number>(4,true);
         }
         out[0] = (color >> 16 & 0xFF) / 255;
         out[1] = (color >> 8 & 0xFF) / 255;
         out[2] = (color & 0xFF) / 255;
         out[3] = (color >> 24 & 0xFF) / 255;
         return out;
      }
      
      public static function multiply(color:uint, factor:Number) : uint
      {
         if(factor == 0)
         {
            return 0;
         }
         var alpha:uint = (color >> 24 & 0xFF) * factor;
         var red:uint = (color >> 16 & 0xFF) * factor;
         var green:uint = (color >> 8 & 0xFF) * factor;
         var blue:uint = (color & 0xFF) * factor;
         if(alpha > 255)
         {
            alpha = 255;
         }
         if(red > 255)
         {
            red = 255;
         }
         if(green > 255)
         {
            green = 255;
         }
         if(blue > 255)
         {
            blue = 255;
         }
         return argb(alpha,red,green,blue);
      }
      
      public static function interpolate(startColor:uint, endColor:uint, ratio:Number) : uint
      {
         var startA:uint = uint(startColor >> 24 & 0xFF);
         var startR:uint = uint(startColor >> 16 & 0xFF);
         var startG:uint = uint(startColor >> 8 & 0xFF);
         var startB:uint = uint(startColor & 0xFF);
         var endA:uint = uint(endColor >> 24 & 0xFF);
         var endR:uint = uint(endColor >> 16 & 0xFF);
         var endG:uint = uint(endColor >> 8 & 0xFF);
         var endB:uint = uint(endColor & 0xFF);
         var newA:uint = startA + (endA - startA) * ratio;
         var newR:uint = startR + (endR - startR) * ratio;
         var newG:uint = startG + (endG - startG) * ratio;
         var newB:uint = startB + (endB - startB) * ratio;
         return newA << 24 | newR << 16 | newG << 8 | newB;
      }
   }
}

