import flash.errors.Error;
import com.emibap.textureAtlas.*;
import flash.display.*;
import flash.display3D.*;
import flash.display3D.textures.RectangleTexture;
import flash.display3D.textures.Texture;
import flash.events.*;
import flash.filters.BlurFilter;
import flash.geom.*;
import flash.system.*;
import flash.utils.*;
import starling.core.*;
import starling.display.*;
import starling.events.*;
import starling.filters.BlurFilter;
import starling.textures.*;
import starling.utils.*;

class StarlingBackgrounds extends starling.display.Sprite
{
    
    public static var myStarling : Starling;
    
    private static var StaticBackground : starling.display.Sprite;
    
    public static var volcanoBackground : ScrollingObject;
    
    private static var inkboardAtlas : TextureAtlas;
    
    public static var inkSplat : starling.display.MovieClip;
    
    public static var cheatScale : starling.display.Sprite;
    
    private static var holdCacheFunc : Dynamic;
    
    private static var croppedBD : BitmapData;
    
    public static var depthOfField : Bool;
    
    public static var depthOfFieldCache : Bool;
    
    public static var realStageX : Int;
    
    public static var realStageY : Int;
    
    public static var doorTexture : starling.textures.Texture;
    
    public static var tearTexture : starling.textures.Texture;
    
    public static var springSurfaceTexture : starling.textures.Texture;
    
    public static var springSpringTexture : starling.textures.Texture;
    
    public static var BackgroundArray : Array<Dynamic> = [];
    
    public static var BackgroundObjArray : Array<Dynamic> = [];
    
    public static var BackContainerArray : Array<Dynamic> = [];
    
    public static var BackgroundMeshes : Array<Dynamic> = [];
    
    public static var allImages : Array<Dynamic> = [];
    
    private static var effectsAtlas : Array<Dynamic> = [];
    
    private static var backBitMax : Int = 4096 - 1;
    
    private static var backFormat : String = "bgraPacked4444";
    
    private static var blurRes : Float = 0.5;
    
    public static var constrained : Bool = false;
    
    private static var sliceNx : Int = 0;
    
    public static var sliceNy : Int = 0;
    
    public static var cameraFocalLength : Int = 200;
    
    public static var backgroundObjectsArray : Array<Dynamic> = [];
    
    public static var bitRes : Float = 1;
    
    public static var doorStampArray : Array<Dynamic> = [];
    
    public static var groundTextures : Array<starling.textures.Texture> = new Array<Texture>();
    
    public static var groundBounds : Array<Rectangle> = new Array<Rectangle>();
    
    private static var charImage : Array<Image> = new Array<Image>();
    
    private static var charTexture : Array<starling.textures.Texture> = new Array<Texture>();
    
    private static var charNative : Array<RectangleTexture> = new Array<RectangleTexture>();
    
    private static var charNativeConstrained : Array<flash.display3D.textures.Texture> = new Array<flash.display3D.textures.Texture>();
    
    private static var pencilImage : Array<Image> = new Array<Image>();
    
    private static var pencilTexture : Array<starling.textures.Texture> = new Array<Texture>();
    
    private static var pencilNative : Array<RectangleTexture> = new Array<RectangleTexture>();
    
    private static var pencilNativeConstrained : Array<flash.display3D.textures.Texture> = new Array<flash.display3D.textures.Texture>();
    
    public static var charColor : Int = 16777215;
    
    public function new()
    {
        super();
        textBubbles.setConstrained(constrained);
        StaticBackground = new Sprite();
        myStarling.stage.addChild(StaticBackground);
        Texture.asyncBitmapUploadEnabled = false;
        if (Capabilities.os.substr(0, 3) != "Win")
        {
            backFormat = "bgra";
        }
        if (constrained)
        {
            backBitMax = as3hx.Compat.parseInt(2048 - 1);
            StarlingSmoke.createAtlas(createEffect(new ToBeCachedSmoke(), 0.74, true));
            StarlingInteract.createAtlas(createEffect(new ToBeCachedInteracts(), 1.5, true));
            StarlingEffect.createAtlas(createEffect(new ToBeCachedEffects(), 1.25, true));
            StarlingDecals.createAtlas(createEffect(new ToBeCachedDecals(), 1.5, true));
        }
        else
        {
            StarlingSmoke.createAtlas(createEffect(new ToBeCachedSmoke(), 1.5, true, true));
            StarlingInteract.createAtlas(createEffect(new ToBeCachedInteracts(), 1.5, true));
            StarlingEffect.createAtlas(createEffect(new ToBeCachedEffects(), 1.5, true));
            StarlingDecals.createAtlas(createEffect(new ToBeCachedDecals(), 1.5, true));
        }
        groundCache();
        Main.stageRoot.StartAfterStarling();
    }
    
