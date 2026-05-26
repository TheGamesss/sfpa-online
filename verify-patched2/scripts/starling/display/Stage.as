package starling.display
{
   import flash.errors.*;
   import flash.geom.*;
   import starling.core.*;
   import starling.events.*;
   import starling.filters.FragmentFilter;
   import starling.utils.*;
   
   use namespace starling_internal;
   
   public class Stage extends DisplayObjectContainer
   {
      
      private static var sMatrix:Matrix = new Matrix();
      
      private static var sMatrix3D:Matrix3D = new Matrix3D();
      
      private var _width:int;
      
      private var _height:int;
      
      private var _color:uint;
      
      private var _fieldOfView:Number;
      
      private var _projectionOffset:Point;
      
      private var _cameraPosition:Vector3D;
      
      private var _enterFrameEvent:EnterFrameEvent;
      
      private var _enterFrameListeners:Vector.<DisplayObject>;
      
      public function Stage(width:int, height:int, color:uint = 0)
      {
         super();
         this._width = width;
         this._height = height;
         this._color = color;
         this._fieldOfView = 1;
         this._projectionOffset = new Point();
         this._cameraPosition = new Vector3D();
         this._enterFrameEvent = new EnterFrameEvent(Event.ENTER_FRAME,0);
         this._enterFrameListeners = new Vector.<DisplayObject>(0);
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         this._enterFrameEvent.reset(Event.ENTER_FRAME,false,passedTime);
         broadcastEvent(this._enterFrameEvent);
      }
      
      override public function hitTest(localPoint:Point) : DisplayObject
      {
         if(!visible || !touchable)
         {
            return null;
         }
         if(localPoint.x < 0 || localPoint.x > this._width || localPoint.y < 0 || localPoint.y > this._height)
         {
            return null;
         }
         var target:DisplayObject = super.hitTest(localPoint);
         return target ? target : this;
      }
      
      public function getStageBounds(targetSpace:DisplayObject, out:Rectangle = null) : Rectangle
      {
         if(out == null)
         {
            out = new Rectangle();
         }
         out.setTo(0,0,this._width,this._height);
         getTransformationMatrix(targetSpace,sMatrix);
         return RectangleUtil.getBounds(out,sMatrix,out);
      }
      
      public function getCameraPosition(space:DisplayObject = null, out:Vector3D = null) : Vector3D
      {
         getTransformationMatrix3D(space,sMatrix3D);
         return MatrixUtil.transformCoords3D(sMatrix3D,this._width / 2 + this._projectionOffset.x,this._height / 2 + this._projectionOffset.y,-this.focalLength,out);
      }
      
      internal function addEnterFrameListener(listener:DisplayObject) : void
      {
         var index:int = int(this._enterFrameListeners.indexOf(listener));
         if(index < 0)
         {
            this._enterFrameListeners[this._enterFrameListeners.length] = listener;
         }
      }
      
      internal function removeEnterFrameListener(listener:DisplayObject) : void
      {
         var index:int = int(this._enterFrameListeners.indexOf(listener));
         if(index >= 0)
         {
            this._enterFrameListeners.removeAt(index);
         }
      }
      
      override internal function getChildEventListeners(object:DisplayObject, eventType:String, listeners:Vector.<DisplayObject>) : void
      {
         var i:int = 0;
         var length:int = 0;
         if(eventType == Event.ENTER_FRAME && object == this)
         {
            i = 0;
            length = int(this._enterFrameListeners.length);
            while(i < length)
            {
               listeners[listeners.length] = this._enterFrameListeners[i];
               i++;
            }
         }
         else
         {
            super.getChildEventListeners(object,eventType,listeners);
         }
      }
      
      override public function set width(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set width of stage");
      }
      
      override public function set height(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set height of stage");
      }
      
      override public function set x(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set x-coordinate of stage");
      }
      
      override public function set y(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set y-coordinate of stage");
      }
      
      override public function set scaleX(value:Number) : void
      {
         throw new IllegalOperationError("Cannot scale stage");
      }
      
      override public function set scaleY(value:Number) : void
      {
         throw new IllegalOperationError("Cannot scale stage");
      }
      
      override public function set rotation(value:Number) : void
      {
         throw new IllegalOperationError("Cannot rotate stage");
      }
      
      override public function set skewX(value:Number) : void
      {
         throw new IllegalOperationError("Cannot skew stage");
      }
      
      override public function set skewY(value:Number) : void
      {
         throw new IllegalOperationError("Cannot skew stage");
      }
      
      override public function set filter(value:FragmentFilter) : void
      {
         throw new IllegalOperationError("Cannot add filter to stage. Add it to \'root\' instead!");
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(value:uint) : void
      {
         this._color = value;
      }
      
      public function get stageWidth() : int
      {
         return this._width;
      }
      
      public function set stageWidth(value:int) : void
      {
         this._width = value;
         setRequiresRedraw();
      }
      
      public function get stageHeight() : int
      {
         return this._height;
      }
      
      public function set stageHeight(value:int) : void
      {
         this._height = value;
         setRequiresRedraw();
      }
      
      public function get starling() : Starling
      {
         var instances:Vector.<Starling> = Starling.all;
         var numInstances:int = int(instances.length);
         for(var i:int = 0; i < numInstances; i++)
         {
            if(instances[i].stage == this)
            {
               return instances[i];
            }
         }
         return null;
      }
      
      public function get focalLength() : Number
      {
         return this._width / (2 * Math.tan(this._fieldOfView / 2));
      }
      
      public function set focalLength(value:Number) : void
      {
         this._fieldOfView = 2 * Math.atan(this.stageWidth / (2 * value));
         setRequiresRedraw();
      }
      
      public function get fieldOfView() : Number
      {
         return this._fieldOfView;
      }
      
      public function set fieldOfView(value:Number) : void
      {
         this._fieldOfView = value;
         setRequiresRedraw();
      }
      
      public function get projectionOffset() : Point
      {
         return this._projectionOffset;
      }
      
      public function set projectionOffset(value:Point) : void
      {
         this._projectionOffset.setTo(value.x,value.y);
         setRequiresRedraw();
      }
      
      public function get cameraPosition() : Vector3D
      {
         return this.getCameraPosition(null,this._cameraPosition);
      }
   }
}

