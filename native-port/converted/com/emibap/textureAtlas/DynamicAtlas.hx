package com.emibap.textureAtlas;

import flash.display.*;
import flash.display3D.*;
import flash.geom.*;
import flash.text.*;
import flash.utils.*;
import starling.textures.*;

class DynamicAtlas
{
    
    private static var _items : Array<Dynamic>;
    
    private static var _canvas : Sprite;
    
    private static var _currentLab : String;
    
    private static var _x : Float;
    
    private static var _y : Float;
    
    private static var _bData : BitmapData;
    
    private static var _mat : Matrix;
    
    private static var _margin : Float;
    
    private static var _preserveColor : Bool;
    
    @:allow(com.emibap.textureAtlas)
    private static var DEFAULT_CANVAS_WIDTH : Float = 2046;
    
    public function new()
    {
        super();
    }
    
    private static function appendIntToString(num : Int, numOfPlaces : Int) : String
    {
        var numString : String = Std.string(num);
        var outString : String = "";
        for (i in 0...numOfPlaces - numString.length)
        {
            outString += "0";
        }
        return outString + numString;
    }
    
    private static function layoutChildren() : Void
    {
        var xPos : Float = Math.NaN;
        var yPos : Float = Math.NaN;
        var itm : TextureItem = null;
        xPos = 0;
        yPos = 0;
        var maxY : Float = 0;
        var len : Int = as3hx.Compat.parseInt(_items.length);
        for (i in 0...len)
        {
            itm = _items[i];
            if (xPos + itm.width > DEFAULT_CANVAS_WIDTH)
            {
                xPos = 0;
                yPos += maxY;
                maxY = 0;
            }
            if (itm.height + 1 > maxY)
            {
                maxY = itm.height + 1;
            }
            itm.x = xPos;
            itm.y = yPos;
            xPos += itm.width + 1;
        }
    }
    
    private static function isEmbedded(fontFamily : String) : Bool
    {
        var embeddedFonts : Array<Font> = Font.enumerateFonts();
        var i : Dynamic = as3hx.Compat.parseInt(embeddedFonts.length - 1);
        while (i > -1 && Reflect.field(embeddedFonts, Std.string(i)).fontName != fontFamily)
        {
            i--;
        }
        return i > -1;
    }
    
    private static function getRealBounds(clip : DisplayObject) : Rectangle
    {
        var j : Int = 0;
        var clipFilters : Array<Dynamic> = null;
        var clipFiltersLength : Int = 0;
        var tmpBData : BitmapData = null;
        var filterRect : Rectangle = null;
        var bounds : Rectangle = clip.getBounds(clip.parent);
        bounds.x = Math.floor(bounds.x);
        bounds.y = Math.floor(bounds.y);
        bounds.height = Math.ceil(bounds.height);
        bounds.width = Math.ceil(bounds.width);
        var realBounds : Rectangle = new Rectangle(0, 0, bounds.width + _margin * 2, bounds.height + _margin * 2);
        if (clip.filters.length > 0)
        {
            j = 0;
            clipFilters = clip.filters;
            clipFiltersLength = as3hx.Compat.parseInt(clipFilters.length);
            tmpBData = new BitmapData(realBounds.width, realBounds.height, false);
            filterRect = tmpBData.generateFilterRect(tmpBData.rect, clipFilters[j]);
            realBounds = realBounds.union(filterRect);
            tmpBData.dispose();
            while (++j < clipFiltersLength)
            {
                tmpBData = new BitmapData(filterRect.width, filterRect.height, true, 0);
                filterRect = tmpBData.generateFilterRect(tmpBData.rect, clipFilters[j]);
                realBounds = realBounds.union(filterRect);
                tmpBData.dispose();
            }
        }
        realBounds.offset(bounds.x, bounds.y);
        realBounds.width = Math.max(realBounds.width, 1);
        realBounds.height = Math.max(realBounds.height, 1);
        tmpBData = null;
        return realBounds;
    }
    
