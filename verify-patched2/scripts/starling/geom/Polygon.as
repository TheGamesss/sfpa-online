package starling.geom
{
   import flash.geom.*;
   import flash.utils.*;
   import starling.rendering.*;
   import starling.utils.*;
   
   public class Polygon
   {
      
      private static var sRestIndices:Vector.<uint> = new Vector.<uint>(0);
      
      private var _coords:Vector.<Number>;
      
      public function Polygon(vertices:Array = null)
      {
         super();
         this._coords = new Vector.<Number>(0);
         this.addVertices.apply(this,vertices);
      }
      
      public static function createEllipse(x:Number, y:Number, radiusX:Number, radiusY:Number, numSides:int = -1) : Polygon
      {
         return new Ellipse(x,y,radiusX,radiusY,numSides);
      }
      
      public static function createCircle(x:Number, y:Number, radius:Number, numSides:int = -1) : Polygon
      {
         return new Ellipse(x,y,radius,radius,numSides);
      }
      
      public static function createRectangle(x:Number, y:Number, width:Number, height:Number) : Polygon
      {
         return new Rectangle(x,y,width,height);
      }
      
      private static function isConvexTriangle(ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number) : Boolean
      {
         return (ay - by) * (cx - bx) + (bx - ax) * (cy - by) >= 0;
      }
      
      private static function areVectorsIntersecting(ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number, dx:Number, dy:Number) : Boolean
      {
         if(ax == bx && ay == by || cx == dx && cy == dy)
         {
            return false;
         }
         var abx:Number = bx - ax;
         var aby:Number = by - ay;
         var cdx:Number = dx - cx;
         var cdy:Number = dy - cy;
         var tDen:Number = cdy * abx - cdx * aby;
         if(tDen == 0)
         {
            return false;
         }
         var t:Number = (aby * (cx - ax) - abx * (cy - ay)) / tDen;
         if(t < 0 || t > 1)
         {
            return false;
         }
         var s:Number = aby ? (cy - ay + t * cdy) / aby : (cx - ax + t * cdx) / abx;
         return s >= 0 && s <= 1;
      }
      
      public function clone() : Polygon
      {
         var clone:Polygon = new Polygon();
         var numCoords:int = int(this._coords.length);
         for(var i:int = 0; i < numCoords; i++)
         {
            clone._coords[i] = this._coords[i];
         }
         return clone;
      }
      
      public function reverse() : void
      {
         var tmp:Number = NaN;
         var numCoords:int = int(this._coords.length);
         var numVertices:int = numCoords / 2;
         for(var i:int = 0; i < numVertices; i += 2)
         {
            tmp = Number(this._coords[i]);
            this._coords[i] = this._coords[numCoords - i - 2];
            this._coords[numCoords - i - 2] = tmp;
            tmp = Number(this._coords[i + 1]);
            this._coords[i + 1] = this._coords[numCoords - i - 1];
            this._coords[numCoords - i - 1] = tmp;
         }
      }
      
      public function addVertices(... args) : void
      {
         var i:int = 0;
         var numArgs:int = int(args.length);
         var numCoords:int = int(this._coords.length);
         if(numArgs > 0)
         {
            if(args[0] is Point)
            {
               for(i = 0; i < numArgs; i++)
               {
                  this._coords[numCoords + i * 2] = (args[i] as Point).x;
                  this._coords[numCoords + i * 2 + 1] = (args[i] as Point).y;
               }
            }
            else
            {
               if(!(args[0] is Number))
               {
                  throw new ArgumentError("Invalid type: " + getQualifiedClassName(args[0]));
               }
               for(i = 0; i < numArgs; i++)
               {
                  this._coords[numCoords + i] = args[i];
               }
            }
         }
      }
      
      public function setVertex(index:int, x:Number, y:Number) : void
      {
         if(index >= 0 && index <= this.numVertices)
         {
            this._coords[index * 2] = x;
            this._coords[index * 2 + 1] = y;
            return;
         }
         throw new RangeError("Invalid index: " + index);
      }
      
      public function getVertex(index:int, out:Point = null) : Point
      {
         if(index >= 0 && index < this.numVertices)
         {
            out ||= new Point();
            out.setTo(this._coords[index * 2],this._coords[index * 2 + 1]);
            return out;
         }
         throw new RangeError("Invalid index: " + index);
      }
      
      public function contains(x:Number, y:Number) : Boolean
      {
         var i:int = 0;
         var ix:Number = NaN;
         var iy:Number = NaN;
         var jx:Number = NaN;
         var jy:Number = NaN;
         var j:int = this.numVertices - 1;
         var oddNodes:uint = 0;
         for(i = 0; i < this.numVertices; i++)
         {
            ix = Number(this._coords[i * 2]);
            iy = Number(this._coords[i * 2 + 1]);
            jx = Number(this._coords[j * 2]);
            jy = Number(this._coords[j * 2 + 1]);
            if((iy < y && jy >= y || jy < y && iy >= y) && (ix <= x || jx <= x))
            {
               oddNodes ^= uint(ix + (y - iy) / (jy - iy) * (jx - ix) < x);
            }
            j = i;
         }
         return oddNodes != 0;
      }
      
      public function containsPoint(point:Point) : Boolean
      {
         return this.contains(point.x,point.y);
      }
      
      public function triangulate(indexData:IndexData = null, offset:int = 0) : IndexData
      {
         var i:int = 0;
         var restIndexPos:int = 0;
         var numRestIndices:* = 0;
         var otherIndex:uint = 0;
         var earFound:Boolean = false;
         var i0:uint = 0;
         var i1:uint = 0;
         var i2:uint = 0;
         var numVertices:int = this.numVertices;
         var numTriangles:int = this.numTriangles;
         if(indexData == null)
         {
            indexData = new IndexData(numTriangles * 3);
         }
         if(numTriangles == 0)
         {
            return indexData;
         }
         sRestIndices.length = numVertices;
         i = 0;
         while(i < numVertices)
         {
            sRestIndices[i] = i;
            i++;
         }
         restIndexPos = 0;
         numRestIndices = numVertices;
         var a:Point = Pool.getPoint();
         var b:Point = Pool.getPoint();
         var c:Point = Pool.getPoint();
         var p:Point = Pool.getPoint();
         while(numRestIndices > 3)
         {
            earFound = false;
            i0 = uint(sRestIndices[restIndexPos % numRestIndices]);
            i1 = uint(sRestIndices[(restIndexPos + 1) % numRestIndices]);
            i2 = uint(sRestIndices[(restIndexPos + 2) % numRestIndices]);
            a.setTo(this._coords[2 * i0],this._coords[2 * i0 + 1]);
            b.setTo(this._coords[2 * i1],this._coords[2 * i1 + 1]);
            c.setTo(this._coords[2 * i2],this._coords[2 * i2 + 1]);
            if(isConvexTriangle(a.x,a.y,b.x,b.y,c.x,c.y))
            {
               earFound = true;
               for(i = 3; i < numRestIndices; i++)
               {
                  otherIndex = uint(sRestIndices[(restIndexPos + i) % numRestIndices]);
                  p.setTo(this._coords[2 * otherIndex],this._coords[2 * otherIndex + 1]);
                  if(MathUtil.isPointInTriangle(p,a,b,c))
                  {
                     earFound = false;
                     break;
                  }
               }
            }
            if(earFound)
            {
               indexData.addTriangle(i0 + offset,i1 + offset,i2 + offset);
               sRestIndices.removeAt((restIndexPos + 1) % numRestIndices);
               numRestIndices--;
               restIndexPos = 0;
            }
            else if(++restIndexPos == numRestIndices)
            {
               break;
            }
         }
         Pool.putPoint(a);
         Pool.putPoint(b);
         Pool.putPoint(c);
         Pool.putPoint(p);
         indexData.addTriangle(sRestIndices[0] + offset,sRestIndices[1] + offset,sRestIndices[2] + offset);
         return indexData;
      }
      
      public function copyToVertexData(target:VertexData = null, targetVertexID:int = 0, attrName:String = "position") : void
      {
         var numVertices:int = this.numVertices;
         var requiredTargetLength:int = targetVertexID + numVertices;
         if(target.numVertices < requiredTargetLength)
         {
            target.numVertices = requiredTargetLength;
         }
         for(var i:int = 0; i < numVertices; i++)
         {
            target.setPoint(targetVertexID + i,attrName,this._coords[i * 2],this._coords[i * 2 + 1]);
         }
      }
      
      public function toString() : String
      {
         var result:String = "[Polygon";
         var numPoints:int = this.numVertices;
         if(numPoints > 0)
         {
            result += "\n";
         }
         for(var i:int = 0; i < numPoints; i++)
         {
            result += "  [Vertex " + i + ": " + "x=" + this._coords[i * 2].toFixed(1) + ", " + "y=" + this._coords[i * 2 + 1].toFixed(1) + "]" + (i == numPoints - 1 ? "\n" : ",\n");
         }
         return result + "]";
      }
      
      public function get isSimple() : Boolean
      {
         var ax:Number = NaN;
         var ay:Number = NaN;
         var bx:Number = NaN;
         var by:Number = NaN;
         var endJ:Number = NaN;
         var j:int = 0;
         var cx:Number = NaN;
         var cy:Number = NaN;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var numCoords:int = int(this._coords.length);
         if(numCoords <= 6)
         {
            return true;
         }
         for(var i:int = 0; i < numCoords; i += 2)
         {
            ax = Number(this._coords[i]);
            ay = Number(this._coords[i + 1]);
            bx = Number(this._coords[(i + 2) % numCoords]);
            by = Number(this._coords[(i + 3) % numCoords]);
            endJ = i + numCoords - 2;
            for(j = i + 4; j < endJ; j += 2)
            {
               cx = Number(this._coords[j % numCoords]);
               cy = Number(this._coords[(j + 1) % numCoords]);
               dx = Number(this._coords[(j + 2) % numCoords]);
               dy = Number(this._coords[(j + 3) % numCoords]);
               if(areVectorsIntersecting(ax,ay,bx,by,cx,cy,dx,dy))
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function get isConvex() : Boolean
      {
         var i:int = 0;
         var numCoords:int = int(this._coords.length);
         if(numCoords < 6)
         {
            return true;
         }
         for(i = 0; i < numCoords; i += 2)
         {
            if(!isConvexTriangle(this._coords[i],this._coords[i + 1],this._coords[(i + 2) % numCoords],this._coords[(i + 3) % numCoords],this._coords[(i + 4) % numCoords],this._coords[(i + 5) % numCoords]))
            {
               return false;
            }
         }
         return true;
      }
      
      public function get area() : Number
      {
         var i:int = 0;
         var area:Number = 0;
         var numCoords:int = int(this._coords.length);
         if(numCoords >= 6)
         {
            for(i = 0; i < numCoords; i += 2)
            {
               area += this._coords[i] * this._coords[(i + 3) % numCoords];
               area -= this._coords[i + 1] * this._coords[(i + 2) % numCoords];
            }
         }
         return area / 2;
      }
      
      public function get numVertices() : int
      {
         return this._coords.length / 2;
      }
      
      public function set numVertices(value:int) : void
      {
         var i:int = 0;
         var oldLength:int = this.numVertices;
         this._coords.length = value * 2;
         if(oldLength < value)
         {
            for(i = oldLength; i < value; i++)
            {
               this._coords[i * 2] = this._coords[i * 2 + 1] = 0;
            }
         }
      }
      
      public function get numTriangles() : int
      {
         var numVertices:int = this.numVertices;
         return numVertices >= 3 ? int(numVertices - 2) : 0;
      }
   }
}

import flash.errors.*;
import flash.utils.*;
import starling.rendering.*;

class ImmutablePolygon extends Polygon
{
   
   private var _frozen:Boolean;
   
   public function ImmutablePolygon(vertices:Array)
   {
      super(vertices);
      this._frozen = true;
   }
   
   override public function addVertices(... args) : void
   {
      if(this._frozen)
      {
         throw this.getImmutableError();
      }
      super.addVertices.apply(this,args);
   }
   
   override public function setVertex(index:int, x:Number, y:Number) : void
   {
      if(this._frozen)
      {
         throw this.getImmutableError();
      }
      super.setVertex(index,x,y);
   }
   
   override public function reverse() : void
   {
      if(this._frozen)
      {
         throw this.getImmutableError();
      }
      super.reverse();
   }
   
   override public function set numVertices(value:int) : void
   {
      if(this._frozen)
      {
         throw this.getImmutableError();
      }
      super.reverse();
   }
   
   private function getImmutableError() : Error
   {
      var className:String = getQualifiedClassName(this).split("::").pop();
      var msg:String = className + " cannot be modified. Call \'clone\' to create a mutable copy.";
      return new IllegalOperationError(msg);
   }
}

class Ellipse extends ImmutablePolygon
{
   
   private var _x:Number;
   
   private var _y:Number;
   
   private var _radiusX:Number;
   
   private var _radiusY:Number;
   
   public function Ellipse(x:Number, y:Number, radiusX:Number, radiusY:Number, numSides:int = -1)
   {
      this._x = x;
      this._y = y;
      this._radiusX = radiusX;
      this._radiusY = radiusY;
      super(this.getVertices(numSides));
   }
   
   private function getVertices(numSides:int) : Array
   {
      if(numSides < 0)
      {
         numSides = Math.PI * (this._radiusX + this._radiusY) / 4;
      }
      if(numSides < 6)
      {
         numSides = 6;
      }
      var vertices:Array = [];
      var angleDelta:Number = 2 * Math.PI / numSides;
      var angle:Number = 0;
      for(var i:int = 0; i < numSides; i++)
      {
         vertices[i * 2] = Math.cos(angle) * this._radiusX + this._x;
         vertices[i * 2 + 1] = Math.sin(angle) * this._radiusY + this._y;
         angle += angleDelta;
      }
      return vertices;
   }
   
   override public function triangulate(indexData:IndexData = null, offset:int = 0) : IndexData
   {
      if(indexData == null)
      {
         indexData = new IndexData((numVertices - 2) * 3);
      }
      var from:uint = 1;
      var to:uint = numVertices - 1;
      for(var i:int = int(from); i < to; i++)
      {
         indexData.addTriangle(offset,offset + i,offset + i + 1);
      }
      return indexData;
   }
   
   override public function contains(x:Number, y:Number) : Boolean
   {
      var vx:Number = x - this._x;
      var vy:Number = y - this._y;
      var a:Number = vx / this._radiusX;
      var b:Number = vy / this._radiusY;
      return a * a + b * b <= 1;
   }
   
   override public function get area() : Number
   {
      return Math.PI * this._radiusX * this._radiusY;
   }
   
   override public function get isSimple() : Boolean
   {
      return true;
   }
   
   override public function get isConvex() : Boolean
   {
      return true;
   }
}

class Rectangle extends ImmutablePolygon
{
   
   private var _x:Number;
   
   private var _y:Number;
   
   private var _width:Number;
   
   private var _height:Number;
   
   public function Rectangle(x:Number, y:Number, width:Number, height:Number)
   {
      this._x = x;
      this._y = y;
      this._width = width;
      this._height = height;
      super([x,y,x + width,y,x + width,y + height,x,y + height]);
   }
   
   override public function triangulate(indexData:IndexData = null, offset:int = 0) : IndexData
   {
      if(indexData == null)
      {
         indexData = new IndexData(6);
      }
      indexData.addTriangle(offset,offset + 1,offset + 3);
      indexData.addTriangle(offset + 1,offset + 2,offset + 3);
      return indexData;
   }
   
   override public function contains(x:Number, y:Number) : Boolean
   {
      return x >= this._x && x <= this._x + this._width && y >= this._y && y <= this._y + this._height;
   }
   
   override public function get area() : Number
   {
      return this._width * this._height;
   }
   
   override public function get isSimple() : Boolean
   {
      return true;
   }
   
   override public function get isConvex() : Boolean
   {
      return true;
   }
}
