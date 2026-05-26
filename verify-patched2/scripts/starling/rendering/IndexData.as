package starling.rendering
{
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.errors.*;
   import flash.utils.*;
   import starling.core.*;
   import starling.errors.*;
   import starling.utils.*;
   
   public class IndexData
   {
      
      private static const INDEX_SIZE:int = 2;
      
      private static var sQuadData:ByteArray = new ByteArray();
      
      private static var sQuadDataNumIndices:uint = 0;
      
      private static var sVector:Vector.<uint> = new Vector.<uint>(0);
      
      private static var sTrimData:ByteArray = new ByteArray();
      
      private var _rawData:ByteArray;
      
      private var _numIndices:int;
      
      private var _initialCapacity:int;
      
      private var _useQuadLayout:Boolean;
      
      public function IndexData(initialCapacity:int = 48)
      {
         super();
         this._numIndices = 0;
         this._initialCapacity = initialCapacity;
         this._useQuadLayout = true;
      }
      
      private static function getBasicQuadIndexAt(indexID:int) : int
      {
         var offset:int = 0;
         var quadID:int = indexID / 6;
         var posInQuad:int = indexID - quadID * 6;
         if(posInQuad == 0)
         {
            offset = 0;
         }
         else if(posInQuad == 1 || posInQuad == 3)
         {
            offset = 1;
         }
         else if(posInQuad == 2 || posInQuad == 5)
         {
            offset = 2;
         }
         else
         {
            offset = 3;
         }
         return quadID * 4 + offset;
      }
      
      public function clear() : void
      {
         if(this._rawData)
         {
            this._rawData.clear();
         }
         this._numIndices = 0;
         this._useQuadLayout = true;
      }
      
      public function clone() : IndexData
      {
         var clone:IndexData = new IndexData(this._numIndices);
         if(!this._useQuadLayout)
         {
            clone.switchToGenericData();
            clone._rawData.writeBytes(this._rawData);
         }
         clone._numIndices = this._numIndices;
         return clone;
      }
      
      public function copyTo(target:IndexData, targetIndexID:int = 0, offset:int = 0, indexID:int = 0, numIndices:int = -1) : void
      {
         var sourceData:ByteArray = null;
         var targetData:ByteArray = null;
         var keepsQuadLayout:Boolean = false;
         var distance:int = 0;
         var distanceInQuads:int = 0;
         var offsetInQuads:int = 0;
         var i:int = 0;
         var indexAB:uint = 0;
         var indexA:uint = 0;
         var indexB:uint = 0;
         if(numIndices < 0 || indexID + numIndices > this._numIndices)
         {
            numIndices = this._numIndices - indexID;
         }
         var newNumIndices:int = targetIndexID + numIndices;
         if(target._numIndices < newNumIndices)
         {
            target._numIndices = newNumIndices;
            if(sQuadDataNumIndices < newNumIndices)
            {
               this.ensureQuadDataCapacity(newNumIndices);
            }
         }
         if(this._useQuadLayout)
         {
            if(target._useQuadLayout)
            {
               keepsQuadLayout = true;
               distance = targetIndexID - indexID;
               distanceInQuads = distance / 6;
               offsetInQuads = offset / 4;
               if(distanceInQuads == offsetInQuads && (offset & 3) == 0 && distanceInQuads * 6 == distance)
               {
                  keepsQuadLayout = true;
               }
               else if(numIndices > 2)
               {
                  keepsQuadLayout = false;
               }
               else
               {
                  for(i = 0; i < numIndices; i++)
                  {
                     keepsQuadLayout &&= getBasicQuadIndexAt(indexID + i) + offset == getBasicQuadIndexAt(targetIndexID + i);
                  }
               }
               if(keepsQuadLayout)
               {
                  return;
               }
               target.switchToGenericData();
            }
            sourceData = sQuadData;
            targetData = target._rawData;
            if((offset & 3) == 0)
            {
               indexID += 6 * offset / 4;
               offset = 0;
               this.ensureQuadDataCapacity(indexID + numIndices);
            }
         }
         else
         {
            if(target._useQuadLayout)
            {
               target.switchToGenericData();
            }
            sourceData = this._rawData;
            targetData = target._rawData;
         }
         targetData.position = targetIndexID * INDEX_SIZE;
         if(offset == 0)
         {
            targetData.writeBytes(sourceData,indexID * INDEX_SIZE,numIndices * INDEX_SIZE);
         }
         else
         {
            sourceData.position = indexID * INDEX_SIZE;
            while(numIndices > 1)
            {
               indexAB = sourceData.readUnsignedInt();
               indexA = ((indexAB & 0xFFFF0000) >> 16) + offset;
               indexB = (indexAB & 0xFFFF) + offset;
               targetData.writeUnsignedInt(indexA << 16 | indexB);
               numIndices -= 2;
            }
            if(numIndices)
            {
               targetData.writeShort(sourceData.readUnsignedShort() + offset);
            }
         }
      }
      
      public function setIndex(indexID:int, index:uint) : void
      {
         if(this._numIndices < indexID + 1)
         {
            this.numIndices = indexID + 1;
         }
         if(this._useQuadLayout)
         {
            if(getBasicQuadIndexAt(indexID) == index)
            {
               return;
            }
            this.switchToGenericData();
         }
         this._rawData.position = indexID * INDEX_SIZE;
         this._rawData.writeShort(index);
      }
      
      public function getIndex(indexID:int) : int
      {
         if(this._useQuadLayout)
         {
            if(indexID < this._numIndices)
            {
               return getBasicQuadIndexAt(indexID);
            }
            throw new EOFError();
         }
         this._rawData.position = indexID * INDEX_SIZE;
         return this._rawData.readUnsignedShort();
      }
      
      public function offsetIndices(offset:int, indexID:int = 0, numIndices:int = -1) : void
      {
         if(numIndices < 0 || indexID + numIndices > this._numIndices)
         {
            numIndices = this._numIndices - indexID;
         }
         var endIndex:int = indexID + numIndices;
         for(var i:int = indexID; i < endIndex; i++)
         {
            this.setIndex(i,this.getIndex(i) + offset);
         }
      }
      
      public function addTriangle(a:uint, b:uint, c:uint) : void
      {
         var oddTriangleID:Boolean = false;
         var evenTriangleID:Boolean = false;
         if(this._useQuadLayout)
         {
            if(a == getBasicQuadIndexAt(this._numIndices))
            {
               oddTriangleID = (this._numIndices & 1) != 0;
               evenTriangleID = !oddTriangleID;
               if(evenTriangleID && b == a + 1 && c == b + 1 || oddTriangleID && c == a + 1 && b == c + 1)
               {
                  this._numIndices += 3;
                  this.ensureQuadDataCapacity(this._numIndices);
                  return;
               }
            }
            this.switchToGenericData();
         }
         this._rawData.position = this._numIndices * INDEX_SIZE;
         this._rawData.writeShort(a);
         this._rawData.writeShort(b);
         this._rawData.writeShort(c);
         this._numIndices += 3;
      }
      
      public function addQuad(a:uint, b:uint, c:uint, d:uint) : void
      {
         if(this._useQuadLayout)
         {
            if(a == getBasicQuadIndexAt(this._numIndices) && b == a + 1 && c == b + 1 && d == c + 1)
            {
               this._numIndices += 6;
               this.ensureQuadDataCapacity(this._numIndices);
               return;
            }
            this.switchToGenericData();
         }
         this._rawData.position = this._numIndices * INDEX_SIZE;
         this._rawData.writeShort(a);
         this._rawData.writeShort(b);
         this._rawData.writeShort(c);
         this._rawData.writeShort(b);
         this._rawData.writeShort(d);
         this._rawData.writeShort(c);
         this._numIndices += 6;
      }
      
      public function toVector(out:Vector.<uint> = null) : Vector.<uint>
      {
         if(out == null)
         {
            out = new Vector.<uint>(this._numIndices);
         }
         else
         {
            out.length = this._numIndices;
         }
         var rawData:ByteArray = this._useQuadLayout ? sQuadData : this._rawData;
         rawData.position = 0;
         for(var i:int = 0; i < this._numIndices; i++)
         {
            out[i] = rawData.readUnsignedShort();
         }
         return out;
      }
      
      public function toString() : String
      {
         var string:String = StringUtil.format("[IndexData numIndices={0} indices=\"{1}\"]",this._numIndices,this.toVector(sVector).join());
         sVector.length = 0;
         return string;
      }
      
      private function switchToGenericData() : void
      {
         if(this._useQuadLayout)
         {
            this._useQuadLayout = false;
            if(this._rawData == null)
            {
               this._rawData = new ByteArray();
               this._rawData.endian = Endian.LITTLE_ENDIAN;
               this._rawData.length = this._initialCapacity * INDEX_SIZE;
               this._rawData.length = this._numIndices * INDEX_SIZE;
            }
            if(this._numIndices)
            {
               this._rawData.writeBytes(sQuadData,0,this._numIndices * INDEX_SIZE);
            }
         }
      }
      
      private function ensureQuadDataCapacity(numIndices:int) : void
      {
         var i:int = 0;
         if(sQuadDataNumIndices >= numIndices)
         {
            return;
         }
         var oldNumQuads:int = sQuadDataNumIndices / 6;
         var newNumQuads:int = Math.ceil(numIndices / 6);
         sQuadData.endian = Endian.LITTLE_ENDIAN;
         sQuadData.position = sQuadData.length;
         sQuadDataNumIndices = newNumQuads * 6;
         for(i = oldNumQuads; i < newNumQuads; i++)
         {
            sQuadData.writeShort(4 * i);
            sQuadData.writeShort(4 * i + 1);
            sQuadData.writeShort(4 * i + 2);
            sQuadData.writeShort(4 * i + 1);
            sQuadData.writeShort(4 * i + 3);
            sQuadData.writeShort(4 * i + 2);
         }
      }
      
      public function createIndexBuffer(upload:Boolean = false, bufferUsage:String = "staticDraw") : IndexBuffer3D
      {
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         if(this._numIndices == 0)
         {
            return null;
         }
         var buffer:IndexBuffer3D = context.createIndexBuffer(this._numIndices,bufferUsage);
         if(upload)
         {
            this.uploadToIndexBuffer(buffer);
         }
         return buffer;
      }
      
      public function uploadToIndexBuffer(buffer:IndexBuffer3D, indexID:int = 0, numIndices:int = -1) : void
      {
         if(numIndices < 0 || indexID + numIndices > this._numIndices)
         {
            numIndices = this._numIndices - indexID;
         }
         if(numIndices > 0)
         {
            buffer.uploadFromByteArray(this.rawData,0,indexID,numIndices);
         }
      }
      
      public function trim() : void
      {
         if(this._useQuadLayout)
         {
            return;
         }
         sTrimData.length = this._rawData.length;
         sTrimData.position = 0;
         sTrimData.writeBytes(this._rawData);
         this._rawData.clear();
         this._rawData.length = sTrimData.length;
         this._rawData.writeBytes(sTrimData);
         sTrimData.clear();
      }
      
      public function get numIndices() : int
      {
         return this._numIndices;
      }
      
      public function set numIndices(value:int) : void
      {
         if(value != this._numIndices)
         {
            if(this._useQuadLayout)
            {
               this.ensureQuadDataCapacity(value);
            }
            else
            {
               this._rawData.length = value * INDEX_SIZE;
            }
            if(value == 0)
            {
               this._useQuadLayout = true;
            }
            this._numIndices = value;
         }
      }
      
      public function get numTriangles() : int
      {
         return this._numIndices / 3;
      }
      
      public function set numTriangles(value:int) : void
      {
         this.numIndices = value * 3;
      }
      
      public function get numQuads() : int
      {
         return this._numIndices / 6;
      }
      
      public function set numQuads(value:int) : void
      {
         this.numIndices = value * 6;
      }
      
      public function get indexSizeInBytes() : int
      {
         return INDEX_SIZE;
      }
      
      public function get useQuadLayout() : Boolean
      {
         return this._useQuadLayout;
      }
      
      public function set useQuadLayout(value:Boolean) : void
      {
         if(value != this._useQuadLayout)
         {
            if(value)
            {
               this.ensureQuadDataCapacity(this._numIndices);
               this._rawData.length = 0;
               this._useQuadLayout = true;
            }
            else
            {
               this.switchToGenericData();
            }
         }
      }
      
      public function get rawData() : ByteArray
      {
         if(this._useQuadLayout)
         {
            return sQuadData;
         }
         return this._rawData;
      }
   }
}

