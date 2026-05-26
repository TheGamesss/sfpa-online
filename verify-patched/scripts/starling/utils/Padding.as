package starling.utils
{
   import starling.events.*;
   
   public class Padding extends EventDispatcher
   {
      
      private var _left:Number;
      
      private var _right:Number;
      
      private var _top:Number;
      
      private var _bottom:Number;
      
      public function Padding(left:Number = 0, right:Number = 0, top:Number = 0, bottom:Number = 0)
      {
         super();
         this.setTo(left,right,top,bottom);
      }
      
      public function setTo(left:Number = 0, right:Number = 0, top:Number = 0, bottom:Number = 0) : void
      {
         var changed:Boolean = this._left != left || this._right != right || this._top != top || this._bottom != bottom;
         this._left = left;
         this._right = right;
         this._top = top;
         this._bottom = bottom;
         if(changed)
         {
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function setToUniform(value:Number) : void
      {
         this.setTo(value,value,value,value);
      }
      
      public function setToSymmetric(horizontal:Number, vertical:Number) : void
      {
         this.setTo(horizontal,horizontal,vertical,vertical);
      }
      
      public function copyFrom(padding:Padding) : void
      {
         if(padding == null)
         {
            this.setTo(0,0,0,0);
         }
         else
         {
            this.setTo(padding._left,padding._right,padding._top,padding._bottom);
         }
      }
      
      public function clone() : Padding
      {
         return new Padding(this._left,this._right,this._top,this._bottom);
      }
      
      public function get left() : Number
      {
         return this._left;
      }
      
      public function set left(value:Number) : void
      {
         if(this._left != value)
         {
            this._left = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get right() : Number
      {
         return this._right;
      }
      
      public function set right(value:Number) : void
      {
         if(this._right != value)
         {
            this._right = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get top() : Number
      {
         return this._top;
      }
      
      public function set top(value:Number) : void
      {
         if(this._top != value)
         {
            this._top = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get bottom() : Number
      {
         return this._bottom;
      }
      
      public function set bottom(value:Number) : void
      {
         if(this._bottom != value)
         {
            this._bottom = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get horizontal() : Number
      {
         return this._left + this._right;
      }
      
      public function get vertical() : Number
      {
         return this._top + this._bottom;
      }
   }
}

