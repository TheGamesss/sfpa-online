package starling.textures
{
   import starling.core.*;
   
   public class TextureOptions
   {
      
      private var _scale:Number;
      
      private var _format:String;
      
      private var _mipMapping:Boolean;
      
      private var _optimizeForRenderToTexture:Boolean = false;
      
      private var _premultipliedAlpha:Boolean;
      
      private var _forcePotTexture:Boolean;
      
      private var _onReady:Function = null;
      
      public function TextureOptions(scale:Number = 1, mipMapping:Boolean = false, format:String = "bgra", premultipliedAlpha:Boolean = true, forcePotTexture:Boolean = false)
      {
         super();
         this._scale = scale;
         this._format = format;
         this._mipMapping = mipMapping;
         this._forcePotTexture = forcePotTexture;
         this._premultipliedAlpha = premultipliedAlpha;
      }
      
      public function clone() : TextureOptions
      {
         var clone:TextureOptions = new TextureOptions(this._scale,this._mipMapping,this._format);
         clone._optimizeForRenderToTexture = this._optimizeForRenderToTexture;
         clone._premultipliedAlpha = this._premultipliedAlpha;
         clone._forcePotTexture = this._forcePotTexture;
         clone._onReady = this._onReady;
         return clone;
      }
      
      public function get scale() : Number
      {
         return this._scale;
      }
      
      public function set scale(value:Number) : void
      {
         this._scale = value > 0 ? value : Number(Starling.contentScaleFactor);
      }
      
      public function get format() : String
      {
         return this._format;
      }
      
      public function set format(value:String) : void
      {
         this._format = value;
      }
      
      public function get mipMapping() : Boolean
      {
         return this._mipMapping;
      }
      
      public function set mipMapping(value:Boolean) : void
      {
         this._mipMapping = value;
      }
      
      public function get optimizeForRenderToTexture() : Boolean
      {
         return this._optimizeForRenderToTexture;
      }
      
      public function set optimizeForRenderToTexture(value:Boolean) : void
      {
         this._optimizeForRenderToTexture = value;
      }
      
      public function get forcePotTexture() : Boolean
      {
         return this._forcePotTexture;
      }
      
      public function set forcePotTexture(value:Boolean) : void
      {
         this._forcePotTexture = value;
      }
      
      public function get onReady() : Function
      {
         return this._onReady;
      }
      
      public function set onReady(value:Function) : void
      {
         this._onReady = value;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return this._premultipliedAlpha;
      }
      
      public function set premultipliedAlpha(value:Boolean) : void
      {
         this._premultipliedAlpha = value;
      }
   }
}