    private static function drawItem(clip : DisplayObject, name : String = "", baseName : String = "", clipColorTransform : ColorTransform = null, frameBounds : Rectangle = null) : TextureItem
    {
        var realBounds : Rectangle = getRealBounds(clip);
        _bData = new BitmapData(realBounds.width, realBounds.height, true, 0);
        _mat = clip.transform.matrix;
        _mat.translate(-realBounds.x + _margin, -realBounds.y + _margin);
        _bData.drawWithQuality(clip, _mat, (_preserveColor) ? clipColorTransform : null, null, null, true, StageQuality.BEST);
        var label : String = "";
        if (Std.is(clip, MovieClip))
        {
            if (Reflect.field(clip, "currentLabel") != _currentLab && Reflect.field(clip, "currentLabel") != null)
            {
                _currentLab = Reflect.field(clip, "currentLabel");
                label = _currentLab;
            }
        }
        if (frameBounds != null)
        {
            realBounds.x = clip.x - realBounds.x + _margin;
            realBounds.y = clip.y - realBounds.y + _margin;
            realBounds.width = frameBounds.width;
            realBounds.height = frameBounds.height;
        }
        var item : TextureItem = new TextureItem(_bData, name, label, realBounds.x, realBounds.y, realBounds.width, realBounds.height);
        _items.push(item);
        _canvas.addChild(item);
        _bData = null;
        return item;
    }
    
    public static function fromClassVector(assets : Array<Class<Dynamic>>, scaleFactor : Float = 1, margin : Int = 0, preserveColor : Bool = true, checkBounds : Bool = false, compress : Bool = true) : TextureAtlas
    {
        var assetClass : Class<Dynamic> = null;
        var assetInstance : DisplayObject = null;
        var container : MovieClip = new MovieClip();
        for (assetClass in assets)
        {
            assetInstance = Type.createInstance(assetClass, []);
            assetInstance.name = Type.getClassName(assetClass);
            container.addChild(assetInstance);
        }
        return fromMovieClipContainer(container, scaleFactor, margin, preserveColor, checkBounds, compress);
    }
    
    public static function getTexturesByClass(textureAtlas : TextureAtlas, assetClass : Class<Dynamic>) : Array<Texture>
    {
        return textureAtlas.getTextures(Type.getClassName(assetClass));
    }
    
