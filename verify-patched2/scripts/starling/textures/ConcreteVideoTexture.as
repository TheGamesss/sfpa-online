package starling.textures
{
   import flash.display3D.*;
   import flash.display3D.textures.*;
   import flash.events.*;
   import starling.core.*;
   import starling.utils.*;
   
   internal class ConcreteVideoTexture extends ConcreteTexture
   {
      
      private var _textureReadyCallback:Function;
      
      private var _disposed:Boolean;
      
      public function ConcreteVideoTexture(base:VideoTexture, scale:Number = 1)
      {
         super(base,Context3DTextureFormat.BGRA,base.videoWidth,base.videoHeight,false,false,false,scale);
      }
      
      override public function dispose() : void
      {
         base.removeEventListener(Event.TEXTURE_READY,this.onTextureReady);
         if(!this._disposed)
         {
            this.videoBase.attachCamera(null);
            this.videoBase.attachNetStream(null);
            this._disposed = true;
         }
         super.dispose();
      }
      
      override protected function createBase() : TextureBase
      {
         return Starling.context.createVideoTexture();
      }
      
      override internal function attachVideo(type:String, attachment:Object, onComplete:Function = null) : void
      {
         this._textureReadyCallback = onComplete;
         base["attach" + type](attachment);
         base.addEventListener(Event.TEXTURE_READY,this.onTextureReady);
         setDataUploaded();
      }
      
      private function onTextureReady(event:Event) : void
      {
         base.removeEventListener(Event.TEXTURE_READY,this.onTextureReady);
         execute(this._textureReadyCallback,this);
         this._textureReadyCallback = null;
      }
      
      override public function get nativeWidth() : Number
      {
         return this.videoBase.videoWidth;
      }
      
      override public function get nativeHeight() : Number
      {
         return this.videoBase.videoHeight;
      }
      
      override public function get width() : Number
      {
         return this.nativeWidth / scale;
      }
      
      override public function get height() : Number
      {
         return this.nativeHeight / scale;
      }
      
      private function get videoBase() : VideoTexture
      {
         return base as VideoTexture;
      }
   }
}

