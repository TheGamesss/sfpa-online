package starling.textures
{
   import flash.display3D.textures.TextureBase;
   import flash.geom.*;
   import starling.core.*;
   
   use namespace starling_internal;
   
   public class SubTexture extends Texture
   {
      
      private var _parent:Texture;
      
      private var _ownsParent:Boolean;
      
      private var _region:Rectangle;
      
      private var _frame:Rectangle;
      
      private var _rotated:Boolean;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _scale:Number;
      
      private var _transformationMatrix:Matrix;
      
      private var _transformationMatrixToRoot:Matrix;
      
      public function SubTexture(parent:Texture, region:Rectangle = null, ownsParent:Boolean = false, frame:Rectangle = null, rotated:Boolean = false, scaleModifier:Number = 1)
      {
         super();
         starling_internal::setTo(parent,region,ownsParent,frame,rotated,scaleModifier);
      }
      
      starling_internal function setTo(parent:Texture, region:Rectangle = null, ownsParent:Boolean = false, frame:Rectangle = null, rotated:Boolean = false, scaleModifier:Number = 1) : void
      {
         if(this._region == null)
         {
            this._region = new Rectangle();
         }
         if(region)
         {
            this._region.copyFrom(region);
         }
         else
         {
            this._region.setTo(0,0,parent.width,parent.height);
         }
         if(frame)
         {
            if(this._frame)
            {
               this._frame.copyFrom(frame);
            }
            else
            {
               this._frame = frame.clone();
            }
         }
         else
         {
            this._frame = null;
         }
         this._parent = parent;
         this._ownsParent = ownsParent;
         this._rotated = rotated;
         this._width = (rotated ? this._region.height : this._region.width) / scaleModifier;
         this._height = (rotated ? this._region.width : this._region.height) / scaleModifier;
         this._scale = this._parent.scale * scaleModifier;
         this.updateMatrices();
      }
      
      private function updateMatrices() : void
      {
         if(this._transformationMatrix)
         {
            this._transformationMatrix.identity();
         }
         else
         {
            this._transformationMatrix = new Matrix();
         }
         if(this._transformationMatrixToRoot)
         {
            this._transformationMatrixToRoot.identity();
         }
         else
         {
            this._transformationMatrixToRoot = new Matrix();
         }
         if(this._rotated)
         {
            this._transformationMatrix.translate(0,-1);
            this._transformationMatrix.rotate(Math.PI / 2);
         }
         this._transformationMatrix.scale(this._region.width / this._parent.width,this._region.height / this._parent.height);
         this._transformationMatrix.translate(this._region.x / this._parent.width,this._region.y / this._parent.height);
         var texture:SubTexture = this;
         while(texture)
         {
            this._transformationMatrixToRoot.concat(texture._transformationMatrix);
            texture = texture.parent as SubTexture;
         }
      }
      
      override public function dispose() : void
      {
         if(this._ownsParent)
         {
            this._parent.dispose();
         }
         super.dispose();
      }
      
      public function get parent() : Texture
      {
         return this._parent;
      }
      
      public function get ownsParent() : Boolean
      {
         return this._ownsParent;
      }
      
      public function get rotated() : Boolean
      {
         return this._rotated;
      }
      
      public function get region() : Rectangle
      {
         return this._region;
      }
      
      override public function get transformationMatrix() : Matrix
      {
         return this._transformationMatrix;
      }
      
      override public function get transformationMatrixToRoot() : Matrix
      {
         return this._transformationMatrixToRoot;
      }
      
      override public function get base() : TextureBase
      {
         return this._parent.base;
      }
      
      override public function get root() : ConcreteTexture
      {
         return this._parent.root;
      }
      
      override public function get format() : String
      {
         return this._parent.format;
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      override public function get nativeWidth() : Number
      {
         return this._width * this._scale;
      }
      
      override public function get nativeHeight() : Number
      {
         return this._height * this._scale;
      }
      
      override public function get mipMapping() : Boolean
      {
         return this._parent.mipMapping;
      }
      
      override public function get premultipliedAlpha() : Boolean
      {
         return this._parent.premultipliedAlpha;
      }
      
      override public function get scale() : Number
      {
         return this._scale;
      }
      
      override public function get frame() : Rectangle
      {
         return this._frame;
      }
   }
}

