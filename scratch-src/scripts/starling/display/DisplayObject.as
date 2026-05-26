package starling.display
{
   import flash.display.*;
   import flash.errors.*;
   import flash.geom.*;
   import flash.system.*;
   import flash.ui.*;
   import flash.utils.*;
   import starling.core.*;
   import starling.errors.*;
   import starling.events.*;
   import starling.filters.FragmentFilter;
   import starling.rendering.*;
   import starling.utils.*;
   
   use namespace starling_internal;
   
   public class DisplayObject extends EventDispatcher
   {
      
      private static var sAncestors:Vector.<starling.display.DisplayObject> = new Vector.<starling.display.DisplayObject>(0);
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperPoint3D:Vector3D = new Vector3D();
      
      private static var sHelperPointAlt3D:Vector3D = new Vector3D();
      
      private static var sHelperRect:Rectangle = new Rectangle();
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperMatrixAlt:Matrix = new Matrix();
      
      private static var sHelperMatrix3D:Matrix3D = new Matrix3D();
      
      private static var sHelperMatrixAlt3D:Matrix3D = new Matrix3D();
      
      private static var sMaskWarningShown:Boolean = false;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _pivotX:Number;
      
      private var _pivotY:Number;
      
      private var _scaleX:Number;
      
      private var _scaleY:Number;
      
      private var _skewX:Number;
      
      private var _skewY:Number;
      
      private var _rotation:Number;
      
      private var _alpha:Number;
      
      private var _visible:Boolean;
      
      private var _touchable:Boolean;
      
      private var _blendMode:String;
      
      private var _name:String;
      
      private var _useHandCursor:Boolean;
      
      private var _transformationMatrix:Matrix;
      
      private var _transformationMatrix3D:Matrix3D;
      
      private var _transformationChanged:Boolean;
      
      private var _is3D:Boolean;
      
      private var _maskee:starling.display.DisplayObject;
      
      private var _maskInverted:Boolean = false;
      
      internal var _parent:starling.display.DisplayObjectContainer;
      
      internal var _lastParentOrSelfChangeFrameID:uint;
      
      internal var _lastChildChangeFrameID:uint;
      
      internal var _tokenFrameID:uint;
      
      internal var _pushToken:BatchToken = new BatchToken();
      
      internal var _popToken:BatchToken = new BatchToken();
      
      internal var _hasVisibleArea:Boolean;
      
      internal var _filter:FragmentFilter;
      
      internal var _mask:starling.display.DisplayObject;
      
      public function DisplayObject()
      {
         super();
         if(Boolean(Capabilities.isDebugger) && getQualifiedClassName(this) == "starling.display::DisplayObject")
         {
            throw new AbstractClassError();
         }
         this._x = this._y = this._pivotX = this._pivotY = this._rotation = this._skewX = this._skewY = 0;
         this._scaleX = this._scaleY = this._alpha = 1;
         this._visible = this._touchable = this._hasVisibleArea = true;
         this._blendMode = BlendMode.AUTO;
         this._transformationMatrix = new Matrix();
      }
      
      private static function findCommonParent(object1:starling.display.DisplayObject, object2:starling.display.DisplayObject) : starling.display.DisplayObject
      {
         var currentObject:starling.display.DisplayObject = object1;
         while(currentObject)
         {
            sAncestors[sAncestors.length] = currentObject;
            currentObject = currentObject._parent;
         }
         currentObject = object2;
         while(Boolean(currentObject) && sAncestors.indexOf(currentObject) == -1)
         {
            currentObject = currentObject._parent;
         }
         sAncestors.length = 0;
         if(currentObject)
         {
            return currentObject;
         }
         throw new ArgumentError("Object not connected to target");
      }
      
      public function dispose() : void
      {
         if(this._filter)
         {
            this._filter.dispose();
         }
         if(this._mask)
         {
            this._mask.dispose();
         }
         this.removeEventListeners();
         this.mask = null;
      }
      
      public function removeFromParent(dispose:Boolean = false) : void
      {
         if(this._parent)
         {
            this._parent.removeChild(this,dispose);
         }
         else if(dispose)
         {
            this.dispose();
         }
      }
      
      public function getTransformationMatrix(targetSpace:starling.display.DisplayObject, out:Matrix = null) : Matrix
      {
         var commonParent:starling.display.DisplayObject = null;
         var currentObject:starling.display.DisplayObject = null;
         if(out)
         {
            out.identity();
         }
         else
         {
            out = new Matrix();
         }
         if(targetSpace == this)
         {
            return out;
         }
         if(targetSpace == this._parent || targetSpace == null && this._parent == null)
         {
            out.copyFrom(this.transformationMatrix);
            return out;
         }
         if(targetSpace == null || targetSpace == this.base)
         {
            currentObject = this;
            while(currentObject != targetSpace)
            {
               out.concat(currentObject.transformationMatrix);
               currentObject = currentObject._parent;
            }
            return out;
         }
         if(targetSpace._parent == this)
         {
            targetSpace.getTransformationMatrix(this,out);
            out.invert();
            return out;
         }
         commonParent = findCommonParent(this,targetSpace);
         currentObject = this;
         while(currentObject != commonParent)
         {
            out.concat(currentObject.transformationMatrix);
            currentObject = currentObject._parent;
         }
         if(commonParent == targetSpace)
         {
            return out;
         }
         sHelperMatrix.identity();
         currentObject = targetSpace;
         while(currentObject != commonParent)
         {
            sHelperMatrix.concat(currentObject.transformationMatrix);
            currentObject = currentObject._parent;
         }
         sHelperMatrix.invert();
         out.concat(sHelperMatrix);
         return out;
      }
      
      public function getBounds(targetSpace:starling.display.DisplayObject, out:Rectangle = null) : Rectangle
      {
         throw new AbstractMethodError();
      }
      
      public function hitTest(localPoint:Point) : starling.display.DisplayObject
      {
         if(!this._visible || !this._touchable)
         {
            return null;
         }
         if(Boolean(this._mask) && !this.hitTestMask(localPoint))
         {
            return null;
         }
         if(this.getBounds(this,sHelperRect).containsPoint(localPoint))
         {
            return this;
         }
         return null;
      }
      
      public function hitTestMask(localPoint:Point) : Boolean
      {
         var helperPoint:Point = null;
         var isMaskHit:Boolean = false;
         if(this._mask)
         {
            if(this._mask.stage)
            {
               this.getTransformationMatrix(this._mask,sHelperMatrixAlt);
            }
            else
            {
               sHelperMatrixAlt.copyFrom(this._mask.transformationMatrix);
               sHelperMatrixAlt.invert();
            }
            helperPoint = localPoint == sHelperPoint ? new Point() : sHelperPoint;
            MatrixUtil.transformPoint(sHelperMatrixAlt,localPoint,helperPoint);
            isMaskHit = this._mask.hitTest(helperPoint) != null;
            return this._maskInverted ? !isMaskHit : isMaskHit;
         }
         return true;
      }
      
      public function localToGlobal(localPoint:Point, out:Point = null) : Point
      {
         if(this.is3D)
         {
            sHelperPoint3D.setTo(localPoint.x,localPoint.y,0);
            return this.local3DToGlobal(sHelperPoint3D,out);
         }
         this.getTransformationMatrix(this.base,sHelperMatrixAlt);
         return MatrixUtil.transformPoint(sHelperMatrixAlt,localPoint,out);
      }
      
      public function globalToLocal(globalPoint:Point, out:Point = null) : Point
      {
         if(this.is3D)
         {
            this.globalToLocal3D(globalPoint,sHelperPoint3D);
            this.stage.getCameraPosition(this,sHelperPointAlt3D);
            return MathUtil.intersectLineWithXYPlane(sHelperPointAlt3D,sHelperPoint3D,out);
         }
         this.getTransformationMatrix(this.base,sHelperMatrixAlt);
         sHelperMatrixAlt.invert();
         return MatrixUtil.transformPoint(sHelperMatrixAlt,globalPoint,out);
      }
      
      public function render(painter:Painter) : void
      {
         throw new AbstractMethodError();
      }
      
      public function alignPivot(horizontalAlign:String = "center", verticalAlign:String = "center") : void
      {
         var bounds:Rectangle = this.getBounds(this,sHelperRect);
         if(horizontalAlign == Align.LEFT)
         {
            this.pivotX = bounds.x;
         }
         else if(horizontalAlign == Align.CENTER)
         {
            this.pivotX = bounds.x + bounds.width / 2;
         }
         else
         {
            if(horizontalAlign != Align.RIGHT)
            {
               throw new ArgumentError("Invalid horizontal alignment: " + horizontalAlign);
            }
            this.pivotX = bounds.x + bounds.width;
         }
         if(verticalAlign == Align.TOP)
         {
            this.pivotY = bounds.y;
         }
         else if(verticalAlign == Align.CENTER)
         {
            this.pivotY = bounds.y + bounds.height / 2;
         }
         else
         {
            if(verticalAlign != Align.BOTTOM)
            {
               throw new ArgumentError("Invalid vertical alignment: " + verticalAlign);
            }
            this.pivotY = bounds.y + bounds.height;
         }
      }
      
      public function drawToBitmapData(out:BitmapData = null, color:uint = 0, alpha:Number = 0) : BitmapData
      {
         var projectionX:Number = NaN;
         var projectionY:Number = NaN;
         var bounds:Rectangle = null;
         var painter:Painter = Starling.painter;
         var stage:starling.display.Stage = Starling.current.stage;
         var viewPort:Rectangle = Starling.current.viewPort;
         var stageWidth:Number = stage.stageWidth;
         var stageHeight:Number = stage.stageHeight;
         var scaleX:Number = viewPort.width / stageWidth;
         var scaleY:Number = viewPort.height / stageHeight;
         var backBufferScale:Number = painter.backBufferScaleFactor;
         if(this is Stage)
         {
            projectionX = viewPort.x < 0 ? -viewPort.x / scaleX : 0;
            projectionY = viewPort.y < 0 ? -viewPort.y / scaleY : 0;
            out ||= new BitmapData(painter.backBufferWidth * backBufferScale,painter.backBufferHeight * backBufferScale);
         }
         else
         {
            bounds = this.getBounds(this._parent,sHelperRect);
            projectionX = bounds.x;
            projectionY = bounds.y;
            out ||= new BitmapData(Math.ceil(bounds.width * scaleX * backBufferScale),Math.ceil(bounds.height * scaleY * backBufferScale));
         }
         color = uint(Color.multiply(color,alpha));
         painter.clear(color,alpha);
         painter.pushState();
         painter.setupContextDefaults();
         painter.state.renderTarget = null;
         painter.state.setModelviewMatricesToIdentity();
         painter.setStateTo(this.transformationMatrix);
         painter.state.setProjectionMatrix(projectionX,projectionY,painter.backBufferWidth / scaleX,painter.backBufferHeight / scaleY,stageWidth,stageHeight,stage.cameraPosition);
         this.render(painter);
         painter.finishMeshBatch();
         painter.context.drawToBitmapData(out);
         painter.popState();
         return out;
      }
      
      public function getTransformationMatrix3D(targetSpace:starling.display.DisplayObject, out:Matrix3D = null) : Matrix3D
      {
         var commonParent:starling.display.DisplayObject = null;
         var currentObject:starling.display.DisplayObject = null;
         if(out)
         {
            out.identity();
         }
         else
         {
            out = new Matrix3D();
         }
         if(targetSpace == this)
         {
            return out;
         }
         if(targetSpace == this._parent || targetSpace == null && this._parent == null)
         {
            out.copyFrom(this.transformationMatrix3D);
            return out;
         }
         if(targetSpace == null || targetSpace == this.base)
         {
            currentObject = this;
            while(currentObject != targetSpace)
            {
               out.append(currentObject.transformationMatrix3D);
               currentObject = currentObject._parent;
            }
            return out;
         }
         if(targetSpace._parent == this)
         {
            targetSpace.getTransformationMatrix3D(this,out);
            out.invert();
            return out;
         }
         commonParent = findCommonParent(this,targetSpace);
         currentObject = this;
         while(currentObject != commonParent)
         {
            out.append(currentObject.transformationMatrix3D);
            currentObject = currentObject._parent;
         }
         if(commonParent == targetSpace)
         {
            return out;
         }
         sHelperMatrix3D.identity();
         currentObject = targetSpace;
         while(currentObject != commonParent)
         {
            sHelperMatrix3D.append(currentObject.transformationMatrix3D);
            currentObject = currentObject._parent;
         }
         sHelperMatrix3D.invert();
         out.append(sHelperMatrix3D);
         return out;
      }
      
      public function local3DToGlobal(localPoint:Vector3D, out:Point = null) : Point
      {
         var stage:starling.display.Stage = this.stage;
         if(stage == null)
         {
            throw new IllegalOperationError("Object not connected to stage");
         }
         this.getTransformationMatrix3D(stage,sHelperMatrixAlt3D);
         MatrixUtil.transformPoint3D(sHelperMatrixAlt3D,localPoint,sHelperPoint3D);
         return MathUtil.intersectLineWithXYPlane(stage.cameraPosition,sHelperPoint3D,out);
      }
      
      public function globalToLocal3D(globalPoint:Point, out:Vector3D = null) : Vector3D
      {
         var stage:starling.display.Stage = this.stage;
         if(stage == null)
         {
            throw new IllegalOperationError("Object not connected to stage");
         }
         this.getTransformationMatrix3D(stage,sHelperMatrixAlt3D);
         sHelperMatrixAlt3D.invert();
         return MatrixUtil.transformCoords3D(sHelperMatrixAlt3D,globalPoint.x,globalPoint.y,0,out);
      }
      
      starling_internal function setParent(value:starling.display.DisplayObjectContainer) : void
      {
         var ancestor:starling.display.DisplayObject = value;
         while(ancestor != this && ancestor != null)
         {
            ancestor = ancestor._parent;
         }
         if(ancestor == this)
         {
            throw new ArgumentError("An object cannot be added as a child to itself or one " + "of its children (or children\'s children, etc.)");
         }
         this._parent = value;
      }
      
      internal function setIs3D(value:Boolean) : void
      {
         this._is3D = value;
      }
      
      internal function get isMask() : Boolean
      {
         return this._maskee != null;
      }
      
      public function setRequiresRedraw() : void
      {
         var parent:starling.display.DisplayObject = this._parent || this._maskee;
         var frameID:int = int(Starling.frameID);
         this._lastParentOrSelfChangeFrameID = frameID;
         this._hasVisibleArea = this._alpha != 0 && Boolean(this._visible) && this._maskee == null && this._scaleX != 0 && this._scaleY != 0;
         while(Boolean(parent) && parent._lastChildChangeFrameID != frameID)
         {
            parent._lastChildChangeFrameID = frameID;
            parent = parent._parent || parent._maskee;
         }
      }
      
      public function get requiresRedraw() : Boolean
      {
         var frameID:uint = uint(Starling.frameID);
         return this._lastParentOrSelfChangeFrameID == frameID || this._lastChildChangeFrameID == frameID;
      }
      
      starling_internal function excludeFromCache() : void
      {
         var object:starling.display.DisplayObject = this;
         var max:uint = 4294967295;
         while(Boolean(object) && object._tokenFrameID != max)
         {
            object._tokenFrameID = max;
            object = object._parent;
         }
      }
      
      starling_internal function setTransformationChanged() : void
      {
         this._transformationChanged = true;
         this.setRequiresRedraw();
      }
      
      starling_internal function updateTransformationMatrices(x:Number, y:Number, pivotX:Number, pivotY:Number, scaleX:Number, scaleY:Number, skewX:Number, skewY:Number, rotation:Number, out:Matrix, out3D:Matrix3D) : void
      {
         var cos:Number = NaN;
         var sin:Number = NaN;
         var a:Number = NaN;
         var b:Number = NaN;
         var c:Number = NaN;
         var d:Number = NaN;
         var tx:Number = NaN;
         var ty:Number = NaN;
         if(skewX == 0 && skewY == 0)
         {
            if(rotation == 0)
            {
               out.setTo(scaleX,0,0,scaleY,x - pivotX * scaleX,y - pivotY * scaleY);
            }
            else
            {
               cos = Math.cos(rotation);
               sin = Math.sin(rotation);
               a = scaleX * cos;
               b = scaleX * sin;
               c = scaleY * -sin;
               d = scaleY * cos;
               tx = x - pivotX * a - pivotY * c;
               ty = y - pivotX * b - pivotY * d;
               out.setTo(a,b,c,d,tx,ty);
            }
         }
         else
         {
            out.identity();
            out.scale(scaleX,scaleY);
            MatrixUtil.skew(out,skewX,skewY);
            out.rotate(rotation);
            out.translate(x,y);
            if(pivotX != 0 || pivotY != 0)
            {
               out.tx = x - out.a * pivotX - out.c * pivotY;
               out.ty = y - out.b * pivotX - out.d * pivotY;
            }
         }
         if(out3D)
         {
            MatrixUtil.convertTo3D(out,out3D);
         }
      }
      
      override public function dispatchEvent(event:Event) : void
      {
         if(event.type == Event.REMOVED_FROM_STAGE && this.stage == null)
         {
            return;
         }
         super.dispatchEvent(event);
      }
      
      override public function addEventListener(type:String, listener:Function) : void
      {
         if(type == Event.ENTER_FRAME && !hasEventListener(type))
         {
            this.addEventListener(Event.ADDED_TO_STAGE,this.addEnterFrameListenerToStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE,this.removeEnterFrameListenerFromStage);
            if(this.stage)
            {
               this.addEnterFrameListenerToStage();
            }
         }
         super.addEventListener(type,listener);
      }
      
      override public function removeEventListener(type:String, listener:Function) : void
      {
         super.removeEventListener(type,listener);
         if(type == Event.ENTER_FRAME && !hasEventListener(type))
         {
            this.removeEventListener(Event.ADDED_TO_STAGE,this.addEnterFrameListenerToStage);
            this.removeEventListener(Event.REMOVED_FROM_STAGE,this.removeEnterFrameListenerFromStage);
            this.removeEnterFrameListenerFromStage();
         }
      }
      
      override public function removeEventListeners(type:String = null) : void
      {
         if((type == null || type == Event.ENTER_FRAME) && hasEventListener(Event.ENTER_FRAME))
         {
            this.removeEventListener(Event.ADDED_TO_STAGE,this.addEnterFrameListenerToStage);
            this.removeEventListener(Event.REMOVED_FROM_STAGE,this.removeEnterFrameListenerFromStage);
            this.removeEnterFrameListenerFromStage();
         }
         super.removeEventListeners(type);
      }
      
      private function addEnterFrameListenerToStage() : void
      {
         Starling.current.stage.addEnterFrameListener(this);
      }
      
      private function removeEnterFrameListenerFromStage() : void
      {
         Starling.current.stage.removeEnterFrameListener(this);
      }
      
      public function get transformationMatrix() : Matrix
      {
         if(this._transformationChanged)
         {
            this._transformationChanged = false;
            if(this._transformationMatrix3D == null && Boolean(this._is3D))
            {
               this._transformationMatrix3D = new Matrix3D();
            }
            this.updateTransformationMatrices(this._x,this._y,this._pivotX,this._pivotY,this._scaleX,this._scaleY,this._skewX,this._skewY,this._rotation,this._transformationMatrix,this._transformationMatrix3D);
         }
         return this._transformationMatrix;
      }
      
      public function set transformationMatrix(matrix:Matrix) : void
      {
         var PI_Q:Number = Math.PI / 4;
         this.setRequiresRedraw();
         this._transformationChanged = false;
         this._transformationMatrix.copyFrom(matrix);
         this._pivotX = this._pivotY = 0;
         this._x = matrix.tx;
         this._y = matrix.ty;
         this._skewX = Math.atan(-matrix.c / matrix.d);
         this._skewY = Math.atan(matrix.b / matrix.a);
         if(this._skewX != this._skewX)
         {
            this._skewX = 0;
         }
         if(this._skewY != this._skewY)
         {
            this._skewY = 0;
         }
         this._scaleY = this._skewX > -PI_Q && this._skewX < PI_Q ? matrix.d / Math.cos(this._skewX) : -matrix.c / Math.sin(this._skewX);
         this._scaleX = this._skewY > -PI_Q && this._skewY < PI_Q ? matrix.a / Math.cos(this._skewY) : matrix.b / Math.sin(this._skewY);
         if(MathUtil.isEquivalent(this._skewX,this._skewY))
         {
            this._rotation = this._skewX;
            this._skewX = this._skewY = 0;
         }
         else
         {
            this._rotation = 0;
         }
      }
      
      public function get transformationMatrix3D() : Matrix3D
      {
         if(this._transformationMatrix3D == null)
         {
            this._transformationMatrix3D = MatrixUtil.convertTo3D(this._transformationMatrix);
         }
         if(this._transformationChanged)
         {
            this._transformationChanged = false;
            this.updateTransformationMatrices(this._x,this._y,this._pivotX,this._pivotY,this._scaleX,this._scaleY,this._skewX,this._skewY,this._rotation,this._transformationMatrix,this._transformationMatrix3D);
         }
         return this._transformationMatrix3D;
      }
      
      public function get is3D() : Boolean
      {
         return this._is3D;
      }
      
      public function get useHandCursor() : Boolean
      {
         return this._useHandCursor;
      }
      
      public function set useHandCursor(value:Boolean) : void
      {
         if(value == this._useHandCursor)
         {
            return;
         }
         this._useHandCursor = value;
         if(this._useHandCursor)
         {
            this.addEventListener(TouchEvent.TOUCH,this.onTouch);
         }
         else
         {
            this.removeEventListener(TouchEvent.TOUCH,this.onTouch);
         }
      }
      
      private function onTouch(event:TouchEvent) : void
      {
         Mouse.cursor = event.interactsWith(this) ? MouseCursor.BUTTON : MouseCursor.AUTO;
      }
      
      public function get bounds() : Rectangle
      {
         return this.getBounds(this._parent);
      }
      
      public function get width() : Number
      {
         return this.getBounds(this._parent,sHelperRect).width;
      }
      
      public function set width(value:Number) : void
      {
         var actualWidth:Number = NaN;
         var scaleIsNaN:Boolean = this._scaleX != this._scaleX;
         if(this._scaleX == 0 || scaleIsNaN)
         {
            this.scaleX = 1;
            actualWidth = this.width;
         }
         else
         {
            actualWidth = Math.abs(this.width / this._scaleX);
         }
         if(actualWidth)
         {
            this.scaleX = value / actualWidth;
         }
      }
      
      public function get height() : Number
      {
         return this.getBounds(this._parent,sHelperRect).height;
      }
      
      public function set height(value:Number) : void
      {
         var actualHeight:Number = NaN;
         var scaleIsNaN:Boolean = this._scaleY != this._scaleY;
         if(this._scaleY == 0 || scaleIsNaN)
         {
            this.scaleY = 1;
            actualHeight = this.height;
         }
         else
         {
            actualHeight = Math.abs(this.height / this._scaleY);
         }
         if(actualHeight)
         {
            this.scaleY = value / actualHeight;
         }
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(value:Number) : void
      {
         if(this._x != value)
         {
            this._x = value;
            this.setTransformationChanged();
         }
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(value:Number) : void
      {
         if(this._y != value)
         {
            this._y = value;
            this.setTransformationChanged();
         }
      }
      
      public function get pivotX() : Number
      {
         return this._pivotX;
      }
      
      public function set pivotX(value:Number) : void
      {
         if(this._pivotX != value)
         {
            this._pivotX = value;
            this.setTransformationChanged();
         }
      }
      
      public function get pivotY() : Number
      {
         return this._pivotY;
      }
      
      public function set pivotY(value:Number) : void
      {
         if(this._pivotY != value)
         {
            this._pivotY = value;
            this.setTransformationChanged();
         }
      }
      
      public function get scaleX() : Number
      {
         return this._scaleX;
      }
      
      public function set scaleX(value:Number) : void
      {
         if(this._scaleX != value)
         {
            this._scaleX = value;
            this.setTransformationChanged();
         }
      }
      
      public function get scaleY() : Number
      {
         return this._scaleY;
      }
      
      public function set scaleY(value:Number) : void
      {
         if(this._scaleY != value)
         {
            this._scaleY = value;
            this.setTransformationChanged();
         }
      }
      
      public function get scale() : Number
      {
         return this.scaleX;
      }
      
      public function set scale(value:Number) : void
      {
         this.scaleX = this.scaleY = value;
      }
      
      public function get skewX() : Number
      {
         return this._skewX;
      }
      
      public function set skewX(value:Number) : void
      {
         value = Number(MathUtil.normalizeAngle(value));
         if(this._skewX != value)
         {
            this._skewX = value;
            this.setTransformationChanged();
         }
      }
      
      public function get skewY() : Number
      {
         return this._skewY;
      }
      
      public function set skewY(value:Number) : void
      {
         value = Number(MathUtil.normalizeAngle(value));
         if(this._skewY != value)
         {
            this._skewY = value;
            this.setTransformationChanged();
         }
      }
      
      public function get rotation() : Number
      {
         return this._rotation;
      }
      
      public function set rotation(value:Number) : void
      {
         value = Number(MathUtil.normalizeAngle(value));
         if(this._rotation != value)
         {
            this._rotation = value;
            this.setTransformationChanged();
         }
      }
      
      internal function get isRotated() : Boolean
      {
         return this._rotation != 0 || this._skewX != 0 || this._skewY != 0;
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(value:Number) : void
      {
         if(value != this._alpha)
         {
            this._alpha = value < 0 ? 0 : (value > 1 ? 1 : value);
            this.setRequiresRedraw();
         }
      }
      
      public function get visible() : Boolean
      {
         return this._visible;
      }
      
      public function set visible(value:Boolean) : void
      {
         if(value != this._visible)
         {
            this._visible = value;
            this.setRequiresRedraw();
         }
      }
      
      public function get touchable() : Boolean
      {
         return this._touchable;
      }
      
      public function set touchable(value:Boolean) : void
      {
         this._touchable = value;
      }
      
      public function get blendMode() : String
      {
         return this._blendMode;
      }
      
      public function set blendMode(value:String) : void
      {
         if(value != this._blendMode)
         {
            this._blendMode = value;
            this.setRequiresRedraw();
         }
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get filter() : FragmentFilter
      {
         return this._filter;
      }
      
      public function set filter(value:FragmentFilter) : void
      {
         if(value != this._filter)
         {
            if(this._filter)
            {
               this._filter.setTarget(null);
            }
            if(value)
            {
               value.setTarget(this);
            }
            this._filter = value;
            this.setRequiresRedraw();
         }
      }
      
      public function get mask() : starling.display.DisplayObject
      {
         return this._mask;
      }
      
      public function set mask(value:starling.display.DisplayObject) : void
      {
         if(this._mask != value)
         {
            if(!sMaskWarningShown)
            {
               if(!SystemUtil.supportsDepthAndStencil)
               {
                  trace("[Starling] Full mask support requires \'depthAndStencil\'" + " to be enabled in the application descriptor.");
               }
               sMaskWarningShown = true;
            }
            if(this._mask)
            {
               this._mask._maskee = null;
            }
            if(value)
            {
               value._maskee = this;
               value._hasVisibleArea = false;
            }
            this._mask = value;
            this.setRequiresRedraw();
         }
      }
      
      public function get maskInverted() : Boolean
      {
         return this._maskInverted;
      }
      
      public function set maskInverted(value:Boolean) : void
      {
         this._maskInverted = value;
      }
      
      public function get parent() : starling.display.DisplayObjectContainer
      {
         return this._parent;
      }
      
      public function get base() : starling.display.DisplayObject
      {
         var currentObject:starling.display.DisplayObject = this;
         while(currentObject._parent)
         {
            currentObject = currentObject._parent;
         }
         return currentObject;
      }
      
      public function get root() : starling.display.DisplayObject
      {
         var currentObject:starling.display.DisplayObject = this;
         while(currentObject._parent)
         {
            if(currentObject._parent is Stage)
            {
               return currentObject;
            }
            currentObject = currentObject.parent;
         }
         return null;
      }
      
      public function get stage() : starling.display.Stage
      {
         return this.base as Stage;
      }
   }
}

