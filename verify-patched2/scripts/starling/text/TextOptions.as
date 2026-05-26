package starling.text
{
   import flash.text.StyleSheet;
   import starling.core.*;
   import starling.events.*;
   
   public class TextOptions extends EventDispatcher
   {
      
      private var _wordWrap:Boolean;
      
      private var _autoScale:Boolean;
      
      private var _autoSize:String;
      
      private var _isHtmlText:Boolean;
      
      private var _textureScale:Number;
      
      private var _textureFormat:String;
      
      private var _styleSheet:StyleSheet;
      
      private var _padding:Number;
      
      public function TextOptions(wordWrap:Boolean = true, autoScale:Boolean = false)
      {
         super();
         this._wordWrap = wordWrap;
         this._autoScale = autoScale;
         this._autoSize = TextFieldAutoSize.NONE;
         this._textureScale = Starling.contentScaleFactor;
         this._textureFormat = TextField.defaultTextureFormat;
         this._isHtmlText = false;
         this._padding = 0;
      }
      
      public function copyFrom(options:TextOptions) : void
      {
         this._wordWrap = options._wordWrap;
         this._autoScale = options._autoScale;
         this._autoSize = options._autoSize;
         this._isHtmlText = options._isHtmlText;
         this._textureScale = options._textureScale;
         this._textureFormat = options._textureFormat;
         this._styleSheet = options._styleSheet;
         this._padding = options._padding;
         dispatchEventWith(Event.CHANGE);
      }
      
      public function clone() : TextOptions
      {
         var actualClass:Class = Object(this).constructor as Class;
         var clone:TextOptions = new actualClass() as TextOptions;
         clone.copyFrom(this);
         return clone;
      }
      
      public function get wordWrap() : Boolean
      {
         return this._wordWrap;
      }
      
      public function set wordWrap(value:Boolean) : void
      {
         if(this._wordWrap != value)
         {
            this._wordWrap = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get autoSize() : String
      {
         return this._autoSize;
      }
      
      public function set autoSize(value:String) : void
      {
         if(this._autoSize != value)
         {
            this._autoSize = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get autoScale() : Boolean
      {
         return this._autoScale;
      }
      
      public function set autoScale(value:Boolean) : void
      {
         if(this._autoScale != value)
         {
            this._autoScale = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get isHtmlText() : Boolean
      {
         return this._isHtmlText;
      }
      
      public function set isHtmlText(value:Boolean) : void
      {
         if(this._isHtmlText != value)
         {
            this._isHtmlText = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get styleSheet() : StyleSheet
      {
         return this._styleSheet;
      }
      
      public function set styleSheet(value:StyleSheet) : void
      {
         this._styleSheet = value;
         dispatchEventWith(Event.CHANGE);
      }
      
      public function get textureScale() : Number
      {
         return this._textureScale;
      }
      
      public function set textureScale(value:Number) : void
      {
         this._textureScale = value;
      }
      
      public function get textureFormat() : String
      {
         return this._textureFormat;
      }
      
      public function set textureFormat(value:String) : void
      {
         if(this._textureFormat != value)
         {
            this._textureFormat = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
      
      public function get padding() : Number
      {
         return this._padding;
      }
      
      public function set padding(value:Number) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         if(this._padding != value)
         {
            this._padding = value;
            dispatchEventWith(Event.CHANGE);
         }
      }
   }
}

