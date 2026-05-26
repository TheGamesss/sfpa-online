package starling.rendering
{
   import flash.display3D.Context3D;
   import flash.display3D.VertexBuffer3D;
   import flash.errors.*;
   import flash.geom.*;
   import flash.utils.*;
   import starling.core.*;
   import starling.errors.*;
   import starling.styles.*;
   import starling.utils.*;
   
   public class VertexData
   {
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperPoint3D:Vector3D = new Vector3D();
      
      private static var sBytes:ByteArray = new ByteArray();
      
      private var _rawData:ByteArray;
      
      private var _numVertices:int;
      
      private var _format:VertexDataFormat;
      
      private var _attributes:Vector.<VertexDataAttribute>;
      
      private var _numAttributes:int;
      
      private var _premultipliedAlpha:Boolean;
      
      private var _tinted:Boolean;
      
      private var _posOffset:int;
      
      private var _colOffset:int;
      
      private var _vertexSize:int;
      
      public function VertexData(format:* = null, initialCapacity:int = 32)
      {
         super();
         if(format == null)
         {
            this._format = MeshStyle.VERTEX_FORMAT;
         }
         else if(format is VertexDataFormat)
         {
            this._format = format;
         }
         else
         {
            if(!(format is String))
            {
               throw new ArgumentError("\'format\' must be String or VertexDataFormat");
            }
            this._format = VertexDataFormat.fromString(format as String);
         }
         this._attributes = this._format.attributes;
         this._numAttributes = this._attributes.length;
         this._posOffset = this._format.hasAttribute("position") ? int(this._format.getOffset("position")) : 0;
         this._colOffset = this._format.hasAttribute("color") ? int(this._format.getOffset("color")) : 0;
         this._vertexSize = this._format.vertexSize;
         this._numVertices = 0;
         this._premultipliedAlpha = true;
         this._rawData = new ByteArray();
         this._rawData.endian = sBytes.endian = Endian.LITTLE_ENDIAN;
         this._rawData.length = initialCapacity * this._vertexSize;
         this._rawData.length = 0;
      }
      
      private static function switchEndian(value:uint) : uint
      {
         return (value & 0xFF) << 24 | (value >> 8 & 0xFF) << 16 | (value >> 16 & 0xFF) << 8 | value >> 24 & 0xFF;
      }
      
      private static function premultiplyAlpha(rgba:uint) : uint
      {
         var factor:Number = NaN;
         var r:uint = 0;
         var g:uint = 0;
         var b:uint = 0;
         var alpha:uint = uint(rgba & 0xFF);
         if(alpha == 255)
         {
            return rgba;
         }
         factor = alpha / 255;
         r = (rgba >> 24 & 0xFF) * factor;
         g = (rgba >> 16 & 0xFF) * factor;
         b = (rgba >> 8 & 0xFF) * factor;
         return (r & 0xFF) << 24 | (g & 0xFF) << 16 | (b & 0xFF) << 8 | alpha;
      }
      
      private static function unmultiplyAlpha(rgba:uint) : uint
      {
         var factor:Number = NaN;
         var r:uint = 0;
         var g:uint = 0;
         var b:uint = 0;
         var alpha:uint = uint(rgba & 0xFF);
         if(alpha == 255 || alpha == 0)
         {
            return rgba;
         }
         factor = alpha / 255;
         r = (rgba >> 24 & 0xFF) / factor;
         g = (rgba >> 16 & 0xFF) / factor;
         b = (rgba >> 8 & 0xFF) / factor;
         return (r & 0xFF) << 24 | (g & 0xFF) << 16 | (b & 0xFF) << 8 | alpha;
      }
      
      public function clear() : void
      {
         this._rawData.clear();
         this._numVertices = 0;
         this._tinted = false;
      }
      
      public function clone() : VertexData
      {
         var clone:VertexData = new VertexData(this._format,this._numVertices);
         clone._rawData.writeBytes(this._rawData);
         clone._numVertices = this._numVertices;
         clone._premultipliedAlpha = this._premultipliedAlpha;
         clone._tinted = this._tinted;
         return clone;
      }
      
      public function copyTo(target:VertexData, targetVertexID:int = 0, matrix:Matrix = null, vertexID:int = 0, numVertices:int = -1) : void
      {
         var targetRawData:ByteArray = null;
         var x:Number = NaN;
         var y:Number = NaN;
         var pos:int = 0;
         var endPos:int = 0;
         var i:int = 0;
         var srcAttr:VertexDataAttribute = null;
         var tgtAttr:VertexDataAttribute = null;
         if(numVertices < 0 || vertexID + numVertices > this._numVertices)
         {
            numVertices = this._numVertices - vertexID;
         }
         if(this._format === target._format)
         {
            if(target._numVertices < targetVertexID + numVertices)
            {
               target._numVertices = targetVertexID + numVertices;
            }
            target._tinted = Boolean(target._tinted) || Boolean(this._tinted);
            targetRawData = target._rawData;
            targetRawData.position = targetVertexID * this._vertexSize;
            targetRawData.writeBytes(this._rawData,vertexID * this._vertexSize,numVertices * this._vertexSize);
            if(matrix)
            {
               pos = targetVertexID * this._vertexSize + this._posOffset;
               endPos = pos + numVertices * this._vertexSize;
               while(pos < endPos)
               {
                  targetRawData.position = pos;
                  x = targetRawData.readFloat();
                  y = targetRawData.readFloat();
                  targetRawData.position = pos;
                  targetRawData.writeFloat(matrix.a * x + matrix.c * y + matrix.tx);
                  targetRawData.writeFloat(matrix.d * y + matrix.b * x + matrix.ty);
                  pos += this._vertexSize;
               }
            }
         }
         else
         {
            if(target._numVertices < targetVertexID + numVertices)
            {
               target.numVertices = targetVertexID + numVertices;
            }
            for(i = 0; i < this._numAttributes; i++)
            {
               srcAttr = this._attributes[i];
               tgtAttr = target.getAttribute(srcAttr.name);
               if(tgtAttr)
               {
                  if(srcAttr.offset == this._posOffset)
                  {
                     this.copyAttributeTo_internal(target,targetVertexID,matrix,srcAttr,tgtAttr,vertexID,numVertices);
                  }
                  else
                  {
                     this.copyAttributeTo_internal(target,targetVertexID,null,srcAttr,tgtAttr,vertexID,numVertices);
                  }
               }
            }
         }
      }
      
      public function copyAttributeTo(target:VertexData, targetVertexID:int, attrName:String, matrix:Matrix = null, vertexID:int = 0, numVertices:int = -1) : void
      {
         var sourceAttribute:VertexDataAttribute = this.getAttribute(attrName);
         var targetAttribute:VertexDataAttribute = target.getAttribute(attrName);
         if(sourceAttribute == null)
         {
            throw new ArgumentError("Attribute \'" + attrName + "\' not found in source data");
         }
         if(targetAttribute == null)
         {
            throw new ArgumentError("Attribute \'" + attrName + "\' not found in target data");
         }
         if(sourceAttribute.isColor)
         {
            target._tinted = Boolean(target._tinted) || Boolean(this._tinted);
         }
         this.copyAttributeTo_internal(target,targetVertexID,matrix,sourceAttribute,targetAttribute,vertexID,numVertices);
      }
      
      private function copyAttributeTo_internal(target:VertexData, targetVertexID:int, matrix:Matrix, sourceAttribute:VertexDataAttribute, targetAttribute:VertexDataAttribute, vertexID:int, numVertices:int) : void
      {
         var i:int = 0;
         var j:int = 0;
         var x:Number = NaN;
         var y:Number = NaN;
         if(sourceAttribute.format != targetAttribute.format)
         {
            throw new IllegalOperationError("Attribute formats differ between source and target");
         }
         if(numVertices < 0 || vertexID + numVertices > this._numVertices)
         {
            numVertices = this._numVertices - vertexID;
         }
         if(target._numVertices < targetVertexID + numVertices)
         {
            target._numVertices = targetVertexID + numVertices;
         }
         var sourceData:ByteArray = this._rawData;
         var targetData:ByteArray = target._rawData;
         var sourceDelta:int = this._vertexSize - sourceAttribute.size;
         var targetDelta:int = target._vertexSize - targetAttribute.size;
         var attributeSizeIn32Bits:int = sourceAttribute.size / 4;
         sourceData.position = vertexID * this._vertexSize + sourceAttribute.offset;
         targetData.position = targetVertexID * target._vertexSize + targetAttribute.offset;
         if(matrix)
         {
            for(i = 0; i < numVertices; i++)
            {
               x = sourceData.readFloat();
               y = sourceData.readFloat();
               targetData.writeFloat(matrix.a * x + matrix.c * y + matrix.tx);
               targetData.writeFloat(matrix.d * y + matrix.b * x + matrix.ty);
               sourceData.position += sourceDelta;
               targetData.position += targetDelta;
            }
         }
         else
         {
            for(i = 0; i < numVertices; i++)
            {
               for(j = 0; j < attributeSizeIn32Bits; j++)
               {
                  targetData.writeUnsignedInt(sourceData.readUnsignedInt());
               }
               sourceData.position += sourceDelta;
               targetData.position += targetDelta;
            }
         }
      }
      
      public function trim() : void
      {
         var numBytes:int = this._numVertices * this._vertexSize;
         sBytes.length = numBytes;
         sBytes.position = 0;
         sBytes.writeBytes(this._rawData,0,numBytes);
         this._rawData.clear();
         this._rawData.length = numBytes;
         this._rawData.writeBytes(sBytes);
         sBytes.clear();
      }
      
      public function toString() : String
      {
         return StringUtil.format("[VertexData format=\"{0}\" numVertices={1}]",this._format.formatString,this._numVertices);
      }
      
      public function getUnsignedInt(vertexID:int, attrName:String) : uint
      {
         this._rawData.position = vertexID * this._vertexSize + this.getAttribute(attrName).offset;
         return this._rawData.readUnsignedInt();
      }
      
      public function setUnsignedInt(vertexID:int, attrName:String, value:uint) : void
      {
         if(this._numVertices < vertexID + 1)
         {
            this.numVertices = vertexID + 1;
         }
         this._rawData.position = vertexID * this._vertexSize + this.getAttribute(attrName).offset;
         this._rawData.writeUnsignedInt(value);
      }
      
      public function getFloat(vertexID:int, attrName:String) : Number
      {
         this._rawData.position = vertexID * this._vertexSize + this.getAttribute(attrName).offset;
         return this._rawData.readFloat();
      }
      
      public function setFloat(vertexID:int, attrName:String, value:Number) : void
      {
         if(this._numVertices < vertexID + 1)
         {
            this.numVertices = vertexID + 1;
         }
         this._rawData.position = vertexID * this._vertexSize + this.getAttribute(attrName).offset;
         this._rawData.writeFloat(value);
      }
      
      public function getPoint(vertexID:int, attrName:String, out:Point = null) : Point
      {
         if(out == null)
         {
            out = new Point();
         }
         var offset:int = attrName == "position" ? int(this._posOffset) : int(this.getAttribute(attrName).offset);
         this._rawData.position = vertexID * this._vertexSize + offset;
         out.x = this._rawData.readFloat();
         out.y = this._rawData.readFloat();
         return out;
      }
      
      public function setPoint(vertexID:int, attrName:String, x:Number, y:Number) : void
      {
         if(this._numVertices < vertexID + 1)
         {
            this.numVertices = vertexID + 1;
         }
         var offset:int = attrName == "position" ? int(this._posOffset) : int(this.getAttribute(attrName).offset);
         this._rawData.position = vertexID * this._vertexSize + offset;
         this._rawData.writeFloat(x);
         this._rawData.writeFloat(y);
      }
      
      public function getPoint3D(vertexID:int, attrName:String, out:Vector3D = null) : Vector3D
      {
         if(out == null)
         {
            out = new Vector3D();
         }
         this._rawData.position = vertexID * this._vertexSize + this.getAttribute(attrName).offset;
         out.x = this._rawData.readFloat();
         out.y = this._rawData.readFloat();
         out.z = this._rawData.readFloat();
         return out;
      }
      
      public function setPoint3D(vertexID:int, attrName:String, x:Number, y:Number, z:Number) : void
      {
         if(this._numVertices < vertexID + 1)
         {
            this.numVertices = vertexID + 1;
         }
         this._rawData.position = vertexID * this._vertexSize + this.getAttribute(attrName).offset;
         this._rawData.writeFloat(x);
         this._rawData.writeFloat(y);
         this._rawData.writeFloat(z);
      }
      
      public function getPoint4D(vertexID:int, attrName:String, out:Vector3D = null) : Vector3D
      {
         if(out == null)
         {
            out = new Vector3D();
         }
         this._rawData.position = vertexID * this._vertexSize + this.getAttribute(attrName).offset;
         out.x = this._rawData.readFloat();
         out.y = this._rawData.readFloat();
         out.z = this._rawData.readFloat();
         out.w = this._rawData.readFloat();
         return out;
      }
      
      public function setPoint4D(vertexID:int, attrName:String, x:Number, y:Number, z:Number, w:Number = 1) : void
      {
         if(this._numVertices < vertexID + 1)
         {
            this.numVertices = vertexID + 1;
         }
         this._rawData.position = vertexID * this._vertexSize + this.getAttribute(attrName).offset;
         this._rawData.writeFloat(x);
         this._rawData.writeFloat(y);
         this._rawData.writeFloat(z);
         this._rawData.writeFloat(w);
      }
      
      public function getColor(vertexID:int, attrName:String = "color") : uint
      {
         var offset:int = attrName == "color" ? int(this._colOffset) : int(this.getAttribute(attrName).offset);
         this._rawData.position = vertexID * this._vertexSize + offset;
         var rgba:uint = uint(switchEndian(this._rawData.readUnsignedInt()));
         if(this._premultipliedAlpha)
         {
            rgba = uint(unmultiplyAlpha(rgba));
         }
         return rgba >> 8 & 0xFFFFFF;
      }
      
      public function setColor(vertexID:int, attrName:String, color:uint) : void
      {
         if(this._numVertices < vertexID + 1)
         {
            this.numVertices = vertexID + 1;
         }
         var alpha:Number = this.getAlpha(vertexID,attrName);
         this.colorize(attrName,color,alpha,vertexID,1);
      }
      
      public function getAlpha(vertexID:int, attrName:String = "color") : Number
      {
         var offset:int = attrName == "color" ? int(this._colOffset) : int(this.getAttribute(attrName).offset);
         this._rawData.position = vertexID * this._vertexSize + offset;
         var rgba:uint = uint(switchEndian(this._rawData.readUnsignedInt()));
         return (rgba & 0xFF) / 255;
      }
      
      public function setAlpha(vertexID:int, attrName:String, alpha:Number) : void
      {
         if(this._numVertices < vertexID + 1)
         {
            this.numVertices = vertexID + 1;
         }
         var color:uint = this.getColor(vertexID,attrName);
         this.colorize(attrName,color,alpha,vertexID,1);
      }
      
      public function getBounds(attrName:String = "position", matrix:Matrix = null, vertexID:int = 0, numVertices:int = -1, out:Rectangle = null) : Rectangle
      {
         var minX:Number = NaN;
         var maxX:Number = NaN;
         var minY:Number = NaN;
         var maxY:Number = NaN;
         var offset:int = 0;
         var position:int = 0;
         var x:Number = NaN;
         var y:Number = NaN;
         var i:int = 0;
         if(out == null)
         {
            out = new Rectangle();
         }
         if(numVertices < 0 || vertexID + numVertices > this._numVertices)
         {
            numVertices = this._numVertices - vertexID;
         }
         if(numVertices == 0)
         {
            if(matrix == null)
            {
               out.setEmpty();
            }
            else
            {
               MatrixUtil.transformCoords(matrix,0,0,sHelperPoint);
               out.setTo(sHelperPoint.x,sHelperPoint.y,0,0);
            }
         }
         else
         {
            minX = Number.MAX_VALUE;
            maxX = -Number.MAX_VALUE;
            minY = Number.MAX_VALUE;
            maxY = -Number.MAX_VALUE;
            offset = attrName == "position" ? int(this._posOffset) : int(this.getAttribute(attrName).offset);
            position = vertexID * this._vertexSize + offset;
            if(matrix == null)
            {
               for(i = 0; i < numVertices; i++)
               {
                  this._rawData.position = position;
                  x = Number(this._rawData.readFloat());
                  y = Number(this._rawData.readFloat());
                  position += this._vertexSize;
                  if(minX > x)
                  {
                     minX = x;
                  }
                  if(maxX < x)
                  {
                     maxX = x;
                  }
                  if(minY > y)
                  {
                     minY = y;
                  }
                  if(maxY < y)
                  {
                     maxY = y;
                  }
               }
            }
            else
            {
               for(i = 0; i < numVertices; i++)
               {
                  this._rawData.position = position;
                  x = Number(this._rawData.readFloat());
                  y = Number(this._rawData.readFloat());
                  position += this._vertexSize;
                  MatrixUtil.transformCoords(matrix,x,y,sHelperPoint);
                  if(minX > sHelperPoint.x)
                  {
                     minX = Number(sHelperPoint.x);
                  }
                  if(maxX < sHelperPoint.x)
                  {
                     maxX = Number(sHelperPoint.x);
                  }
                  if(minY > sHelperPoint.y)
                  {
                     minY = Number(sHelperPoint.y);
                  }
                  if(maxY < sHelperPoint.y)
                  {
                     maxY = Number(sHelperPoint.y);
                  }
               }
            }
            out.setTo(minX,minY,maxX - minX,maxY - minY);
         }
         return out;
      }
      
      public function getBoundsProjected(attrName:String, matrix:Matrix3D, camPos:Vector3D, vertexID:int = 0, numVertices:int = -1, out:Rectangle = null) : Rectangle
      {
         var minX:Number = NaN;
         var maxX:Number = NaN;
         var minY:Number = NaN;
         var maxY:Number = NaN;
         var offset:int = 0;
         var position:int = 0;
         var x:Number = NaN;
         var y:Number = NaN;
         var i:int = 0;
         if(out == null)
         {
            out = new Rectangle();
         }
         if(camPos == null)
         {
            throw new ArgumentError("camPos must not be null");
         }
         if(numVertices < 0 || vertexID + numVertices > this._numVertices)
         {
            numVertices = this._numVertices - vertexID;
         }
         if(numVertices == 0)
         {
            if(matrix)
            {
               MatrixUtil.transformCoords3D(matrix,0,0,0,sHelperPoint3D);
            }
            else
            {
               sHelperPoint3D.setTo(0,0,0);
            }
            MathUtil.intersectLineWithXYPlane(camPos,sHelperPoint3D,sHelperPoint);
            out.setTo(sHelperPoint.x,sHelperPoint.y,0,0);
         }
         else
         {
            minX = Number.MAX_VALUE;
            maxX = -Number.MAX_VALUE;
            minY = Number.MAX_VALUE;
            maxY = -Number.MAX_VALUE;
            offset = attrName == "position" ? int(this._posOffset) : int(this.getAttribute(attrName).offset);
            position = vertexID * this._vertexSize + offset;
            for(i = 0; i < numVertices; i++)
            {
               this._rawData.position = position;
               x = Number(this._rawData.readFloat());
               y = Number(this._rawData.readFloat());
               position += this._vertexSize;
               if(matrix)
               {
                  MatrixUtil.transformCoords3D(matrix,x,y,0,sHelperPoint3D);
               }
               else
               {
                  sHelperPoint3D.setTo(x,y,0);
               }
               MathUtil.intersectLineWithXYPlane(camPos,sHelperPoint3D,sHelperPoint);
               if(minX > sHelperPoint.x)
               {
                  minX = Number(sHelperPoint.x);
               }
               if(maxX < sHelperPoint.x)
               {
                  maxX = Number(sHelperPoint.x);
               }
               if(minY > sHelperPoint.y)
               {
                  minY = Number(sHelperPoint.y);
               }
               if(maxY < sHelperPoint.y)
               {
                  maxY = Number(sHelperPoint.y);
               }
            }
            out.setTo(minX,minY,maxX - minX,maxY - minY);
         }
         return out;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return this._premultipliedAlpha;
      }
      
      public function set premultipliedAlpha(value:Boolean) : void
      {
         this.setPremultipliedAlpha(value,false);
      }
      
      public function setPremultipliedAlpha(value:Boolean, updateData:Boolean) : void
      {
         var i:int = 0;
         var attribute:VertexDataAttribute = null;
         var pos:int = 0;
         var oldColor:uint = 0;
         var newColor:uint = 0;
         var j:int = 0;
         if(updateData && value != this._premultipliedAlpha)
         {
            for(i = 0; i < this._numAttributes; i++)
            {
               attribute = this._attributes[i];
               if(attribute.isColor)
               {
                  pos = attribute.offset;
                  for(j = 0; j < this._numVertices; j++)
                  {
                     this._rawData.position = pos;
                     oldColor = uint(switchEndian(this._rawData.readUnsignedInt()));
                     newColor = value ? uint(premultiplyAlpha(oldColor)) : uint(unmultiplyAlpha(oldColor));
                     this._rawData.position = pos;
                     this._rawData.writeUnsignedInt(switchEndian(newColor));
                     pos += this._vertexSize;
                  }
               }
            }
         }
         this._premultipliedAlpha = value;
      }
      
      public function updateTinted(attrName:String = "color") : Boolean
      {
         var pos:int = attrName == "color" ? int(this._colOffset) : int(this.getAttribute(attrName).offset);
         this._tinted = false;
         for(var i:int = 0; i < this._numVertices; i++)
         {
            this._rawData.position = pos;
            if(this._rawData.readUnsignedInt() != 4294967295)
            {
               this._tinted = true;
               break;
            }
            pos += this._vertexSize;
         }
         return this._tinted;
      }
      
      public function transformPoints(attrName:String, matrix:Matrix, vertexID:int = 0, numVertices:int = -1) : void
      {
         var x:Number = NaN;
         var y:Number = NaN;
         if(numVertices < 0 || vertexID + numVertices > this._numVertices)
         {
            numVertices = this._numVertices - vertexID;
         }
         var offset:int = attrName == "position" ? int(this._posOffset) : int(this.getAttribute(attrName).offset);
         var pos:int = vertexID * this._vertexSize + offset;
         var endPos:int = pos + numVertices * this._vertexSize;
         while(pos < endPos)
         {
            this._rawData.position = pos;
            x = Number(this._rawData.readFloat());
            y = Number(this._rawData.readFloat());
            this._rawData.position = pos;
            this._rawData.writeFloat(matrix.a * x + matrix.c * y + matrix.tx);
            this._rawData.writeFloat(matrix.d * y + matrix.b * x + matrix.ty);
            pos += this._vertexSize;
         }
      }
      
      public function translatePoints(attrName:String, deltaX:Number, deltaY:Number, vertexID:int = 0, numVertices:int = -1) : void
      {
         var x:Number = NaN;
         var y:Number = NaN;
         if(numVertices < 0 || vertexID + numVertices > this._numVertices)
         {
            numVertices = this._numVertices - vertexID;
         }
         var offset:int = attrName == "position" ? int(this._posOffset) : int(this.getAttribute(attrName).offset);
         var pos:int = vertexID * this._vertexSize + offset;
         var endPos:int = pos + numVertices * this._vertexSize;
         while(pos < endPos)
         {
            this._rawData.position = pos;
            x = Number(this._rawData.readFloat());
            y = Number(this._rawData.readFloat());
            this._rawData.position = pos;
            this._rawData.writeFloat(x + deltaX);
            this._rawData.writeFloat(y + deltaY);
            pos += this._vertexSize;
         }
      }
      
      public function scaleAlphas(attrName:String, factor:Number, vertexID:int = 0, numVertices:int = -1) : void
      {
         var i:int = 0;
         var alphaPos:int = 0;
         var alpha:Number = NaN;
         var rgba:uint = 0;
         if(factor == 1)
         {
            return;
         }
         if(numVertices < 0 || vertexID + numVertices > this._numVertices)
         {
            numVertices = this._numVertices - vertexID;
         }
         this._tinted = true;
         var offset:int = attrName == "color" ? int(this._colOffset) : int(this.getAttribute(attrName).offset);
         var colorPos:int = vertexID * this._vertexSize + offset;
         for(i = 0; i < numVertices; i++)
         {
            alphaPos = colorPos + 3;
            alpha = this._rawData[alphaPos] / 255 * factor;
            if(alpha > 1)
            {
               alpha = 1;
            }
            else if(alpha < 0)
            {
               alpha = 0;
            }
            if(alpha == 1 || !this._premultipliedAlpha)
            {
               this._rawData[alphaPos] = int(alpha * 255);
            }
            else
            {
               this._rawData.position = colorPos;
               rgba = uint(unmultiplyAlpha(switchEndian(this._rawData.readUnsignedInt())));
               rgba = uint(rgba & 0xFFFFFF00 | int(alpha * 255) & 0xFF);
               rgba = uint(premultiplyAlpha(rgba));
               this._rawData.position = colorPos;
               this._rawData.writeUnsignedInt(switchEndian(rgba));
            }
            colorPos += this._vertexSize;
         }
      }
      
      public function colorize(attrName:String = "color", color:uint = 16777215, alpha:Number = 1, vertexID:int = 0, numVertices:int = -1) : void
      {
         if(numVertices < 0 || vertexID + numVertices > this._numVertices)
         {
            numVertices = this._numVertices - vertexID;
         }
         var offset:int = attrName == "color" ? int(this._colOffset) : int(this.getAttribute(attrName).offset);
         var pos:int = vertexID * this._vertexSize + offset;
         var endPos:int = pos + numVertices * this._vertexSize;
         if(alpha > 1)
         {
            alpha = 1;
         }
         else if(alpha < 0)
         {
            alpha = 0;
         }
         var rgba:uint = uint(color << 8 & 0xFFFFFF00 | int(alpha * 255) & 0xFF);
         if(rgba == 4294967295 && numVertices == this._numVertices)
         {
            this._tinted = false;
         }
         else if(rgba != 4294967295)
         {
            this._tinted = true;
         }
         if(Boolean(this._premultipliedAlpha) && alpha != 1)
         {
            rgba = uint(premultiplyAlpha(rgba));
         }
         this._rawData.position = vertexID * this._vertexSize + offset;
         this._rawData.writeUnsignedInt(switchEndian(rgba));
         while(pos < endPos)
         {
            this._rawData.position = pos;
            this._rawData.writeUnsignedInt(switchEndian(rgba));
            pos += this._vertexSize;
         }
      }
      
      public function getFormat(attrName:String) : String
      {
         return this.getAttribute(attrName).format;
      }
      
      public function getSize(attrName:String) : int
      {
         return this.getAttribute(attrName).size;
      }
      
      public function getSizeIn32Bits(attrName:String) : int
      {
         return this.getAttribute(attrName).size / 4;
      }
      
      public function getOffset(attrName:String) : int
      {
         return this.getAttribute(attrName).offset;
      }
      
      public function getOffsetIn32Bits(attrName:String) : int
      {
         return this.getAttribute(attrName).offset / 4;
      }
      
      public function hasAttribute(attrName:String) : Boolean
      {
         return this.getAttribute(attrName) != null;
      }
      
      public function createVertexBuffer(upload:Boolean = false, bufferUsage:String = "staticDraw") : VertexBuffer3D
      {
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         if(this._numVertices == 0)
         {
            return null;
         }
         var buffer:VertexBuffer3D = context.createVertexBuffer(this._numVertices,this._vertexSize / 4,bufferUsage);
         if(upload)
         {
            this.uploadToVertexBuffer(buffer);
         }
         return buffer;
      }
      
      public function uploadToVertexBuffer(buffer:VertexBuffer3D, vertexID:int = 0, numVertices:int = -1) : void
      {
         if(numVertices < 0 || vertexID + numVertices > this._numVertices)
         {
            numVertices = this._numVertices - vertexID;
         }
         if(numVertices > 0)
         {
            buffer.uploadFromByteArray(this._rawData,0,vertexID,numVertices);
         }
      }
      
      final private function getAttribute(attrName:String) : VertexDataAttribute
      {
         var i:int = 0;
         var attribute:VertexDataAttribute = null;
         for(i = 0; i < this._numAttributes; i++)
         {
            attribute = this._attributes[i];
            if(attribute.name == attrName)
            {
               return attribute;
            }
         }
         return null;
      }
      
      public function get numVertices() : int
      {
         return this._numVertices;
      }
      
      public function set numVertices(value:int) : void
      {
         var oldLength:int = 0;
         var newLength:int = 0;
         var i:int = 0;
         var attribute:VertexDataAttribute = null;
         var pos:int = 0;
         var j:int = 0;
         if(value > this._numVertices)
         {
            oldLength = this._numVertices * this.vertexSize;
            newLength = value * this._vertexSize;
            if(this._rawData.length > oldLength)
            {
               this._rawData.position = oldLength;
               while(this._rawData.bytesAvailable)
               {
                  this._rawData.writeUnsignedInt(0);
               }
            }
            if(this._rawData.length < newLength)
            {
               this._rawData.length = newLength;
            }
            for(i = 0; i < this._numAttributes; i++)
            {
               attribute = this._attributes[i];
               if(attribute.isColor)
               {
                  pos = this._numVertices * this._vertexSize + attribute.offset;
                  for(j = int(this._numVertices); j < value; j++)
                  {
                     this._rawData.position = pos;
                     this._rawData.writeUnsignedInt(4294967295);
                     pos += this._vertexSize;
                  }
               }
            }
         }
         if(value == 0)
         {
            this._tinted = false;
         }
         this._numVertices = value;
      }
      
      public function get rawData() : ByteArray
      {
         return this._rawData;
      }
      
      public function get format() : VertexDataFormat
      {
         return this._format;
      }
      
      public function set format(value:VertexDataFormat) : void
      {
         var a:int = 0;
         var i:int = 0;
         var pos:int = 0;
         var tgtAttr:VertexDataAttribute = null;
         var srcAttr:VertexDataAttribute = null;
         if(this._format === value)
         {
            return;
         }
         var srcVertexSize:int = int(this._format.vertexSize);
         var tgtVertexSize:int = value.vertexSize;
         var numAttributes:int = value.numAttributes;
         sBytes.length = value.vertexSize * this._numVertices;
         for(a = 0; a < numAttributes; a++)
         {
            tgtAttr = value.attributes[a];
            srcAttr = this.getAttribute(tgtAttr.name);
            if(srcAttr)
            {
               pos = tgtAttr.offset;
               for(i = 0; i < this._numVertices; i++)
               {
                  sBytes.position = pos;
                  sBytes.writeBytes(this._rawData,srcVertexSize * i + srcAttr.offset,srcAttr.size);
                  pos += tgtVertexSize;
               }
            }
            else if(tgtAttr.isColor)
            {
               pos = tgtAttr.offset;
               for(i = 0; i < this._numVertices; i++)
               {
                  sBytes.position = pos;
                  sBytes.writeUnsignedInt(4294967295);
                  pos += tgtVertexSize;
               }
            }
         }
         this._rawData.clear();
         this._rawData.length = sBytes.length;
         this._rawData.writeBytes(sBytes);
         sBytes.clear();
         this._format = value;
         this._attributes = this._format.attributes;
         this._numAttributes = this._attributes.length;
         this._vertexSize = this._format.vertexSize;
         this._posOffset = this._format.hasAttribute("position") ? int(this._format.getOffset("position")) : 0;
         this._colOffset = this._format.hasAttribute("color") ? int(this._format.getOffset("color")) : 0;
      }
      
      public function get tinted() : Boolean
      {
         return this._tinted;
      }
      
      public function set tinted(value:Boolean) : void
      {
         this._tinted = value;
      }
      
      public function get formatString() : String
      {
         return this._format.formatString;
      }
      
      public function get vertexSize() : int
      {
         return this._vertexSize;
      }
      
      public function get vertexSizeIn32Bits() : int
      {
         return this._vertexSize / 4;
      }
      
      public function get size() : int
      {
         return this._numVertices * this._vertexSize;
      }
      
      public function get sizeIn32Bits() : int
      {
         return this._numVertices * this._vertexSize / 4;
      }
   }
}

