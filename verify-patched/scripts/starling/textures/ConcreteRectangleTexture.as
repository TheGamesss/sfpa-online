package starling.textures
{
   import flash.display.BitmapData;
   import flash.display3D.textures.*;
   import flash.events.*;
   import flash.utils.*;
   import starling.core.*;
   import starling.utils.*;
   
   internal class ConcreteRectangleTexture extends ConcreteTexture
   {
      
      private static var sAsyncUploadEnabled:Boolean = false;
      
      private var _textureReadyCallback:Function;
      
      public function ConcreteRectangleTexture(base:RectangleTexture, format:String, width:int, height:int, premultipliedAlpha:Boolean, optimizedForRenderTexture:Boolean = false, scale:Number = 1)
      {
         super(base,format,width,height,false,premultipliedAlpha,optimizedForRenderTexture,scale);
      }
      
      internal static function get asyncUploadEnabled() : Boolean
      {
         return sAsyncUploadEnabled;
      }
      
      internal static function set asyncUploadEnabled(value:Boolean) : void
      {
         sAsyncUploadEnabled = value;
      }
      
      override public function uploadBitmapData(data:BitmapData, async:* = null) : void
      {
         if(async is Function)
         {
            this._textureReadyCallback = async as Function;
         }
         this.upload(data,async != null);
         setDataUploaded();
      }
      
      override protected function createBase() : TextureBase
      {
         return Starling.context.createRectangleTexture(nativeWidth,nativeHeight,format,optimizedForRenderTexture);
      }
      
      private function get rectBase() : RectangleTexture
      {
         return base as RectangleTexture;
      }
      
      private function upload(source:BitmapData, isAsync:Boolean) : void
      {
         if(isAsync)
         {
            this.uploadAsync(source);
            base.addEventListener(Event.TEXTURE_READY,this.onTextureReady);
            base.addEventListener(ErrorEvent.ERROR,this.onTextureReady);
         }
         else
         {
            this.rectBase.uploadFromBitmapData(source);
         }
      }
      
      private function uploadAsync(source:BitmapData) : void
      {
         if(sAsyncUploadEnabled)
         {
            try
            {
               base["uploadFromBitmapDataAsync"](source);
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
            this.rectBase.uploadFromBitmapData(source);
         }
      }
      
      private function onTextureReady(event:Event) : void
      {
         base.removeEventListener(Event.TEXTURE_READY,this.onTextureReady);
         base.removeEventListener(ErrorEvent.ERROR,this.onTextureReady);
         execute(this._textureReadyCallback,this,event as ErrorEvent);
         this._textureReadyCallback = null;
      }
   }
}

