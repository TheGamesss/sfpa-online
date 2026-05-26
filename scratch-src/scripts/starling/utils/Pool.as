package starling.utils
{
   import flash.geom.*;
   import starling.errors.*;
   
   public class Pool
   {
      
      private static var sPoints:Vector.<Point> = new Vector.<Point>(0);
      
      private static var sPoints3D:Vector.<Vector3D> = new Vector.<Vector3D>(0);
      
      private static var sMatrices:Vector.<Matrix> = new Vector.<Matrix>(0);
      
      private static var sMatrices3D:Vector.<Matrix3D> = new Vector.<Matrix3D>(0);
      
      private static var sRectangles:Vector.<Rectangle> = new Vector.<Rectangle>(0);
      
      public function Pool()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function getPoint(x:Number = 0, y:Number = 0) : Point
      {
         var point:Point = null;
         if(sPoints.length == 0)
         {
            return new Point(x,y);
         }
         point = sPoints.pop();
         point.x = x;
         point.y = y;
         return point;
      }
      
      public static function putPoint(point:Point) : void
      {
         if(point)
         {
            sPoints[sPoints.length] = point;
         }
      }
      
      public static function getPoint3D(x:Number = 0, y:Number = 0, z:Number = 0) : Vector3D
      {
         var point:Vector3D = null;
         if(sPoints3D.length == 0)
         {
            return new Vector3D(x,y,z);
         }
         point = sPoints3D.pop();
         point.x = x;
         point.y = y;
         point.z = z;
         return point;
      }
      
      public static function putPoint3D(point:Vector3D) : void
      {
         if(point)
         {
            sPoints3D[sPoints3D.length] = point;
         }
      }
      
      public static function getMatrix(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0) : Matrix
      {
         var matrix:Matrix = null;
         if(sMatrices.length == 0)
         {
            return new Matrix(a,b,c,d,tx,ty);
         }
         matrix = sMatrices.pop();
         matrix.setTo(a,b,c,d,tx,ty);
         return matrix;
      }
      
      public static function putMatrix(matrix:Matrix) : void
      {
         if(matrix)
         {
            sMatrices[sMatrices.length] = matrix;
         }
      }
      
      public static function getMatrix3D(identity:Boolean = true) : Matrix3D
      {
         var matrix:Matrix3D = null;
         if(sMatrices3D.length == 0)
         {
            return new Matrix3D();
         }
         matrix = sMatrices3D.pop();
         if(identity)
         {
            matrix.identity();
         }
         return matrix;
      }
      
      public static function putMatrix3D(matrix:Matrix3D) : void
      {
         if(matrix)
         {
            sMatrices3D[sMatrices3D.length] = matrix;
         }
      }
      
      public static function getRectangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) : Rectangle
      {
         var rectangle:Rectangle = null;
         if(sRectangles.length == 0)
         {
            return new Rectangle(x,y,width,height);
         }
         rectangle = sRectangles.pop();
         rectangle.setTo(x,y,width,height);
         return rectangle;
      }
      
      public static function putRectangle(rectangle:Rectangle) : void
      {
         if(rectangle)
         {
            sRectangles[sRectangles.length] = rectangle;
         }
      }
   }
}