    public static function startStarling(e : flash.display.Stage) : Dynamic
    {
        var stage3D : Stage3D = null;
        if (rootHUD.HUD.isReallyMobile)
        {
            myStarling = new Starling(StarlingBackgrounds, Main.stageRoot.stage, null, null, "auto", "auto");
            Main.FadeClip.x = Main.realStageX;
            Main.FadeClip.y = Main.realStageY;
            myStarling.start();
        }
        else
        {
            stage3D = e.stage3Ds[0];
            stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, onExtendedComplete);
            stage3D.addEventListener(ErrorEvent.ERROR, onExtendedFailed);
            try
            {
                stage3D.requestContext3D("auto", Context3DProfile.BASELINE_EXTENDED);
            }
            catch (err : Error)
            {
                onExtendedFailed(null);
            }
        }
    }
    
    private static function onExtendedComplete(e : flash.events.Event) : Void
    {
        Main.stageRoot.stage.stage3Ds[0].removeEventListener(flash.events.Event.CONTEXT3D_CREATE, onExtendedComplete);
        Main.stageRoot.stage.stage3Ds[0].removeEventListener(ErrorEvent.ERROR, onExtendedFailed);
        if (Main.stageRoot.stage.stage3Ds[0].context3D)
        {
            Main.stageRoot.stage.stage3Ds[0].context3D.dispose(false);
        }
        as3hx.Compat.setTimeout(reallyStartStarling, 100);
    }
    
    private static function onExtendedFailed(e : flash.events.Event) : Void
    {
        Main.stageRoot.stage.stage3Ds[0].removeEventListener(flash.events.Event.CONTEXT3D_CREATE, onExtendedComplete);
        Main.stageRoot.stage.stage3Ds[0].removeEventListener(ErrorEvent.ERROR, onExtendedFailed);
        if (Main.stageRoot.stage.stage3Ds[0].context3D)
        {
            Main.stageRoot.stage.stage3Ds[0].context3D.dispose(false);
        }
        constrained = true;
        as3hx.Compat.setTimeout(reallyStartStarling, 1000);
    }
    
    private static function reallyStartStarling() : Void
    {
        if (constrained)
        {
            myStarling = new Starling(StarlingBackgrounds, Main.stageRoot.stage, null, null, "auto", Context3DProfile.BASELINE_CONSTRAINED);
        }
        else
        {
            myStarling = new Starling(StarlingBackgrounds, Main.stageRoot.stage, null, null, "auto", Context3DProfile.BASELINE_EXTENDED);
        }
        Main.FadeClip.x = Main.realStageX;
        Main.FadeClip.y = Main.realStageY;
        myStarling.start();
    }
    
    public static function addStaticBack(bitmap : BitmapData) : Dynamic
    {
        if (StaticBackground.numChildren > 0)
        {
            StaticBackground.removeChildAt(0);
        }
        var tile : Image = new Image(Texture.fromBitmapData(bitmap, false, true, 1, backFormat));
        StaticBackground.blendMode = BlendMode.NONE;
        StaticBackground.addChild(tile);
    }
    
    public static function resizeStaticBack(scx : Float, scy : Float) : Void
    {
        StaticBackground.scaleX = scx;
        StaticBackground.scaleY = scy;
    }
    
    public static function setupCharStarling(ratio : Float, id : Int) : Void
    {
        charTexture[id] = Texture.empty(133, 140, true, false, true, ratio);
        if (constrained)
        {
            charNativeConstrained[id] = try cast(charTexture[id].base, flash.display3D.textures.Texture) catch(e:Dynamic) null;
        }
        else
        {
            charNative[id] = try cast(charTexture[id].base, RectangleTexture) catch(e:Dynamic) null;
        }
        charImage[id] = new Image(charTexture[id]);
        charImage[id].textureSmoothing = "bilinear";
        charImage[id].pivotX = 66.5;
        charImage[id].pivotY = 70;
        myStarling.stage.addChild(charImage[id]);
        pencilTexture[id] = Texture.empty(20, 80, true, false, true, 1.5);
        if (constrained)
        {
            pencilNativeConstrained[id] = try cast(pencilTexture[id].base, flash.display3D.textures.Texture) catch(e:Dynamic) null;
        }
        else
        {
            pencilNative[id] = try cast(pencilTexture[id].base, RectangleTexture) catch(e:Dynamic) null;
        }
        pencilImage[id] = new Image(pencilTexture[id]);
        pencilImage[id].pivotX = 5;
        pencilImage[id].pivotY = 60;
        myStarling.stage.addChild(pencilImage[id]);
    }
    
    public static function addCharStarling(id : Int) : Void
    {
        myStarling.stage.addChild(charImage[id]);
        myStarling.stage.addChild(pencilImage[id]);
    }
    
    public static function pressCharBitmap(charBitmap : BitmapData, id : Int) : Void
    {
        if (constrained)
        {
            charNativeConstrained[id].uploadFromBitmapData(charBitmap);
        }
        else
        {
            charNative[id].uploadFromBitmapData(charBitmap);
        }
        charImage[id].texture = charTexture[id];
    }
    
    public static function placeCharBitmap(ex : Float, ey : Float, rot : Float, ratio : Float, id : Int) : Void
    {
        charImage[id].x = ex;
        charImage[id].y = ey;
        charImage[id].rotation = rot;
        charImage[id].scaleX = charImage[id].scaleY = ratio;
    }
    
    public static function ArrangeBackgrounds(rail : Int, id : Int) : Void
    {
        charImage[id].parent.addChild(charImage[id]);
        pencilImage[id].parent.addChild(pencilImage[id]);
        var depth : Int = as3hx.Compat.parseInt(BackgroundObjArray[rail].parent.getChildIndex(BackgroundObjArray[rail]));
        charImage[id].parent.addChildAt(charImage[id], depth + 1);
        pencilImage[id].parent.addChildAt(pencilImage[id], depth + 2);
        charImage[id].color = charColor;
        pencilImage[id].color = charColor;
    }
    
    public static function placeSlash(slash : Dynamic) : Void
    {
        myStarling.stage.addChildAt(slash, pencilImage[0].parent.getChildIndex(pencilImage[0]) + 1);
    }
    
    public static function pressPencilBitmap(pencilBitmap : BitmapData, id : Int) : Void
    {
        if (constrained)
        {
            pencilNativeConstrained[id].uploadFromBitmapData(pencilBitmap);
        }
        else
        {
            pencilNative[id].uploadFromBitmapData(pencilBitmap);
        }
        pencilImage[id].texture = pencilTexture[id];
    }
    
    public static function placePencilBitmap(ex : Float, ey : Float, rot : Float, ratioX : Float, ratioY : Float, id : Int) : Void
    {
        pencilImage[id].x = ex;
        pencilImage[id].y = ey;
        pencilImage[id].rotation = rot;
        pencilImage[id].scaleX = ratioX;
        pencilImage[id].scaleY = ratioY;
    }
    
    public static function charVisible(vis : Bool, id : Int) : Void
    {
        charImage[id].visible = vis;
    }
    
    public static function pencilVisible(vis : Bool, id : Int) : Void
    {
        pencilImage[id].visible = vis;
    }
    
    public static function toStarlingFromMC(clip : Dynamic, ratio : Dynamic, background : Dynamic, offsetX : Int = 0, offsetY : Int = 0, toMesh : Bool = false, func : Dynamic = null, blur : Float = 0) : Bool
    {
        var ex : Int = 0;
        var ey : Int = 0;
        var rec : Rectangle = null;
        var filter : flash.filters.BlurFilter = null;
        var bounds : Rectangle = clip.getBounds(clip);
        bounds.x -= 5 / ratio;
        bounds.y -= 5 / ratio;
        bounds.width += 10 / ratio;
        bounds.height += 10 / ratio;
        holdCacheFunc = null;
        if (sliceNx < bounds.width * ratio / backBitMax)
        {
            ex = as3hx.Compat.parseInt(bounds.width * ratio - sliceNx * backBitMax);
            if (ex > backBitMax)
            {
                ex = backBitMax;
            }
            if (sliceNy < bounds.height * ratio / backBitMax)
            {
                ey = as3hx.Compat.parseInt(bounds.height * ratio - sliceNy * backBitMax);
                if (ey > backBitMax)
                {
                    ey = backBitMax;
                }
                bitmapData = new BitmapData(ex + 1, ey + 1, true, 0);
                bitmapData.drawWithQuality(clip, new Matrix(ratio, 0, 0, ratio, -(bounds.x * ratio + sliceNx * backBitMax), -(bounds.y * ratio + sliceNy * backBitMax)), null, null, null, true, StageQuality.BEST);
                rec = new Rectangle(0, 0, ex, ey);
                if (blur < 0)
                {
                    blur = 1 + Math.abs(blur);
                }
                else if (blur > 0)
                {
                    blur = 2 + Math.abs(blur) / 10;
                }
                if (blur != 0 && depthOfFieldCache)
                {
                    filter = new flash.filters.BlurFilter(blur, blur);
                    filter.quality = 3;
                    bitmapData.applyFilter(bitmapData, rec, new Point(0, 0), filter);
                }
                rec = bitmapData.getColorBoundsRect(4278190080, 0, false);
                if (!(rec.width == 0 || rec.height == 0))
                {
                    Main.bitmapTotal += rec.height * rec.width;
                    croppedBD = new BitmapData(rec.width, rec.height);
                    croppedBD.copyPixels(bitmapData, rec, new Point(0, 0));
                    bitmapData.dispose();
                    if (func == null)
                    {
                        addBitmap(croppedBD, background, bounds.x + offsetX + sliceNx * backBitMax / ratio + rec.x / ratio, bounds.y + offsetY + sliceNy * backBitMax / ratio + rec.y / ratio, 1 / ratio, true, null, blur);
                        ++sliceNy;
                        croppedBD.dispose();
                    }
                    else
                    {
                        holdCacheFunc = func;
                        addBitmap(croppedBD, background, bounds.x + offsetX + sliceNx * backBitMax / ratio + rec.x / ratio, bounds.y + offsetY + sliceNy * backBitMax / ratio + rec.y / ratio, 1 / ratio, true, advanceBitmap, blur);
                    }
                }
                else
                {
                    ++sliceNy;
                    if (func != null)
                    {
                        func();
                    }
                }
            }
            else
            {
                ++sliceNx;
                sliceNy = 0;
                if (func != null)
                {
                    func();
                }
            }
            return false;
        }
        sliceNx = 0;
        sliceNy = 0;
        return true;
    }
    
    public static function toStarlingObj(clip : Dynamic, ratio : Dynamic, background : Dynamic) : Image
    {
        var bounds : Rectangle = clip.getBounds(clip);
        bitmapData = new BitmapData(bounds.width + 4, bounds.height + 4, true, 0);
        bitmapData.drawWithQuality(clip, new Matrix(ratio, 0, 0, ratio, -bounds.x, -bounds.y), clip.transform.colorTransform, null, null, true, StageQuality.BEST);
        return addBitmap(bitmapData, background, clip.x + bounds.x, clip.y + bounds.y, 1 / ratio);
    }
    
    private static function advanceBitmap() : Void
    {
        ++sliceNy;
        croppedBD.dispose();
        if (holdCacheFunc != null)
        {
            holdCacheFunc();
        }
    }
    
    public static function addBackground(i : Dynamic) : Dynamic
    {
        Reflect.setField(BackContainerArray, Std.string(i), new Sprite());
        Reflect.setField(BackgroundArray, Std.string(i), new Sprite());
        Reflect.setField(BackgroundObjArray, Std.string(i), new Sprite());
        myStarling.stage.addChild(Reflect.field(BackContainerArray, Std.string(i)));
        myStarling.stage.addChild(Reflect.field(BackgroundArray, Std.string(i)));
        myStarling.stage.addChild(Reflect.field(BackgroundObjArray, Std.string(i)));
    }
    
    public static function addBitmap(bitmap : BitmapData, background : Dynamic, ex : Dynamic, ey : Dynamic, ratio : Dynamic, toAll : Bool = true, func : Dynamic = null, blur : Float = 0) : Image
    {
        var tile : Image = null;
        if (bitmap.width > 5 && bitmap.height > 5)
        {
            tile = new Image(Texture.fromBitmapData(bitmap, false, true, 1, backFormat, false, func));
            tile.textureSmoothing = "bilinear";
            tile.x = ex;
            tile.y = ey;
            tile.scaleX = tile.scaleY = ratio;
            if (toAll)
            {
                allImages.push(tile);
            }
            background.addChild(tile);
            return tile;
        }
        if (func != null)
        {
            func();
        }
    }
    
    public static function setBlur(rail : Int, clear : Bool = false) : Void
    {
        var i : Int = 0;
        var blur : Float = Math.NaN;
        if (!depthOfField || constrained)
        {
            return;
        }
        var blurOffset : Float = Main.getBlurOffset(rail);
        var ratio : Float = 2.16 / Main.overRatio;
        for (i in Reflect.fields(BackgroundArray))
        {
            blur = (0.25 + Math.abs(Main.getBlurOffset(i) - blurOffset) * 1.5) / 2.16 * Main.overRatio;
            if (i == rail)
            {
                if (BackgroundArray[i].filter != null)
                {
                    BackgroundArray[i].filter.dispose();
                    BackgroundArray[i].filter = null;
                }
            }
            else
            {
                if (BackgroundArray[i].filter == null)
                {
                    BackgroundArray[i].filter = new starling.filters.BlurFilter(blur, blur, blurRes * ratio);
                }
                else
                {
                    BackgroundArray[i].filter.blurX = blur;
                    BackgroundArray[i].filter.blurY = blur;
                }
                BackgroundArray[i].filter.cache();
            }
            if (i == rail)
            {
                if (BackgroundObjArray[i].filter != null)
                {
                    BackgroundObjArray[i].filter.dispose();
                    BackgroundObjArray[i].filter = null;
                }
            }
            else
            {
                if (BackgroundObjArray[i].filter == null || clear)
                {
                    BackgroundObjArray[i].filter = new starling.filters.BlurFilter(blur, blur, blurRes * ratio);
                }
                else
                {
                    BackgroundObjArray[i].filter.blurX = blur;
                    BackgroundObjArray[i].filter.blurY = blur;
                }
                BackgroundObjArray[i].filter.padding = new Padding(40, 40, 40, 40);
            }
            if (i == rail)
            {
                if (BackContainerArray[i].filter != null)
                {
                    BackContainerArray[i].filter.dispose();
                    BackContainerArray[i].filter = null;
                }
            }
            else if (BackContainerArray[i].filter == null || clear)
            {
                BackContainerArray[i].filter = new starling.filters.BlurFilter(blur, blur, blurRes * ratio);
            }
            else
            {
                BackContainerArray[i].filter.blurX = blur;
                BackContainerArray[i].filter.blurY = blur;
            }
        }
    }
    
    public static function addScrollObject(e : Dynamic, ez : Dynamic, res : Float = 1, func : Dynamic = null) : Bool
    {
        var obj : ScrollingObject = new ScrollingObject(e.x, e.y, ez);
        backgroundObjectsArray.push(obj);
        myStarling.stage.addChild(obj);
        if (func == null)
        {
            while (!toStarlingFromMC(e, res, obj))
            {
            }
            return true;
        }
        return toStarlingFromMC(e, res, obj, 0, 0, false, func);
    }
    
    public static function addVolcano() : Void
    {
        volcanoBackground = new ScrollingObject(0, 0, 1000);
        myStarling.stage.addChild(volcanoBackground);
        var clip : VolcanoClip = new VolcanoClip();
        var bounds : Rectangle = clip.getBounds(clip);
        bounds.y -= 10;
        bounds.height += 20;
        bitmapData = new BitmapData(1100, 350, true, 0);
        bitmapData.drawWithQuality(clip, new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y), null, null, null, true, StageQuality.BEST);
        var filter : flash.filters.BlurFilter = new flash.filters.BlurFilter();
        filter.blurX = 2;
        filter.blurY = 2;
        bitmapData.applyFilter(bitmapData, new Rectangle(0, 0, 1100, 350), new Point(0, 0), filter);
        addBitmap(bitmapData, volcanoBackground, bounds.x, bounds.y, 1, false);
        volcanoBackground.touchable = false;
    }
    
    public static function resizeVolcano(ex : Dynamic, ey : Dynamic) : Void
    {
        volcanoBackground.scaleX = ex;
        volcanoBackground.scaleY = ey;
    }
    
    public static function addBitmapRender(bitmap : Dynamic, n : Dynamic, ex : Dynamic, ey : Dynamic, ratio : Dynamic) : Dynamic
    {
        var rend : RenderTexture = new RenderTexture(bitmap.width, bitmap.height, true, 1);
        var image : Image = new Image(Texture.fromBitmapData(bitmap, false, true, 1, backFormat));
        rend.draw(image);
        image.texture.dispose();
        image.dispose();
        var tile : Image = new Image(rend);
        tile.x = ex;
        tile.y = ey;
        tile.scaleX = tile.scaleY = ratio;
        Reflect.field(BackgroundObjArray, Std.string(n)).addChild(tile);
        return tile;
    }
    
    private static function createEffect(mc : Dynamic, n : Dynamic, compress : Dynamic, xl : Bool = false) : Dynamic
    {
        return DynamicAtlas.fromMovieClipContainer(mc, n, 1, true, true, compress, xl);
    }
    
    public static function addObject(mc : Dynamic, rail : Int) : Void
    {
        BackgroundObjArray[rail].addChild(mc);
    }
    
    public static function addObjectBack(mc : starling.display.MovieClip, rail : Int) : Void
    {
        BackContainerArray[rail].addChild(mc);
    }
    
    public static function stampInkSplat(bit : Dynamic, b : Dynamic, matrix : Dynamic) : Dynamic
    {
        inkSplat.currentFrame = b;
        bit.texture.draw(inkSplat, matrix);
    }
    
    public static function removeMovieClip(e : Dynamic) : Dynamic
    {
        myStarling.juggler.remove(e);
        e.removeFromParent(true);
        e.dispose();
    }
    
    public static function scrollBackgrounds(n : Dynamic, ex : Dynamic, ey : Dynamic, ratio : Dynamic) : Void
    {
        Reflect.setField(BackContainerArray, Std.string(n), Reflect.setField(BackgroundObjArray, Std.string(n), Reflect.setField(BackgroundArray, Std.string(n), ex).x).x).x;
        Reflect.setField(BackContainerArray, Std.string(n), Reflect.setField(BackgroundObjArray, Std.string(n), Reflect.setField(BackgroundArray, Std.string(n), ey).y).y).y;
        Reflect.setField(BackContainerArray, Std.string(n), Reflect.setField(BackContainerArray, Std.string(n), Reflect.setField(BackgroundObjArray, Std.string(n), Reflect.setField(BackgroundObjArray, Std.string(n), Reflect.setField(BackgroundArray, Std.string(n), Reflect.setField(BackgroundArray, Std.string(n), ratio).scaleY).scaleX).scaleY).scaleX).scaleY).scaleX;
    }
    
    public static function scrollVolcano(ex : Float, ey : Float, ratio : Float) : Void
    {
        volcanoBackground.x = realStageX + (ex - 20000) * ratio;
        volcanoBackground.y = realStageY + (ey - 12500) * ratio;
        volcanoBackground.scaleX = volcanoBackground.scaleY = 50 * ratio;
    }
    
    public static function scrollBackgroundObjects(cameraX : Dynamic, cameraY : Dynamic, cameraZ : Dynamic) : Dynamic
    {
        var ratio : Float = Math.NaN;
        for (i in 0...backgroundObjectsArray.length)
        {
            ratio = cameraFocalLength / (cameraFocalLength + Reflect.field(backgroundObjectsArray, Std.string(i)).theZ - cameraZ) * Main.overRatio;
            if (ratio > 0)
            {
                Reflect.setField(backgroundObjectsArray, Std.string(i), true).visible;
                Reflect.setField(backgroundObjectsArray, Std.string(i), realStageX + (Reflect.field(backgroundObjectsArray, Std.string(i)).theX - cameraX) * ratio).x;
                Reflect.setField(backgroundObjectsArray, Std.string(i), realStageY + (Reflect.field(backgroundObjectsArray, Std.string(i)).theY - cameraY) * ratio).y;
                Reflect.setField(backgroundObjectsArray, Std.string(i), Reflect.setField(backgroundObjectsArray, Std.string(i), ratio).scaleY).scaleX;
            }
            else
            {
                Reflect.setField(backgroundObjectsArray, Std.string(i), false).visible;
            }
        }
    }
    
    public static function onResize() : Dynamic
    {
        myStarling.viewPort.width = Main.stageRoot.stage.stageWidth;
        myStarling.viewPort.height = Main.stageRoot.stage.stageHeight;
        myStarling.stage.stageWidth = Main.stageRoot.stage.stageWidth;
        myStarling.stage.stageHeight = Main.stageRoot.stage.stageHeight;
    }
    
    public static function flattenBackgrounds() : Dynamic
    {
        var i : Int = 0;
        for (i in Reflect.fields(BackgroundArray))
        {
            BackgroundArray[i].touchable = false;
            BackContainerArray[i].touchable = false;
            BackgroundObjArray[i].touchable = false;
        }
        for (i in Reflect.fields(backgroundObjectsArray))
        {
            backgroundObjectsArray[i].touchable = false;
        }
    }
    
    public static function unflattenBackgrounds() : Dynamic
    {
    }
    
    public static function flushBackgrounds() : Dynamic
    {
        var i : Int = 0;
        for (i in Reflect.fields(allImages))
        {
            allImages[i].removeFromParent(true);
            allImages[i].texture.dispose();
            allImages[i].dispose();
            allImages[i] = null;
        }
        allImages = [];
    }
    
    public static function removeBackgrounds() : Dynamic
    {
        var i : Int = 0;
        for (i in Reflect.fields(BackgroundArray))
        {
            if (BackgroundArray[i].filter != null)
            {
                BackgroundArray[i].filter.dispose();
                BackgroundArray[i].filter = null;
            }
            if (BackgroundObjArray[i].filter != null)
            {
                BackgroundObjArray[i].filter.dispose();
                BackgroundObjArray[i].filter = null;
            }
            if (BackContainerArray[i].filter != null)
            {
                BackContainerArray[i].filter.dispose();
                BackContainerArray[i].filter = null;
            }
            BackgroundArray[i].removeFromParent(true);
            BackgroundArray[i].dispose();
            BackgroundObjArray[i].removeFromParent(true);
            BackgroundObjArray[i].dispose();
            BackContainerArray[i].removeFromParent(true);
            BackContainerArray[i].dispose();
        }
        BackgroundArray = [];
        BackgroundObjArray = [];
        BackContainerArray = [];
    }
    
    public static function removeOneBackground(i : Dynamic) : Dynamic
    {
        Reflect.field(BackgroundArray, Std.string(i)).removeFromParent(true);
        Reflect.field(BackgroundArray, Std.string(i)).dispose();
        BackgroundArray.splice(i, 1);
        BackgroundObjArray.splice(i, 1);
        BackContainerArray.splice(i, 1);
    }
    
    private static function groundCache() : Void
    {
        var bounds : Rectangle = null;
        var bitmapData : BitmapData = null;
        var ground : GroundStampW4 = new GroundStampW4();
        for (i in 0...ground.totalFrames)
        {
            ground.gotoAndStop(i + 1);
            bounds = Reflect.setField(groundBounds, Std.string(i), ground.getBounds(ground));
            bitmapData = new BitmapData(bounds.width, bounds.height, true, 0);
            bitmapData.drawWithQuality(ground, new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y), null, null, null, true, StageQuality.BEST);
            Reflect.setField(groundTextures, Std.string(i), Texture.fromBitmapData(bitmapData, false, true, 1, Context3DTextureFormat.BGRA_PACKED));
            bitmapData.dispose();
        }
    }
    
    public static function getGroundSmoke(frame : Int, rail : Int) : Image
    {
        var ground : Image = new Image(groundTextures[frame]);
        ground.pivotX = -groundBounds[frame].x;
        ground.pivotY = -groundBounds[frame].y;
        BackContainerArray[rail].addChild(ground);
        return ground;
    }
}


