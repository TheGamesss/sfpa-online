package starling.rendering
{
   import flash.display3D.VertexBuffer3D;
   import flash.utils.*;
   import starling.core.*;
   import starling.utils.*;
   
   public class VertexDataFormat
   {
      
      private static var sFormats:Dictionary = new Dictionary();
      
      private var _format:String;
      
      private var _vertexSize:int;
      
      private var _attributes:Vector.<VertexDataAttribute>;
      
      public function VertexDataFormat()
      {
         super();
         this._attributes = new Vector.<VertexDataAttribute>();
      }
      
      public static function fromString(format:String) : VertexDataFormat
      {
         var instance:VertexDataFormat = null;
         var normalizedFormat:String = null;
         if(format in sFormats)
         {
            return sFormats[format];
         }
         instance = new VertexDataFormat();
         instance.parseFormat(format);
         normalizedFormat = instance._format;
         if(normalizedFormat in sFormats)
         {
            instance = sFormats[normalizedFormat];
         }
         sFormats[format] = instance;
         sFormats[normalizedFormat] = instance;
         return instance;
      }
      
      public function extend(format:String) : VertexDataFormat
      {
         return fromString(this._format + ", " + format);
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
      
      public function getFormat(attrName:String) : String
      {
         return this.getAttribute(attrName).format;
      }
      
      public function getName(attrIndex:int) : String
      {
         return this._attributes[attrIndex].name;
      }
      
      public function hasAttribute(attrName:String) : Boolean
      {
         var numAttributes:int = int(this._attributes.length);
         for(var i:int = 0; i < numAttributes; i++)
         {
            if(this._attributes[i].name == attrName)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setVertexBufferAt(index:int, buffer:VertexBuffer3D, attrName:String) : void
      {
         var attribute:VertexDataAttribute = this.getAttribute(attrName);
         Starling.context.setVertexBufferAt(index,buffer,attribute.offset / 4,attribute.format);
      }
      
      private function parseFormat(format:String) : void
      {
         var parts:Array = null;
         var numParts:int = 0;
         var offset:int = 0;
         var i:int = 0;
         var attrDesc:String = null;
         var attrParts:Array = null;
         var attrName:String = null;
         var attrFormat:String = null;
         var attribute:VertexDataAttribute = null;
         if(format != null && format != "")
         {
            this._attributes.length = 0;
            this._format = "";
            parts = format.split(",");
            numParts = int(parts.length);
            offset = 0;
            for(i = 0; i < numParts; i++)
            {
               attrDesc = parts[i];
               attrParts = attrDesc.split(":");
               if(attrParts.length != 2)
               {
                  throw new ArgumentError("Missing colon: " + attrDesc);
               }
               attrName = StringUtil.trim(attrParts[0]);
               attrFormat = StringUtil.trim(attrParts[1]);
               if(attrName.length == 0 || attrFormat.length == 0)
               {
                  throw new ArgumentError("Invalid format string: " + attrDesc);
               }
               attribute = new VertexDataAttribute(attrName,attrFormat,offset);
               offset += attribute.size;
               this._format += (i == 0 ? "" : ", ") + attribute.name + ":" + attribute.format;
               this._attributes[this._attributes.length] = attribute;
            }
            this._vertexSize = offset;
         }
         else
         {
            this._format = "";
         }
      }
      
      public function toString() : String
      {
         return this._format;
      }
      
      internal function getAttribute(attrName:String) : VertexDataAttribute
      {
         var i:int = 0;
         var attribute:VertexDataAttribute = null;
         var numAttributes:int = int(this._attributes.length);
         for(i = 0; i < numAttributes; i++)
         {
            attribute = this._attributes[i];
            if(attribute.name == attrName)
            {
               return attribute;
            }
         }
         return null;
      }
      
      internal function get attributes() : Vector.<VertexDataAttribute>
      {
         return this._attributes;
      }
      
      public function get formatString() : String
      {
         return this._format;
      }
      
      public function get vertexSize() : int
      {
         return this._vertexSize;
      }
      
      public function get vertexSizeIn32Bits() : int
      {
         return this._vertexSize / 4;
      }
      
      public function get numAttributes() : int
      {
         return this._attributes.length;
      }
   }
}

