package starling.events
{
   import starling.core.starling_internal;
   import starling.display.DisplayObject;
   
   use namespace starling_internal;
   
   public class TouchEvent extends Event
   {
      
      public static const TOUCH:String = "touch";
      
      private static var sTouches:Vector.<Touch> = new Vector.<Touch>(0);
      
      private var _shiftKey:Boolean;
      
      private var _ctrlKey:Boolean;
      
      private var _timestamp:Number;
      
      private var _visitedObjects:Vector.<EventDispatcher>;
      
      public function TouchEvent(type:String, touches:Vector.<Touch> = null, shiftKey:Boolean = false, ctrlKey:Boolean = false, bubbles:Boolean = true)
      {
         super(type,bubbles,touches);
         this._shiftKey = shiftKey;
         this._ctrlKey = ctrlKey;
         this._visitedObjects = new Vector.<EventDispatcher>(0);
         this.updateTimestamp(touches);
      }
      
      internal function resetTo(type:String, touches:Vector.<Touch> = null, shiftKey:Boolean = false, ctrlKey:Boolean = false, bubbles:Boolean = true) : TouchEvent
      {
         super.reset(type,bubbles,touches);
         this._shiftKey = shiftKey;
         this._ctrlKey = ctrlKey;
         this._visitedObjects.length = 0;
         this.updateTimestamp(touches);
         return this;
      }
      
      private function updateTimestamp(touches:Vector.<Touch>) : void
      {
         this._timestamp = -1;
         var numTouches:int = touches ? int(touches.length) : 0;
         for(var i:int = 0; i < numTouches; i++)
         {
            if(touches[i].timestamp > this._timestamp)
            {
               this._timestamp = touches[i].timestamp;
            }
         }
      }
      
      public function getTouches(target:DisplayObject, phase:String = null, out:Vector.<Touch> = null) : Vector.<Touch>
      {
         var touch:Touch = null;
         var correctTarget:Boolean = false;
         var correctPhase:Boolean = false;
         if(out == null)
         {
            out = new Vector.<Touch>(0);
         }
         var allTouches:Vector.<Touch> = data as Vector.<Touch>;
         var numTouches:int = int(allTouches.length);
         for(var i:int = 0; i < numTouches; i++)
         {
            touch = allTouches[i];
            correctTarget = touch.isTouching(target);
            correctPhase = phase == null || phase == touch.phase;
            if(correctTarget && correctPhase)
            {
               out[out.length] = touch;
            }
         }
         return out;
      }
      
      public function getTouch(target:DisplayObject, phase:String = null, id:int = -1) : Touch
      {
         var touch:Touch = null;
         var i:int = 0;
         this.getTouches(target,phase,sTouches);
         var numTouches:int = int(sTouches.length);
         if(numTouches > 0)
         {
            touch = null;
            if(id < 0)
            {
               touch = sTouches[0];
            }
            else
            {
               for(i = 0; i < numTouches; i++)
               {
                  if(sTouches[i].id == id)
                  {
                     touch = sTouches[i];
                     break;
                  }
               }
            }
            sTouches.length = 0;
            return touch;
         }
         return null;
      }
      
      public function interactsWith(target:DisplayObject) : Boolean
      {
         var result:Boolean = false;
         this.getTouches(target,null,sTouches);
         for(var i:* = int(sTouches.length - 1); i >= 0; i--)
         {
            if(sTouches[i].phase != TouchPhase.ENDED)
            {
               result = true;
               break;
            }
         }
         sTouches.length = 0;
         return result;
      }
      
      internal function dispatch(chain:Vector.<EventDispatcher>) : void
      {
         var chainLength:int = 0;
         var previousTarget:EventDispatcher = null;
         var i:int = 0;
         var chainElement:EventDispatcher = null;
         var stopPropagation:Boolean = false;
         if(Boolean(chain) && Boolean(chain.length))
         {
            chainLength = bubbles ? int(chain.length) : 1;
            previousTarget = target;
            setTarget(chain[0] as EventDispatcher);
            for(i = 0; i < chainLength; i++)
            {
               chainElement = chain[i] as EventDispatcher;
               if(this._visitedObjects.indexOf(chainElement) == -1)
               {
                  stopPropagation = chainElement.invokeEvent(this);
                  this._visitedObjects[this._visitedObjects.length] = chainElement;
                  if(stopPropagation)
                  {
                     break;
                  }
               }
            }
            setTarget(previousTarget);
         }
      }
      
      public function get timestamp() : Number
      {
         return this._timestamp;
      }
      
      public function get touches() : Vector.<Touch>
      {
         return (data as Vector.<Touch>).concat();
      }
      
      public function get shiftKey() : Boolean
      {
         return this._shiftKey;
      }
      
      public function get ctrlKey() : Boolean
      {
         return this._ctrlKey;
      }
   }
}

