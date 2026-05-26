package starling.display
{
   import flash.geom.*;
   import flash.system.*;
   import flash.utils.*;
   import starling.core.starling_internal;
   import starling.errors.*;
   import starling.events.*;
   import starling.filters.FragmentFilter;
   import starling.rendering.*;
   import starling.utils.*;
   
   use namespace starling_internal;
   
   public class DisplayObjectContainer extends DisplayObject
   {
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sBroadcastListeners:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
      
      private static var sSortBuffer:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
      
      private static var sCacheToken:BatchToken = new BatchToken();
      
      private var _children:Vector.<DisplayObject>;
      
      private var _touchGroup:Boolean;
      
      public function DisplayObjectContainer()
      {
         super();
         if(Boolean(Capabilities.isDebugger) && getQualifiedClassName(this) == "starling.display::DisplayObjectContainer")
         {
            throw new AbstractClassError();
         }
         this._children = new Vector.<DisplayObject>(0);
      }
      
      private static function mergeSort(input:Vector.<DisplayObject>, compareFunc:Function, startIndex:int, length:int, buffer:Vector.<DisplayObject>) : void
      {
         var i:int = 0;
         var endIndex:int = 0;
         var halfLength:int = 0;
         var l:int = 0;
         var r:int = 0;
         if(length > 1)
         {
            endIndex = startIndex + length;
            halfLength = length / 2;
            l = startIndex;
            r = startIndex + halfLength;
            mergeSort(input,compareFunc,startIndex,halfLength,buffer);
            mergeSort(input,compareFunc,startIndex + halfLength,length - halfLength,buffer);
            for(i = 0; i < length; i++)
            {
               if(l < startIndex + halfLength && (r == endIndex || compareFunc(input[l],input[r]) <= 0))
               {
                  buffer[i] = input[l];
                  l++;
               }
               else
               {
                  buffer[i] = input[r];
                  r++;
               }
            }
            for(i = startIndex; i < endIndex; i++)
            {
               input[i] = buffer[int(i - startIndex)];
            }
         }
      }
      
      override public function dispose() : void
      {
         for(var i:* = int(this._children.length - 1); i >= 0; i--)
         {
            this._children[i].dispose();
         }
         super.dispose();
      }
      
      public function addChild(child:DisplayObject) : DisplayObject
      {
         return this.addChildAt(child,this._children.length);
      }
      
      public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         var container:DisplayObjectContainer = null;
         var numChildren:int = int(this._children.length);
         if(index >= 0 && index <= numChildren)
         {
            setRequiresRedraw();
            if(child.parent == this)
            {
               this.setChildIndex(child,index);
            }
            else
            {
               this._children.insertAt(index,child);
               child.removeFromParent();
               child.setParent(this);
               child.dispatchEventWith(Event.ADDED,true);
               if(stage)
               {
                  container = child as DisplayObjectContainer;
                  if(container)
                  {
                     container.broadcastEventWith(Event.ADDED_TO_STAGE);
                  }
                  else
                  {
                     child.dispatchEventWith(Event.ADDED_TO_STAGE);
                  }
               }
            }
            return child;
         }
         throw new RangeError("Invalid child index");
      }
      
      public function removeChild(child:DisplayObject, dispose:Boolean = false) : DisplayObject
      {
         var childIndex:int = this.getChildIndex(child);
         if(childIndex != -1)
         {
            return this.removeChildAt(childIndex,dispose);
         }
         return null;
      }
      
      public function removeChildAt(index:int, dispose:Boolean = false) : DisplayObject
      {
         var child:DisplayObject = null;
         var container:DisplayObjectContainer = null;
         if(index >= 0 && index < this._children.length)
         {
            setRequiresRedraw();
            child = this._children[index];
            child.dispatchEventWith(Event.REMOVED,true);
            if(stage)
            {
               container = child as DisplayObjectContainer;
               if(container)
               {
                  container.broadcastEventWith(Event.REMOVED_FROM_STAGE);
               }
               else
               {
                  child.dispatchEventWith(Event.REMOVED_FROM_STAGE);
               }
            }
            child.setParent(null);
            index = int(this._children.indexOf(child));
            if(index >= 0)
            {
               this._children.removeAt(index);
            }
            if(dispose)
            {
               child.dispose();
            }
            return child;
         }
         throw new RangeError("Invalid child index");
      }
      
      public function removeChildren(beginIndex:int = 0, endIndex:int = -1, dispose:Boolean = false) : void
      {
         if(endIndex < 0 || endIndex >= this.numChildren)
         {
            endIndex = this.numChildren - 1;
         }
         for(var i:int = beginIndex; i <= endIndex; i++)
         {
            this.removeChildAt(beginIndex,dispose);
         }
      }
      
      public function getChildAt(index:int) : DisplayObject
      {
         var numChildren:int = int(this._children.length);
         if(index < 0)
         {
            index = numChildren + index;
         }
         if(index >= 0 && index < numChildren)
         {
            return this._children[index];
         }
         throw new RangeError("Invalid child index");
      }
      
      public function getChildByName(name:String) : DisplayObject
      {
         var numChildren:int = int(this._children.length);
         for(var i:int = 0; i < numChildren; i++)
         {
            if(this._children[i].name == name)
            {
               return this._children[i];
            }
         }
         return null;
      }
      
      public function getChildIndex(child:DisplayObject) : int
      {
         return this._children.indexOf(child);
      }
      
      public function setChildIndex(child:DisplayObject, index:int) : void
      {
         var oldIndex:int = this.getChildIndex(child);
         if(oldIndex == index)
         {
            return;
         }
         if(oldIndex == -1)
         {
            throw new ArgumentError("Not a child of this container");
         }
         this._children.removeAt(oldIndex);
         this._children.insertAt(index,child);
         setRequiresRedraw();
      }
      
      public function swapChildren(child1:DisplayObject, child2:DisplayObject) : void
      {
         var index1:int = this.getChildIndex(child1);
         var index2:int = this.getChildIndex(child2);
         if(index1 == -1 || index2 == -1)
         {
            throw new ArgumentError("Not a child of this container");
         }
         this.swapChildrenAt(index1,index2);
      }
      
      public function swapChildrenAt(index1:int, index2:int) : void
      {
         var child1:DisplayObject = this.getChildAt(index1);
         var child2:DisplayObject = this.getChildAt(index2);
         this._children[index1] = child2;
         this._children[index2] = child1;
         setRequiresRedraw();
      }
      
      public function sortChildren(compareFunction:Function) : void
      {
         sSortBuffer.length = this._children.length;
         mergeSort(this._children,compareFunction,0,this._children.length,sSortBuffer);
         sSortBuffer.length = 0;
         setRequiresRedraw();
      }
      
      public function contains(child:DisplayObject) : Boolean
      {
         while(child)
         {
            if(child == this)
            {
               return true;
            }
            child = child.parent;
         }
         return false;
      }
      
      override public function getBounds(targetSpace:DisplayObject, out:Rectangle = null) : Rectangle
      {
         var minX:Number = NaN;
         var maxX:Number = NaN;
         var minY:Number = NaN;
         var maxY:Number = NaN;
         var i:int = 0;
         if(out == null)
         {
            out = new Rectangle();
         }
         var numChildren:int = int(this._children.length);
         if(numChildren == 0)
         {
            getTransformationMatrix(targetSpace,sHelperMatrix);
            MatrixUtil.transformCoords(sHelperMatrix,0,0,sHelperPoint);
            out.setTo(sHelperPoint.x,sHelperPoint.y,0,0);
         }
         else if(numChildren == 1)
         {
            this._children[0].getBounds(targetSpace,out);
         }
         else
         {
            minX = Number.MAX_VALUE;
            maxX = -Number.MAX_VALUE;
            minY = Number.MAX_VALUE;
            maxY = -Number.MAX_VALUE;
            for(i = 0; i < numChildren; i++)
            {
               this._children[i].getBounds(targetSpace,out);
               if(minX > out.x)
               {
                  minX = out.x;
               }
               if(maxX < out.right)
               {
                  maxX = out.right;
               }
               if(minY > out.y)
               {
                  minY = out.y;
               }
               if(maxY < out.bottom)
               {
                  maxY = out.bottom;
               }
            }
            out.setTo(minX,minY,maxX - minX,maxY - minY);
         }
         return out;
      }
      
      override public function hitTest(localPoint:Point) : DisplayObject
      {
         var child:DisplayObject = null;
         if(!visible || !touchable || !hitTestMask(localPoint))
         {
            return null;
         }
         var target:DisplayObject = null;
         var localX:Number = localPoint.x;
         var localY:Number = localPoint.y;
         var numChildren:int = int(this._children.length);
         for(var i:* = int(numChildren - 1); i >= 0; i--)
         {
            child = this._children[i];
            if(!child.isMask)
            {
               sHelperMatrix.copyFrom(child.transformationMatrix);
               sHelperMatrix.invert();
               MatrixUtil.transformCoords(sHelperMatrix,localX,localY,sHelperPoint);
               target = child.hitTest(sHelperPoint);
               if(target)
               {
                  return this._touchGroup ? this : target;
               }
            }
         }
         return null;
      }
      
      override public function render(painter:Painter) : void
      {
         var child:DisplayObject = null;
         var pushToken:BatchToken = null;
         var popToken:BatchToken = null;
         var filter:FragmentFilter = null;
         var mask:DisplayObject = null;
         var numChildren:int = int(this._children.length);
         var frameID:uint = painter.frameID;
         var cacheEnabled:Boolean = frameID != 0;
         var selfOrParentChanged:Boolean = _lastParentOrSelfChangeFrameID == frameID;
         painter.pushState();
         for(var i:int = 0; i < numChildren; i++)
         {
            child = this._children[i];
            if(child._hasVisibleArea)
            {
               if(i != 0)
               {
                  painter.restoreState();
               }
               if(selfOrParentChanged)
               {
                  child._lastParentOrSelfChangeFrameID = frameID;
               }
               if(child._lastParentOrSelfChangeFrameID != frameID && child._lastChildChangeFrameID != frameID && child._tokenFrameID == frameID - 1 && cacheEnabled)
               {
                  painter.fillToken(sCacheToken);
                  painter.drawFromCache(child._pushToken,child._popToken);
                  painter.fillToken(child._popToken);
                  child._pushToken.copyFrom(sCacheToken);
               }
               else
               {
                  pushToken = cacheEnabled ? child._pushToken : null;
                  popToken = cacheEnabled ? child._popToken : null;
                  filter = child._filter;
                  mask = child._mask;
                  painter.fillToken(pushToken);
                  painter.setStateTo(child.transformationMatrix,child.alpha,child.blendMode);
                  if(mask)
                  {
                     painter.drawMask(mask,child);
                  }
                  if(filter)
                  {
                     filter.render(painter);
                  }
                  else
                  {
                     child.render(painter);
                  }
                  if(mask)
                  {
                     painter.eraseMask(mask,child);
                  }
                  painter.fillToken(popToken);
               }
               if(cacheEnabled)
               {
                  child._tokenFrameID = frameID;
               }
            }
         }
         painter.popState();
      }
      
      public function broadcastEvent(event:Event) : void
      {
         if(event.bubbles)
         {
            throw new ArgumentError("Broadcast of bubbling events is prohibited");
         }
         var fromIndex:int = int(sBroadcastListeners.length);
         this.getChildEventListeners(this,event.type,sBroadcastListeners);
         var toIndex:int = int(sBroadcastListeners.length);
         for(var i:int = fromIndex; i < toIndex; i++)
         {
            sBroadcastListeners[i].dispatchEvent(event);
         }
         sBroadcastListeners.length = fromIndex;
      }
      
      public function broadcastEventWith(eventType:String, data:Object = null) : void
      {
         var event:Event = Event.fromPool(eventType,false,data);
         this.broadcastEvent(event);
         Event.toPool(event);
      }
      
      public function get numChildren() : int
      {
         return this._children.length;
      }
      
      public function get touchGroup() : Boolean
      {
         return this._touchGroup;
      }
      
      public function set touchGroup(value:Boolean) : void
      {
         this._touchGroup = value;
      }
      
      internal function getChildEventListeners(object:DisplayObject, eventType:String, listeners:Vector.<DisplayObject>) : void
      {
         var children:Vector.<DisplayObject> = null;
         var numChildren:int = 0;
         var i:int = 0;
         var container:DisplayObjectContainer = object as DisplayObjectContainer;
         if(object.hasEventListener(eventType))
         {
            listeners[listeners.length] = object;
         }
         if(container)
         {
            children = container._children;
            numChildren = int(children.length);
            for(i = 0; i < numChildren; i++)
            {
               this.getChildEventListeners(children[i],eventType,listeners);
            }
         }
      }
   }
}

