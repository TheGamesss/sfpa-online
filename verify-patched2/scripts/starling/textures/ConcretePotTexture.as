package starling.textures
{
   import flash.display.*;
   import flash.display3D.textures.Texture;
   import flash.display3D.textures.TextureBase;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import starling.core.*;
   import starling.utils.*;
   
   internal class ConcretePotTexture extends ConcreteTexture
   {
      
      private static var sMatrix:Matrix = new Matrix();
      
      private static var sRectangle:Rectangle = new Rectangle();
      
      private static var sOrigin:Point = new Point();
      
      private static var sAsyncUploadEnabled:Boolean = false;
      
      private var _textureReadyCallback:Function;
      
      public function ConcretePotTexture(base:flash.display3D.textures.Texture, format:String, width:int, height:int, mipMapping:Boolean, premultipliedAlpha:Boolean, optimizedForRenderTexture:Boolean = false, scale:Number = 1)
      {
         super(base,format,width,height,mipMapping,premultipliedAlpha,optimizedForRenderTexture,scale);
         if(width != MathUtil.getNextPowerOfTwo(width))
         {
            throw new ArgumentError("width must be a power of two");
         }
         if(height != MathUtil.getNextPowerOfTwo(height))
         {
            throw new ArgumentError("height must be a power of two");
         }
      }
      
      internal static function get asyncUploadEnabled() : Boolean
      {
         return sAsyncUploadEnabled;
      }
      
      internal static function set asyncUploadEnabled(value:Boolean) : void
      {
         sAsyncUploadEnabled = value;
      }
      
      override public function dispose() : void
      {
         base.removeEventListener(Event.TEXTURE_READY,this.onTextureReady);
         super.dispose();
      }
      
      override protected function createBase() : TextureBase
      {
         return Starling.context.createTexture(nativeWidth,nativeHeight,format,optimizedForRenderTexture);
      }
      
      override public function uploadBitmapData(data:BitmapData, async:* = null) : void
      {
         var currentWidth:int = 0;
         var currentHeight:int = 0;
         var level:* = 0;
         var canvas:BitmapData = null;
         var bounds:Rectangle = null;
         var matrix:Matrix = null;
         var buffer:BitmapData = null;
         var isAsync:Boolean = async is Function || async === true;
         if(async is Function)
         {
            this._textureReadyCallback = async as Function;
         }
         if(data.width != nativeWidth || data.height != nativeHeight)
         {
            buffer = new BitmapData(nativeWidth,nativeHeight,true,0);
            buffer.copyPixels(data,data.rect,sOrigin);
            data = buffer;
         }
         this.upload(data,0,isAsync);
         if(mipMapping && data.width > 1 && data.height > 1)
         {
            currentWidth = data.width >> 1;
            currentHeight = data.height >> 1;
            level = 1;
            canvas = new BitmapData(currentWidth,currentHeight,true,0);
            bounds = sRectangle;
            matrix = sMatrix;
            matrix.setTo(0.5,0,0,0.5,0,0);
            while(currentWidth >= 1 || currentHeight >= 1)
            {
               bounds.setTo(0,0,currentWidth,currentHeight);
               canvas.fillRect(bounds,0);
               canvas.draw(data,matrix,null,null,null,true);
               this.upload(canvas,level++,false);
               matrix.scale(0.5,0.5);
               currentWidth >>= 1;
               currentHeight >>= 1;
            }
            canvas.dispose();
         }
         if(buffer)
         {
            buffer.dispose();
         }
         setDataUploaded();
      }
      
      override public function get isPotTexture() : Boolean
      {
         return true;
      }
      
      override public function uploadAtfData(data:ByteArray, offset:int = 0, async:* = null) : void
      {
         var isAsync:Boolean = async is Function || async === true;
         if(async is Function)
         {
            this._textureReadyCallback = async as Function;
            base.addEventListener(Event.TEXTURE_READY,this.onTextureReady);
         }
         this.potBase.uploadCompressedTextureFromByteArray(data,offset,isAsync);
         setDataUploaded();
      }
      
      private function upload(source:BitmapData, mipLevel:uint, isAsync:Boolean) : void
      {
         if(isAsync)
         {
            this.uploadAsync(source,mipLevel);
            base.addEventListener(Event.TEXTURE_READY,this.onTextureReady);
            base.addEventListener(ErrorEvent.ERROR,this.onTextureReady);
         }
         else
         {
            this.potBase.uploadFromBitmapData(source,mipLevel);
         }
      }
      
      private function uploadAsync(source:BitmapData, mipLevel:uint) : void
      {
         if(sAsyncUploadEnabled)
         {
            try
            {
               base["uploadFromBitmapDataAsync"](source,mipLevel);
            }
            catch(error:Error)
            {
               if(!(error.errorID == 3708 || error.errorID == 1069))
               {
                  throw error;
               }
               sAsyncUploadEnabled = false;
            }
         }
         if(!sAsyncUploadEnabled)
         {
            setTimeout(base.dispatchEvent,1,new Event(Event.TEXTURE_READY));
            this.potBase.uploadFromBitmapData(source);
         }
      }
      
      private function onTextureReady(event:Event) : void
      {
         base.removeEventListener(Event.TEXTURE_READY,this.onTextureReady);
         base.removeEventListener(ErrorEvent.ERROR,this.onTextureReady);
         execute(this._textureReadyCallback,this,event as ErrorEvent);
         this._textureReadyCallback = null;
      }
      
      private function get potBase() : flash.display3D.textures.Texture
      {
         return base as flash.display3D.textures.Texture;
      }
   }
}

