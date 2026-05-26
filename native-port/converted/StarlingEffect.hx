import starling.display.*;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

class StarlingEffect extends MovieClip
{
    
    public static var framin : Float;
    
    public static var arrayLength : Int;
    
    public static var effectsAtlas : TextureAtlas;
    
    public static var meshBatch : MeshBatch;
    
    public static var smokePuffTextures : Array<Texture>;
    
    public static var SquigPopTextures : Array<Texture>;
    
    public static var popEffectTextures : Array<Texture>;
    
    public static var impactEffectTextures : Array<Texture>;
    
    public static var blockPieceTextures : Array<Texture>;
    
    public static var inkTrail0Textures : Array<Texture>;
    
    public static var inkTrail1Textures : Array<Texture>;
    
    public static var inkTrail2Textures : Array<Texture>;
    
    public static var inkImpact0Textures : Array<Texture>;
    
    public static var inkImpact1Textures : Array<Texture>;
    
    public static var inkImpact2Textures : Array<Texture>;
    
    public static var inkZipTrail0Textures : Array<Texture>;
    
    public static var inkZipTrail1Textures : Array<Texture>;
    
    public static var inkZipTrail2Textures : Array<Texture>;
    
    public static var inkSplashTextures : Array<Texture>;
    
    public static var SplatTextures : Array<Texture>;
    
    public static var bubbleTextures : Array<Texture>;
    
    public static var fireTextures : Array<Texture>;
    
    public static var effectsArray : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    private static var effectColor : Int = 16777215;
    
    private static var effectNames : Array<String> = ["smokePuff", "SquigPop", "popEffect", "impactEffect", "blockPiece", "inkSplash", "inkTrail0", "inkTrail1", "inkTrail2", "inkImpact0", "inkImpact1", "inkImpact2", "inkZipTrail0", "inkZipTrail1", "inkZipTrail2", "Splat", "bubble", "fire"];
    
    public static var smokePuffPool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var SquigPopPool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var popEffectPool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var impactEffectPool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var blockPiecePool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var inkTrail0Pool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var inkTrail1Pool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var inkTrail2Pool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var inkImpact0Pool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var inkImpact1Pool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var inkImpact2Pool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var inkZipTrail0Pool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var inkZipTrail1Pool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var inkZipTrail2Pool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var inkSplashPool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var SplatPool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var bubblePool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public static var firePool : Array<StarlingEffect> = new Array<StarlingEffect>();
    
    public var ItIs : String;
    
    public var moveRL : Float;
    
    public var moveUD : Float;
    
    public var onRail : Int;
    
    public var isVector : Bool;
    
    public function new(e : String, ex : Int, ey : Int, rot : Float, sca : Float, eRL : Float, eUD : Float, rail : Int, lop : Bool)
    {
        super(StarlingEffect[e + "Textures"]);
        this.ItIs = e;
        x = ex;
        y = ey;
        rotation = rot;
        scaleX = sca;
        scaleY = Math.abs(sca);
        this.moveRL = eRL;
        this.moveUD = eUD;
        this.onRail = rail;
        loop = lop;
    }
    
