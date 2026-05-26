package starling.textures
{
   import flash.display3D.textures.TextureBase;
   import flash.errors.*;
   import flash.geom.*;
   import flash.utils.Dictionary;
   import starling.core.*;
   import starling.display.*;
   import starling.filters.FragmentFilter;
   import starling.rendering.Painter;
   import starling.rendering.RenderState;
   import starling.utils.*;
   
   public class RenderTexture extends SubTexture
   {
      
      private static const USE_DOUBLE_BUFFERING_DATA_NAME:String = "starling.textures.RenderTexture.useDoubleBuffering";
      
      private static var sClipRect:Rectangle = new Rectangle();
      
      private var _activeTexture:Texture;
      
      private var _bufferTexture:Texture;
      
      private var _helperImage:Image;
      
      private var _drawing:Boolean;
      
      private var _bufferReady:Boolean;
      
      private var _isPersistent:Boolean;
      
      public function RenderTexture(width:int, height:int, persistent:Boolean = true, scale:Number = -1, format:String = "bgra")
      {
         this._isPersistent = persistent;
         this._activeTexture = Texture.empty(width,height,true,false,true,scale,format);
         this._activeTexture.root.onRestore = this._activeTexture.root.clear;
         super(this._activeTexture,new Rectangle(0,0,width,height),true,null,false);
         if(persistent && useDoubleBuffering)
         {
            this._bufferTexture = Texture.empty(width,height,true,false,true,scale,format);
            this._bufferTexture.root.onRestore = this._bufferTexture.root.clear;
            this._helperImage = new Image(this._bufferTexture);
            this._helperImage.textureSmoothing = TextureSmoothing.NONE;
         }
      }
      
      public static function get useDoubleBuffering() : Boolean
      {
         var painter:Painter = null;
         var sharedData:Dictionary = null;
         var profile:String = null;
         var value:Boolean = false;
         if(Starling.current)
         {
            painter = Starling.painter;
            sharedData = painter.sharedData;
            if(USE_DOUBLE_BUFFERING_DATA_NAME in sharedData)
            {
               return sharedData[USE_DOUBLE_BUFFERING_DATA_NAME];
            }
            profile = painter.profile ? painter.profile : "baseline";
            value = profile == "baseline" || profile == "baselineConstrained";
            sharedData[USE_DOUBLE_BUFFERING_DATA_NAME] = value;
            return value;
         }
         return false;
      }
      
      public static function set useDoubleBuffering(value:Boolean) : void
      {
         if(Starling.current == null)
         {
            throw new IllegalOperationError("Starling not yet initialized");
         }
         Starling.painter.sharedData[USE_DOUBLE_BUFFERING_DATA_NAME] = value;
      }
      
      override public function dispose() : void
      {
         this._activeTexture.dispose();
         if(this.isDoubleBuffered)
         {
            this._bufferTexture.dispose();
            this._helperImage.dispose();
         }
         super.dispose();
      }
      
      public function draw(object:DisplayObject, matrix:Matrix = null, alpha:Number = 1, antiAliasing:int = 0) : void
      {
         if(object == null)
         {
            return;
         }
         if(this._drawing)
         {
            this.render(object,matrix,alpha);
         }
         else
         {
            this.renderBundled(this.render,object,matrix,alpha,antiAliasing);
         }
      }
      
      public function drawBundled(drawingBlock:Function, antiAliasing:int = 0) : void
      {
         this.renderBundled(drawingBlock,null,null,1,antiAliasing);
      }
      
      private function render(object:DisplayObject, matrix:Matrix = null, alpha:Number = 1) : void
      {
         var painter:Painter = Starling.painter;
         var state:RenderState = painter.state;
         var wasCacheEnabled:Boolean = painter.cacheEnabled;
         var filter:FragmentFilter = object.filter;
         var mask:DisplayObject = object.mask;
         painter.cacheEnabled = false;
         painter.pushState();
         state.alpha = object.alpha * alpha;
         state.setModelviewMatricesToIdentity();
         state.blendMode = object.blendMode == BlendMode.AUTO ? BlendMode.NORMAL : object.blendMode;
         if(matrix)
         {
            state.transformModelviewMatrix(matrix);
         }
         else
         {
            state.transformModelviewMatrix(object.transformationMatrix);
         }
         if(mask)
         {
            painter.drawMask(mask,object);
         }
         if(filter)
         {
            filter.render(painter);
         }
         else
         {
            object.render(painter);
         }
         if(mask)
         {
            painter.eraseMask(mask,object);
         }
         painter.popState();
         painter.cacheEnabled = wasCacheEnabled;
      }
      
      private function renderBundled(renderBlock:Function, object:DisplayObject = null, matrix:Matrix = null, alpha:Number = 1, antiAliasing:int = 0) : void
      {
         var rootTexture:Texture;
         var tmpTexture:Texture = null;
         var painter:Painter = Starling.painter;
         var state:RenderState = painter.state;
         if(!Starling.current.contextValid)
         {
            return;
         }
         if(this.isDoubleBuffered)
         {
            tmpTexture = this._activeTexture;
            this._activeTexture = this._bufferTexture;
            this._bufferTexture = tmpTexture;
            this._helperImage.texture = this._bufferTexture;
         }
         painter.pushState();
         rootTexture = this._activeTexture.root;
         state.setProjectionMatrix(0,0,rootTexture.width,rootTexture.height,width,height);
         sClipRect.setTo(0,0,this._activeTexture.width,this._activeTexture.height);
         state.clipRect = sClipRect;
         state.setRenderTarget(this._activeTexture,true,antiAliasing);
         painter.prepareToDraw();
         if(Boolean(this.isDoubleBuffered) || !this.isPersistent || !this._bufferReady)
         {
            painter.clear();
         }
         if(Boolean(this.isDoubleBuffered) && Boolean(this._bufferReady))
         {
            this._helperImage.render(painter);
         }
         else
         {
            this._bufferReady = true;
         }
         try
         {
            this._drawing = true;
            execute(renderBlock,object,matrix,alpha);
         }
         finally
         {
            this._drawing = false;
            painter.popState();
         }
      }
      
      public function clear(color:uint = 0, alpha:Number = 0) : void
      {
         this._activeTexture.root.clear(color,alpha);
         this._bufferReady = true;
      }
      
      private function get isDoubleBuffered() : Boolean
      {
         return this._bufferTexture != null;
      }
      
      public function get isPersistent() : Boolean
      {
         return this._isPersistent;
      }
      
      override public function get base() : TextureBase
      {
         return this._activeTexture.base;
      }
      
      override public function get root() : ConcreteTexture
      {
         return this._activeTexture.root;
      }
   }
}

