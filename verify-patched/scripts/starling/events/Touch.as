package starling.events
{
   import flash.geom.*;
   import starling.display.DisplayObject;
   import starling.utils.*;
   
   public class Touch
   {
      
      private static var sHelperPoint:Point = new Point();
      
      private var _id:int;
      
      private var _globalX:Number;
      
      private var _globalY:Number;
      
      private var _previousGlobalX:Number;
      
      private var _previousGlobalY:Number;
      
      private var _tapCount:int;
      
      private var _phase:String;
      
      private var _target:DisplayObject;
      
      private var _timestamp:Number;
      
      private var _pressure:Number;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _cancelled:Boolean;
      
      private var _bubbleChain:Vector.<EventDispatcher>;
      
      public function Touch(id:int)
      {
         super();
         this._id = id;
         this._tapCount = 0;
         this._phase = TouchPhase.HOVER;
         this._pressure = this._width = this._height = 1;
         this._bubbleChain = new Vector.<EventDispatcher>(0);
      }
      
      public function getLocation(space:DisplayObject, out:Point = null) : Point
      {
         sHelperPoint.setTo(this._globalX,this._globalY);
         return space.globalToLocal(sHelperPoint,out);
      }
      
      public function getPreviousLocation(space:DisplayObject, out:Point = null) : Point
      {
         sHelperPoint.setTo(this._previousGlobalX,this._previousGlobalY);
         return space.globalToLocal(sHelperPoint,out);
      }
      
      public function getMovement(space:DisplayObject, out:Point = null) : Point
      {
         if(out == null)
         {
            out = new Point();
         }
         this.getLocation(space,out);
         var x:Number = out.x;
         var y:Number = out.y;
         this.getPreviousLocation(space,out);
         out.setTo(x - out.x,y - out.y);
         return out;
      }
      
      public function isTouching(target:DisplayObject) : Boolean
      {
         return this._bubbleChain.indexOf(target) != -1;
      }
      
      public function toString() : String
      {
         return StringUtil.format("[Touch {0}: globalX={1}, globalY={2}, phase={3}]",this._id,this._globalX,this._globalY,this._phase);
      }
      
      public function clone() : Touch
      {
         var clone:Touch = new Touch(this._id);
         clone._globalX = this._globalX;
         clone._globalY = this._globalY;
         clone._previousGlobalX = this._previousGlobalX;
         clone._previousGlobalY = this._previousGlobalY;
         clone._phase = this._phase;
         clone._tapCount = this._tapCount;
         clone._timestamp = this._timestamp;
         clone._pressure = this._pressure;
         clone._width = this._width;
         clone._height = this._height;
         clone._cancelled = this._cancelled;
         clone.target = this._target;
         return clone;
      }
      
      private function updateBubbleChain() : void
      {
         var length:* = 0;
         var element:DisplayObject = null;
         if(this._target)
         {
            length = 1;
            element = this._target;
            this._bubbleChain.length = 1;
            this._bubbleChain[0] = element;
            while(true)
            {
               element = element.parent;
               if(element == null)
               {
                  break;
               }
               this._bubbleChain[int(length++)] = element;
            }
         }
         else
         {
            this._bubbleChain.length = 0;
         }
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get previousGlobalX() : Number
      {
         return this._previousGlobalX;
      }
      
      public function get previousGlobalY() : Number
      {
         return this._previousGlobalY;
      }
      
      public function get globalX() : Number
      {
         return this._globalX;
      }
      
      public function set globalX(value:Number) : void
      {
         this._previousGlobalX = this._globalX != this._globalX ? value : Number(this._globalX);
         this._globalX = value;
      }
      
      public function get globalY() : Number
      {
         return this._globalY;
      }
      
      public function set globalY(value:Number) : void
      {
         this._previousGlobalY = this._globalY != this._globalY ? value : Number(this._globalY);
         this._globalY = value;
      }
      
      public function get tapCount() : int
      {
         return this._tapCount;
      }
      
      public function set tapCount(value:int) : void
      {
         this._tapCount = value;
      }
      
      public function get phase() : String
      {
         return this._phase;
      }
      
      public function set phase(value:String) : void
      {
         this._phase = value;
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      public function set target(value:DisplayObject) : void
      {
         if(this._target != value)
         {
            this._target = value;
            this.updateBubbleChain();
         }
      }
      
      public function get timestamp() : Number
      {
         return this._timestamp;
      }
      
      public function set timestamp(value:Number) : void
      {
         this._timestamp = value;
      }
      
      public function get pressure() : Number
      {
         return this._pressure;
      }
      
      public function set pressure(value:Number) : void
      {
         this._pressure = value;
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function set width(value:Number) : void
      {
         this._width = value;
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set height(value:Number) : void
      {
         this._height = value;
      }
      
      public function get cancelled() : Boolean
      {
         return this._cancelled;
      }
      
      public function set cancelled(value:Boolean) : void
      {
         this._cancelled = value;
      }
      
      internal function dispatchEvent(event:TouchEvent) : void
      {
         if(this._target)
         {
            event.dispatch(this._bubbleChain);
         }
      }
      
      internal function get bubbleChain() : Vector.<EventDispatcher>
      {
         return this._bubbleChain.concat();
      }
   }
}

