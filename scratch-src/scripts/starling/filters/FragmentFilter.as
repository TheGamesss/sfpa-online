package starling.filters
{
   import flash.display3D.*;
   import flash.errors.*;
   import flash.geom.*;
   import starling.core.*;
   import starling.display.*;
   import starling.events.*;
   import starling.rendering.*;
   import starling.textures.*;
   import starling.utils.*;
   
   use namespace starling_internal;
   
   public class FragmentFilter extends EventDispatcher
   {
      
      private static var sMatrix3D:Matrix3D = new Matrix3D();
      
      private var _quad:FilterQuad;
      
      private var _target:DisplayObject;
      
      private var _effect:FilterEffect;
      
      private var _vertexData:VertexData;
      
      private var _indexData:IndexData;
      
      private var _padding:Padding;
      
      private var _helper:FilterHelper;
      
      private var _resolution:Number;
      
      private var _antiAliasing:int;
      
      private var _textureFormat:String;
      
      private var _textureSmoothing:String;
      
      private var _alwaysDrawToBackBuffer:Boolean;
      
      private var _cacheRequested:Boolean;
      
      private var _cached:Boolean;
      
      public function FragmentFilter()
      {
         super();
         this._resolution = 1;
         this._textureFormat = Context3DTextureFormat.BGRA;
         this._textureSmoothing = TextureSmoothing.BILINEAR;
         Starling.current.stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated,false,0,true);
      }
      
      public function dispose() : void
      {
         Starling.current.stage3D.removeEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated);
         if(this._helper)
         {
            this._helper.dispose();
         }
         if(this._effect)
         {
            this._effect.dispose();
         }
         if(this._quad)
         {
            this._quad.dispose();
         }
         this._effect = null;
         this._quad = null;
      }
      
      private function onContextCreated(event:Object) : void
      {
         this.setRequiresRedraw();
      }
      
      public function render(painter:Painter) : void
      {
         if(this._target == null)
         {
            throw new IllegalOperationError("Cannot render filter without target");
         }
         if(this._target.is3D)
         {
            this._cached = this._cacheRequested = false;
         }
         if(!this._cached || Boolean(this._cacheRequested))
         {
            this.renderPasses(painter,this._cacheRequested);
            this._cacheRequested = false;
         }
         else if(this._quad.visible)
         {
            this._quad.render(painter);
         }
      }
      
      private function renderPasses(painter:Painter, forCache:Boolean) : void
      {
         var stageBounds:Rectangle = null;
         var output:Texture = null;
         if(this._helper == null)
         {
            this._helper = new FilterHelper(this._textureFormat);
         }
         if(this._quad == null)
         {
            this._quad = new FilterQuad(this._textureSmoothing);
         }
         else
         {
            this._helper.putTexture(this._quad.texture);
            this._quad.texture = null;
         }
         var bounds:Rectangle = Pool.getRectangle();
         var drawLastPassToBackBuffer:Boolean = false;
         var origResolution:Number = Number(this._resolution);
         var renderSpace:DisplayObject = this._target.stage || this._target.parent;
         var isOnStage:Boolean = renderSpace is Stage;
         var stage:Stage = Starling.current.stage;
         if(!forCache && (Boolean(this._alwaysDrawToBackBuffer) || Boolean(this._target.requiresRedraw)))
         {
            drawLastPassToBackBuffer = painter.state.alpha == 1;
            painter.excludeFromCache(this._target);
         }
         if(this._target == Starling.current.root)
         {
            stage.getStageBounds(this._target,bounds);
         }
         else
         {
            this._target.getBounds(renderSpace,bounds);
            if(!forCache && isOnStage)
            {
               stageBounds = stage.getStageBounds(null,Pool.getRectangle());
               RectangleUtil.intersect(bounds,stageBounds,bounds);
               Pool.putRectangle(stageBounds);
            }
         }
         this._quad.visible = !bounds.isEmpty();
         if(!this._quad.visible)
         {
            Pool.putRectangle(bounds);
            return;
         }
         if(this._padding)
         {
            RectangleUtil.extend(bounds,this._padding.left,this._padding.right,this._padding.top,this._padding.bottom);
         }
         RectangleUtil.extendToWholePixels(bounds,Starling.contentScaleFactor);
         this._helper.textureScale = Starling.contentScaleFactor * this._resolution;
         this._helper.projectionMatrix3D = painter.state.projectionMatrix3D;
         this._helper.renderTarget = painter.state.renderTarget;
         this._helper.clipRect = painter.state.clipRect;
         this._helper.targetBounds = bounds;
         this._helper.target = this._target;
         this._helper.start(this.numPasses,drawLastPassToBackBuffer);
         this._quad.setBounds(bounds);
         this._resolution = 1;
         var wasCacheEnabled:Boolean = painter.cacheEnabled;
         var input:Texture = this._helper.getTexture();
         painter.cacheEnabled = false;
         painter.pushState();
         painter.state.alpha = 1;
         painter.state.clipRect = null;
         painter.state.setRenderTarget(input,true,this._antiAliasing);
         painter.state.setProjectionMatrix(bounds.x,bounds.y,input.root.width,input.root.height,stage.stageWidth,stage.stageHeight,stage.cameraPosition);
         this._target.render(painter);
         painter.finishMeshBatch();
         painter.state.setModelviewMatricesToIdentity();
         output = this.process(painter,this._helper,input);
         painter.popState();
         painter.cacheEnabled = wasCacheEnabled;
         if(output)
         {
            painter.pushState();
            if(this._target.is3D)
            {
               painter.state.setModelviewMatricesToIdentity();
            }
            else
            {
               this._quad.moveVertices(renderSpace,this._target);
            }
            this._quad.texture = output;
            this._quad.render(painter);
            painter.finishMeshBatch();
            painter.popState();
         }
         this._helper.target = null;
         this._helper.putTexture(input);
         this._resolution = origResolution;
         Pool.putRectangle(bounds);
      }
      
      public function process(painter:Painter, helper:IFilterHelper, input0:Texture = null, input1:Texture = null, input2:Texture = null, input3:Texture = null) : Texture
      {
         var projectionMatrix:Matrix3D = null;
         var renderTarget:Texture = null;
         var effect:FilterEffect = this.effect;
         var output:Texture = helper.getTexture(this._resolution);
         var bounds:Rectangle = null;
         if(output)
         {
            renderTarget = output;
            projectionMatrix = MatrixUtil.createPerspectiveProjectionMatrix(0,0,output.root.width / this._resolution,output.root.height / this._resolution,0,0,null,sMatrix3D);
         }
         else
         {
            bounds = helper.targetBounds;
            renderTarget = (helper as FilterHelper).renderTarget;
            projectionMatrix = (helper as FilterHelper).projectionMatrix3D;
            effect.textureSmoothing = this._textureSmoothing;
            painter.state.clipRect = (helper as FilterHelper).clipRect;
            painter.state.projectionMatrix3D.copyFrom(projectionMatrix);
         }
         painter.state.renderTarget = renderTarget;
         painter.prepareToDraw();
         painter.drawCount += 1;
         input0.setupVertexPositions(this.vertexData,0,"position",bounds);
         input0.setupTextureCoordinates(this.vertexData);
         effect.texture = input0;
         effect.mvpMatrix3D = projectionMatrix;
         effect.uploadVertexData(this.vertexData);
         effect.uploadIndexData(this.indexData);
         effect.render(0,this.indexData.numTriangles);
         return output;
      }
      
      protected function createEffect() : FilterEffect
      {
         return new FilterEffect();
      }
      
      public function cache() : void
      {
         this._cached = this._cacheRequested = true;
         this.setRequiresRedraw();
      }
      
      public function clearCache() : void
      {
         this._cached = this._cacheRequested = false;
         this.setRequiresRedraw();
      }
      
      override public function addEventListener(type:String, listener:Function) : void
      {
         if(type == Event.ENTER_FRAME && Boolean(this._target))
         {
            this._target.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         super.addEventListener(type,listener);
      }
      
      override public function removeEventListener(type:String, listener:Function) : void
      {
         if(type == Event.ENTER_FRAME && Boolean(this._target))
         {
            this._target.removeEventListener(type,this.onEnterFrame);
         }
         super.removeEventListener(type,listener);
      }
      
      private function onEnterFrame(event:Event) : void
      {
         dispatchEvent(event);
      }
      
      protected function get effect() : FilterEffect
      {
         if(this._effect == null)
         {
            this._effect = this.createEffect();
         }
         return this._effect;
      }
      
      protected function get vertexData() : VertexData
      {
         if(this._vertexData == null)
         {
            this._vertexData = new VertexData(this.effect.vertexFormat,4);
         }
         return this._vertexData;
      }
      
      protected function get indexData() : IndexData
      {
         if(this._indexData == null)
         {
            this._indexData = new IndexData(6);
            this._indexData.addQuad(0,1,2,3);
         }
         return this._indexData;
      }
      
      protected function setRequiresRedraw() : void
      {
         dispatchEventWith(Event.CHANGE);
         if(this._target)
         {
            this._target.setRequiresRedraw();
         }
         if(this._cached)
         {
            this._cacheRequested = true;
         }
      }
      
      public function get numPasses() : int
      {
         return 1;
      }
      
      protected function onTargetAssigned(target:DisplayObject) : void
      {
      }
      
      public function get padding() : Padding
      {
         if(this._padding == null)
         {
            this._padding = new Padding();
            this._padding.addEventListener(Event.CHANGE,this.setRequiresRedraw);
         }
         return this._padding;
      }
      
      public function set padding(value:Padding) : void
      {
         this.padding.copyFrom(value);
      }
      
      public function get isCached() : Boolean
      {
         return this._cached;
      }
      
      public function get resolution() : Number
      {
         return this._resolution;
      }
      
      public function set resolution(value:Number) : void
      {
         if(value != this._resolution)
         {
            if(value <= 0)
            {
               throw new ArgumentError("resolution must be > 0");
            }
            this._resolution = value;
            this.setRequiresRedraw();
         }
      }
      
      public function get antiAliasing() : int
      {
         return this._antiAliasing;
      }
      
      public function set antiAliasing(value:int) : void
      {
         if(value != this._antiAliasing)
         {
            this._antiAliasing = value;
            this.setRequiresRedraw();
         }
      }
      
      public function get textureSmoothing() : String
      {
         return this._textureSmoothing;
      }
      
      public function set textureSmoothing(value:String) : void
      {
         if(value != this._textureSmoothing)
         {
            this._textureSmoothing = value;
            if(this._quad)
            {
               this._quad.textureSmoothing = value;
            }
            this.setRequiresRedraw();
         }
      }
      
      public function get textureFormat() : String
      {
         return this._textureFormat;
      }
      
      public function set textureFormat(value:String) : void
      {
         if(value != this._textureFormat)
         {
            this._textureFormat = value;
            if(this._helper)
            {
               this._helper.textureFormat = value;
            }
            this.setRequiresRedraw();
         }
      }
      
      public function get alwaysDrawToBackBuffer() : Boolean
      {
         return this._alwaysDrawToBackBuffer;
      }
      
      public function set alwaysDrawToBackBuffer(value:Boolean) : void
      {
         this._alwaysDrawToBackBuffer = value;
      }
      
      starling_internal function setTarget(target:DisplayObject) : void
      {
         var prevTarget:DisplayObject = null;
         if(target != this._target)
         {
            prevTarget = this._target;
            this._target = target;
            if(target == null)
            {
               if(this._helper)
               {
                  this._helper.purge();
               }
               if(this._effect)
               {
                  this._effect.purgeBuffers();
               }
               if(this._quad)
               {
                  this._quad.disposeTexture();
               }
            }
            if(prevTarget)
            {
               prevTarget.filter = null;
               prevTarget.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            }
            if(target)
            {
               if(hasEventListener(Event.ENTER_FRAME))
               {
                  target.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               }
               this.onTargetAssigned(target);
            }
         }
      }
   }
}

