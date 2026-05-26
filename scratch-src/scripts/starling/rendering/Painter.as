package starling.rendering
{
   import flash.display.Stage3D;
   import flash.display3D.*;
   import flash.display3D.textures.TextureBase;
   import flash.errors.*;
   import flash.geom.*;
   import flash.utils.*;
   import starling.core.starling_internal;
   import starling.display.*;
   import starling.events.*;
   import starling.textures.Texture;
   import starling.utils.*;
   
   use namespace starling_internal;
   
   public class Painter
   {
      
      private static const PROGRAM_DATA_NAME:String = "starling.rendering.Painter.Programs";
      
      private static const DEFAULT_STENCIL_VALUE:uint = 127;
      
      private static var sSharedData:Dictionary = new Dictionary();
      
      private static var sMatrix:Matrix = new Matrix();
      
      private static var sPoint3D:Vector3D = new Vector3D();
      
      private static var sMatrix3D:Matrix3D = new Matrix3D();
      
      private static var sClipRect:Rectangle = new Rectangle();
      
      private static var sBufferRect:Rectangle = new Rectangle();
      
      private static var sScissorRect:Rectangle = new Rectangle();
      
      private static var sMeshSubset:MeshSubset = new MeshSubset();
      
      private var _stage3D:Stage3D;
      
      private var _context:Context3D;
      
      private var _shareContext:Boolean;
      
      private var _drawCount:int;
      
      private var _frameID:uint;
      
      private var _pixelSize:Number;
      
      private var _enableErrorChecking:Boolean;
      
      private var _stencilReferenceValues:Dictionary;
      
      private var _clipRectStack:Vector.<Rectangle>;
      
      private var _batchCacheExclusions:Vector.<DisplayObject>;
      
      private var _batchProcessor:BatchProcessor;
      
      private var _batchProcessorCurr:BatchProcessor;
      
      private var _batchProcessorPrev:BatchProcessor;
      
      private var _batchProcessorSpec:BatchProcessor;
      
      private var _actualRenderTarget:TextureBase;
      
      private var _actualRenderTargetOptions:uint;
      
      private var _actualCulling:String;
      
      private var _actualBlendMode:String;
      
      private var _actualDepthMask:Boolean;
      
      private var _actualDepthTest:String;
      
      private var _backBufferWidth:Number;
      
      private var _backBufferHeight:Number;
      
      private var _backBufferScaleFactor:Number;
      
      private var _state:RenderState;
      
      private var _stateStack:Vector.<RenderState>;
      
      private var _stateStackPos:int;
      
      private var _stateStackLength:int;
      
      public function Painter(stage3D:Stage3D)
      {
         super();
         this._stage3D = stage3D;
         this._stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated,false,40,true);
         this._context = this._stage3D.context3D;
         this._shareContext = Boolean(this._context) && this._context.driverInfo != "Disposed";
         this._backBufferWidth = this._context ? Number(this._context.backBufferWidth) : 0;
         this._backBufferHeight = this._context ? Number(this._context.backBufferHeight) : 0;
         this._backBufferScaleFactor = this._pixelSize = 1;
         this._stencilReferenceValues = new Dictionary(true);
         this._clipRectStack = new Vector.<Rectangle>(0);
         this._batchProcessorCurr = new BatchProcessor();
         this._batchProcessorCurr.onBatchComplete = this.drawBatch;
         this._batchProcessorPrev = new BatchProcessor();
         this._batchProcessorPrev.onBatchComplete = this.drawBatch;
         this._batchProcessorSpec = new BatchProcessor();
         this._batchProcessorSpec.onBatchComplete = this.drawBatch;
         this._batchProcessor = this._batchProcessorCurr;
         this._batchCacheExclusions = new Vector.<DisplayObject>();
         this._state = new RenderState();
         this._state.onDrawRequired = this.finishMeshBatch;
         this._stateStack = new Vector.<RenderState>(0);
         this._stateStackPos = -1;
         this._stateStackLength = 0;
      }
      
      public function dispose() : void
      {
         this._batchProcessorCurr.dispose();
         this._batchProcessorPrev.dispose();
         this._batchProcessorSpec.dispose();
         if(!this._shareContext)
         {
            this._context.dispose(false);
            sSharedData = new Dictionary();
         }
      }
      
      public function requestContext3D(renderMode:String, profile:*) : void
      {
         RenderUtil.requestContext3D(this._stage3D,renderMode,profile);
      }
      
      private function onContextCreated(event:Object) : void
      {
         this._context = this._stage3D.context3D;
         this._context.enableErrorChecking = this._enableErrorChecking;
      }
      
      public function configureBackBuffer(viewPort:Rectangle, contentScaleFactor:Number, antiAlias:int, enableDepthAndStencil:Boolean) : void
      {
         if(!this._shareContext)
         {
            enableDepthAndStencil &&= Boolean(SystemUtil.supportsDepthAndStencil);
            if(this._context.profile == "baselineConstrained")
            {
               this._context.configureBackBuffer(32,32,antiAlias,enableDepthAndStencil);
            }
            if(viewPort.width * contentScaleFactor > this._context.maxBackBufferWidth || viewPort.height * contentScaleFactor > this._context.maxBackBufferHeight)
            {
               contentScaleFactor = 1;
            }
            this._stage3D.x = viewPort.x;
            this._stage3D.y = viewPort.y;
            this._context.configureBackBuffer(viewPort.width,viewPort.height,antiAlias,enableDepthAndStencil,contentScaleFactor != 1);
         }
         this._backBufferWidth = viewPort.width;
         this._backBufferHeight = viewPort.height;
         this._backBufferScaleFactor = contentScaleFactor;
      }
      
      public function registerProgram(name:String, program:Program) : void
      {
         this.deleteProgram(name);
         this.programs[name] = program;
      }
      
      public function deleteProgram(name:String) : void
      {
         var program:Program = this.getProgram(name);
         if(program)
         {
            program.dispose();
            delete this.programs[name];
         }
      }
      
      public function getProgram(name:String) : Program
      {
         return this.programs[name] as Program;
      }
      
      public function hasProgram(name:String) : Boolean
      {
         return name in this.programs;
      }
      
      public function pushState(token:BatchToken = null) : void
      {
         ++this._stateStackPos;
         if(this._stateStackLength < this._stateStackPos + 1)
         {
            this._stateStack[this._stateStackLength++] = new RenderState();
         }
         if(token)
         {
            this._batchProcessor.fillToken(token);
         }
         this._stateStack[this._stateStackPos].copyFrom(this._state);
      }
      
      public function setStateTo(transformationMatrix:Matrix, alphaFactor:Number = 1, blendMode:String = "auto") : void
      {
         if(transformationMatrix)
         {
            MatrixUtil.prependMatrix(this._state._modelviewMatrix,transformationMatrix);
         }
         if(alphaFactor != 1)
         {
            this._state._alpha *= alphaFactor;
         }
         if(blendMode != BlendMode.AUTO)
         {
            this._state.blendMode = blendMode;
         }
      }
      
      public function popState(token:BatchToken = null) : void
      {
         if(this._stateStackPos < 0)
         {
            throw new IllegalOperationError("Cannot pop empty state stack");
         }
         this._state.copyFrom(this._stateStack[this._stateStackPos]);
         --this._stateStackPos;
         if(token)
         {
            this._batchProcessor.fillToken(token);
         }
      }
      
      public function restoreState() : void
      {
         if(this._stateStackPos < 0)
         {
            throw new IllegalOperationError("Cannot restore from empty state stack");
         }
         this._state.copyFrom(this._stateStack[this._stateStackPos]);
      }
      
      public function fillToken(token:BatchToken) : void
      {
         if(token)
         {
            this._batchProcessor.fillToken(token);
         }
      }
      
      public function drawMask(mask:DisplayObject, maskee:DisplayObject = null) : void
      {
         if(this._context == null)
         {
            return;
         }
         this.finishMeshBatch();
         if(this.isRectangularMask(mask,maskee,sMatrix))
         {
            mask.getBounds(mask,sClipRect);
            RectangleUtil.getBounds(sClipRect,sMatrix,sClipRect);
            this.pushClipRect(sClipRect);
         }
         else
         {
            if(Boolean(maskee) && maskee.maskInverted)
            {
               this._context.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK,Context3DCompareMode.ALWAYS,Context3DStencilAction.KEEP,Context3DStencilAction.DECREMENT_SATURATE);
               this.renderMask(mask);
            }
            else
            {
               this._context.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK,Context3DCompareMode.EQUAL,Context3DStencilAction.KEEP,Context3DStencilAction.INCREMENT_SATURATE);
               this.renderMask(mask);
               ++this.stencilReferenceValue;
            }
            this._context.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK,Context3DCompareMode.EQUAL);
         }
         this.excludeFromCache(maskee);
      }
      
      public function eraseMask(mask:DisplayObject, maskee:DisplayObject = null) : void
      {
         if(this._context == null)
         {
            return;
         }
         this.finishMeshBatch();
         if(this.isRectangularMask(mask,maskee,sMatrix))
         {
            this.popClipRect();
         }
         else
         {
            if(Boolean(maskee) && maskee.maskInverted)
            {
               this._context.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK,Context3DCompareMode.ALWAYS,Context3DStencilAction.KEEP,Context3DStencilAction.INCREMENT_SATURATE);
               this.renderMask(mask);
            }
            else
            {
               this._context.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK,Context3DCompareMode.EQUAL,Context3DStencilAction.KEEP,Context3DStencilAction.DECREMENT_SATURATE);
               this.renderMask(mask);
               --this.stencilReferenceValue;
            }
            this._context.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK,Context3DCompareMode.EQUAL);
         }
      }
      
      private function renderMask(mask:DisplayObject) : void
      {
         var matrix:Matrix = null;
         var matrix3D:Matrix3D = null;
         var wasCacheEnabled:Boolean = this.cacheEnabled;
         this.pushState();
         this.cacheEnabled = false;
         this._state.depthTest = Context3DCompareMode.NEVER;
         if(mask.stage)
         {
            this._state.setModelviewMatricesToIdentity();
            if(mask.is3D)
            {
               matrix3D = mask.getTransformationMatrix3D(null,sMatrix3D);
            }
            else
            {
               matrix = mask.getTransformationMatrix(null,sMatrix);
            }
         }
         else if(mask.is3D)
         {
            matrix3D = mask.transformationMatrix3D;
         }
         else
         {
            matrix = mask.transformationMatrix;
         }
         if(matrix3D)
         {
            this._state.transformModelviewMatrix3D(matrix3D);
         }
         else
         {
            this._state.transformModelviewMatrix(matrix);
         }
         mask.render(this);
         this.finishMeshBatch();
         this.cacheEnabled = wasCacheEnabled;
         this.popState();
      }
      
      private function pushClipRect(clipRect:Rectangle) : void
      {
         var stack:Vector.<Rectangle> = this._clipRectStack;
         var stackLength:uint = stack.length;
         var intersection:Rectangle = Pool.getRectangle();
         if(stackLength)
         {
            RectangleUtil.intersect(stack[stackLength - 1],clipRect,intersection);
         }
         else
         {
            intersection.copyFrom(clipRect);
         }
         stack[stackLength] = intersection;
         this._state.clipRect = intersection;
      }
      
      private function popClipRect() : void
      {
         var stack:Vector.<Rectangle> = this._clipRectStack;
         var stackLength:uint = stack.length;
         if(stackLength == 0)
         {
            throw new Error("Trying to pop from empty clip rectangle stack");
         }
         stackLength--;
         Pool.putRectangle(stack.pop());
         this._state.clipRect = stackLength ? stack[stackLength - 1] : null;
      }
      
      private function isRectangularMask(mask:DisplayObject, maskee:DisplayObject, out:Matrix) : Boolean
      {
         var quad:Quad = mask as Quad;
         var isInverted:Boolean = Boolean(maskee) && maskee.maskInverted;
         var is3D:Boolean = mask.is3D || maskee && maskee.is3D && mask.stage == null;
         if(Boolean(quad && !isInverted) && Boolean(!is3D) && quad.texture == null)
         {
            if(mask.stage)
            {
               mask.getTransformationMatrix(null,out);
            }
            else
            {
               out.copyFrom(mask.transformationMatrix);
               out.concat(this._state.modelviewMatrix);
            }
            return Boolean(MathUtil.isEquivalent(out.a,0)) && Boolean(MathUtil.isEquivalent(out.d,0)) || Boolean(MathUtil.isEquivalent(out.b,0)) && Boolean(MathUtil.isEquivalent(out.c,0));
         }
         return false;
      }
      
      public function batchMesh(mesh:Mesh, subset:MeshSubset = null) : void
      {
         this._batchProcessor.addMesh(mesh,this._state,subset);
      }
      
      public function finishMeshBatch() : void
      {
         this._batchProcessor.finishBatch();
      }
      
      public function finishFrame() : void
      {
         if(this._frameID % 99 == 0)
         {
            this._batchProcessorCurr.trim();
         }
         if(this._frameID % 150 == 0)
         {
            this._batchProcessorSpec.trim();
         }
         this._batchProcessor.finishBatch();
         this._batchProcessor = this._batchProcessorSpec;
         this.processCacheExclusions();
      }
      
      private function processCacheExclusions() : void
      {
         var i:int = 0;
         var length:int = int(this._batchCacheExclusions.length);
         i = 0;
         while(i < length)
         {
            this._batchCacheExclusions[i].excludeFromCache();
            i++;
         }
         this._batchCacheExclusions.length = 0;
      }
      
      public function setupContextDefaults() : void
      {
         this._actualBlendMode = null;
         this._actualCulling = null;
         this._actualDepthMask = false;
         this._actualDepthTest = null;
      }
      
      public function nextFrame() : void
      {
         this._batchProcessor = this.swapBatchProcessors();
         this._batchProcessor.clear();
         this._batchProcessorSpec.clear();
         this.setupContextDefaults();
         this.stencilReferenceValue = DEFAULT_STENCIL_VALUE;
         this._clipRectStack.length = 0;
         this._drawCount = 0;
         this._stateStackPos = -1;
         this._state.reset();
      }
      
      private function swapBatchProcessors() : BatchProcessor
      {
         var tmp:BatchProcessor = this._batchProcessorPrev;
         this._batchProcessorPrev = this._batchProcessorCurr;
         return this._batchProcessorCurr = tmp;
      }
      
      public function drawFromCache(startToken:BatchToken, endToken:BatchToken) : void
      {
         var meshBatch:MeshBatch = null;
         var i:int = 0;
         var subset:MeshSubset = sMeshSubset;
         if(!startToken.equals(endToken))
         {
            this.pushState();
            for(i = startToken.batchID; i <= endToken.batchID; i++)
            {
               meshBatch = this._batchProcessorPrev.getBatchAt(i);
               subset.setTo();
               if(i == startToken.batchID)
               {
                  subset.vertexID = startToken.vertexID;
                  subset.indexID = startToken.indexID;
                  subset.numVertices = meshBatch.numVertices - subset.vertexID;
                  subset.numIndices = meshBatch.numIndices - subset.indexID;
               }
               if(i == endToken.batchID)
               {
                  subset.numVertices = endToken.vertexID - subset.vertexID;
                  subset.numIndices = endToken.indexID - subset.indexID;
               }
               if(subset.numVertices)
               {
                  this._state.alpha = 1;
                  this._state.blendMode = meshBatch.blendMode;
                  this._batchProcessor.addMesh(meshBatch,this._state,subset,true);
               }
            }
            this.popState();
         }
      }
      
      public function excludeFromCache(object:DisplayObject) : void
      {
         if(object)
         {
            this._batchCacheExclusions[this._batchCacheExclusions.length] = object;
         }
      }
      
      private function drawBatch(meshBatch:MeshBatch) : void
      {
         this.pushState();
         this.state.blendMode = meshBatch.blendMode;
         this.state.modelviewMatrix.identity();
         this.state.alpha = 1;
         meshBatch.render(this);
         this.popState();
      }
      
      public function prepareToDraw() : void
      {
         this.applyBlendMode();
         this.applyRenderTarget();
         this.applyClipRect();
         this.applyCulling();
         this.applyDepthTest();
      }
      
      public function clear(rgb:uint = 0, alpha:Number = 0) : void
      {
         this.applyRenderTarget();
         this.stencilReferenceValue = DEFAULT_STENCIL_VALUE;
         RenderUtil.clear(rgb,alpha);
      }
      
      public function present() : void
      {
         this._state.renderTarget = null;
         this._actualRenderTarget = null;
         this._context.present();
      }
      
      private function applyBlendMode() : void
      {
         var blendMode:String = this._state.blendMode;
         if(blendMode != this._actualBlendMode)
         {
            BlendMode.get(this._state.blendMode).activate();
            this._actualBlendMode = blendMode;
         }
      }
      
      private function applyCulling() : void
      {
         var culling:String = this._state.culling;
         if(culling != this._actualCulling)
         {
            this._context.setCulling(culling);
            this._actualCulling = culling;
         }
      }
      
      private function applyDepthTest() : void
      {
         var depthMask:Boolean = Boolean(this._state.depthMask);
         var depthTest:String = this._state.depthTest;
         if(depthMask != this._actualDepthMask || depthTest != this._actualDepthTest)
         {
            this._context.setDepthTest(depthMask,depthTest);
            this._actualDepthMask = depthMask;
            this._actualDepthTest = depthTest;
         }
      }
      
      private function applyRenderTarget() : void
      {
         var antiAlias:int = 0;
         var depthAndStencil:Boolean = false;
         var target:TextureBase = this._state.renderTargetBase;
         var options:uint = uint(this._state.renderTargetOptions);
         if(target != this._actualRenderTarget || options != this._actualRenderTargetOptions)
         {
            if(target)
            {
               antiAlias = int(this._state.renderTargetAntiAlias);
               depthAndStencil = Boolean(this._state.renderTargetSupportsDepthAndStencil);
               this._context.setRenderToTexture(target,depthAndStencil,antiAlias);
            }
            else
            {
               this._context.setRenderToBackBuffer();
            }
            this._context.setStencilReferenceValue(this.stencilReferenceValue);
            this._actualRenderTargetOptions = options;
            this._actualRenderTarget = target;
         }
      }
      
      private function applyClipRect() : void
      {
         var width:int = 0;
         var height:int = 0;
         var projMatrix:Matrix3D = null;
         var renderTarget:Texture = null;
         var clipRect:Rectangle = this._state.clipRect;
         if(clipRect)
         {
            projMatrix = this._state.projectionMatrix3D;
            renderTarget = this._state.renderTarget;
            if(renderTarget)
            {
               width = renderTarget.root.nativeWidth;
               height = renderTarget.root.nativeHeight;
            }
            else
            {
               width = int(this._backBufferWidth);
               height = int(this._backBufferHeight);
            }
            MatrixUtil.transformCoords3D(projMatrix,clipRect.x,clipRect.y,0,sPoint3D);
            sPoint3D.project();
            sClipRect.x = (sPoint3D.x * 0.5 + 0.5) * width;
            sClipRect.y = (0.5 - sPoint3D.y * 0.5) * height;
            MatrixUtil.transformCoords3D(projMatrix,clipRect.right,clipRect.bottom,0,sPoint3D);
            sPoint3D.project();
            sClipRect.right = (sPoint3D.x * 0.5 + 0.5) * width;
            sClipRect.bottom = (0.5 - sPoint3D.y * 0.5) * height;
            sBufferRect.setTo(0,0,width,height);
            RectangleUtil.intersect(sClipRect,sBufferRect,sScissorRect);
            if(sScissorRect.width < 1 || sScissorRect.height < 1)
            {
               sScissorRect.setTo(0,0,1,1);
            }
            this._context.setScissorRectangle(sScissorRect);
         }
         else
         {
            this._context.setScissorRectangle(null);
         }
      }
      
      public function get drawCount() : int
      {
         return this._drawCount;
      }
      
      public function set drawCount(value:int) : void
      {
         this._drawCount = value;
      }
      
      public function get stencilReferenceValue() : uint
      {
         var key:Object = this._state.renderTarget ? this._state.renderTargetBase : this;
         if(key in this._stencilReferenceValues)
         {
            return this._stencilReferenceValues[key];
         }
         return 0;
      }
      
      public function set stencilReferenceValue(value:uint) : void
      {
         var key:Object = this._state.renderTarget ? this._state.renderTargetBase : this;
         this._stencilReferenceValues[key] = value;
         if(this.contextValid)
         {
            this._context.setStencilReferenceValue(value);
         }
      }
      
      public function get cacheEnabled() : Boolean
      {
         return this._batchProcessor == this._batchProcessorCurr;
      }
      
      public function set cacheEnabled(value:Boolean) : void
      {
         if(value != this.cacheEnabled)
         {
            this.finishMeshBatch();
            if(value)
            {
               this._batchProcessor = this._batchProcessorCurr;
            }
            else
            {
               this._batchProcessor = this._batchProcessorSpec;
            }
         }
      }
      
      public function get state() : RenderState
      {
         return this._state;
      }
      
      public function get stage3D() : Stage3D
      {
         return this._stage3D;
      }
      
      public function get context() : Context3D
      {
         return this._context;
      }
      
      public function set frameID(value:uint) : void
      {
         this._frameID = value;
      }
      
      public function get frameID() : uint
      {
         return this._batchProcessor == this._batchProcessorCurr ? uint(this._frameID) : 0;
      }
      
      public function get pixelSize() : Number
      {
         return this._pixelSize;
      }
      
      public function set pixelSize(value:Number) : void
      {
         this._pixelSize = value;
      }
      
      public function get shareContext() : Boolean
      {
         return this._shareContext;
      }
      
      public function set shareContext(value:Boolean) : void
      {
         this._shareContext = value;
      }
      
      public function get enableErrorChecking() : Boolean
      {
         return this._enableErrorChecking;
      }
      
      public function set enableErrorChecking(value:Boolean) : void
      {
         this._enableErrorChecking = value;
         if(this._context)
         {
            this._context.enableErrorChecking = value;
         }
      }
      
      public function get backBufferWidth() : int
      {
         return this._backBufferWidth;
      }
      
      public function get backBufferHeight() : int
      {
         return this._backBufferHeight;
      }
      
      public function get backBufferScaleFactor() : Number
      {
         return this._backBufferScaleFactor;
      }
      
      public function get contextValid() : Boolean
      {
         var driverInfo:String = null;
         if(this._context)
         {
            driverInfo = this._context.driverInfo;
            return driverInfo != null && driverInfo != "" && driverInfo != "Disposed";
         }
         return false;
      }
      
      public function get profile() : String
      {
         if(this._context)
         {
            return this._context.profile;
         }
         return null;
      }
      
      public function get sharedData() : Dictionary
      {
         var data:Dictionary = sSharedData[this.stage3D] as Dictionary;
         if(data == null)
         {
            data = new Dictionary();
            sSharedData[this.stage3D] = data;
         }
         return data;
      }
      
      private function get programs() : Dictionary
      {
         var programs:Dictionary = this.sharedData[PROGRAM_DATA_NAME] as Dictionary;
         if(programs == null)
         {
            programs = new Dictionary();
            this.sharedData[PROGRAM_DATA_NAME] = programs;
         }
         return programs;
      }
   }
}

