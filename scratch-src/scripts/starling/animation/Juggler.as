package starling.animation
{
   import flash.utils.*;
   import starling.core.*;
   import starling.events.*;
   
   public class Juggler implements IAnimatable
   {
      
      private static var sCurrentObjectID:uint;
      
      private var _objects:Vector.<IAnimatable>;
      
      private var _objectIDs:Dictionary;
      
      private var _elapsedTime:Number;
      
      private var _timeScale:Number;
      
      public function Juggler()
      {
         super();
         this._elapsedTime = 0;
         this._timeScale = 1;
         this._objects = new Vector.<IAnimatable>(0);
         this._objectIDs = new Dictionary(true);
      }
      
      private static function getNextID() : uint
      {
         return ++sCurrentObjectID;
      }
      
      public function add(object:IAnimatable) : uint
      {
         return this.addWithID(object,getNextID());
      }
      
      private function addWithID(object:IAnimatable, objectID:uint) : uint
      {
         var dispatcher:EventDispatcher = null;
         if(Boolean(object) && !(object in this._objectIDs))
         {
            dispatcher = object as EventDispatcher;
            if(dispatcher)
            {
               dispatcher.addEventListener(Event.REMOVE_FROM_JUGGLER,this.onRemove);
            }
            this._objects[this._objects.length] = object;
            this._objectIDs[object] = objectID;
            return objectID;
         }
         return 0;
      }
      
      public function contains(object:IAnimatable) : Boolean
      {
         return object in this._objectIDs;
      }
      
      public function remove(object:IAnimatable) : uint
      {
         var dispatcher:EventDispatcher = null;
         var index:int = 0;
         var objectID:uint = 0;
         if(Boolean(object) && object in this._objectIDs)
         {
            dispatcher = object as EventDispatcher;
            if(dispatcher)
            {
               dispatcher.removeEventListener(Event.REMOVE_FROM_JUGGLER,this.onRemove);
            }
            index = int(this._objects.indexOf(object));
            this._objects[index] = null;
            objectID = uint(this._objectIDs[object]);
            delete this._objectIDs[object];
         }
         return objectID;
      }
      
      public function removeByID(objectID:uint) : uint
      {
         var object:IAnimatable = null;
         for(var i:* = int(this._objects.length - 1); i >= 0; i--)
         {
            object = this._objects[i];
            if(this._objectIDs[object] == objectID)
            {
               this.remove(object);
               return objectID;
            }
         }
         return 0;
      }
      
      public function removeTweens(target:Object) : void
      {
         var tween:Tween = null;
         if(target == null)
         {
            return;
         }
         for(var i:* = int(this._objects.length - 1); i >= 0; i--)
         {
            tween = this._objects[i] as Tween;
            if(Boolean(tween) && tween.target == target)
            {
               tween.removeEventListener(Event.REMOVE_FROM_JUGGLER,this.onRemove);
               this._objects[i] = null;
               delete this._objectIDs[tween];
            }
         }
      }
      
      public function removeDelayedCalls(callback:Function) : void
      {
         var delayedCall:DelayedCall = null;
         if(callback == null)
         {
            return;
         }
         for(var i:* = int(this._objects.length - 1); i >= 0; i--)
         {
            delayedCall = this._objects[i] as DelayedCall;
            if(Boolean(delayedCall) && delayedCall.callback == callback)
            {
               delayedCall.removeEventListener(Event.REMOVE_FROM_JUGGLER,this.onRemove);
               this._objects[i] = null;
               delete this._objectIDs[delayedCall];
            }
         }
      }
      
      public function containsTweens(target:Object) : Boolean
      {
         var i:* = 0;
         var tween:Tween = null;
         if(target)
         {
            for(i = int(this._objects.length - 1); i >= 0; i--)
            {
               tween = this._objects[i] as Tween;
               if(Boolean(tween) && tween.target == target)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function containsDelayedCalls(callback:Function) : Boolean
      {
         var i:* = 0;
         var delayedCall:DelayedCall = null;
         if(callback != null)
         {
            for(i = int(this._objects.length - 1); i >= 0; i--)
            {
               delayedCall = this._objects[i] as DelayedCall;
               if(Boolean(delayedCall) && delayedCall.callback == callback)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function purge() : void
      {
         var object:IAnimatable = null;
         var dispatcher:EventDispatcher = null;
         for(var i:* = int(this._objects.length - 1); i >= 0; i--)
         {
            object = this._objects[i];
            dispatcher = object as EventDispatcher;
            if(dispatcher)
            {
               dispatcher.removeEventListener(Event.REMOVE_FROM_JUGGLER,this.onRemove);
            }
            this._objects[i] = null;
            delete this._objectIDs[object];
         }
      }
      
      public function delayCall(call:Function, delay:Number, ... args) : uint
      {
         if(call == null)
         {
            throw new ArgumentError("call must not be null");
         }
         var delayedCall:DelayedCall = DelayedCall.starling_internal::fromPool(call,delay,args);
         delayedCall.addEventListener(Event.REMOVE_FROM_JUGGLER,this.onPooledDelayedCallComplete);
         return this.add(delayedCall);
      }
      
      public function repeatCall(call:Function, interval:Number, repeatCount:int = 0, ... args) : uint
      {
         if(call == null)
         {
            throw new ArgumentError("call must not be null");
         }
         var delayedCall:DelayedCall = DelayedCall.starling_internal::fromPool(call,interval,args);
         delayedCall.repeatCount = repeatCount;
         delayedCall.addEventListener(Event.REMOVE_FROM_JUGGLER,this.onPooledDelayedCallComplete);
         return this.add(delayedCall);
      }
      
      private function onPooledDelayedCallComplete(event:Event) : void
      {
         DelayedCall.starling_internal::toPool(event.target as DelayedCall);
      }
      
      public function tween(target:Object, time:Number, properties:Object) : uint
      {
         var property:String = null;
         var value:Object = null;
         if(target == null)
         {
            throw new ArgumentError("target must not be null");
         }
         var tween:Tween = Tween.starling_internal::fromPool(target,time);
         for(property in properties)
         {
            value = properties[property];
            if(tween.hasOwnProperty(property))
            {
               tween[property] = value;
            }
            else
            {
               if(!target.hasOwnProperty(Tween.getPropertyName(property)))
               {
                  throw new ArgumentError("Invalid property: " + property);
               }
               tween.animate(property,value as Number);
            }
         }
         tween.addEventListener(Event.REMOVE_FROM_JUGGLER,this.onPooledTweenComplete);
         return this.add(tween);
      }
      
      private function onPooledTweenComplete(event:Event) : void
      {
         Tween.starling_internal::toPool(event.target as Tween);
      }
      
      public function advanceTime(time:Number) : void
      {
         var i:* = 0;
         var object:IAnimatable = null;
         var numObjects:int = int(this._objects.length);
         var currentIndex:* = 0;
         time *= this._timeScale;
         if(numObjects == 0 || time == 0)
         {
            return;
         }
         this._elapsedTime += time;
         for(i = 0; i < numObjects; i++)
         {
            object = this._objects[i];
            if(object)
            {
               if(currentIndex != i)
               {
                  this._objects[currentIndex] = object;
                  this._objects[i] = null;
               }
               object.advanceTime(time);
               currentIndex++;
            }
         }
         if(currentIndex != i)
         {
            numObjects = int(this._objects.length);
            while(i < numObjects)
            {
               this._objects[int(currentIndex++)] = this._objects[int(i++)];
            }
            this._objects.length = currentIndex;
         }
      }
      
      private function onRemove(event:Event) : void
      {
         var tween:Tween = null;
         var objectID:uint = this.remove(event.target as IAnimatable);
         if(objectID)
         {
            tween = event.target as Tween;
            if(Boolean(tween) && tween.isComplete)
            {
               this.addWithID(tween.nextTween,objectID);
            }
         }
      }
      
      public function get elapsedTime() : Number
      {
         return this._elapsedTime;
      }
      
      public function get timeScale() : Number
      {
         return this._timeScale;
      }
      
      public function set timeScale(value:Number) : void
      {
         this._timeScale = value;
      }
      
      protected function get objects() : Vector.<IAnimatable>
      {
         return this._objects;
      }
   }
}