import flash.geom.*;
import starling.display.DisplayObject;
import starling.display.Mesh;
import starling.rendering.*;
import starling.textures.Texture;

class FilterQuad extends Mesh
{
   
   private static var sMatrix:Matrix = new Matrix();
   
   public function FilterQuad(smoothing:String)
   {
      var vertexData:VertexData = new VertexData(null,4);
      vertexData.numVertices = 4;
      var indexData:IndexData = new IndexData(6);
      indexData.addQuad(0,1,2,3);
      super(vertexData,indexData);
      textureSmoothing = smoothing;
      pixelSnapping = false;
   }
   
   override public function dispose() : void
   {
      this.disposeTexture();
      super.dispose();
   }
   
   public function disposeTexture() : void
   {
      if(texture)
      {
         texture.dispose();
         this.texture = null;
      }
   }
   
   public function moveVertices(sourceSpace:DisplayObject, targetSpace:DisplayObject) : void
   {
      if(targetSpace.is3D)
      {
         throw new Error("cannot move vertices into 3D space");
      }
      if(sourceSpace != targetSpace)
      {
         targetSpace.getTransformationMatrix(sourceSpace,sMatrix).invert();
         vertexData.transformPoints("position",sMatrix);
      }
   }
   
   public function setBounds(bounds:Rectangle) : void
   {
      var vertexData:VertexData = this.vertexData;
      var attrName:String = "position";
      vertexData.setPoint(0,attrName,bounds.x,bounds.y);
      vertexData.setPoint(1,attrName,bounds.right,bounds.y);
      vertexData.setPoint(2,attrName,bounds.x,bounds.bottom);
      vertexData.setPoint(3,attrName,bounds.right,bounds.bottom);
   }
   
   override public function set texture(value:Texture) : void
   {
      super.texture = value;
      if(value)
      {
         value.setupTextureCoordinates(vertexData);
      }
   }
}
