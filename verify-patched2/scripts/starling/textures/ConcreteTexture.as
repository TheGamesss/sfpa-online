package starling.textures
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display3D.textures.TextureBase;
   import flash.media.Camera;
   import flash.net.NetStream;
   import flash.system.*;
   import flash.utils.*;
   import starling.core.*;
   import starling.errors.*;
   import starling.events.*;
   import starling.rendering.Painter;
   import starling.utils.*;
   
   use namespace starling_internal;
   
   public class ConcreteTexture extends Texture
   {
      
      private var _base:TextureBase;
      
      private var _format:String;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _mipMapping:Boolean;
      
      private var _premultipliedAlpha:Boolean;
      
      private var _optimizedForRenderTexture:Boolean;
      
      private var _scale:Number;
      
      private var _onRestore:Function;
      
      private var _dataUploaded:Boolean;
      
      public function ConcreteTexture(base:TextureBase, format:String, width:int, height:int, mipMapping:Boolean, premultipliedAlpha:Boolean, optimizedForRenderTexture:Boolean = false, scale:Number = 1)
      {
         super();
         if(Boolean(Capabilities.isDebugger) && getQualifiedClassName(this) == "starling.textures::ConcreteTexture")
         {
            throw new AbstractClassError();
         }
         this._scale = scale <= 0 ? 1 : scale;
         this._base = base;
         this._format = format;
         this._width = width;
         this._height = height;
         this._mipMapping = mipMapping;
         this._premultipliedAlpha = premultipliedAlpha;
         this._optimizedForRenderTexture = optimizedForRenderTexture;
         this._onRestore = null;
         this._dataUploaded = false;
      }
      
      override public function dispose() : void
      {
         if(this._base)
         {
            this._base.dispose();
         }
         this.onRestore = null;
         super.dispose();
      }
      
      public function uploadBitmap(bitmap:Bitmap, async:* = null) : void
      {
         this.uploadBitmapData(bitmap.bitmapData,async);
      }
      
      public function uploadBitmapData(data:BitmapData, async:* = null) : void
      {
         throw new NotSupportedError();
      }
      
      public function uploadAtfData(data:ByteArray, offset:int = 0, async:* = null) : void
      {
         throw new NotSupportedError();
      }
      
      public function attachNetStream(netStream:NetStream, onComplete:Function = null) : void
      {
         this.attachVideo("NetStream",netStream,onComplete);
      }
      
      public function attachCamera(camera:Camera, onComplete:Function = null) : void
      {
         this.attachVideo("Camera",camera,onComplete);
      }
      
      internal function attachVideo(type:String, attachment:Object, onComplete:Function = null) : void
      {
         throw new NotSupportedError();
      }
      
      private function onContextCreated() : void
      {
         this._dataUploaded = false;
         this._base = this.createBase();
         execute(this._onRestore,this);
         if(!this._dataUploaded)
         {
            this.clear();
         }
      }
      
      protected function createBase() : TextureBase
      {
         throw new AbstractMethodError();
      }
      
      starling_internal function recreateBase() : void
      {
         this._base = this.createBase();
      }
      
      public function clear(color:uint = 0, alpha:Number = 0) : void
      {
         if(Boolean(this._premultipliedAlpha) && alpha < 1)
         {
            color = uint(Color.rgb(Color.getRed(color) * alpha,Color.getGreen(color) * alpha,Color.getBlue(color) * alpha));
         }
         var painter:Painter = Starling.painter;
         painter.pushState();
         painter.state.renderTarget = this;
         try
         {
            painter.clear(color,alpha);
         }
         catch(e:Error)
         {
         }
         painter.popState();
         this.setDataUploaded();
      }
      
      protected function setDataUploaded() : void
      {
         this._dataUploaded = true;
      }
      
      public function get optimizedForRenderTexture() : Boolean
      {
         return this._optimizedForRenderTexture;
      }
      
      public function get isPotTexture() : Boolean
      {
         return false;
      }
      
      public function get onRestore() : Function
      {
         return this._onRestore;
      }
      
      public function set onRestore(value:Function) : void
      {
         Starling.current.removeEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated);
         if(value != null)
         {
            this._onRestore = value;
            Starling.current.addEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated);
         }
         else
         {
            this._onRestore = null;
         }
      }
      
      override public function get base() : TextureBase
      {
         return this._base;
      }
      
      override public function get root() : ConcreteTexture
      {
         return this;
      }
      
      override public function get format() : String
      {
         return this._format;
      }
      
      override public function get width() : Number
      {
         return this._width / this._scale;
      }
      
      override public function get height() : Number
      {
         return this._height / this._scale;
      }
      
      override public function get nativeWidth() : Number
      {
         return this._width;
      }
      
      override public function get nativeHeight() : Number
      {
         return this._height;
      }
      
      override public function get scale() : Number
      {
         return this._scale;
      }
      
      override public function get mipMapping() : Boolean
      {
         return this._mipMapping;
      }
      
      override public function get premultipliedAlpha() : Boolean
      {
         return this._premultipliedAlpha;
      }
   }
}

