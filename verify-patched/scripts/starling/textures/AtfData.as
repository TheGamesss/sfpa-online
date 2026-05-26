package starling.textures
{
   import flash.display3D.*;
   import flash.utils.ByteArray;
   
   public class AtfData
   {
      
      private var _format:String;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _numTextures:int;
      
      private var _isCubeMap:Boolean;
      
      private var _data:ByteArray;
      
      public function AtfData(data:ByteArray)
      {
         var emptyMipmaps:Boolean = false;
         var numTextures:int = 0;
         super();
         if(!isAtfData(data))
         {
            throw new ArgumentError("Invalid ATF data");
         }
         if(data[6] == 255)
         {
            data.position = 12;
         }
         else
         {
            data.position = 6;
         }
         var format:uint = data.readUnsignedByte();
         switch(format & 0x7F)
         {
            case 0:
            case 1:
               this._format = Context3DTextureFormat.BGRA;
               break;
            case 12:
            case 2:
            case 3:
               this._format = Context3DTextureFormat.COMPRESSED;
               break;
            case 13:
            case 4:
            case 5:
               this._format = "compressedAlpha";
               break;
            default:
               throw new Error("Invalid ATF format");
         }
         this._width = Math.pow(2,data.readUnsignedByte());
         this._height = Math.pow(2,data.readUnsignedByte());
         this._numTextures = data.readUnsignedByte();
         this._isCubeMap = (format & 0x80) != 0;
         this._data = data;
         if(data[5] != 0 && data[6] == 255)
         {
            emptyMipmaps = (data[5] & 1) == 1;
            numTextures = data[5] >> 1 & 0x7F;
            this._numTextures = emptyMipmaps ? 1 : numTextures;
         }
      }
      
      public static function isAtfData(data:ByteArray) : Boolean
      {
         var signature:String = null;
         if(data.length < 3)
         {
            return false;
         }
         signature = String.fromCharCode(data[0],data[1],data[2]);
         return signature == "ATF";
      }
      
      public function get format() : String
      {
         return this._format;
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function get height() : int
      {
         return this._height;
      }
      
      public function get numTextures() : int
      {
         return this._numTextures;
      }
      
      public function get isCubeMap() : Boolean
      {
         return this._isCubeMap;
      }
      
      public function get data() : ByteArray
      {
         return this._data;
      }
   }
}