    public static function createAtlas(atlas : Dynamic) : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(effectNames.length - 1);
        while (i >= 0)
        {
            StarlingEffect[Reflect.setField(effectNames, Std.string(i), "Textures")];
            i--;
        }
        StarlingBackgrounds.inkSplat = new MovieClip(atlas.getTextures("inkSplat"));
    }
    
    public static function Spawn(e : String, ex : Int, ey : Int, rot : Float, sca : Float, eRL : Float, eUD : Float, rail : Int, lop : Bool = false, type : String = "nothing", frame : Int = 1) : Void
    {
        var effect : StarlingEffect = null;
        if (StarlingEffect[e + "Pool"].length > 0)
        {
            effect = StarlingEffect[e + "Pool"].pop();
            effect.setVariables(e, ex, ey, rot, sca, eRL, eUD, rail, lop);
            effect.visible = true;
        }
        else
        {
            if (e == "blockPiece")
            {
                effect = new StarlingShrapnel(e, ex, ey, rot, sca, eRL, eUD, rail, lop);
            }
            else if (e == "bubble")
            {
                effect = new StarlingBubble(e, ex, ey, rot, sca, eRL, eUD, rail, lop);
            }
            else if (e == "fire")
            {
                effect = new StarlingFire(e, ex, ey, rot, sca, eRL, eUD, rail, lop);
            }
            else
            {
                effect = new StarlingEffect(e, ex, ey, rot, sca, eRL, eUD, rail, lop);
            }
            effect.textureSmoothing = "bilinear";
        }
        if (rail > 0)
        {
            StarlingBackgrounds.addObject(effect, rail);
        }
        effect.color = effectColor;
        effect.currentFrame = frame;
        effectsArray[arrayLength] = effect;
        effect.setupEffect();
        ++arrayLength;
        effect = null;
    }
    
    public static function GrabLastEffect() : StarlingEffect
    {
        return effectsArray[arrayLength - 1];
    }
    
    public static function setColor(e : Int) : Void
    {
        effectColor = e;
    }
    
    public static function meshCache(background : Dynamic) : Void
    {
        meshBatch = new MeshBatch();
        background.addChild(meshBatch);
    }
    
    public static function pressMeshes() : Void
    {
        meshBatch.clear();
        for (i in 0...arrayLength)
        {
            if (Reflect.field(effectsArray, Std.string(i)).onRail == 0)
            {
                meshBatch.addMesh(Reflect.field(effectsArray, Std.string(i)));
            }
        }
    }
    
    public static function effectsEnterFrames(f : Float) : Void
    {
        framin = f;
        var i : Dynamic = as3hx.Compat.parseInt(arrayLength - 1);
        while (i >= 0)
        {
            Reflect.field(effectsArray, Std.string(i)).effectsEnterFrame() && Reflect.field(effectsArray, Std.string(i)).killWithInt(i);
            i--;
        }
    }
    
    public static function clearAllEffects() : Dynamic
    {
        var i : Dynamic = as3hx.Compat.parseInt(arrayLength - 1);
        while (i >= 0)
        {
            if (Reflect.field(effectsArray, Std.string(i)).parent != null)
            {
                Reflect.field(effectsArray, Std.string(i)).parent.addChild(Reflect.field(effectsArray, Std.string(i)));
            }
            Reflect.setField(effectsArray, Std.string(i), false).visible;
            StarlingEffect[Reflect.field(effectsArray, Std.string(i)).ItIs + "Pool"].push(Reflect.field(effectsArray, Std.string(i)));
            i--;
        }
        effectsArray = new Array<StarlingEffect>();
        arrayLength = 0;
        detachPools();
        meshBatch.dispose();
    }
    
    public static function detachPools() : Dynamic
    {
        var i : Dynamic = 0;
        var n : Dynamic = as3hx.Compat.parseInt(effectNames.length - 1);
        while (n >= 0)
        {
            i = as3hx.Compat.parseInt(StarlingEffect[Reflect.field(effectNames, Std.string(n)) + "Pool"].length - 1);
            while (i >= 0)
            {
                if (StarlingEffect[Reflect.field(effectNames, Std.string(n)) + "Pool"][i].parent != null)
                {
                    StarlingEffect[Reflect.field(effectNames, Std.string(n)) + "Pool"][i].parent.removeChild(StarlingEffect[Reflect.field(effectNames, Std.string(n)) + "Pool"][i]);
                }
                i--;
            }
            n--;
        }
    }
    
    public static function elevate() : Dynamic
    {
        var i : Dynamic = as3hx.Compat.parseInt(effectsArray.length - 1);
        while (i >= 0)
        {
            if (Reflect.field(effectsArray, Std.string(i)) != null)
            {
                StarlingBackgrounds.addObject(Reflect.field(effectsArray, Std.string(i)), 0);
            }
            i--;
        }
    }
    
    public function setupEffect() : Void
    {
    }
    
    private function setVariables(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, lop : Bool) : Dynamic
    {
        this.ItIs = e;
        x = ex;
        y = ey;
        this.moveRL = eRL;
        this.moveUD = eUD;
        rotation = rot;
        this.onRail = rail;
        scaleX = scale;
        scaleY = Math.abs(scale);
        loop = lop;
    }
    
    public function effectsEnterFrame() : Bool
    {
        x += this.moveRL * framin;
        y += this.moveUD * framin;
        this.moveRL -= this.moveRL * 0.22 * framin;
        this.moveUD -= this.moveUD * 0.22 * framin;
        return nextFrameStep(framin);
    }
    
    private function killWithInt(i : Int) : Void
    {
        effectsArray.splice(i, 1)[0];
        StarlingEffect[this.ItIs + "Pool"].push(this);
        if (this.onRail > 0)
        {
            parent.removeChild(this);
        }
        --arrayLength;
        visible = false;
    }
    
    public function goSwim() : Void
    {
        if (Lambda.indexOf(effectsArray, this) > -1)
        {
            this.killWithInt(Lambda.indexOf(effectsArray, this));
        }
    }
}


