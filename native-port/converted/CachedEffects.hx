import flash.display.*;
import flash.geom.*;

class CachedEffects extends MovieClip
{
    
    public static var arrayLength : Int;
    
    private static var effect : CachedEffects;
    
    private static var ImpactFrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var ImpactBitmapXs : Array<Int> = new Array<Int>();
    
    private static var ImpactBitmapYs : Array<Int> = new Array<Int>();
    
    private static var SplatFrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var SplatBitmapXs : Array<Int> = new Array<Int>();
    
    private static var SplatBitmapYs : Array<Int> = new Array<Int>();
    
    private static var Slash1FrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var Slash1BitmapXs : Array<Int> = new Array<Int>();
    
    private static var Slash1BitmapYs : Array<Int> = new Array<Int>();
    
    private static var Slash2FrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var Slash2BitmapXs : Array<Int> = new Array<Int>();
    
    private static var Slash2BitmapYs : Array<Int> = new Array<Int>();
    
    private static var Slash3FrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var Slash3BitmapXs : Array<Int> = new Array<Int>();
    
    private static var Slash3BitmapYs : Array<Int> = new Array<Int>();
    
    private static var Slash4FrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var Slash4BitmapXs : Array<Int> = new Array<Int>();
    
    private static var Slash4BitmapYs : Array<Int> = new Array<Int>();
    
    private static var SlashMedium1FrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var SlashMedium1BitmapXs : Array<Int> = new Array<Int>();
    
    private static var SlashMedium1BitmapYs : Array<Int> = new Array<Int>();
    
    private static var SlashMedium2FrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var SlashMedium2BitmapXs : Array<Int> = new Array<Int>();
    
    private static var SlashMedium2BitmapYs : Array<Int> = new Array<Int>();
    
    private static var SlashRisingFrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var SlashRisingBitmapXs : Array<Int> = new Array<Int>();
    
    private static var SlashRisingBitmapYs : Array<Int> = new Array<Int>();
    
    private static var SlashHeavy1FrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var SlashHeavy1BitmapXs : Array<Int> = new Array<Int>();
    
    private static var SlashHeavy1BitmapYs : Array<Int> = new Array<Int>();
    
    private static var BuzzSawFrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var BuzzSawBitmapXs : Array<Int> = new Array<Int>();
    
    private static var BuzzSawBitmapYs : Array<Int> = new Array<Int>();
    
    private static var HeavyUpFrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var HeavyUpBitmapXs : Array<Int> = new Array<Int>();
    
    private static var HeavyUpBitmapYs : Array<Int> = new Array<Int>();
    
    private static var SwipeUpFrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var SwipeUpBitmapXs : Array<Int> = new Array<Int>();
    
    private static var SwipeUpBitmapYs : Array<Int> = new Array<Int>();
    
    private static var PokeDownFrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var PokeDownBitmapXs : Array<Int> = new Array<Int>();
    
    private static var PokeDownBitmapYs : Array<Int> = new Array<Int>();
    
    private static var HeavyDownFrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var HeavyDownBitmapXs : Array<Int> = new Array<Int>();
    
    private static var HeavyDownBitmapYs : Array<Int> = new Array<Int>();
    
    private static var PopFrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var PopBitmapXs : Array<Int> = new Array<Int>();
    
    private static var PopBitmapYs : Array<Int> = new Array<Int>();
    
    private static var SquigPopFrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var SquigPopBitmapXs : Array<Int> = new Array<Int>();
    
    private static var SquigPopBitmapYs : Array<Int> = new Array<Int>();
    
    private static var SmokePuffFrameCache : Array<BitmapData> = new Array<BitmapData>();
    
    private static var SmokePuffBitmapXs : Array<Int> = new Array<Int>();
    
    private static var SmokePuffBitmapYs : Array<Int> = new Array<Int>();
    
    private static var effectsArray : Array<CachedEffects> = new Array<CachedEffects>();
    
    private static var effectsPool : Array<CachedEffects> = new Array<CachedEffects>();
    
    public var frame : Int = 0;
    
    public var totalBitmaps : Int;
    
    private var ItIs : String;
    
    private var myBitmapData : BitmapData;
    
    public var myBitmap : Bitmap;
    
    public var onRail : Int;
    
    private var moveRL : Float;
    
    private var moveUD : Float;
    
    private var animate : Bool = true;
    
    public var isVector : Bool = true;
    
    public function new(itis : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, par : Sprite, anim : Bool)
    {
        super();
        this.ItIs = itis;
        x = ex;
        y = ey;
        this.onRail = rail;
        this.moveRL = eRL;
        this.moveUD = eUD;
        scaleX = scale;
        scaleY = Math.abs(scale);
        rotation = rot * (180 / Math.PI);
        this.myBitmapData = cachedEffects[itis + "FrameCache"][0];
        this.myBitmap = new Bitmap(this.myBitmapData);
        this.myBitmap.smoothing = false;
        this.addChild(this.myBitmap);
        this.myBitmap.x = cachedEffects[itis + "BitmapXs"][0];
        this.myBitmap.y = cachedEffects[itis + "BitmapYs"][0];
        this.totalBitmaps = cachedEffects[itis + "FrameCache"].length;
        this.animate = anim;
    }
    
