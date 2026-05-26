package starling.rendering
{
   import flash.display3D.*;
   import flash.display3D.textures.TextureBase;
   import flash.geom.*;
   import starling.display.*;
   import starling.textures.Texture;
   import starling.utils.*;
   
   public class RenderState
   {
      
      private static const CULLING_VALUES:Vector.<String> = new <String>[Context3DTriangleFace.NONE,Context3DTriangleFace.FRONT,Context3DTriangleFace.BACK,Context3DTriangleFace.FRONT_AND_BACK];
      
      private static const COMPARE_VALUES:Vector.<String> = new <String>[Context3DCompareMode.ALWAYS,Context3DCompareMode.NEVER,Context3DCompareMode.LESS,Context3DCompareMode.LESS_EQUAL,Context3DCompareMode.EQUAL,Context3DCompareMode.GREATER_EQUAL,Context3DCompareMode.GREATER,Context3DCompareMode.NOT_EQUAL];
      
      private static var sMatrix3D:Matrix3D = new Matrix3D();
      
      private static var sProjectionMatrix3DRev:uint = 0;
      
      internal var _alpha:Number;
      
      internal var _blendMode:String;
      
      internal var _modelviewMatrix:Matrix;
      
      private var _miscOptions:uint;
      
      private var _clipRect:Rectangle;
      
      private var _renderTarget:Texture;
      
      private var _onDrawRequired:Function;
      
      private var _modelviewMatrix3D:Matrix3D;
      
      private var _projectionMatrix3D:Matrix3D;
      
      private var _projectionMatrix3DRev:uint;
      
      private var _mvpMatrix3D:Matrix3D;
      
      public function RenderState()
      {
         super();
         this.reset();
      }
      
      public function copyFrom(renderState:RenderState) : void
      {
         var currentTarget:TextureBase = null;
         var nextTarget:TextureBase = null;
         var cullingChanges:Boolean = false;
         var depthMaskChanges:Boolean = false;
         var depthTestChanges:Boolean = false;
         var clipRectChanges:Boolean = false;
         if(this._onDrawRequired != null)
         {
            currentTarget = this._renderTarget ? this._renderTarget.base : null;
            nextTarget = renderState._renderTarget ? renderState._renderTarget.base : null;
            cullingChanges = (this._miscOptions & 0x0F00) != (renderState._miscOptions & 0x0F00);
            depthMaskChanges = (this._miscOptions & 0xF000) != (renderState._miscOptions & 0xF000);
            depthTestChanges = (this._miscOptions & 0x0F0000) != (renderState._miscOptions & 0x0F0000);
            clipRectChanges = Boolean(this._clipRect) || Boolean(renderState._clipRect) ? !RectangleUtil.compare(this._clipRect,renderState._clipRect) : false;
            if(this._blendMode != renderState._blendMode || currentTarget != nextTarget || clipRectChanges || cullingChanges || depthMaskChanges || depthTestChanges)
            {
               this._onDrawRequired();
            }
         }
         this._alpha = renderState._alpha;
         this._blendMode = renderState._blendMode;
         this._renderTarget = renderState._renderTarget;
         this._miscOptions = renderState._miscOptions;
         this._modelviewMatrix.copyFrom(renderState._modelviewMatrix);
         if(this._projectionMatrix3DRev != renderState._projectionMatrix3DRev)
         {
            this._projectionMatrix3DRev = renderState._projectionMatrix3DRev;
            this._projectionMatrix3D.copyFrom(renderState._projectionMatrix3D);
         }
         if(Boolean(this._modelviewMatrix3D) || Boolean(renderState._modelviewMatrix3D))
         {
            this.modelviewMatrix3D = renderState._modelviewMatrix3D;
         }
         if(Boolean(this._clipRect) || Boolean(renderState._clipRect))
         {
            this.clipRect = renderState._clipRect;
         }
      }
      
      public function reset() : void
      {
         this.alpha = 1;
         this.blendMode = BlendMode.NORMAL;
         this.culling = Context3DTriangleFace.NONE;
         this.depthMask = false;
         this.depthTest = Context3DCompareMode.ALWAYS;
         this.modelviewMatrix3D = null;
         this.renderTarget = null;
         this.clipRect = null;
         this._projectionMatrix3DRev = 0;
         if(this._modelviewMatrix)
         {
            this._modelviewMatrix.identity();
         }
         else
         {
            this._modelviewMatrix = new Matrix();
         }
         if(this._projectionMatrix3D)
         {
            this._projectionMatrix3D.identity();
         }
         else
         {
            this._projectionMatrix3D = new Matrix3D();
         }
         if(this._mvpMatrix3D == null)
         {
            this._mvpMatrix3D = new Matrix3D();
         }
      }
      
      public function transformModelviewMatrix(matrix:Matrix) : void
      {
         MatrixUtil.prependMatrix(this._modelviewMatrix,matrix);
      }
      
      public function transformModelviewMatrix3D(matrix:Matrix3D) : void
      {
         if(this._modelviewMatrix3D == null)
         {
            this._modelviewMatrix3D = Pool.getMatrix3D();
         }
         this._modelviewMatrix3D.prepend(MatrixUtil.convertTo3D(this._modelviewMatrix,sMatrix3D));
         this._modelviewMatrix3D.prepend(matrix);
         this._modelviewMatrix.identity();
      }
      
      public function setProjectionMatrix(x:Number, y:Number, width:Number, height:Number, stageWidth:Number = 0, stageHeight:Number = 0, cameraPos:Vector3D = null) : void
      {
         this._projectionMatrix3DRev = ++sProjectionMatrix3DRev;
         MatrixUtil.createPerspectiveProjectionMatrix(x,y,width,height,stageWidth,stageHeight,cameraPos,this._projectionMatrix3D);
      }
      
      public function setProjectionMatrixChanged() : void
      {
         this._projectionMatrix3DRev = ++sProjectionMatrix3DRev;
      }
      
      public function setModelviewMatricesToIdentity() : void
      {
         this._modelviewMatrix.identity();
         if(this._modelviewMatrix3D)
         {
            this._modelviewMatrix3D.identity();
         }
      }
      
      public function get modelviewMatrix() : Matrix
      {
         return this._modelviewMatrix;
      }
      
      public function set modelviewMatrix(value:Matrix) : void
      {
         this._modelviewMatrix.copyFrom(value);
      }
      
      public function get modelviewMatrix3D() : Matrix3D
      {
         return this._modelviewMatrix3D;
      }
      
      public function set modelviewMatrix3D(value:Matrix3D) : void
      {
         if(value)
         {
            if(this._modelviewMatrix3D == null)
            {
               this._modelviewMatrix3D = Pool.getMatrix3D(false);
            }
            this._modelviewMatrix3D.copyFrom(value);
         }
         else if(this._modelviewMatrix3D)
         {
            Pool.putMatrix3D(this._modelviewMatrix3D);
            this._modelviewMatrix3D = null;
         }
      }
      
      public function get projectionMatrix3D() : Matrix3D
      {
         return this._projectionMatrix3D;
      }
      
      public function set projectionMatrix3D(value:Matrix3D) : void
      {
         this.setProjectionMatrixChanged();
         this._projectionMatrix3D.copyFrom(value);
      }
      
      public function get mvpMatrix3D() : Matrix3D
      {
         this._mvpMatrix3D.copyFrom(this._projectionMatrix3D);
         if(this._modelviewMatrix3D)
         {
            this._mvpMatrix3D.prepend(this._modelviewMatrix3D);
         }
         this._mvpMatrix3D.prepend(MatrixUtil.convertTo3D(this._modelviewMatrix,sMatrix3D));
         return this._mvpMatrix3D;
      }
      
      public function setRenderTarget(target:Texture, enableDepthAndStencil:Boolean = true, antiAlias:int = 0) : void
      {
         var currentTarget:TextureBase = this._renderTarget ? this._renderTarget.base : null;
         var newTarget:TextureBase = target ? target.base : null;
         var newOptions:uint = uint(MathUtil.min(antiAlias,15) | uint(enableDepthAndStencil) << 4);
         var optionsChange:Boolean = newOptions != (this._miscOptions & 0xFF);
         if(currentTarget != newTarget || optionsChange)
         {
            if(this._onDrawRequired != null)
            {
               this._onDrawRequired();
            }
            this._renderTarget = target;
            this._miscOptions = this._miscOptions & 0xFFFFFF00 | newOptions;
         }
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(value:Number) : void
      {
         this._alpha = value;
      }
      
      public function get blendMode() : String
      {
         return this._blendMode;
      }
      
      public function set blendMode(value:String) : void
      {
         if(value != BlendMode.AUTO && this._blendMode != value)
         {
            if(this._onDrawRequired != null)
            {
               this._onDrawRequired();
            }
            this._blendMode = value;
         }
      }
      
      public function get renderTarget() : Texture
      {
         return this._renderTarget;
      }
      
      public function set renderTarget(value:Texture) : void
      {
         this.setRenderTarget(value);
      }
      
      internal function get renderTargetBase() : TextureBase
      {
         return this._renderTarget ? this._renderTarget.base : null;
      }
      
      internal function get renderTargetOptions() : uint
      {
         return this._miscOptions & 0xFF;
      }
      
      public function get culling() : String
      {
         var index:int = (this._miscOptions & 0x0F00) >> 8;
         return CULLING_VALUES[index];
      }
      
      public function set culling(value:String) : void
      {
         var index:int = 0;
         if(this.culling != value)
         {
            if(this._onDrawRequired != null)
            {
               this._onDrawRequired();
            }
            index = int(CULLING_VALUES.indexOf(value));
            if(index == -1)
            {
               throw new ArgumentError("Invalid culling mode");
            }
            this._miscOptions = this._miscOptions & 0xFFFFF0FF | index << 8;
         }
      }
      
      public function get depthMask() : Boolean
      {
         return (this._miscOptions & 0xF000) != 0;
      }
      
      public function set depthMask(value:Boolean) : void
      {
         if(this.depthMask != value)
         {
            if(this._onDrawRequired != null)
            {
               this._onDrawRequired();
            }
            this._miscOptions = this._miscOptions & 0xFFFF0FFF | uint(value) << 12;
         }
      }
      
      public function get depthTest() : String
      {
         var index:int = (this._miscOptions & 0x0F0000) >> 16;
         return COMPARE_VALUES[index];
      }
      
      public function set depthTest(value:String) : void
      {
         var index:int = 0;
         if(this.depthTest != value)
         {
            if(this._onDrawRequired != null)
            {
               this._onDrawRequired();
            }
            index = int(COMPARE_VALUES.indexOf(value));
            if(index == -1)
            {
               throw new ArgumentError("Invalid compare mode");
            }
            this._miscOptions = this._miscOptions & 0xFFF0FFFF | index << 16;
         }
      }
      
      public function get clipRect() : Rectangle
      {
         return this._clipRect;
      }
      
      public function set clipRect(value:Rectangle) : void
      {
         if(!RectangleUtil.compare(this._clipRect,value))
         {
            if(this._onDrawRequired != null)
            {
               this._onDrawRequired();
            }
            if(value)
            {
               if(this._clipRect == null)
               {
                  this._clipRect = Pool.getRectangle();
               }
               this._clipRect.copyFrom(value);
            }
            else if(this._clipRect)
            {
               Pool.putRectangle(this._clipRect);
               this._clipRect = null;
            }
         }
      }
      
      public function get renderTargetAntiAlias() : int
      {
         return this._miscOptions & 0x0F;
      }
      
      public function get renderTargetSupportsDepthAndStencil() : Boolean
      {
         return (this._miscOptions & 0xF0) != 0;
      }
      
      public function get is3D() : Boolean
      {
         return this._modelviewMatrix3D != null;
      }
      
      internal function get onDrawRequired() : Function
      {
         return this._onDrawRequired;
      }
      
      internal function set onDrawRequired(value:Function) : void
      {
         this._onDrawRequired = value;
      }
   }
}

