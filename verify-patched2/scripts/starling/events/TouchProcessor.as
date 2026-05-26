package starling.events
{
   import flash.geom.*;
   import flash.utils.*;
   import starling.core.*;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   
   public class TouchProcessor
   {
      
      private static var sUpdatedTouches:Vector.<Touch> = new Vector.<Touch>(0);
      
      private static var sHoveringTouchData:Vector.<Object> = new Vector.<Object>(0);
      
      private static var sHelperPoint:Point = new Point();
      
      private var _stage:Stage;
      
      private var _root:DisplayObject;
      
      private var _elapsedTime:Number;
      
      private var _lastTaps:Vector.<Touch>;
      
      private var _shiftDown:Boolean = false;
      
      private var _ctrlDown:Boolean = false;
      
      private var _multitapTime:Number = 0.3;
      
      private var _multitapDistance:Number = 25;
      
      private var _touchEvent:TouchEvent;
      
      private var _touchMarker:TouchMarker;
      
      private var _simulateMultitouch:Boolean;
      
      protected var _queue:Vector.<Array>;
      
      protected var _currentTouches:Vector.<Touch>;
      
      public function TouchProcessor(stage:Stage)
      {
         super();
         this._root = this._stage = stage;
         this._elapsedTime = 0;
         this._currentTouches = new Vector.<Touch>(0);
         this._queue = new Vector.<Array>(0);
         this._lastTaps = new Vector.<Touch>(0);
         this._touchEvent = new TouchEvent(TouchEvent.TOUCH);
         this._stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
         this._stage.addEventListener(KeyboardEvent.KEY_UP,this.onKey);
         this.monitorInterruptions(true);
      }
      
      public function dispose() : void
      {
         this.monitorInterruptions(false);
         this._stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
         this._stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKey);
         if(this._touchMarker)
         {
            this._touchMarker.dispose();
         }
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         var i:* = 0;
         var touch:Touch = null;
         var touchArgs:Array = null;
         var numIterations:int = 0;
         this._elapsedTime += passedTime;
         sUpdatedTouches.length = 0;
         if(this._lastTaps.length > 0)
         {
            for(i = int(this._lastTaps.length - 1); i >= 0; i--)
            {
               if(this._elapsedTime - this._lastTaps[i].timestamp > this._multitapTime)
               {
                  this._lastTaps.removeAt(i);
               }
            }
         }
         while(this._queue.length > 0 || numIterations == 0)
         {
            numIterations++;
            for each(touch in this._currentTouches)
            {
               if(touch.phase == TouchPhase.BEGAN || touch.phase == TouchPhase.MOVED)
               {
                  touch.phase = TouchPhase.STATIONARY;
               }
            }
            while(this._queue.length > 0 && !this.containsTouchWithID(sUpdatedTouches,this._queue[this._queue.length - 1][0]))
            {
               touchArgs = this._queue.pop();
               touch = this.createOrUpdateTouch(touchArgs[0],touchArgs[1],touchArgs[2],touchArgs[3],touchArgs[4],touchArgs[5],touchArgs[6]);
               sUpdatedTouches[sUpdatedTouches.length] = touch;
            }
            for(i = int(this._currentTouches.length - 1); i >= 0; i--)
            {
               touch = this._currentTouches[i];
               if(touch.phase == TouchPhase.HOVER && !this.containsTouchWithID(sUpdatedTouches,touch.id))
               {
                  sHelperPoint.setTo(touch.globalX,touch.globalY);
                  if(touch.target != this._root.hitTest(sHelperPoint))
                  {
                     sUpdatedTouches[sUpdatedTouches.length] = touch;
                  }
               }
            }
            if(sUpdatedTouches.length)
            {
               this.processTouches(sUpdatedTouches,this._shiftDown,this._ctrlDown);
            }
            for(i = int(this._currentTouches.length - 1); i >= 0; i--)
            {
               if(this._currentTouches[i].phase == TouchPhase.ENDED)
               {
                  this._currentTouches.removeAt(i);
               }
            }
            sUpdatedTouches.length = 0;
         }
      }
      
      protected function processTouches(touches:Vector.<Touch>, shiftDown:Boolean, ctrlDown:Boolean) : void
      {
         var touch:Touch = null;
         var touchData:Object = null;
         sHoveringTouchData.length = 0;
         this._touchEvent.resetTo(TouchEvent.TOUCH,this._currentTouches,shiftDown,ctrlDown);
         for each(touch in touches)
         {
            if(touch.phase == TouchPhase.HOVER && Boolean(touch.target))
            {
               sHoveringTouchData[sHoveringTouchData.length] = {
                  "touch":touch,
                  "target":touch.target,
                  "bubbleChain":touch.bubbleChain
               };
            }
            if(touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.BEGAN)
            {
               sHelperPoint.setTo(touch.globalX,touch.globalY);
               touch.target = this._root.hitTest(sHelperPoint);
            }
         }
         for each(touchData in sHoveringTouchData)
         {
            if(touchData.touch.target != touchData.target)
            {
               this._touchEvent.dispatch(touchData.bubbleChain);
            }
         }
         for each(touch in touches)
         {
            touch.dispatchEvent(this._touchEvent);
         }
         this._touchEvent.resetTo(TouchEvent.TOUCH);
      }
      
      public function enqueue(touchID:int, phase:String, globalX:Number, globalY:Number, pressure:Number = 1, width:Number = 1, height:Number = 1) : void
      {
         this._queue.unshift(arguments);
         if(Boolean(this._ctrlDown) && Boolean(this._touchMarker) && touchID == 0)
         {
            this._touchMarker.moveMarker(globalX,globalY,this._shiftDown);
            this._queue.unshift([1,phase,this._touchMarker.mockX,this._touchMarker.mockY]);
         }
      }
      
      public function enqueueMouseLeftStage() : void
      {
         var mouse:Touch = this.getCurrentTouch(0);
         if(mouse == null || mouse.phase != TouchPhase.HOVER)
         {
            return;
         }
         var offset:int = 1;
         var exitX:Number = mouse.globalX;
         var exitY:Number = mouse.globalY;
         var distLeft:Number = mouse.globalX;
         var distRight:Number = this._stage.stageWidth - distLeft;
         var distTop:Number = mouse.globalY;
         var distBottom:Number = this._stage.stageHeight - distTop;
         var minDist:Number = Math.min(distLeft,distRight,distTop,distBottom);
         if(minDist == distLeft)
         {
            exitX = -offset;
         }
         else if(minDist == distRight)
         {
            exitX = this._stage.stageWidth + offset;
         }
         else if(minDist == distTop)
         {
            exitY = -offset;
         }
         else
         {
            exitY = this._stage.stageHeight + offset;
         }
         this.enqueue(0,TouchPhase.HOVER,exitX,exitY);
      }
      
      public function cancelTouches() : void
      {
         var touch:Touch = null;
         if(this._currentTouches.length > 0)
         {
            for each(touch in this._currentTouches)
            {
               if(touch.phase == TouchPhase.BEGAN || touch.phase == TouchPhase.MOVED || touch.phase == TouchPhase.STATIONARY)
               {
                  touch.phase = TouchPhase.ENDED;
                  touch.cancelled = true;
               }
            }
            this.processTouches(this._currentTouches,this._shiftDown,this._ctrlDown);
         }
         this._currentTouches.length = 0;
         this._queue.length = 0;
      }
      
      private function createOrUpdateTouch(touchID:int, phase:String, globalX:Number, globalY:Number, pressure:Number = 1, width:Number = 1, height:Number = 1) : Touch
      {
         var touch:Touch = this.getCurrentTouch(touchID);
         if(touch == null)
         {
            touch = new Touch(touchID);
            this.addCurrentTouch(touch);
         }
         touch.globalX = globalX;
         touch.globalY = globalY;
         touch.phase = phase;
         touch.timestamp = this._elapsedTime;
         touch.pressure = pressure;
         touch.width = width;
         touch.height = height;
         if(phase == TouchPhase.BEGAN)
         {
            this.updateTapCount(touch);
         }
         return touch;
      }
      
      private function updateTapCount(touch:Touch) : void
      {
         var tap:Touch = null;
         var sqDist:Number = NaN;
         var nearbyTap:Touch = null;
         var minSqDist:Number = this._multitapDistance * this._multitapDistance;
         for each(tap in this._lastTaps)
         {
            sqDist = Math.pow(tap.globalX - touch.globalX,2) + Math.pow(tap.globalY - touch.globalY,2);
            if(sqDist <= minSqDist)
            {
               nearbyTap = tap;
               break;
            }
         }
         if(nearbyTap)
         {
            touch.tapCount = nearbyTap.tapCount + 1;
            this._lastTaps.removeAt(this._lastTaps.indexOf(nearbyTap));
         }
         else
         {
            touch.tapCount = 1;
         }
         this._lastTaps[this._lastTaps.length] = touch.clone();
      }
      
      private function addCurrentTouch(touch:Touch) : void
      {
         for(var i:* = int(this._currentTouches.length - 1); i >= 0; i--)
         {
            if(this._currentTouches[i].id == touch.id)
            {
               this._currentTouches.removeAt(i);
            }
         }
         this._currentTouches[this._currentTouches.length] = touch;
      }
      
      private function getCurrentTouch(touchID:int) : Touch
      {
         var touch:Touch = null;
         for each(touch in this._currentTouches)
         {
            if(touch.id == touchID)
            {
               return touch;
            }
         }
         return null;
      }
      
      private function containsTouchWithID(touches:Vector.<Touch>, touchID:int) : Boolean
      {
         var touch:Touch = null;
         for each(touch in touches)
         {
            if(touch.id == touchID)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get simulateMultitouch() : Boolean
      {
         return this._simulateMultitouch;
      }
      
      public function set simulateMultitouch(value:Boolean) : void
      {
         var target:Starling = null;
         var createTouchMarker:* = undefined;
         createTouchMarker = function():void
         {
            target.removeEventListener(Event.CONTEXT3D_CREATE,createTouchMarker);
            if(_touchMarker == null)
            {
               _touchMarker = new TouchMarker();
               _touchMarker.visible = false;
               _stage.addChild(_touchMarker);
            }
         };
         if(this.simulateMultitouch == value)
         {
            return;
         }
         this._simulateMultitouch = value;
         target = Starling.current;
         if(value && this._touchMarker == null)
         {
            if(Starling.current.contextValid)
            {
               createTouchMarker();
            }
            else
            {
               target.addEventListener(Event.CONTEXT3D_CREATE,createTouchMarker);
            }
         }
         else if(!value && Boolean(this._touchMarker))
         {
            this._touchMarker.removeFromParent(true);
            this._touchMarker = null;
         }
      }
      
      public function get multitapTime() : Number
      {
         return this._multitapTime;
      }
      
      public function set multitapTime(value:Number) : void
      {
         this._multitapTime = value;
      }
      
      public function get multitapDistance() : Number
      {
         return this._multitapDistance;
      }
      
      public function set multitapDistance(value:Number) : void
      {
         this._multitapDistance = value;
      }
      
      public function get root() : DisplayObject
      {
         return this._root;
      }
      
      public function set root(value:DisplayObject) : void
      {
         this._root = value;
      }
      
      public function get stage() : Stage
      {
         return this._stage;
      }
      
      public function get numCurrentTouches() : int
      {
         return this._currentTouches.length;
      }
      
      private function onKey(event:KeyboardEvent) : void
      {
         var wasCtrlDown:Boolean = false;
         var mouseTouch:Touch = null;
         var mockedTouch:Touch = null;
         if(event.keyCode == 17 || event.keyCode == 15)
         {
            wasCtrlDown = Boolean(this._ctrlDown);
            this._ctrlDown = event.type == KeyboardEvent.KEY_DOWN;
            if(Boolean(this._touchMarker) && wasCtrlDown != this._ctrlDown)
            {
               this._touchMarker.visible = this._ctrlDown;
               this._touchMarker.moveCenter(this._stage.stageWidth / 2,this._stage.stageHeight / 2);
               mouseTouch = this.getCurrentTouch(0);
               mockedTouch = this.getCurrentTouch(1);
               if(mouseTouch)
               {
                  this._touchMarker.moveMarker(mouseTouch.globalX,mouseTouch.globalY);
               }
               if(Boolean(wasCtrlDown) && Boolean(mockedTouch) && mockedTouch.phase != TouchPhase.ENDED)
               {
                  this._queue.unshift([1,TouchPhase.ENDED,mockedTouch.globalX,mockedTouch.globalY]);
               }
               else if(Boolean(this._ctrlDown) && Boolean(mouseTouch))
               {
                  if(mouseTouch.phase == TouchPhase.HOVER || mouseTouch.phase == TouchPhase.ENDED)
                  {
                     this._queue.unshift([1,TouchPhase.HOVER,this._touchMarker.mockX,this._touchMarker.mockY]);
                  }
                  else
                  {
                     this._queue.unshift([1,TouchPhase.BEGAN,this._touchMarker.mockX,this._touchMarker.mockY]);
                  }
               }
            }
         }
         else if(event.keyCode == 16)
         {
            this._shiftDown = event.type == KeyboardEvent.KEY_DOWN;
         }
      }
      
      private function monitorInterruptions(enable:Boolean) : void
      {
         var nativeAppClass:Object = null;
         var nativeApp:Object = null;
         try
         {
            nativeAppClass = getDefinitionByName("flash.desktop::NativeApplication");
            nativeApp = nativeAppClass["nativeApplication"];
            if(enable)
            {
               nativeApp.addEventListener("deactivate",this.onInterruption,false,0,true);
            }
            else
            {
               nativeApp.removeEventListener("deactivate",this.onInterruption);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onInterruption(event:Object) : void
      {
         this.cancelTouches();
      }
   }
}

