package com.emibap.textureAtlas
{
   import flash.display.*;
   import flash.display3D.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import starling.textures.*;
   
   public class DynamicAtlas
   {
      
      protected static var _items:Array;
      
      protected static var _canvas:Sprite;
      
      protected static var _currentLab:String;
      
      protected static var _x:Number;
      
      protected static var _y:Number;
      
      protected static var _bData:BitmapData;
      
      protected static var _mat:Matrix;
      
      protected static var _margin:Number;
      
      protected static var _preserveColor:Boolean;
      
      internal static var DEFAULT_CANVAS_WIDTH:Number = 2046;
      
      public function DynamicAtlas()
      {
         super();
      }
      
      protected static function appendIntToString(num:int, numOfPlaces:int) : String
      {
         var numString:String = num.toString();
         var outString:String = "";
         for(var i:int = 0; i < numOfPlaces - numString.length; i++)
         {
            outString += "0";
         }
         return outString + numString;
      }
      
      protected static function layoutChildren() : void
      {
         var xPos:Number = NaN;
         var yPos:Number = NaN;
         var itm:TextureItem = null;
         xPos = 0;
         yPos = 0;
         var maxY:Number = 0;
         var len:int = int(_items.length);
         for(var i:uint = 0; i < len; i++)
         {
            itm = _items[i];
            if(xPos + itm.width > DEFAULT_CANVAS_WIDTH)
            {
               xPos = 0;
               yPos += maxY;
               maxY = 0;
            }
            if(itm.height + 1 > maxY)
            {
               maxY = itm.height + 1;
            }
            itm.x = xPos;
            itm.y = yPos;
            xPos += itm.width + 1;
         }
      }
      
      protected static function isEmbedded(fontFamily:String) : Boolean
      {
         var embeddedFonts:Vector.<Font> = Vector.<Font>(Font.enumerateFonts());
         var i:* = int(embeddedFonts.length - 1);
         while(i > -1 && embeddedFonts[i].fontName != fontFamily)
         {
            i--;
         }
         return i > -1;
      }
      
      protected static function getRealBounds(clip:DisplayObject) : Rectangle
      {
         var j:int = 0;
         var clipFilters:Array = null;
         var clipFiltersLength:int = 0;
         var tmpBData:BitmapData = null;
         var filterRect:Rectangle = null;
         var bounds:Rectangle = clip.getBounds(clip.parent);
         bounds.x = Math.floor(bounds.x);
         bounds.y = Math.floor(bounds.y);
         bounds.height = Math.ceil(bounds.height);
         bounds.width = Math.ceil(bounds.width);
         var realBounds:Rectangle = new Rectangle(0,0,bounds.width + _margin * 2,bounds.height + _margin * 2);
         if(clip.filters.length > 0)
         {
            j = 0;
            clipFilters = clip.filters;
            clipFiltersLength = int(clipFilters.length);
            tmpBData = new BitmapData(realBounds.width,realBounds.height,false);
            filterRect = tmpBData.generateFilterRect(tmpBData.rect,clipFilters[j]);
            realBounds = realBounds.union(filterRect);
            tmpBData.dispose();
            while(++j < clipFiltersLength)
            {
               tmpBData = new BitmapData(filterRect.width,filterRect.height,true,0);
               filterRect = tmpBData.generateFilterRect(tmpBData.rect,clipFilters[j]);
               realBounds = realBounds.union(filterRect);
               tmpBData.dispose();
            }
         }
         realBounds.offset(bounds.x,bounds.y);
         realBounds.width = Math.max(realBounds.width,1);
         realBounds.height = Math.max(realBounds.height,1);
         tmpBData = null;
         return realBounds;
      }
      
      protected static function drawItem(clip:DisplayObject, name:String = "", baseName:String = "", clipColorTransform:ColorTransform = null, frameBounds:Rectangle = null) : TextureItem
      {
         var realBounds:Rectangle = getRealBounds(clip);
         _bData = new BitmapData(realBounds.width,realBounds.height,true,0);
         _mat = clip.transform.matrix;
         _mat.translate(-realBounds.x + _margin,-realBounds.y + _margin);
         _bData.drawWithQuality(clip,_mat,_preserveColor ? clipColorTransform : null,null,null,true,StageQuality.BEST);
         var label:String = "";
         if(clip is MovieClip)
         {
            if(clip["currentLabel"] != _currentLab && clip["currentLabel"] != null)
            {
               _currentLab = clip["currentLabel"];
               label = _currentLab;
            }
         }
         if(frameBounds)
         {
            realBounds.x = clip.x - realBounds.x + _margin;
            realBounds.y = clip.y - realBounds.y + _margin;
            realBounds.width = frameBounds.width;
            realBounds.height = frameBounds.height;
         }
         var item:TextureItem = new TextureItem(_bData,name,label,realBounds.x,realBounds.y,realBounds.width,realBounds.height);
         _items.push(item);
         _canvas.addChild(item);
         _bData = null;
         return item;
      }
      
      public static function fromClassVector(assets:Vector.<Class>, scaleFactor:Number = 1, margin:uint = 0, preserveColor:Boolean = true, checkBounds:Boolean = false, compress:Boolean = true) : TextureAtlas
      {
         var assetClass:Class = null;
         var assetInstance:DisplayObject = null;
         var container:MovieClip = new MovieClip();
         for each(assetClass in assets)
         {
            assetInstance = new assetClass();
            assetInstance.name = getQualifiedClassName(assetClass);
            container.addChild(assetInstance);
         }
         return fromMovieClipContainer(container,scaleFactor,margin,preserveColor,checkBounds,compress);
      }
      
      public static function getTexturesByClass(textureAtlas:TextureAtlas, assetClass:Class) : Vector.<Texture>
      {
         return textureAtlas.getTextures(getQualifiedClassName(assetClass));
      }
      
      public static function fromMovieClipContainer(swf:Sprite, scaleFactor:Number = 1, margin:uint = 0, preserveColor:Boolean = true, checkBounds:Boolean = false, compress:Boolean = true, xl:Boolean = false) : TextureAtlas
      {
         var selected:DisplayObject = null;
         var selectedTotalFrames:int = 0;
         var selectedColorTransform:ColorTransform = null;
         var canvasData:BitmapData = null;
         var texture:Texture = null;
         var xml:XML = null;
         var subText:XML = null;
         var atlas:TextureAtlas = null;
         var itemsLen:int = 0;
         var itm:TextureItem = null;
         var m:uint = 0;
         var filters:Array = null;
         var filtersLen:int = 0;
         var filter:Object = null;
         var j:uint = 0;
         var b:uint = 0;
         var parseFrame:Boolean = false;
         var frameBounds:Rectangle = new Rectangle(0,0,0,0);
         var children:uint = uint(swf.numChildren);
         _margin = margin;
         _preserveColor = preserveColor;
         if(xl)
         {
            DEFAULT_CANVAS_WIDTH = 4096;
         }
         else
         {
            DEFAULT_CANVAS_WIDTH = 2048;
         }
         _items = [];
         if(!_canvas)
         {
            _canvas = new Sprite();
         }
         if(swf is MovieClip)
         {
            MovieClip(swf).gotoAndStop(1);
         }
         for(var i:uint = 0; i < children; i++)
         {
            selected = swf.getChildAt(i);
            selectedColorTransform = selected.transform.colorTransform;
            _x = selected.x;
            _y = selected.y;
            if(scaleFactor != 1)
            {
               selected.scaleX *= scaleFactor;
               selected.scaleY *= scaleFactor;
               if(selected.filters.length > 0)
               {
                  filters = selected.filters;
                  filtersLen = int(selected.filters.length);
                  for(j = 0; j < filtersLen; j++)
                  {
                     filter = filters[j];
                     if(filter.hasOwnProperty("blurX"))
                     {
                        filter.blurX *= scaleFactor;
                        filter.blurY *= scaleFactor;
                     }
                     if(filter.hasOwnProperty("distance"))
                     {
                        filter.distance *= scaleFactor;
                     }
                  }
                  selected.filters = filters;
               }
            }
            if(selected is MovieClip)
            {
               selectedTotalFrames = int(MovieClip(selected).totalFrames);
               if(checkBounds)
               {
                  for(MovieClip(selected).gotoAndStop(0); b < MovieClip(selected).numChildren; )
                  {
                     if(getQualifiedClassName(MovieClip(selected).getChildAt(b)) == "flash.display::MovieClip")
                     {
                        MovieClip(selected).getChildAt(b).gotoAndStop(0);
                     }
                     b++;
                  }
                  frameBounds = getRealBounds(selected);
                  m = 1;
                  while(++m <= selectedTotalFrames)
                  {
                     MovieClip(selected).gotoAndStop(m);
                     for(b = 0; b < MovieClip(selected).numChildren; b++)
                     {
                        if(getQualifiedClassName(MovieClip(selected).getChildAt(b)) == "flash.display::MovieClip")
                        {
                           MovieClip(selected).getChildAt(b).gotoAndStop(m);
                        }
                     }
                     frameBounds = frameBounds.union(getRealBounds(selected));
                  }
               }
            }
            else
            {
               selectedTotalFrames = 1;
            }
            m = 0;
            while(++m <= selectedTotalFrames)
            {
               if(selected is MovieClip)
               {
                  MovieClip(selected).gotoAndStop(m);
               }
               for(b = 0; b < MovieClip(selected).numChildren; b++)
               {
                  if(getQualifiedClassName(MovieClip(selected).getChildAt(b)) == "flash.display::MovieClip")
                  {
                     MovieClip(selected).getChildAt(b).gotoAndStop(m);
                  }
               }
               drawItem(selected,selected.name + "_" + appendIntToString(m - 1,5),selected.name,selectedColorTransform,frameBounds);
            }
         }
         _currentLab = "";
         layoutChildren();
         canvasData = new BitmapData(_canvas.width,_canvas.height,true,0);
         canvasData.drawWithQuality(_canvas,null,null,null,null,true,StageQuality.BEST);
         trace(canvasData.width + " " + canvasData.height + " " + swf);
         xml = new XML(<TextureAtlas></TextureAtlas>);
         xml.@imagePath = "atlas.png";
         itemsLen = int(_items.length);
         for(var k:uint = 0; k < itemsLen; k++)
         {
            itm = _items[k];
            itm.graphic.dispose();
            subText = new XML(<SubTexture/>);
            subText.@name = itm.textureName;
            subText.@x = itm.x;
            subText.@y = itm.y;
            subText.@width = itm.width;
            subText.@height = itm.height;
            subText.@frameX = itm.frameX;
            subText.@frameY = itm.frameY;
            subText.@frameWidth = itm.frameWidth;
            subText.@frameHeight = itm.frameHeight;
            if(itm.frameName != "")
            {
               subText.@frameLabel = itm.frameName;
            }
            xml.appendChild(subText);
         }
         if(compress)
         {
            texture = Texture.fromBitmapData(canvasData,false,false,scaleFactor,Context3DTextureFormat.BGRA_PACKED);
         }
         else
         {
            texture = Texture.fromBitmapData(canvasData,false,false,scaleFactor);
         }
         canvasData.dispose();
         atlas = new TextureAtlas(texture,xml);
         _items.length = 0;
         _canvas.removeChildren();
         _items = null;
         xml = null;
         _canvas = null;
         _currentLab = null;
         return atlas;
      }
      
      public static function bitmapFontFromString(chars:String, fontFamily:String, fontSize:Number = 12, bold:Boolean = false, italic:Boolean = false, charMarginX:int = 0, fontCustomID:String = "") : void
      {
         var format:TextFormat = new TextFormat(fontFamily,fontSize,16777215,bold,italic);
         var tf:TextField = new TextField();
         tf.autoSize = TextFieldAutoSize.LEFT;
         if(isEmbedded(fontFamily))
         {
            tf.antiAliasType = AntiAliasType.ADVANCED;
            tf.embedFonts = true;
         }
         tf.defaultTextFormat = format;
         tf.text = chars;
         if(fontCustomID == "")
         {
            fontCustomID = fontFamily;
         }
         bitmapFontFromTextField(tf,charMarginX,fontCustomID);
      }
      
      public static function bitmapFontFromTextField(tf:TextField, charMarginX:int = 0, fontCustomID:String = "") : void
      {
      }
   }
}