    public static function spawnCachedEffect(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, par : Sprite = null, anim : Bool = true) : CachedEffects
    {
        if (effectsPool.length > 0)
        {
            effect = effectsPool.pop();
            effect.moveRL = eRL;
            effect.moveUD = eUD;
            effect.x = ex;
            effect.y = ey;
            effect.scaleX = scale;
            effect.scaleY = Math.abs(scale);
            effect.rotation = rot * (180 / Math.PI);
            effect.visible = true;
            effect.ItIs = e;
            effect.frame = 0;
            effect.myBitmap.bitmapData = cachedEffects[e + "FrameCache"][0];
            effect.myBitmap.x = cachedEffects[e + "BitmapXs"][0];
            effect.myBitmap.y = cachedEffects[e + "BitmapYs"][0];
            effect.totalBitmaps = cachedEffects[e + "FrameCache"].length;
        }
        else
        {
            effect = new CachedEffects(e, ex, ey, rot, scale, eRL, eUD, rail, par, anim);
        }
        if (par == null)
        {
            Backgrounds.backgroundsArray[rail].addChild(effect);
        }
        else
        {
            par.addChild(effect);
        }
        if (anim)
        {
            effectsArray[arrayLength] = effect;
            ++arrayLength;
        }
        return effect;
    }
    
    public static function EffectEnterFrames(f : Float) : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(arrayLength - 1);
        while (i >= 0)
        {
            Reflect.field(effectsArray, Std.string(i)).EffectEnterFrame() && Reflect.field(effectsArray, Std.string(i)).killWithInt(i);
            i--;
        }
    }
    
    public static function cacheMe(itis : Dynamic) : Void
    {
        var bounds : Rectangle = null;
        var bmpData : BitmapData = null;
        var effectClass : Class<Dynamic> = Type.getClass(Type.resolveClass("effect" + itis));
        var effect : MovieClip = Type.createInstance(effectClass, []);
        for (i in 0...effect.totalFrames)
        {
            effect.gotoAndStop(i + 1);
            if (effect.effect != null)
            {
                effect.effect.gotoAndStop(i + 1);
            }
            if (effect.effect2 != null)
            {
                effect.effect2.gotoAndStop(i + 1);
            }
            bounds = effect.getBounds(effect);
            bounds.x -= 5;
            bounds.y -= 5;
            bounds.height += 10;
            bounds.width += 10;
            if (bounds.width < 35)
            {
                bounds.width = 35;
            }
            cachedEffects[itis + "BitmapXs"][i] = bounds.x;
            cachedEffects[itis + "BitmapYs"][i] = bounds.y;
            bmpData = new BitmapData(Math.floor(bounds.width), Math.floor(bounds.height), true, 16777215);
            bmpData.lock();
            bmpData.drawWithQuality(effect, new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y), null, null, null, true, StageQuality.HIGH);
            cachedEffects[itis + "FrameCache"][i] = bmpData;
        }
        bmpData = null;
        bounds = null;
        effectClass = null;
        effect = null;
    }
    
    public function EffectEnterFrame() : Bool
    {
        x += this.moveRL;
        y += this.moveUD;
        this.moveRL *= 0.8;
        this.moveUD *= 0.8;
        ++this.frame;
        if (this.frame < this.totalBitmaps)
        {
            this.myBitmap.bitmapData = cachedEffects[this.ItIs + "FrameCache"][this.frame];
            this.myBitmap.x = cachedEffects[this.ItIs + "BitmapXs"][this.frame];
            this.myBitmap.y = cachedEffects[this.ItIs + "BitmapYs"][this.frame];
            return false;
        }
        return true;
    }
    
    public function changeFrame(f : Int) : Void
    {
        this.frame = f;
        this.myBitmap.bitmapData = cachedEffects[this.ItIs + "FrameCache"][this.frame];
        this.myBitmap.x = cachedEffects[this.ItIs + "BitmapXs"][this.frame];
        this.myBitmap.y = cachedEffects[this.ItIs + "BitmapYs"][this.frame];
    }
    
    private function killWithInt(i : Int) : Void
    {
        if (arrayLength == 1)
        {
            effectsArray = new Array<CachedEffects>();
        }
        else if (i < arrayLength - 1)
        {
            effectsArray[i] = effectsArray.pop();
        }
        else
        {
            effectsArray.pop();
        }
        effectsPool.push(this);
        --arrayLength;
        visible = false;
    }
    
    public function goSwim() : Void
    {
        effectsPool.push(this);
        visible = false;
    }
}


