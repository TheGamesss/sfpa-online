package starling.utils
{
   import flash.geom.*;
   import starling.errors.*;
   
   public class MathUtil
   {
      
      private static const TWO_PI:Number = Math.PI * 2;
      
      public function MathUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function intersectLineWithXYPlane(pointA:Vector3D, pointB:Vector3D, out:Point = null) : Point
      {
         if(out == null)
         {
            out = new Point();
         }
         var vectorX:Number = pointB.x - pointA.x;
         var vectorY:Number = pointB.y - pointA.y;
         var vectorZ:Number = pointB.z - pointA.z;
         var lambda:Number = -pointA.z / vectorZ;
         out.x = pointA.x + lambda * vectorX;
         out.y = pointA.y + lambda * vectorY;
         return out;
      }
      
      public static function isPointInTriangle(p:Point, a:Point, b:Point, c:Point) : Boolean
      {
         var v0x:Number = c.x - a.x;
         var v0y:Number = c.y - a.y;
         var v1x:Number = b.x - a.x;
         var v1y:Number = b.y - a.y;
         var v2x:Number = p.x - a.x;
         var v2y:Number = p.y - a.y;
         var dot00:Number = v0x * v0x + v0y * v0y;
         var dot01:Number = v0x * v1x + v0y * v1y;
         var dot02:Number = v0x * v2x + v0y * v2y;
         var dot11:Number = v1x * v1x + v1y * v1y;
         var dot12:Number = v1x * v2x + v1y * v2y;
         var invDen:Number = 1 / (dot00 * dot11 - dot01 * dot01);
         var u:Number = (dot11 * dot02 - dot01 * dot12) * invDen;
         var v:Number = (dot00 * dot12 - dot01 * dot02) * invDen;
         return u >= 0 && v >= 0 && u + v < 1;
      }
      
      public static function normalizeAngle(angle:Number) : Number
      {
         angle %= TWO_PI;
         if(angle < -Math.PI)
         {
            angle += TWO_PI;
         }
         if(angle > Math.PI)
         {
            angle -= TWO_PI;
         }
         return angle;
      }
      
      public static function getNextPowerOfTwo(number:Number) : int
      {
         var result:int = 0;
         if(number is int && number > 0 && (number & number - 1) == 0)
         {
            return number;
         }
         result = 1;
         for(number -= 1e-9; result < number; )
         {
            result <<= 1;
         }
         return result;
      }
      
      public static function isEquivalent(a:Number, b:Number, epsilon:Number = 0.0001) : Boolean
      {
         return a - epsilon < b && a + epsilon > b;
      }
      
      public static function max(a:Number, b:Number) : Number
      {
         return a > b ? a : b;
      }
      
      public static function min(a:Number, b:Number) : Number
      {
         return a < b ? a : b;
      }
      
      public static function clamp(value:Number, min:Number, max:Number) : Number
      {
         return value < min ? min : (value > max ? max : value);
      }
   }
}

