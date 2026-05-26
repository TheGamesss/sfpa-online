package starling.events
{
   import flash.utils.*;
   import starling.core.starling_internal;
   import starling.display.*;
   
   use namespace starling_internal;
   
   public class EventDispatcher
   {
      
      private static var sBubbleChains:Array = [];
      
      private var _eventListeners:Dictionary;
      
      private var _eventStack:Vector.<String> = new Vector.<String>(0);
      
      public function EventDispatcher()
      {
         super();
      }
      
      public function addEventListener(type:String, listener:Function) : void
      {
         if(this._eventListeners == null)
         {
            this._eventListeners = new Dictionary();
         }
         var listeners:Vector.<Function> = this._eventListeners[type] as Vector.<Function>;
         if(listeners == null)
         {
            this._eventListeners[type] = new <Function>[listener];
         }
         else if(listeners.indexOf(listener) == -1)
         {
            listeners[listeners.length] = listener;
         }
      }
      
      public function removeEventListener(type:String, listener:Function) : void
      {
         var listeners:Vector.<Function> = null;
         var numListeners:int = 0;
         var index:int = 0;
         var restListeners:Vector.<Function> = null;
         var i:int = 0;
         if(this._eventListeners)
         {
            listeners = this._eventListeners[type] as Vector.<Function>;
            numListeners = listeners ? int(listeners.length) : 0;
            if(numListeners > 0)
            {
               index = listeners.indexOf(listener);
               if(index != -1)
               {
                  if(this._eventStack.indexOf(type) == -1)
                  {
                     listeners.removeAt(index);
                  }
                  else
                  {
                     restListeners = listeners.slice(0,index);
                     for(i = index + 1; i < numListeners; i++)
                     {
                        restListeners[i - 1] = listeners[i];
                     }
                     this._eventListeners[type] = restListeners;
                  }
               }
            }
         }
      }
      
      public function removeEventListeners(type:String = null) : void
      {
         if(Boolean(type) && Boolean(this._eventListeners))
         {
            delete this._eventListeners[type];
         }
         else
         {
            this._eventListeners = null;
         }
      }
      
      public function dispatchEvent(event:Event) : void
      {
         var bubbles:Boolean = event.bubbles;
         if(!bubbles && (this._eventListeners == null || !(event.type in this._eventListeners)))
         {
            return;
         }
         var previousTarget:EventDispatcher = event.target;
         event.setTarget(this);
         if(bubbles && this is DisplayObject)
         {
            this.bubbleEvent(event);
         }
         else
         {
            this.invokeEvent(event);
         }
         if(previousTarget)
         {
            event.setTarget(previousTarget);
         }
      }
      
      internal function invokeEvent(event:Event) : Boolean
      {
         var i:int = 0;
         var listener:Function = null;
         var numArgs:int = 0;
         var listeners:Vector.<Function> = this._eventListeners ? this._eventListeners[event.type] as Vector.<Function> : null;
         var numListeners:int = listeners == null ? 0 : int(listeners.length);
         if(numListeners)
         {
            event.setCurrentTarget(this);
            this._eventStack[this._eventStack.length] = event.type;
            for(i = 0; i < numListeners; i++)
            {
               listener = listeners[i] as Function;
               numArgs = listener.length;
               if(numArgs == 0)
               {
                  listener();
               }
               else if(numArgs == 1)
               {
                  listener(event);
               }
               else
               {
                  listener(event,event.data);
               }
               if(event.stopsImmediatePropagation)
               {
                  return true;
               }
            }
            this._eventStack.pop();
            return event.stopsPropagation;
         }
         return false;
      }
      
      internal function bubbleEvent(event:Event) : void
      {
         var chain:Vector.<EventDispatcher> = null;
         var stopPropagation:Boolean = false;
         var element:DisplayObject = this as DisplayObject;
         var length:* = 1;
         if(sBubbleChains.length > 0)
         {
            chain = sBubbleChains.pop();
            chain[0] = element;
         }
         else
         {
            chain = new <EventDispatcher>[element];
         }
         while(true)
         {
            element = element.parent;
            if(element == null)
            {
               break;
            }
            chain[int(length++)] = element;
         }
         for(var i:int = 0; i < length; i++)
         {
            stopPropagation = chain[i].invokeEvent(event);
            if(stopPropagation)
            {
               break;
            }
         }
         chain.length = 0;
         sBubbleChains[sBubbleChains.length] = chain;
      }
      
      public function dispatchEventWith(type:String, bubbles:Boolean = false, data:Object = null) : void
      {
         var event:Event = null;
         if(bubbles || this.hasEventListener(type))
         {
            event = Event.fromPool(type,bubbles,data);
            this.dispatchEvent(event);
            Event.toPool(event);
         }
      }
      
      public function hasEventListener(type:String, listener:Function = null) : Boolean
      {
         var listeners:Vector.<Function> = this._eventListeners ? this._eventListeners[type] : null;
         if(listeners == null)
         {
            return false;
         }
         if(listener != null)
         {
            return listeners.indexOf(listener) != -1;
         }
         return listeners.length != 0;
      }
   }
}

