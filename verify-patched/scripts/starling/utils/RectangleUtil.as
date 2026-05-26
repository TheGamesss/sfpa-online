package starling.utils
{
   import flash.geom.*;
   import starling.errors.*;
   
   public class RectangleUtil
   {
      
      private static const sPoint:Point = new Point();
      
      private static const sPoint3D:Vector3D = new Vector3D();
      
      private static const sPositions:Vector.<Point> = new <Point>[new Point(),new Point(),new Point(),new Point()];
      
      public function RectangleUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function intersect(rect1:Rectangle, rect2:Rectangle, out:Rectangle = null) : Rectangle
      {
         if(out == null)
         {
            out = new Rectangle();
         }
         var left:Number = rect1.x > rect2.x ? rect1.x : rect2.x;
         var right:Number = rect1.right < rect2.right ? rect1.right : rect2.right;
         var top:Number = rect1.y > rect2.y ? rect1.y : rect2.y;
         var bottom:Number = rect1.bottom < rect2.bottom ? rect1.bottom : rect2.bottom;
         if(left > right || top > bottom)
         {
            out.setEmpty();
         }
         else
         {
            out.setTo(left,top,right - left,bottom - top);
         }
         return out;
      }
      
      public static function fit(rectangle:Rectangle, into:Rectangle, scaleMode:String = "showAll", pixelPerfect:Boolean = false, out:Rectangle = null) : Rectangle
      {
         if(!ScaleMode.isValid(scaleMode))
         {
            throw new ArgumentError("Invalid scaleMode: " + scaleMode);
         }
         if(out == null)
         {
            out = new Rectangle();
         }
         var width:Number = rectangle.width;
         var height:Number = rectangle.height;
         var factorX:Number = into.width / width;
         var factorY:Number = into.height / height;
         var factor:Number = 1;
         if(scaleMode == ScaleMode.SHOW_ALL)
         {
            factor = factorX < factorY ? factorX : factorY;
            if(pixelPerfect)
            {
               factor = Number(nextSuitableScaleFactor(factor,false));
            }
         }
         else if(scaleMode == ScaleMode.NO_BORDER)
         {
            factor = factorX > factorY ? factorX : factorY;
            if(pixelPerfect)
            {
               factor = Number(nextSuitableScaleFactor(factor,true));
            }
         }
         width *= factor;
         height *= factor;
         out.setTo(into.x + (into.width - width) / 2,into.y + (into.height - height) / 2,width,height);
         return out;
      }
      
      private static function nextSuitableScaleFactor(factor:Number, up:Boolean) : Number
      {
         var divisor:Number = 1;
         if(up)
         {
            if(factor >= 0.5)
            {
               return Math.ceil(factor);
            }
            while(1 / (divisor + 1) > factor)
            {
               divisor++;
            }
         }
         else
         {
            if(factor >= 1)
            {
               return Math.floor(factor);
            }
            while(1 / divisor > factor)
            {
               divisor++;
            }
         }
         return 1 / divisor;
      }
      
      public static function normalize(rect:Rectangle) : void
      {
         if(rect.width < 0)
         {
            rect.width = -rect.width;
            rect.x -= rect.width;
         }
         if(rect.height < 0)
         {
            rect.height = -rect.height;
            rect.y -= rect.height;
         }
      }
      
      public static function extend(rect:Rectangle, left:Number = 0, right:Number = 0, top:Number = 0, bottom:Number = 0) : void
      {
         rect.x -= left;
         rect.y -= top;
         rect.width += left + right;
         rect.height += top + bottom;
      }
      
      public static function extendToWholePixels(rect:Rectangle, scaleFactor:Number = 1) : void
      {
         var left:Number = Math.floor(rect.x * scaleFactor) / scaleFactor;
         var top:Number = Math.floor(rect.y * scaleFactor) / scaleFactor;
         var right:Number = Math.ceil(rect.right * scaleFactor) / scaleFactor;
         var bottom:Number = Math.ceil(rect.bottom * scaleFactor) / scaleFactor;
         rect.setTo(left,top,right - left,bottom - top);
      }
      
      public static function getBounds(rectangle:Rectangle, matrix:Matrix, out:Rectangle = null) : Rectangle
      {
         if(out == null)
         {
            out = new Rectangle();
         }
         var minX:Number = Number.MAX_VALUE;
         var maxX:Number = -Number.MAX_VALUE;
         var minY:Number = Number.MAX_VALUE;
         var maxY:Number = -Number.MAX_VALUE;
         var positions:Vector.<Point> = getPositions(rectangle,sPositions);
         for(var i:int = 0; i < 4; i++)
         {
            MatrixUtil.transformCoords(matrix,positions[i].x,positions[i].y,sPoint);
            if(minX > sPoint.x)
            {
               minX = Number(sPoint.x);
            }
            if(maxX < sPoint.x)
            {
               maxX = Number(sPoint.x);
            }
            if(minY > sPoint.y)
            {
               minY = Number(sPoint.y);
            }
            if(maxY < sPoint.y)
            {
               maxY = Number(sPoint.y);
            }
         }
         out.setTo(minX,minY,maxX - minX,maxY - minY);
         return out;
      }
      
      public static function getBoundsProjected(rectangle:Rectangle, matrix:Matrix3D, camPos:Vector3D, out:Rectangle = null) : Rectangle
      {
         var position:Point = null;
         if(out == null)
         {
            out = new Rectangle();
         }
         if(camPos == null)
         {
            throw new ArgumentError("camPos must not be null");
         }
         var minX:Number = Number.MAX_VALUE;
         var maxX:Number = -Number.MAX_VALUE;
         var minY:Number = Number.MAX_VALUE;
         var maxY:Number = -Number.MAX_VALUE;
         var positions:Vector.<Point> = getPositions(rectangle,sPositions);
         for(var i:int = 0; i < 4; i++)
         {
            position = positions[i];
            if(matrix)
            {
               MatrixUtil.transformCoords3D(matrix,position.x,position.y,0,sPoint3D);
            }
            else
            {
               sPoint3D.setTo(position.x,position.y,0);
            }
            MathUtil.intersectLineWithXYPlane(camPos,sPoint3D,sPoint);
            if(minX > sPoint.x)
            {
               minX = Number(sPoint.x);
            }
            if(maxX < sPoint.x)
            {
               maxX = Number(sPoint.x);
            }
            if(minY > sPoint.y)
            {
               minY = Number(sPoint.y);
            }
            if(maxY < sPoint.y)
            {
               maxY = Number(sPoint.y);
            }
         }
         out.setTo(minX,minY,maxX - minX,maxY - minY);
         return out;
      }
      
      public static function getPositions(rectangle:Rectangle, out:Vector.<Point> = null) : Vector.<Point>
      {
         if(out == null)
         {
            out = new Vector.<Point>(4,true);
         }
         for(var i:int = 0; i < 4; i++)
         {
            if(out[i] == null)
            {
               out[i] = new Point();
            }
         }
         out[0].x = rectangle.left;
         out[0].y = rectangle.top;
         out[1].x = rectangle.right;
         out[1].y = rectangle.top;
         out[2].x = rectangle.left;
         out[2].y = rectangle.bottom;
         out[3].x = rectangle.right;
         out[3].y = rectangle.bottom;
         return out;
      }
      
      public static function compare(r1:Rectangle, r2:Rectangle, e:Number = 0.0001) : Boolean
      {
         if(r1 == null)
         {
            return r2 == null;
         }
         if(r2 == null)
         {
            return false;
         }
         return r1.x > r2.x - e && r1.x < r2.x + e && r1.y > r2.y - e && r1.y < r2.y + e && r1.width > r2.width - e && r1.width < r2.width + e && r1.height > r2.height - e && r1.height < r2.height + e;
      }
   }
}

