package starling.animation
{
   import starling.core.starling_internal;
   import starling.events.*;
   import starling.utils.*;
   
   use namespace starling_internal;
   
   public class Tween extends EventDispatcher implements IAnimatable
   {
      
      private static const HINT_MARKER:String = "#";
      
      private static var sTweenPool:Vector.<Tween> = new Vector.<Tween>(0);
      
      private var _target:Object;
      
      private var _transitionFunc:Function;
      
      private var _transitionName:String;
      
      private var _properties:Vector.<String>;
      
      private var _startValues:Vector.<Number>;
      
      private var _endValues:Vector.<Number>;
      
      private var _updateFuncs:Vector.<Function>;
      
      private var _onStart:Function;
      
      private var _onUpdate:Function;
      
      private var _onRepeat:Function;
      
      private var _onComplete:Function;
      
      private var _onStartArgs:Array;
      
      private var _onUpdateArgs:Array;
      
      private var _onRepeatArgs:Array;
      
      private var _onCompleteArgs:Array;
      
      private var _totalTime:Number;
      
      private var _currentTime:Number;
      
      private var _progress:Number;
      
      private var _delay:Number;
      
      private var _roundToInt:Boolean;
      
      private var _nextTween:Tween;
      
      private var _repeatCount:int;
      
      private var _repeatDelay:Number;
      
      private var _reverse:Boolean;
      
      private var _currentCycle:int;
      
      public function Tween(target:Object, time:Number, transition:Object = "linear")
      {
         super();
         this.reset(target,time,transition);
      }
      
      internal static function getPropertyHint(property:String) : String
      {
         if(property.indexOf("color") != -1 || property.indexOf("Color") != -1)
         {
            return "rgb";
         }
         var hintMarkerIndex:int = property.indexOf(HINT_MARKER);
         if(hintMarkerIndex != -1)
         {
            return property.substr(hintMarkerIndex + 1);
         }
         return null;
      }
      
      internal static function getPropertyName(property:String) : String
      {
         var hintMarkerIndex:int = property.indexOf(HINT_MARKER);
         if(hintMarkerIndex != -1)
         {
            return property.substring(0,hintMarkerIndex);
         }
         return property;
      }
      
      starling_internal static function fromPool(target:Object, time:Number, transition:Object = "linear") : Tween
      {
         if(sTweenPool.length)
         {
            return sTweenPool.pop().reset(target,time,transition);
         }
         return new Tween(target,time,transition);
      }
      
      starling_internal static function toPool(tween:Tween) : void
      {
         tween._onStart = tween._onUpdate = tween._onRepeat = tween._onComplete = null;
         tween._onStartArgs = tween._onUpdateArgs = tween._onRepeatArgs = tween._onCompleteArgs = null;
         tween._target = null;
         tween._transitionFunc = null;
         tween.removeEventListeners();
         sTweenPool.push(tween);
      }
      
      public function reset(target:Object, time:Number, transition:Object = "linear") : Tween
      {
         this._target = target;
         this._currentTime = 0;
         this._totalTime = Math.max(0.0001,time);
         this._progress = 0;
         this._delay = this._repeatDelay = 0;
         this._onStart = this._onUpdate = this._onRepeat = this._onComplete = null;
         this._onStartArgs = this._onUpdateArgs = this._onRepeatArgs = this._onCompleteArgs = null;
         this._roundToInt = this._reverse = false;
         this._repeatCount = 1;
         this._currentCycle = -1;
         this._nextTween = null;
         if(transition is String)
         {
            this.transition = transition as String;
         }
         else
         {
            if(!(transition is Function))
            {
               throw new ArgumentError("Transition must be either a string or a function");
            }
            this.transitionFunc = transition as Function;
         }
         if(this._properties)
         {
            this._properties.length = 0;
         }
         else
         {
            this._properties = new Vector.<String>(0);
         }
         if(this._startValues)
         {
            this._startValues.length = 0;
         }
         else
         {
            this._startValues = new Vector.<Number>(0);
         }
         if(this._endValues)
         {
            this._endValues.length = 0;
         }
         else
         {
            this._endValues = new Vector.<Number>(0);
         }
         if(this._updateFuncs)
         {
            this._updateFuncs.length = 0;
         }
         else
         {
            this._updateFuncs = new Vector.<Function>(0);
         }
         return this;
      }
      
      public function animate(property:String, endValue:Number) : void
      {
         if(this._target == null)
         {
            return;
         }
         var pos:int = int(this._properties.length);
         var updateFunc:Function = this.getUpdateFuncFromProperty(property);
         this._properties[pos] = getPropertyName(property);
         this._startValues[pos] = Number.NaN;
         this._endValues[pos] = endValue;
         this._updateFuncs[pos] = updateFunc;
      }
      
      public function scaleTo(factor:Number) : void
      {
         this.animate("scaleX",factor);
         this.animate("scaleY",factor);
      }
      
      public function moveTo(x:Number, y:Number) : void
      {
         this.animate("x",x);
         this.animate("y",y);
      }
      
      public function fadeTo(alpha:Number) : void
      {
         this.animate("alpha",alpha);
      }
      
      public function rotateTo(angle:Number, type:String = "rad") : void
      {
         this.animate("rotation#" + type,angle);
      }
      
      public function advanceTime(time:Number) : void
      {
         var i:int = 0;
         var updateFunc:Function = null;
         var onComplete:Function = null;
         var onCompleteArgs:Array = null;
         if(time == 0 || this._repeatCount == 1 && this._currentTime == this._totalTime)
         {
            return;
         }
         var previousTime:Number = Number(this._currentTime);
         var restTime:Number = this._totalTime - this._currentTime;
         var carryOverTime:Number = time > restTime ? time - restTime : 0;
         this._currentTime += time;
         if(this._currentTime <= 0)
         {
            return;
         }
         if(this._currentTime > this._totalTime)
         {
            this._currentTime = this._totalTime;
         }
         if(this._currentCycle < 0 && previousTime <= 0 && this._currentTime > 0)
         {
            ++this._currentCycle;
            if(this._onStart != null)
            {
               this._onStart.apply(this,this._onStartArgs);
            }
         }
         var ratio:Number = this._currentTime / this._totalTime;
         var reversed:Boolean = Boolean(this._reverse) && this._currentCycle % 2 == 1;
         var numProperties:int = int(this._startValues.length);
         this._progress = reversed ? Number(this._transitionFunc(1 - ratio)) : Number(this._transitionFunc(ratio));
         for(i = 0; i < numProperties; i++)
         {
            if(this._startValues[i] != this._startValues[i])
            {
               this._startValues[i] = this._target[this._properties[i]] as Number;
            }
            updateFunc = this._updateFuncs[i] as Function;
            updateFunc(this._properties[i],this._startValues[i],this._endValues[i]);
         }
         if(this._onUpdate != null)
         {
            this._onUpdate.apply(this,this._onUpdateArgs);
         }
         if(previousTime < this._totalTime && this._currentTime >= this._totalTime)
         {
            if(this._repeatCount == 0 || this._repeatCount > 1)
            {
               this._currentTime = -this._repeatDelay;
               ++this._currentCycle;
               if(this._repeatCount > 1)
               {
                  --this._repeatCount;
               }
               if(this._onRepeat != null)
               {
                  this._onRepeat.apply(this,this._onRepeatArgs);
               }
            }
            else
            {
               onComplete = this._onComplete;
               onCompleteArgs = this._onCompleteArgs;
               dispatchEventWith(Event.REMOVE_FROM_JUGGLER);
               if(onComplete != null)
               {
                  onComplete.apply(this,onCompleteArgs);
               }
               if(this._currentTime == 0)
               {
                  carryOverTime = 0;
               }
            }
         }
         if(carryOverTime)
         {
            this.advanceTime(carryOverTime);
         }
      }
      
      private function getUpdateFuncFromProperty(property:String) : Function
      {
         var updateFunc:Function = null;
         var hint:String = getPropertyHint(property);
         switch(hint)
         {
            case null:
               updateFunc = this.updateStandard;
               break;
            case "rgb":
               updateFunc = this.updateRgb;
               break;
            case "rad":
               updateFunc = this.updateRad;
               break;
            case "deg":
               updateFunc = this.updateDeg;
               break;
            default:
               trace("[Starling] Ignoring unknown property hint:",hint);
               updateFunc = this.updateStandard;
         }
         return updateFunc;
      }
      
      private function updateStandard(property:String, startValue:Number, endValue:Number) : void
      {
         var newValue:Number = startValue + this._progress * (endValue - startValue);
         if(this._roundToInt)
         {
            newValue = Math.round(newValue);
         }
         this._target[property] = newValue;
      }
      
      private function updateRgb(property:String, startValue:Number, endValue:Number) : void
      {
         this._target[property] = Color.interpolate(uint(startValue),uint(endValue),this._progress);
      }
      
      private function updateRad(property:String, startValue:Number, endValue:Number) : void
      {
         this.updateAngle(Math.PI,property,startValue,endValue);
      }
      
      private function updateDeg(property:String, startValue:Number, endValue:Number) : void
      {
         this.updateAngle(180,property,startValue,endValue);
      }
      
      private function updateAngle(pi:Number, property:String, startValue:Number, endValue:Number) : void
      {
         while(Math.abs(endValue - startValue) > pi)
         {
            if(startValue < endValue)
            {
               endValue -= 2 * pi;
            }
            else
            {
               endValue += 2 * pi;
            }
         }
         this.updateStandard(property,startValue,endValue);
      }
      
      public function getEndValue(property:String) : Number
      {
         var index:int = int(this._properties.indexOf(property));
         if(index == -1)
         {
            throw new ArgumentError("The property \'" + property + "\' is not animated");
         }
         return this._endValues[index] as Number;
      }
      
      public function get isComplete() : Boolean
      {
         return this._currentTime >= this._totalTime && this._repeatCount == 1;
      }
      
      public function get target() : Object
      {
         return this._target;
      }
      
      public function get transition() : String
      {
         return this._transitionName;
      }
      
      public function set transition(value:String) : void
      {
         this._transitionName = value;
         this._transitionFunc = Transitions.getTransition(value);
         if(this._transitionFunc == null)
         {
            throw new ArgumentError("Invalid transiton: " + value);
         }
      }
      
      public function get transitionFunc() : Function
      {
         return this._transitionFunc;
      }
      
      public function set transitionFunc(value:Function) : void
      {
         this._transitionName = "custom";
         this._transitionFunc = value;
      }
      
      public function get totalTime() : Number
      {
         return this._totalTime;
      }
      
      public function get currentTime() : Number
      {
         return this._currentTime;
      }
      
      public function get progress() : Number
      {
         return this._progress;
      }
      
      public function get delay() : Number
      {
         return this._delay;
      }
      
      public function set delay(value:Number) : void
      {
         this._currentTime = this._currentTime + this._delay - value;
         this._delay = value;
      }
      
      public function get repeatCount() : int
      {
         return this._repeatCount;
      }
      
      public function set repeatCount(value:int) : void
      {
         this._repeatCount = value;
      }
      
      public function get repeatDelay() : Number
      {
         return this._repeatDelay;
      }
      
      public function set repeatDelay(value:Number) : void
      {
         this._repeatDelay = value;
      }
      
      public function get reverse() : Boolean
      {
         return this._reverse;
      }
      
      public function set reverse(value:Boolean) : void
      {
         this._reverse = value;
      }
      
      public function get roundToInt() : Boolean
      {
         return this._roundToInt;
      }
      
      public function set roundToInt(value:Boolean) : void
      {
         this._roundToInt = value;
      }
      
      public function get onStart() : Function
      {
         return this._onStart;
      }
      
      public function set onStart(value:Function) : void
      {
         this._onStart = value;
      }
      
      public function get onUpdate() : Function
      {
         return this._onUpdate;
      }
      
      public function set onUpdate(value:Function) : void
      {
         this._onUpdate = value;
      }
      
      public function get onRepeat() : Function
      {
         return this._onRepeat;
      }
      
      public function set onRepeat(value:Function) : void
      {
         this._onRepeat = value;
      }
      
      public function get onComplete() : Function
      {
         return this._onComplete;
      }
      
      public function set onComplete(value:Function) : void
      {
         this._onComplete = value;
      }
      
      public function get onStartArgs() : Array
      {
         return this._onStartArgs;
      }
      
      public function set onStartArgs(value:Array) : void
      {
         this._onStartArgs = value;
      }
      
      public function get onUpdateArgs() : Array
      {
         return this._onUpdateArgs;
      }
      
      public function set onUpdateArgs(value:Array) : void
      {
         this._onUpdateArgs = value;
      }
      
      public function get onRepeatArgs() : Array
      {
         return this._onRepeatArgs;
      }
      
      public function set onRepeatArgs(value:Array) : void
      {
         this._onRepeatArgs = value;
      }
      
      public function get onCompleteArgs() : Array
      {
         return this._onCompleteArgs;
      }
      
      public function set onCompleteArgs(value:Array) : void
      {
         this._onCompleteArgs = value;
      }
      
      public function get nextTween() : Tween
      {
         return this._nextTween;
      }
      
      public function set nextTween(value:Tween) : void
      {
         this._nextTween = value;
      }
   }
}

