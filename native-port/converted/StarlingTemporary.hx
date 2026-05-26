import com.emibap.textureAtlas.*;
import flash.display.MovieClip;
import starling.display.MovieClip;
import starling.textures.TextureAtlas;

class StarlingTemporary extends starling.display.MovieClip
{
    
    public static var arrayLength : Int;
    
    public static var textureObj : Dynamic;
    
    private static var alreadyCached : Bool;
    
    private static var tempAtlas : TextureAtlas;
    
    public static var TempArray : Array<StarlingTemporary> = new Array<StarlingTemporary>();
    
    public static var tempEnterFrameArray : Array<StarlingTemporary> = new Array<StarlingTemporary>();
    
    public var ItIs : String;
    
    public var onRail : Int;
    
    private var loopRand : Int = 0;
    
    private var rand : Int = 0;
    
    public function new(e : String, ex : Int, ey : Int, rot : Float, sca : Float, rail : Int, loop : Bool, lr : Int)
    {
        super(Reflect.field(textureObj, Std.string(e + "Textures")));
        this.ItIs = e;
        x = ex;
        y = ey;
        rotation = rot;
        scaleX = sca;
        scaleY = Math.abs(sca);
        this.onRail = rail;
        this.loopRand = lr;
    }
    
    public static function createCache(mc : flash.display.MovieClip, n : Float, compress : Bool) : Dynamic
    {
        if (!alreadyCached)
        {
            createAtlas(DynamicAtlas.fromMovieClipContainer(mc, n, 1, true, true, compress), mc);
        }
        alreadyCached = true;
    }
    
    public static function createAtlas(atlas : Dynamic, mc : flash.display.MovieClip) : Void
    {
        var itis : String = null;
        textureObj = {};
        tempAtlas = atlas;
        var i : Int = 0;
        var l : Int = as3hx.Compat.parseInt(mc.numChildren);
        while (i < l)
        {
            itis = mc.getChildAt(i).name;
            Reflect.setField(textureObj, Std.string(itis + "Textures"), "Textures");
            i++;
        }
    }
    
    public static function Spawn(e : String, ex : Int, ey : Int, rot : Float, sca : Float, rail : Int, loop : Bool = false, lr : Int = 0, back : Bool = false) : Int
    {
        var temp : StarlingTemporary = new StarlingTemporary(e, ex, ey, rot, sca, rail, loop, lr);
        temp.textureSmoothing = "trilinear";
        if (loop)
        {
            tempEnterFrameArray.push(temp);
        }
        TempArray.push(temp);
        if (rail > -1)
        {
            if (back)
            {
                StarlingBackgrounds.addObjectBack(temp, rail);
            }
            else
            {
                StarlingBackgrounds.addObject(temp, rail);
            }
        }
        return as3hx.Compat.parseInt(TempArray.length - 1);
    }
    
    public static function placeTemp(n : Int, ex : Float, ey : Float, erot : Float) : Void
    {
        TempArray[n].place(ex, ey, erot);
    }
    
    public static function setScales(n : Int, scx : Float, scy : Float) : Void
    {
        TempArray[n].scaleX = scx;
        TempArray[n].scaleY = scy;
    }
    
    public static function setFrame(n : Int, f : Int) : Void
    {
        TempArray[n].currentFrame = f;
    }
    
    public static function setVisible(n : Int, vis : Bool) : Void
    {
        TempArray[n].visible = vis;
    }
    
    public static function justGetWithN(n : Int) : StarlingTemporary
    {
        return TempArray[n];
    }
    
    public static function clearAll() : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(TempArray.length - 1);
        while (i >= 0)
        {
            Reflect.field(TempArray, Std.string(i)).cleanUp();
            i--;
        }
        TempArray = new Array<StarlingTemporary>();
    }
    
    public static function wipeAtlas() : Void
    {
        if (alreadyCached)
        {
            tempAtlas.texture.dispose();
            tempAtlas.dispose();
            tempAtlas = null;
            alreadyCached = false;
            effectsArray = new Array<StarlingTemporary>();
            tempEnterFrameArray = new Array<StarlingTemporary>();
        }
    }
    
    public static function tempEnterFrames() : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(tempEnterFrameArray.length - 1);
        while (i >= 0)
        {
            Reflect.field(tempEnterFrameArray, Std.string(i)).tempEnterFrame();
            i--;
        }
    }
    
    public function setupEffect() : Void
    {
    }
    
    private function place(ex : Float, ey : Float, erot : Float) : Void
    {
        x = ex;
        y = ey;
        rotation = erot;
    }
    
    public function cleanUp() : Void
    {
        removeFromParent(true);
        texture.dispose();
        dispose();
    }
    
    public function tempEnterFrame() : Bool
    {
        if (this.rand > 0)
        {
            --this.rand;
        }
        else if (currentFrame < numFrames)
        {
            ++currentFrame;
        }
        else
        {
            currentFrame = 1;
            this.rand = Math.random() * this.loopRand;
        }
    }
}