    public static function fromMovieClipContainer(swf : Sprite, scaleFactor : Float = 1, margin : Int = 0, preserveColor : Bool = true, checkBounds : Bool = false, compress : Bool = true, xl : Bool = false) : TextureAtlas
    {
        var selected : DisplayObject = null;
        var selectedTotalFrames : Int = 0;
        var selectedColorTransform : ColorTransform = null;
        var canvasData : BitmapData = null;
        var texture : Texture = null;
        var xml : FastXML = null;
        var subText : FastXML = null;
        var atlas : TextureAtlas = null;
        var itemsLen : Int = 0;
        var itm : TextureItem = null;
        var m : Int = 0;
        var filters : Array<Dynamic> = null;
        var filtersLen : Int = 0;
        var filter : Dynamic = null;
        var j : Int = 0;
        var b : Int = 0;
        var parseFrame : Bool = false;
        var frameBounds : Rectangle = new Rectangle(0, 0, 0, 0);
        var children : Int = as3hx.Compat.parseInt(swf.numChildren);
        _margin = margin;
        _preserveColor = preserveColor;
        if (xl)
        {
            DEFAULT_CANVAS_WIDTH = 4096;
        }
        else
        {
            DEFAULT_CANVAS_WIDTH = 2048;
        }
        _items = [];
        if (_canvas == null)
        {
            _canvas = new Sprite();
        }
        if (Std.is(swf, MovieClip))
        {
            cast((swf), MovieClip).gotoAndStop(1);
        }
        for (i in 0...children)
        {
            selected = swf.getChildAt(i);
            selectedColorTransform = selected.transform.colorTransform;
            _x = selected.x;
            _y = selected.y;
            if (scaleFactor != 1)
            {
                selected.scaleX *= scaleFactor;
                selected.scaleY *= scaleFactor;
                if (selected.filters.length > 0)
                {
                    filters = selected.filters;
                    filtersLen = as3hx.Compat.parseInt(selected.filters.length);
                    for (j in 0...filtersLen)
                    {
                        filter = filters[j];
                        if (filter.exists("blurX"))
                        {
                            filter.blurX *= scaleFactor;
                            filter.blurY *= scaleFactor;
                        }
                        if (filter.exists("distance"))
                        {
                            filter.distance *= scaleFactor;
                        }
                    }
                    selected.filters = filters;
                }
            }
            if (Std.is(selected, MovieClip))
            {
                selectedTotalFrames = as3hx.Compat.parseInt(cast((selected), MovieClip).totalFrames);
                if (checkBounds)
                {
                    cast((selected), MovieClip).gotoAndStop(0);
                    while (b < cast((selected), MovieClip).numChildren)
                    {
                        if (Type.getClassName(cast((selected), MovieClip).getChildAt(b)) == "flash.display::MovieClip")
                        {
                            cast((selected), MovieClip).getChildAt(b).gotoAndStop(0);
                        }
                        b++;
                    }
                    frameBounds = getRealBounds(selected);
                    m = 1;
                    while (++m <= selectedTotalFrames)
                    {
                        cast((selected), MovieClip).gotoAndStop(m);
                        for (b in 0...cast((selected), MovieClip).numChildren)
                        {
                            if (Type.getClassName(cast((selected), MovieClip).getChildAt(b)) == "flash.display::MovieClip")
                            {
                                cast((selected), MovieClip).getChildAt(b).gotoAndStop(m);
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
            while (++m <= selectedTotalFrames)
            {
                if (Std.is(selected, MovieClip))
                {
                    cast((selected), MovieClip).gotoAndStop(m);
                }
                for (b in 0...cast((selected), MovieClip).numChildren)
                {
                    if (Type.getClassName(cast((selected), MovieClip).getChildAt(b)) == "flash.display::MovieClip")
                    {
                        cast((selected), MovieClip).getChildAt(b).gotoAndStop(m);
                    }
                }
                drawItem(selected, selected.name + "_" + appendIntToString(m - 1, 5), selected.name, selectedColorTransform, frameBounds);
            }
        }
        _currentLab = "";
        layoutChildren();
        canvasData = new BitmapData(_canvas.width, _canvas.height, true, 0);
        canvasData.drawWithQuality(_canvas, null, null, null, null, true, StageQuality.BEST);
        trace(canvasData.width + " " + canvasData.height + " " + swf);
        xml = new FastXML(FastXML.parse("<TextureAtlas></TextureAtlas>"));
        xml.setAttribute("imagePath", "atlas.png");
        itemsLen = as3hx.Compat.parseInt(_items.length);
        for (k in 0...itemsLen)
        {
            itm = _items[k];
            itm.graphic.dispose();
            subText = new FastXML(FastXML.parse("<SubTexture/>"));
            subText.setAttribute("name", itm.textureName);
            subText.setAttribute("x", itm.x);
            subText.setAttribute("y", itm.y);
            subText.setAttribute("width", itm.width);
            subText.setAttribute("height", itm.height);
            subText.setAttribute("frameX", itm.frameX);
            subText.setAttribute("frameY", itm.frameY);
            subText.setAttribute("frameWidth", itm.frameWidth);
            subText.setAttribute("frameHeight", itm.frameHeight);
            if (itm.frameName != "")
            {
                subText.setAttribute("frameLabel", itm.frameName);
            }
            xml.node.appendChild.innerData(subText);
        }
        if (compress)
        {
            texture = Texture.fromBitmapData(canvasData, false, false, scaleFactor, Context3DTextureFormat.BGRA_PACKED);
        }
        else
        {
            texture = Texture.fromBitmapData(canvasData, false, false, scaleFactor);
        }
        canvasData.dispose();
        atlas = new TextureAtlas(texture, xml);
        as3hx.Compat.setArrayLength(_items, 0);
        _canvas.removeChildren();
        _items = null;
        xml = null;
        _canvas = null;
        _currentLab = null;
        return atlas;
    }
    
    public static function bitmapFontFromString(chars : String, fontFamily : String, fontSize : Float = 12, bold : Bool = false, italic : Bool = false, charMarginX : Int = 0, fontCustomID : String = "") : Void
    {
        var format : TextFormat = new TextFormat(fontFamily, fontSize, 16777215, bold, italic);
        var tf : TextField = new TextField();
        tf.autoSize = TextFieldAutoSize.LEFT;
        if (isEmbedded(fontFamily))
        {
            tf.antiAliasType = AntiAliasType.ADVANCED;
            tf.embedFonts = true;
        }
        tf.defaultTextFormat = format;
        tf.text = chars;
        if (fontCustomID == "")
        {
            fontCustomID = fontFamily;
        }
        bitmapFontFromTextField(tf, charMarginX, fontCustomID);
    }
    
    public static function bitmapFontFromTextField(tf : TextField, charMarginX : Int = 0, fontCustomID : String = "") : Void
    {
    }
}


