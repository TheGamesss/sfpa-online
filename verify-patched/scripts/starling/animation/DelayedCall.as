package starling.animation
{
   import starling.core.starling_internal;
   import starling.events.*;
   
   use namespace starling_internal;
   
   public class DelayedCall extends EventDispatcher implements IAnimatable
   {
      
      private static var sPool:Vector.<DelayedCall> = new Vector.<DelayedCall>(0);
      
      private var _currentTime:Number;
      
      private var _totalTime:Number;
      
      private var _callback:Function;
      
      private var _args:Array;
      
      private var _repeatCount:int;
      
      public function DelayedCall(callback:Function, delay:Number, args:Array = null)
      {
         super();
         this.reset(callback,delay,args);
      }
      
      starling_internal static function fromPool(call:Function, delay:Number, args:Array = null) : DelayedCall
      {
         if(sPool.length)
         {
            return sPool.pop().reset(call,delay,args);
         }
         return new DelayedCall(call,delay,args);
      }
      
      starling_internal static function toPool(delayedCall:DelayedCall) : void
      {
         delayedCall._callback = null;
         delayedCall._args = null;
         delayedCall.removeEventListeners();
         sPool.push(delayedCall);
      }
      
      public function reset(callback:Function, delay:Number, args:Array = null) : DelayedCall
      {
         this._currentTime = 0;
         this._totalTime = Math.max(delay,0.0001);
         this._callback = callback;
         this._args = args;
         this._repeatCount = 1;
         return this;
      }
      
      public function advanceTime(time:Number) : void
      {
         var call:Function = null;
         var args:Array = null;
         var previousTime:Number = Number(this._currentTime);
         this._currentTime += time;
         if(this._currentTime > this._totalTime)
         {
            this._currentTime = this._totalTime;
         }
         if(previousTime < this._totalTime && this._currentTime >= this._totalTime)
         {
            if(this._repeatCount == 0 || this._repeatCount > 1)
            {
               this._callback.apply(null,this._args);
               if(this._repeatCount > 0)
               {
                  --this._repeatCount;
               }
               this._currentTime = 0;
               this.advanceTime(previousTime + time - this._totalTime);
            }
            else
            {
               call = this._callback;
               args = this._args;
               dispatchEventWith(Event.REMOVE_FROM_JUGGLER);
               call.apply(null,args);
            }
         }
      }
      
      public function complete() : void
      {
         var restTime:Number = this._totalTime - this._currentTime;
         if(restTime > 0)
         {
            this.advanceTime(restTime);
         }
      }
      
      public function get isComplete() : Boolean
      {
         return this._repeatCount == 1 && this._currentTime >= this._totalTime;
      }
      
      public function get totalTime() : Number
      {
         return this._totalTime;
      }
      
      public function get currentTime() : Number
      {
         return this._currentTime;
      }
      
      public function get repeatCount() : int
      {
         return this._repeatCount;
      }
      
      public function set repeatCount(value:int) : void
      {
         this._repeatCount = value;
      }
      
      public function get callback() : Function
      {
         return this._callback;
      }
      
      public function get arguments() : Array
      {
         return this._args;
      }
   }
}

