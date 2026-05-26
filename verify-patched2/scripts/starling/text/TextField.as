package starling.text
{
   import flash.display3D.*;
   import flash.geom.*;
   import flash.text.StyleSheet;
   import flash.utils.*;
   import starling.core.*;
   import starling.display.*;
   import starling.events.*;
   import starling.rendering.Painter;
   import starling.styles.MeshStyle;
   import starling.utils.*;
   
   public class TextField extends DisplayObjectContainer
   {
      
      private static const COMPOSITOR_DATA_NAME:String = "starling.display.TextField.compositors";
      
      private static var sMatrix:Matrix = new Matrix();
      
      private static var sDefaultCompositor:ITextCompositor = new TrueTypeCompositor();
      
      private static var sDefaultTextureFormat:String = Context3DTextureFormat.BGRA_PACKED;
      
      private static var sStringCache:Dictionary = new Dictionary();
      
      private var _text:String;
      
      private var _options:TextOptions;
      
      private var _format:TextFormat;
      
      private var _textBounds:Rectangle;
      
      private var _hitArea:Rectangle;
      
      private var _compositor:ITextCompositor;
      
      private var _requiresRecomposition:Boolean;
      
      private var _border:DisplayObjectContainer;
      
      private var _meshBatch:MeshBatch;
      
      private var _style:MeshStyle;
      
      private var _recomposing:Boolean;
      
      public function TextField(width:int, height:int, text:String = "", format:TextFormat = null, options:TextOptions = null)
      {
         super();
         this._text = text ? text : "";
         this._hitArea = new Rectangle(0,0,width,height);
         this._requiresRecomposition = true;
         this._compositor = sDefaultCompositor;
         this._format = format ? format.clone() : new TextFormat();
         this._format.addEventListener(Event.CHANGE,this.setRequiresRecomposition);
         this._options = options ? options.clone() : new TextOptions();
         this._options.addEventListener(Event.CHANGE,this.setRequiresRecomposition);
         this._meshBatch = new MeshBatch();
         this._meshBatch.touchable = false;
         this._meshBatch.pixelSnapping = true;
         addChild(this._meshBatch);
      }
      
      public static function get defaultTextureFormat() : String
      {
         return sDefaultTextureFormat;
      }
      
      public static function set defaultTextureFormat(value:String) : void
      {
         sDefaultTextureFormat = value;
      }
      
      public static function get defaultCompositor() : ITextCompositor
      {
         return sDefaultCompositor;
      }
      
      public static function set defaultCompositor(value:ITextCompositor) : void
      {
         sDefaultCompositor = value;
      }
      
      public static function updateEmbeddedFonts() : void
      {
         SystemUtil.updateEmbeddedFonts();
      }
      
      public static function registerCompositor(compositor:ITextCompositor, fontName:String) : void
      {
         if(fontName == null)
         {
            throw new ArgumentError("fontName must not be null");
         }
         compositors[convertToLowerCase(fontName)] = compositor;
      }
      
      public static function unregisterCompositor(fontName:String, dispose:Boolean = true) : void
      {
         fontName = convertToLowerCase(fontName);
         if(dispose && compositors[fontName] != undefined)
         {
            compositors[fontName].dispose();
         }
         delete compositors[fontName];
      }
      
      public static function getCompositor(fontName:String) : ITextCompositor
      {
         return compositors[convertToLowerCase(fontName)];
      }
      
      public static function registerBitmapFont(bitmapFont:BitmapFont, name:String = null) : String
      {
         if(name == null)
         {
            name = bitmapFont.name;
         }
         registerCompositor(bitmapFont,name);
         return name;
      }
      
      public static function unregisterBitmapFont(name:String, dispose:Boolean = true) : void
      {
         unregisterCompositor(name,dispose);
      }
      
      public static function getBitmapFont(name:String) : BitmapFont
      {
         return getCompositor(name) as BitmapFont;
      }
      
      private static function get compositors() : Dictionary
      {
         var compositors:Dictionary = Starling.painter.sharedData[COMPOSITOR_DATA_NAME] as Dictionary;
         if(compositors == null)
         {
            compositors = new Dictionary();
            Starling.painter.sharedData[COMPOSITOR_DATA_NAME] = compositors;
         }
         return compositors;
      }
      
      private static function convertToLowerCase(string:String) : String
      {
         var result:String = sStringCache[string];
         if(result == null)
         {
            result = string.toLowerCase();
            sStringCache[string] = result;
         }
         return result;
      }
      
      override public function dispose() : void
      {
         this._format.removeEventListener(Event.CHANGE,this.setRequiresRecomposition);
         this._options.removeEventListener(Event.CHANGE,this.setRequiresRecomposition);
         this._compositor.clearMeshBatch(this._meshBatch);
         super.dispose();
      }
      
      override public function render(painter:Painter) : void
      {
         if(this._requiresRecomposition)
         {
            this.recompose();
         }
         super.render(painter);
      }
      
      private function recompose() : void
      {
         var fontName:String = null;
         var compositor:ITextCompositor = null;
         if(this._requiresRecomposition)
         {
            this._recomposing = true;
            this._compositor.clearMeshBatch(this._meshBatch);
            fontName = this._format.font;
            compositor = getCompositor(fontName);
            if(compositor == null && fontName == BitmapFont.MINI)
            {
               compositor = new BitmapFont();
               registerCompositor(compositor,fontName);
            }
            this._compositor = compositor ? compositor : sDefaultCompositor;
            this.updateText();
            this.updateBorder();
            this._requiresRecomposition = false;
            this._recomposing = false;
         }
      }
      
      private function updateText() : void
      {
         var width:Number = Number(this._hitArea.width);
         var height:Number = Number(this._hitArea.height);
         if(Boolean(this.isHorizontalAutoSize) && !this._options.isHtmlText)
         {
            width = 100000;
         }
         if(this.isVerticalAutoSize)
         {
            height = 100000;
         }
         this._meshBatch.x = this._meshBatch.y = 0;
         this._options.textureScale = Starling.contentScaleFactor;
         this._compositor.fillMeshBatch(this._meshBatch,width,height,this._text,this._format,this._options);
         if(this._style)
         {
            this._meshBatch.style = this._style;
         }
         if(this._options.autoSize != TextFieldAutoSize.NONE)
         {
            this._textBounds = this._meshBatch.getBounds(this._meshBatch,this._textBounds);
            if(this.isHorizontalAutoSize)
            {
               this._meshBatch.x = this._textBounds.x = -this._textBounds.x;
               this._hitArea.width = this._textBounds.width;
               this._textBounds.x = 0;
            }
            if(this.isVerticalAutoSize)
            {
               this._meshBatch.y = this._textBounds.y = -this._textBounds.y;
               this._hitArea.height = this._textBounds.height;
               this._textBounds.y = 0;
            }
         }
         else
         {
            this._textBounds = null;
         }
      }
      
      private function updateBorder() : void
      {
         if(this._border == null)
         {
            return;
         }
         var width:Number = Number(this._hitArea.width);
         var height:Number = Number(this._hitArea.height);
         var topLine:Quad = this._border.getChildAt(0) as Quad;
         var rightLine:Quad = this._border.getChildAt(1) as Quad;
         var bottomLine:Quad = this._border.getChildAt(2) as Quad;
         var leftLine:Quad = this._border.getChildAt(3) as Quad;
         topLine.width = width;
         topLine.height = 1;
         bottomLine.width = width;
         bottomLine.height = 1;
         leftLine.width = 1;
         leftLine.height = height;
         rightLine.width = 1;
         rightLine.height = height;
         rightLine.x = width - 1;
         bottomLine.y = height - 1;
         topLine.color = rightLine.color = bottomLine.color = leftLine.color = this._format.color;
      }
      
      public function setRequiresRecomposition() : void
      {
         if(!this._recomposing)
         {
            this._requiresRecomposition = true;
            setRequiresRedraw();
         }
      }
      
      private function get isHorizontalAutoSize() : Boolean
      {
         return this._options.autoSize == TextFieldAutoSize.HORIZONTAL || this._options.autoSize == TextFieldAutoSize.BOTH_DIRECTIONS;
      }
      
      private function get isVerticalAutoSize() : Boolean
      {
         return this._options.autoSize == TextFieldAutoSize.VERTICAL || this._options.autoSize == TextFieldAutoSize.BOTH_DIRECTIONS;
      }
      
      public function get textBounds() : Rectangle
      {
         if(this._requiresRecomposition)
         {
            this.recompose();
         }
         if(this._textBounds == null)
         {
            this._textBounds = this._meshBatch.getBounds(this);
         }
         return this._textBounds.clone();
      }
      
      override public function getBounds(targetSpace:DisplayObject, out:Rectangle = null) : Rectangle
      {
         if(this._requiresRecomposition)
         {
            this.recompose();
         }
         getTransformationMatrix(targetSpace,sMatrix);
         return RectangleUtil.getBounds(this._hitArea,sMatrix,out);
      }
      
      override public function hitTest(localPoint:Point) : DisplayObject
      {
         if(!visible || !touchable || !hitTestMask(localPoint))
         {
            return null;
         }
         if(this._hitArea.containsPoint(localPoint))
         {
            return this;
         }
         return null;
      }
      
      override public function set width(value:Number) : void
      {
         this._hitArea.width = value / (scaleX || 1);
         this.setRequiresRecomposition();
      }
      
      override public function set height(value:Number) : void
      {
         this._hitArea.height = value / (scaleY || 1);
         this.setRequiresRecomposition();
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(value:String) : void
      {
         if(value == null)
         {
            value = "";
         }
         if(this._text != value)
         {
            this._text = value;
            this.setRequiresRecomposition();
         }
      }
      
      public function get format() : TextFormat
      {
         return this._format;
      }
      
      public function set format(value:TextFormat) : void
      {
         if(value == null)
         {
            throw new ArgumentError("format cannot be null");
         }
         this._format.copyFrom(value);
      }
      
      protected function get options() : TextOptions
      {
         return this._options;
      }
      
      public function get border() : Boolean
      {
         return this._border != null;
      }
      
      public function set border(value:Boolean) : void
      {
         var i:int = 0;
         if(value && this._border == null)
         {
            this._border = new Sprite();
            addChild(this._border);
            for(i = 0; i < 4; i++)
            {
               this._border.addChild(new Quad(1,1));
            }
            this.updateBorder();
         }
         else if(!value && this._border != null)
         {
            this._border.removeFromParent(true);
            this._border = null;
         }
      }
      
      public function get autoScale() : Boolean
      {
         return this._options.autoScale;
      }
      
      public function set autoScale(value:Boolean) : void
      {
         this._options.autoScale = value;
      }
      
      public function get autoSize() : String
      {
         return this._options.autoSize;
      }
      
      public function set autoSize(value:String) : void
      {
         this._options.autoSize = value;
      }
      
      public function get wordWrap() : Boolean
      {
         return this._options.wordWrap;
      }
      
      public function set wordWrap(value:Boolean) : void
      {
         this._options.wordWrap = value;
      }
      
      public function get batchable() : Boolean
      {
         return this._meshBatch.batchable;
      }
      
      public function set batchable(value:Boolean) : void
      {
         this._meshBatch.batchable = value;
      }
      
      public function get isHtmlText() : Boolean
      {
         return this._options.isHtmlText;
      }
      
      public function set isHtmlText(value:Boolean) : void
      {
         this._options.isHtmlText = value;
      }
      
      public function get styleSheet() : StyleSheet
      {
         return this._options.styleSheet;
      }
      
      public function set styleSheet(value:StyleSheet) : void
      {
         this._options.styleSheet = value;
      }
      
      public function get padding() : Number
      {
         return this._options.padding;
      }
      
      public function set padding(value:Number) : void
      {
         this._options.padding = value;
      }
      
      public function get pixelSnapping() : Boolean
      {
         return this._meshBatch.pixelSnapping;
      }
      
      public function set pixelSnapping(value:Boolean) : void
      {
         this._meshBatch.pixelSnapping = value;
      }
      
      public function get style() : MeshStyle
      {
         return this._meshBatch.style;
      }
      
      public function set style(value:MeshStyle) : void
      {
         this._meshBatch.style = this._style = value;
         this.setRequiresRecomposition();
      }
   }
}

