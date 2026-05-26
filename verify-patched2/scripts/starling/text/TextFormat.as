package starling.text
{
   import flash.text.TextFormat;
   import starling.events.*;
   import starling.utils.*;
   
   public class TextFormat extends EventDispatcher
   {
      
      private var _font:String;
      
      private var _size:Number;
      
      private var _color:uint;
      
      private var _bold:Boolean;
      
      private var _italic:Boolean;
      
      private var _underline:Boolean;
      
      private var _horizontalAlign:String;
      
      private var _verticalAlign:String;
      
      private var _kerning:Boolean;
      
      private var _leading:Number;
      
      private var _letterSpacing:Number;
      
      public function TextFormat(font:String = "Verdana", size:Number = 12, color:uint = 0, horizontalAlign:String = "center", verticalAlign:String = "center")
      {
         super();
         this._font = font;
         this._size = size;
         this._color = color;
         this._horizontalAlign = horizontalAlign;
         this._verticalAlign = verticalAlign;
         this._kerning = true;
         this._letterSpacing = this._leading = 0;
      }
      
      public function copyFrom(format:starling.text.TextFormat) : void
      {
         this._font = format._font;
         this._size = format._size;
         this._color = format._color;
         this._bold = format._bold;
         this._italic = format._italic;
         this._underline = format._underline;
         this._horizontalAlign = format._horizontalAlign;
         this._verticalAlign = format._verticalAlign;
         this._kerning = format._kerning;
         this._leading = format._leading;
         this._letterSpacing = format._letterSpacing;
         dispatchEventWith(Event.CHANGE);
      }
      
      public function clone() : starling.text.TextFormat
      {
         var actualClass:Class = Object(this).constructor as Class;
         var clone:starling.text.TextFormat = new actualClass() as starling.text.TextFormat;
         clone.copyFrom(this);
         return clone;
      }
      
      public function setTo(font:String = "Verdana", size:Number = 12, color:uint = 0, horizontalAlign:String = "center", verticalAlign:String = "center") : void
      {
         this._font = font;
         this._size = size;
         this._color = color;
         this._horizontalAlign = horizontalAlign;
         this._verticalAlign = verticalAlign;
         dispatchEventWith(Event.CHANGE);
      }
      
      public function toNativeFormat(out:flash.text.TextFormat = null) : flash.text.TextFormat
      {
         if(out == null)
         {
            out = new flash.text.TextFormat();
         }
         out.font = this._font;
         out.size = this._size;
         out.color = this._color;
         out.bold = this._bold;
         out.italic = this._italic;
         out.underline = this._underline;
         out.align = this._horizontalAlign;
         out.kerning = this._kerning;
         out.leading = this._leading;
         out.letterSpacing = this._letterSpacing;
         return out;
      }
      
      public function get font() : String
      {
         return this._font;
      }
      
      public function set font(value:String) : void
      {
         if(value != this._font)
         {
            this._font = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get size() : Number
      {
         return this._size;
      }
      
      public function set size(value:Number) : void
      {
         if(value != this._size)
         {
            this._size = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(value:uint) : void
      {
         if(value != this._color)
         {
            this._color = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get bold() : Boolean
      {
         return this._bold;
      }
      
      public function set bold(value:Boolean) : void
      {
         if(value != this._bold)
         {
            this._bold = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get italic() : Boolean
      {
         return this._italic;
      }
      
      public function set italic(value:Boolean) : void
      {
         if(value != this._italic)
         {
            this._italic = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get underline() : Boolean
      {
         return this._underline;
      }
      
      public function set underline(value:Boolean) : void
      {
         if(value != this._underline)
         {
            this._underline = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get horizontalAlign() : String
      {
         return this._horizontalAlign;
      }
      
      public function set horizontalAlign(value:String) : void
      {
         if(!Align.isValidHorizontal(value))
         {
            throw new ArgumentError("Invalid horizontal alignment");
         }
         if(value != this._horizontalAlign)
         {
            this._horizontalAlign = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get verticalAlign() : String
      {
         return this._verticalAlign;
      }
      
      public function set verticalAlign(value:String) : void
      {
         if(!Align.isValidVertical(value))
         {
            throw new ArgumentError("Invalid vertical alignment");
         }
         if(value != this._verticalAlign)
         {
            this._verticalAlign = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get kerning() : Boolean
      {
         return this._kerning;
      }
      
      public function set kerning(value:Boolean) : void
      {
         if(value != this._kerning)
         {
            this._kerning = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get leading() : Number
      {
         return this._leading;
      }
      
      public function set leading(value:Number) : void
      {
         if(value != this._leading)
         {
            this._leading = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get letterSpacing() : Number
      {
         return this._letterSpacing;
      }
      
      public function set letterSpacing(value:Number) : void
      {
         if(value != this._letterSpacing)
         {
            this._letterSpacing = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
   }
}

