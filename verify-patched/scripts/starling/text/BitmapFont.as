package starling.text
{
   import flash.geom.*;
   import flash.utils.*;
   import starling.display.*;
   import starling.textures.*;
   import starling.utils.*;
   
   public class BitmapFont implements ITextCompositor
   {
      
      public static const NATIVE_SIZE:int = -1;
      
      public static const MINI:String = "mini";
      
      private static const CHAR_SPACE:int = 32;
      
      private static const CHAR_TAB:int = 9;
      
      private static const CHAR_NEWLINE:int = 10;
      
      private static const CHAR_CARRIAGE_RETURN:int = 13;
      
      private static var sLines:Array = [];
      
      private static var sDefaultOptions:TextOptions = new TextOptions();
      
      private var _texture:Texture;
      
      private var _chars:Dictionary;
      
      private var _name:String;
      
      private var _size:Number;
      
      private var _lineHeight:Number;
      
      private var _baseline:Number;
      
      private var _offsetX:Number;
      
      private var _offsetY:Number;
      
      private var _padding:Number;
      
      private var _helperImage:Image;
      
      public function BitmapFont(texture:Texture = null, fontXml:XML = null)
      {
         super();
         if(texture == null && fontXml == null)
         {
            texture = MiniBitmapFont.texture;
            fontXml = MiniBitmapFont.xml;
         }
         else if(texture == null || fontXml == null)
         {
            throw new ArgumentError("Set both of the \'texture\' and \'fontXml\' arguments to valid objects or leave both of them null.");
         }
         this._name = "unknown";
         this._lineHeight = this._size = this._baseline = 14;
         this._offsetX = this._offsetY = this._padding = 0;
         this._texture = texture;
         this._chars = new Dictionary();
         this._helperImage = new Image(texture);
         this.parseFontXml(fontXml);
      }
      
      public function dispose() : void
      {
         if(this._texture)
         {
            this._texture.dispose();
         }
      }
      
      private function parseFontXml(fontXml:XML) : void
      {
         var charElement:XML = null;
         var kerningElement:XML = null;
         var id:int = 0;
         var xOffset:Number = NaN;
         var yOffset:Number = NaN;
         var xAdvance:Number = NaN;
         var region:Rectangle = null;
         var texture:Texture = null;
         var bitmapChar:BitmapChar = null;
         var first:int = 0;
         var second:int = 0;
         var amount:Number = NaN;
         var scale:Number = Number(this._texture.scale);
         var frame:Rectangle = this._texture.frame;
         var frameX:Number = frame ? frame.x : 0;
         var frameY:Number = frame ? frame.y : 0;
         this._name = StringUtil.clean(fontXml.info.@face);
         this._size = parseFloat(fontXml.info.@size) / scale;
         this._lineHeight = parseFloat(fontXml.common.@lineHeight) / scale;
         this._baseline = parseFloat(fontXml.common.@base) / scale;
         if(fontXml.info.@smooth.toString() == "0")
         {
            this.smoothing = TextureSmoothing.NONE;
         }
         if(this._size <= 0)
         {
            trace("[Starling] Warning: invalid font size in \'" + this._name + "\' font.");
            this._size = this._size == 0 ? 16 : this._size * -1;
         }
         for each(charElement in fontXml.chars.char)
         {
            id = int(parseInt(charElement.@id));
            xOffset = parseFloat(charElement.@xoffset) / scale;
            yOffset = parseFloat(charElement.@yoffset) / scale;
            xAdvance = parseFloat(charElement.@xadvance) / scale;
            region = new Rectangle();
            region.x = parseFloat(charElement.@x) / scale + frameX;
            region.y = parseFloat(charElement.@y) / scale + frameY;
            region.width = parseFloat(charElement.@width) / scale;
            region.height = parseFloat(charElement.@height) / scale;
            texture = Texture.fromTexture(this._texture,region);
            bitmapChar = new BitmapChar(id,texture,xOffset,yOffset,xAdvance);
            this.addChar(id,bitmapChar);
         }
         for each(kerningElement in fontXml.kernings.kerning)
         {
            first = int(parseInt(kerningElement.@first));
            second = int(parseInt(kerningElement.@second));
            amount = parseFloat(kerningElement.@amount) / scale;
            if(second in this._chars)
            {
               this.getChar(second).addKerning(first,amount);
            }
         }
      }
      
      public function getChar(charID:int) : BitmapChar
      {
         return this._chars[charID];
      }
      
      public function addChar(charID:int, bitmapChar:BitmapChar) : void
      {
         this._chars[charID] = bitmapChar;
      }
      
      public function getCharIDs(out:Vector.<int> = null) : Vector.<int>
      {
         var key:* = undefined;
         if(out == null)
         {
            out = new Vector.<int>(0);
         }
         for(key in this._chars)
         {
            out[out.length] = int(key);
         }
         return out;
      }
      
      public function hasChars(text:String) : Boolean
      {
         var charID:int = 0;
         if(text == null)
         {
            return true;
         }
         var numChars:int = text.length;
         for(var i:int = 0; i < numChars; i++)
         {
            charID = text.charCodeAt(i);
            if(charID != CHAR_SPACE && charID != CHAR_TAB && charID != CHAR_NEWLINE && charID != CHAR_CARRIAGE_RETURN && this.getChar(charID) == null)
            {
               return false;
            }
         }
         return true;
      }
      
      public function createSprite(width:Number, height:Number, text:String, format:TextFormat, options:TextOptions = null) : Sprite
      {
         var smoothing:String = null;
         var charLocation:CharLocation = null;
         var char:Image = null;
         var charLocations:Vector.<CharLocation> = this.arrangeChars(width,height,text,format,options);
         var numChars:int = int(charLocations.length);
         smoothing = this.smoothing;
         var sprite:Sprite = new Sprite();
         for(var i:int = 0; i < numChars; i++)
         {
            charLocation = charLocations[i];
            char = charLocation.char.createImage();
            char.x = charLocation.x;
            char.y = charLocation.y;
            char.scale = charLocation.scale;
            char.color = format.color;
            char.textureSmoothing = smoothing;
            sprite.addChild(char);
         }
         CharLocation.rechargePool();
         return sprite;
      }
      
      public function fillMeshBatch(meshBatch:MeshBatch, width:Number, height:Number, text:String, format:TextFormat, options:TextOptions = null) : void
      {
         var charLocation:CharLocation = null;
         var charLocations:Vector.<CharLocation> = this.arrangeChars(width,height,text,format,options);
         var numChars:int = int(charLocations.length);
         this._helperImage.color = format.color;
         for(var i:int = 0; i < numChars; i++)
         {
            charLocation = charLocations[i];
            this._helperImage.texture = charLocation.char.texture;
            this._helperImage.readjustSize();
            this._helperImage.x = charLocation.x;
            this._helperImage.y = charLocation.y;
            this._helperImage.scale = charLocation.scale;
            meshBatch.addMesh(this._helperImage);
         }
         CharLocation.rechargePool();
      }
      
      public function clearMeshBatch(meshBatch:MeshBatch) : void
      {
         meshBatch.clear();
      }
      
      private function arrangeChars(width:Number, height:Number, text:String, format:TextFormat, options:TextOptions) : Vector.<CharLocation>
      {
         var charLocation:CharLocation = null;
         var numChars:int = 0;
         var containerWidth:Number = NaN;
         var containerHeight:Number = NaN;
         var scale:Number = NaN;
         var i:int = 0;
         var j:int = 0;
         var lastWhiteSpace:int = 0;
         var lastCharID:int = 0;
         var currentX:Number = NaN;
         var currentY:Number = NaN;
         var currentLine:Vector.<CharLocation> = null;
         var lineFull:Boolean = false;
         var charID:int = 0;
         var char:BitmapChar = null;
         var numCharsToRemove:int = 0;
         var line:Vector.<CharLocation> = null;
         var xOffset:int = 0;
         var lastLocation:CharLocation = null;
         var right:Number = NaN;
         var c:int = 0;
         if(text == null || text.length == 0)
         {
            return CharLocation.vectorFromPool();
         }
         if(options == null)
         {
            options = sDefaultOptions;
         }
         var kerning:Boolean = format.kerning;
         var leading:Number = format.leading;
         var hAlign:String = format.horizontalAlign;
         var vAlign:String = format.verticalAlign;
         var fontSize:Number = format.size;
         var autoScale:Boolean = options.autoScale;
         var wordWrap:Boolean = options.wordWrap;
         var finished:Boolean = false;
         if(fontSize < 0)
         {
            fontSize *= -this._size;
         }
         while(!finished)
         {
            sLines.length = 0;
            scale = fontSize / this._size;
            containerWidth = (width - 2 * this._padding) / scale;
            containerHeight = (height - 2 * this._padding) / scale;
            if(this._lineHeight <= containerHeight)
            {
               lastWhiteSpace = -1;
               lastCharID = -1;
               currentX = 0;
               currentY = 0;
               currentLine = CharLocation.vectorFromPool();
               numChars = text.length;
               for(i = 0; i < numChars; i++)
               {
                  lineFull = false;
                  charID = text.charCodeAt(i);
                  char = this.getChar(charID);
                  if(charID == CHAR_NEWLINE || charID == CHAR_CARRIAGE_RETURN)
                  {
                     lineFull = true;
                  }
                  else if(char == null)
                  {
                     trace("[Starling] Font: " + this.name + " missing character: " + text.charAt(i) + " id: " + charID);
                  }
                  else
                  {
                     if(charID == CHAR_SPACE || charID == CHAR_TAB)
                     {
                        lastWhiteSpace = i;
                     }
                     if(kerning)
                     {
                        currentX += char.getKerning(lastCharID);
                     }
                     charLocation = CharLocation.instanceFromPool(char);
                     charLocation.x = currentX + char.xOffset;
                     charLocation.y = currentY + char.yOffset;
                     currentLine[currentLine.length] = charLocation;
                     currentX += char.xAdvance;
                     lastCharID = charID;
                     if(charLocation.x + char.width > containerWidth)
                     {
                        if(wordWrap)
                        {
                           if(autoScale && lastWhiteSpace == -1)
                           {
                              break;
                           }
                           numCharsToRemove = lastWhiteSpace == -1 ? 1 : int(i - lastWhiteSpace);
                           for(j = 0; j < numCharsToRemove; j++)
                           {
                              currentLine.pop();
                           }
                           if(currentLine.length == 0)
                           {
                              break;
                           }
                           i -= numCharsToRemove;
                        }
                        else
                        {
                           if(autoScale)
                           {
                              break;
                           }
                           currentLine.pop();
                           while(i < numChars - 1 && text.charCodeAt(i) != CHAR_NEWLINE)
                           {
                              i++;
                           }
                        }
                        lineFull = true;
                     }
                  }
                  if(i == numChars - 1)
                  {
                     sLines[sLines.length] = currentLine;
                     finished = true;
                  }
                  else if(lineFull)
                  {
                     sLines[sLines.length] = currentLine;
                     if(lastWhiteSpace == i)
                     {
                        currentLine.pop();
                     }
                     if(currentY + leading + 2 * this._lineHeight > containerHeight)
                     {
                        break;
                     }
                     currentLine = CharLocation.vectorFromPool();
                     currentX = 0;
                     currentY += this._lineHeight + leading;
                     lastWhiteSpace = -1;
                     lastCharID = -1;
                  }
               }
            }
            if(autoScale && !finished && fontSize > 3)
            {
               fontSize--;
            }
            else
            {
               finished = true;
            }
         }
         var finalLocations:Vector.<CharLocation> = CharLocation.vectorFromPool();
         var numLines:int = int(sLines.length);
         var bottom:Number = currentY + this._lineHeight;
         var yOffset:int = 0;
         if(vAlign == Align.BOTTOM)
         {
            yOffset = containerHeight - bottom;
         }
         else if(vAlign == Align.CENTER)
         {
            yOffset = (containerHeight - bottom) / 2;
         }
         for(var lineID:int = 0; lineID < numLines; lineID++)
         {
            line = sLines[lineID];
            numChars = int(line.length);
            if(numChars != 0)
            {
               xOffset = 0;
               lastLocation = line[line.length - 1];
               right = lastLocation.x - lastLocation.char.xOffset + lastLocation.char.xAdvance;
               if(hAlign == Align.RIGHT)
               {
                  xOffset = containerWidth - right;
               }
               else if(hAlign == Align.CENTER)
               {
                  xOffset = (containerWidth - right) / 2;
               }
               for(c = 0; c < numChars; c++)
               {
                  charLocation = line[c];
                  charLocation.x = scale * (charLocation.x + xOffset + this._offsetX) + this._padding;
                  charLocation.y = scale * (charLocation.y + yOffset + this._offsetY) + this._padding;
                  charLocation.scale = scale;
                  if(charLocation.char.width > 0 && charLocation.char.height > 0)
                  {
                     finalLocations[finalLocations.length] = charLocation;
                  }
               }
            }
         }
         return finalLocations;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get size() : Number
      {
         return this._size;
      }
      
      public function get lineHeight() : Number
      {
         return this._lineHeight;
      }
      
      public function set lineHeight(value:Number) : void
      {
         this._lineHeight = value;
      }
      
      public function get smoothing() : String
      {
         return this._helperImage.textureSmoothing;
      }
      
      public function set smoothing(value:String) : void
      {
         this._helperImage.textureSmoothing = value;
      }
      
      public function get baseline() : Number
      {
         return this._baseline;
      }
      
      public function set baseline(value:Number) : void
      {
         this._baseline = value;
      }
      
      public function get offsetX() : Number
      {
         return this._offsetX;
      }
      
      public function set offsetX(value:Number) : void
      {
         this._offsetX = value;
      }
      
      public function get offsetY() : Number
      {
         return this._offsetY;
      }
      
      public function set offsetY(value:Number) : void
      {
         this._offsetY = value;
      }
      
      public function get padding() : Number
      {
         return this._padding;
      }
      
      public function set padding(value:Number) : void
      {
         this._padding = value;
      }
      
      public function get texture() : Texture
      {
         return this._texture;
      }
   }
}

class CharLocation
{
   
   private static var sInstancePool:Vector.<CharLocation> = new Vector.<CharLocation>(0);
   
   private static var sVectorPool:Array = [];
   
   private static var sInstanceLoan:Vector.<CharLocation> = new Vector.<CharLocation>(0);
   
   private static var sVectorLoan:Array = [];
   
   public var char:BitmapChar;
   
   public var scale:Number;
   
   public var x:Number;
   
   public var y:Number;
   
   public function CharLocation(char:BitmapChar)
   {
      super();
      this.reset(char);
   }
   
   public static function instanceFromPool(char:BitmapChar) : CharLocation
   {
      var instance:CharLocation = sInstancePool.length > 0 ? sInstancePool.pop() : new CharLocation(char);
      instance.reset(char);
      sInstanceLoan[sInstanceLoan.length] = instance;
      return instance;
   }
   
   public static function vectorFromPool() : Vector.<CharLocation>
   {
      var vector:Vector.<CharLocation> = sVectorPool.length > 0 ? sVectorPool.pop() : new Vector.<CharLocation>(0);
      vector.length = 0;
      sVectorLoan[sVectorLoan.length] = vector;
      return vector;
   }
   
   public static function rechargePool() : void
   {
      var instance:CharLocation = null;
      var vector:Vector.<CharLocation> = null;
      while(sInstanceLoan.length > 0)
      {
         instance = sInstanceLoan.pop();
         instance.char = null;
         sInstancePool[sInstancePool.length] = instance;
      }
      while(sVectorLoan.length > 0)
      {
         vector = sVectorLoan.pop();
         vector.length = 0;
         sVectorPool[sVectorPool.length] = vector;
      }
   }
   
   private function reset(char:BitmapChar) : CharLocation
   {
      this.char = char;
      return this;
   }
}
