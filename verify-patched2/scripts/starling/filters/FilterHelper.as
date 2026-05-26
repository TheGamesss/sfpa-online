package starling.filters
{
   import flash.display3D.*;
   import flash.geom.*;
   import starling.core.*;
   import starling.display.DisplayObject;
   import starling.textures.*;
   import starling.utils.*;
   
   use namespace starling_internal;
   
   internal class FilterHelper implements IFilterHelper
   {
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _nativeWidth:int;
      
      private var _nativeHeight:int;
      
      private var _pool:Vector.<Texture>;
      
      private var _usePotTextures:Boolean;
      
      private var _textureFormat:String;
      
      private var _preferredScale:Number;
      
      private var _scale:Number;
      
      private var _sizeStep:int;
      
      private var _numPasses:int;
      
      private var _projectionMatrix:Matrix3D;
      
      private var _renderTarget:Texture;
      
      private var _targetBounds:Rectangle;
      
      private var _target:DisplayObject;
      
      private var _clipRect:Rectangle;
      
      private var sRegion:Rectangle = new Rectangle();
      
      public function FilterHelper(textureFormat:String = "bgra")
      {
         super();
         this._usePotTextures = Starling.current.profile == Context3DProfile.BASELINE_CONSTRAINED;
         this._preferredScale = Starling.contentScaleFactor;
         this._textureFormat = textureFormat;
         this._sizeStep = 64;
         this._pool = new Vector.<Texture>(0);
         this._projectionMatrix = new Matrix3D();
         this._targetBounds = new Rectangle();
         this.setSize(this._sizeStep,this._sizeStep);
      }
      
      public function dispose() : void
      {
         Pool.putRectangle(this._clipRect);
         this._clipRect = null;
         this.purge();
      }
      
      public function start(numPasses:int, drawLastPassToBackBuffer:Boolean) : void
      {
         this._numPasses = drawLastPassToBackBuffer ? numPasses : -1;
      }
      
      public function getTexture(resolution:Number = 1) : Texture
      {
         var texture:Texture = null;
         var subTexture:SubTexture = null;
         if(this._numPasses >= 0)
         {
            if(this._numPasses-- == 0)
            {
               return null;
            }
         }
         if(this._pool.length)
         {
            texture = this._pool.pop();
         }
         else
         {
            texture = Texture.empty(this._nativeWidth / this._scale,this._nativeHeight / this._scale,true,false,true,this._scale,this._textureFormat);
         }
         if(!MathUtil.isEquivalent(texture.width,this._width,0.1) || !MathUtil.isEquivalent(texture.height,this._height,0.1) || !MathUtil.isEquivalent(texture.scale,this._scale * resolution))
         {
            this.sRegion.setTo(0,0,this._width * resolution,this._height * resolution);
            subTexture = texture as SubTexture;
            if(subTexture)
            {
               subTexture.setTo(texture.root,this.sRegion,true,null,false,resolution);
            }
            else
            {
               texture = new SubTexture(texture.root,this.sRegion,true,null,false,resolution);
            }
         }
         texture.root.clear();
         return texture;
      }
      
      public function putTexture(texture:Texture) : void
      {
         if(texture)
         {
            if(texture.root.nativeWidth == this._nativeWidth && texture.root.nativeHeight == this._nativeHeight)
            {
               this._pool.insertAt(this._pool.length,texture);
            }
            else
            {
               texture.dispose();
            }
         }
      }
      
      public function purge() : void
      {
         var i:int = 0;
         var len:int = int(this._pool.length);
         while(i < len)
         {
            this._pool[i].dispose();
            i++;
         }
         this._pool.length = 0;
      }
      
      private function setSize(width:Number, height:Number) : void
      {
         var factor:Number = NaN;
         var newScale:Number = Number(this._preferredScale);
         var maxNativeSize:int = int(Texture.maxSize);
         var newNativeWidth:int = int(this.getNativeSize(width,newScale));
         var newNativeHeight:int = int(this.getNativeSize(height,newScale));
         if(newNativeWidth > maxNativeSize || newNativeHeight > maxNativeSize)
         {
            factor = maxNativeSize / Math.max(newNativeWidth,newNativeHeight);
            newNativeWidth *= factor;
            newNativeHeight *= factor;
            newScale *= factor;
         }
         if(this._nativeWidth != newNativeWidth || this._nativeHeight != newNativeHeight || this._scale != newScale)
         {
            this.purge();
            this._scale = newScale;
            this._nativeWidth = newNativeWidth;
            this._nativeHeight = newNativeHeight;
         }
         this._width = width;
         this._height = height;
      }
      
      private function getNativeSize(size:Number, textureScale:Number) : int
      {
         var nativeSize:Number = size * textureScale;
         if(this._usePotTextures)
         {
            return nativeSize > this._sizeStep ? int(MathUtil.getNextPowerOfTwo(nativeSize)) : int(this._sizeStep);
         }
         return Math.ceil(nativeSize / this._sizeStep) * this._sizeStep;
      }
      
      public function get projectionMatrix3D() : Matrix3D
      {
         return this._projectionMatrix;
      }
      
      public function set projectionMatrix3D(value:Matrix3D) : void
      {
         this._projectionMatrix.copyFrom(value);
      }
      
      public function get renderTarget() : Texture
      {
         return this._renderTarget;
      }
      
      public function set renderTarget(value:Texture) : void
      {
         this._renderTarget = value;
      }
      
      public function get clipRect() : Rectangle
      {
         return this._clipRect;
      }
      
      public function set clipRect(value:Rectangle) : void
      {
         if(value)
         {
            if(this._clipRect)
            {
               this._clipRect.copyFrom(value);
            }
            else
            {
               this._clipRect = Pool.getRectangle(value.x,value.y,value.width,value.height);
            }
         }
         else if(this._clipRect)
         {
            Pool.putRectangle(this._clipRect);
            this._clipRect = null;
         }
      }
      
      public function get targetBounds() : Rectangle
      {
         return this._targetBounds;
      }
      
      public function set targetBounds(value:Rectangle) : void
      {
         this._targetBounds.copyFrom(value);
         this.setSize(value.width,value.height);
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      public function set target(value:DisplayObject) : void
      {
         this._target = value;
      }
      
      public function get textureScale() : Number
      {
         return this._preferredScale;
      }
      
      public function set textureScale(value:Number) : void
      {
         this._preferredScale = value > 0 ? value : Number(Starling.contentScaleFactor);
      }
      
      public function get textureFormat() : String
      {
         return this._textureFormat;
      }
      
      public function set textureFormat(value:String) : void
      {
         this._textureFormat = value;
      }
   }
}

