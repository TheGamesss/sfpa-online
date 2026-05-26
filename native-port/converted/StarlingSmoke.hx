import starling.display.*;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

class StarlingSmoke extends MovieClip
{
    
    public static var framin : Float;
    
    public static var backgroundsN : Int;
    
    public static var localSquiggles : Int;
    
    public static var arrayLength : Int;
    
    public static var smokesAtlas : TextureAtlas;
    
    public static var meshBatch : MeshBatch;
    
    public static var Slash1Textures : Array<Texture>;
    
    public static var Slash2Textures : Array<Texture>;
    
    public static var Slash3Textures : Array<Texture>;
    
    public static var Slash4Textures : Array<Texture>;
    
    public static var SlashMedium1Textures : Array<Texture>;
    
    public static var SlashMedium2Textures : Array<Texture>;
    
    public static var SlashHeavy1Textures : Array<Texture>;
    
    public static var BuzzSawTextures : Array<Texture>;
    
    public static var SwipeUpTextures : Array<Texture>;
    
    public static var HeavyUpTextures : Array<Texture>;
    
    public static var HeavyDownTextures : Array<Texture>;
    
    public static var PokeDownTextures : Array<Texture>;
    
    public static var SlashRisingTextures : Array<Texture>;
    
    private static var Baddie1SmokeTextures : Array<Texture>;
    
    private static var InkFlySmokeTextures : Array<Texture>;
    
    private static var InkFloatSmokeTextures : Array<Texture>;
    
    private static var SpiderSmokeTextures : Array<Texture>;
    
    private static var MouseSmokeTextures : Array<Texture>;
    
    private static var NinjaSmokeTextures : Array<Texture>;
    
    private static var BatSmokeTextures : Array<Texture>;
    
    private static var SnailShellSmokeTextures : Array<Texture>;
    
    private static var InkBallSmokeTextures : Array<Texture>;
    
    private static var inkDripperTextures : Array<Texture>;
    
    private static var doorStampTextures : Array<Texture>;
    
    private static var surfaceStampTextures : Array<Texture>;
    
    private static var springStampTextures : Array<Texture>;
    
    private static var tearStampTextures : Array<Texture>;
    
    private static var aWallStampTextures : Array<Texture>;
    
    private static var tutorialIconStampTextures : Array<Texture>;
    
    private static var SpinnerStampTextures : Array<Texture>;
    
    private static var baddiePuddleStampTextures : Array<Texture>;
    
    private static var PortalBoxStampTextures : Array<Texture>;
    
    private static var inkSpoutStampTextures : Array<Texture>;
    
    private static var healthBarTextures : Array<Texture>;
    
    private static var doorPromptTextures : Array<Texture>;
    
    private static var blackBlockTextures : Array<Texture>;
    
    public static var dontCheat : Dynamic = { };
    
    public static var smokesArray : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var smokeColor : Int = 16777215;
    
    private static var smokeNames : Array<String> = ["aWallStamp", "Baddie1Smoke", "InkFlySmoke", "InkBallSmoke", "InkFloatSmoke", "SpiderSmoke", "MouseSmoke", "NinjaSmoke", "BatSmoke", "SnailShellSmoke", "inkDripper", "doorStamp", "surfaceStamp", "springStamp", "tearStamp", "Slash1", "Slash2", "Slash3", "Slash4", "SlashMedium1", "SlashMedium2", "SlashHeavy1", "BuzzSaw", "SwipeUp", "HeavyUp", "HeavyDown", "PokeDown", "SlashRising", "tutorialIconStamp", "SpinnerStamp", "baddiePuddleStamp", "PortalBoxStamp", "inkSpoutStamp", "healthBar", "doorPrompt", "blackBlock"];
    
    public static var Slash1Pool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var Slash2Pool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var Slash3Pool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var Slash4Pool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var SlashMedium1Pool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var SlashMedium2Pool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var SlashHeavy1Pool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var BuzzSawPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var SwipeUpPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var HeavyUpPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var HeavyDownPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var PokeDownPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public static var SlashRisingPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var Baddie1SmokePool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var InkFlySmokePool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var InkFloatSmokePool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var SpiderSmokePool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var MouseSmokePool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var NinjaSmokePool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var BatSmokePool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var SnailShellSmokePool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var InkBallSmokePool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var inkDripperPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var doorStampPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var surfaceStampPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var springStampPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var tearStampPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var aWallStampPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var tutorialIconStampPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var SpinnerStampPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var baddiePuddleStampPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var PortalBoxStampPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var inkSpoutStampPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var healthBarPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var doorPromptPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    private static var blackBlockPool : Array<StarlingSmoke> = new Array<StarlingSmoke>();
    
    public var ItIs : String;
    
    public var isWide : Int = 15;
    
    public var isTall : Int = 15;
    
    public var moveRL : Float;
    
    public var moveUD : Float;
    
    public var onRail : Int;
    
    public var ID : Int;
    
    public var predictOffsetY : Int = 0;
    
    public var downTime : Int = 0;
    
    public var health : Int = 0;
    
    public var isVector : Bool = false;
    
    public function new(e : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, scale : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic)
    {
        super(StarlingSmoke[e + "Textures"]);
        this.setVariables(e, ex, ey, rot, scale, eRL, eUD, rail);
    }
    
    public static function createAtlas(atlas : Dynamic) : Void
    {
        var i : Int = 0;
        while (i < smokeNames.length)
        {
            StarlingSmoke[smokeNames[i] + "Textures"] = atlas.getTextures(smokeNames[i]);
            i++;
        }
    }
    
    public static function Spawn(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, attachBack : Bool = false) : StarlingSmoke
    {
        var smoke : StarlingSmoke = null;
        if (StarlingSmoke[e + "Pool"].length > 0)
        {
            smoke = StarlingSmoke[e + "Pool"].pop();
            smoke.setVariables(e, ex, ey, rot, scale, eRL, eUD, rail);
            smoke.currentFrame = 1;
        }
        else
        {
            smoke = new StarlingSmoke(e, ex, ey, rot, scale, eRL, eUD, rail);
            smoke.textureSmoothing = "bilinear";
        }
        smoke.reset();
        smoke.returnToMesh(rail, attachBack);
        smoke.color = smokeColor;
        return smoke;
    }
    
    public static function SpawnSlash(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, attachBack : Bool = false) : StarlingSmoke
    {
        var smoke : StarlingSmoke = null;
        if (StarlingSmoke[e + "Pool"].length > 0)
        {
            smoke = StarlingSmoke[e + "Pool"].pop();
            smoke.setVariables(e, ex, ey, rot, scale, eRL, eUD, rail);
            smoke.currentFrame = 1;
        }
        else
        {
            smoke = new StarlingSmoke(e, ex, ey, rot, scale, eRL, eUD, rail);
            smoke.textureSmoothing = "bilinear";
        }
        smoke.reset();
        smoke.visible = true;
        StarlingBackgrounds.placeSlash(smoke);
        smoke.color = smokeColor;
        return smoke;
    }
    
    public static function setColor(e : Int) : Void
    {
        smokeColor = e;
    }
    
    public static function checkByName(e : String, ex : Int, ey : Int, wide : Int, tall : Int, rail : Int) : StarlingSmoke
    {
        var i : Dynamic = as3hx.Compat.parseInt(arrayLength - 1);
        while (i >= 0)
        {
            if (Reflect.field(smokesArray, Std.string(i)).ItIs == e && Reflect.field(smokesArray, Std.string(i)).onRail == rail)
            {
                if (Math.abs(ex - Reflect.field(smokesArray, Std.string(i)).x) < wide + Reflect.field(smokesArray, Std.string(i)).isWide && Math.abs(ey - Reflect.field(smokesArray, Std.string(i)).y) < tall + Reflect.field(smokesArray, Std.string(i)).isTall)
                {
                    return Reflect.field(smokesArray, Std.string(i));
                }
            }
            i--;
        }
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
            meshBatch.addMesh(smokesArray[i]);
        }
    }
    
    public static function clearAllSmokes() : Dynamic
    {
        var i : Dynamic = as3hx.Compat.parseInt(arrayLength - 1);
        while (i >= 0)
        {
            if (Reflect.field(smokesArray, Std.string(i)).parent != null)
            {
                Reflect.field(smokesArray, Std.string(i)).parent.removeChild(Reflect.field(smokesArray, Std.string(i)));
            }
            Reflect.setField(smokesArray, Std.string(i), false).visible;
            StarlingSmoke[Reflect.field(smokesArray, Std.string(i)).ItIs + "Pool"].push(Reflect.field(smokesArray, Std.string(i)));
            i--;
        }
        smokesArray = new Array<StarlingSmoke>();
        arrayLength = 0;
        detachPools();
        meshBatch.dispose();
    }
    
    public static function detachPools() : Dynamic
    {
        var i : Dynamic = 0;
        var n : Dynamic = as3hx.Compat.parseInt(smokeNames.length - 1);
        while (n >= 0)
        {
            i = as3hx.Compat.parseInt(StarlingSmoke[Reflect.field(smokeNames, Std.string(n)) + "Pool"].length - 1);
            while (i >= 0)
            {
                if (StarlingSmoke[Reflect.field(smokeNames, Std.string(n)) + "Pool"][i].parent != null)
                {
                    StarlingSmoke[Reflect.field(smokeNames, Std.string(n)) + "Pool"][i].parent.removeChild(StarlingSmoke[Reflect.field(smokeNames, Std.string(n)) + "Pool"][i]);
                }
                i--;
            }
            n--;
        }
    }
    
    public static function elevate() : Dynamic
    {
        var i : Dynamic = as3hx.Compat.parseInt(smokesArray.length - 1);
        while (i >= 0)
        {
            if (Reflect.field(smokesArray, Std.string(i)) != null)
            {
                StarlingBackgrounds.addObject(Reflect.field(smokesArray, Std.string(i)), Reflect.field(smokesArray, Std.string(i)).onRail);
            }
            i--;
        }
    }
    
    private function setVariables(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int) : Dynamic
    {
        this.ItIs = e;
        x = ex;
        y = ey;
        rotation = rot;
        this.onRail = rail;
        scaleX = scale;
        scaleY = Math.abs(scale);
    }
    
    public function reset() : Void
    {
    }
    
    private function killWithInt(i : Int) : Void
    {
        smokesArray.splice(i, 1)[0];
        visible = false;
        --arrayLength;
    }
    
    private function killWithoutInt() : Void
    {
        var temp : Int = 0;
        StarlingSmoke[this.ItIs + "Pool"].push(this);
        temp = Lambda.indexOf(smokesArray, this);
        if (temp > -1)
        {
            --arrayLength;
            smokesArray.splice(temp, 1)[0];
        }
        else if (parent != null)
        {
            parent.removeChild(this);
        }
        visible = false;
    }
    
    public function returnToMesh(rail : Int, attachBack : Bool) : Void
    {
        visible = true;
        if (attachBack)
        {
            StarlingBackgrounds.addObjectBack(this, rail);
        }
        else if (rail > 0)
        {
            StarlingBackgrounds.addObject(this, rail);
        }
        else
        {
            smokesArray[arrayLength] = this;
            ++arrayLength;
        }
    }
    
    public function goSwim() : Void
    {
        this.killWithoutInt();
    }
    
    public function hideFromMesh() : Void
    {
        var temp : Int = 0;
        temp = Lambda.indexOf(smokesArray, this);
        if (temp > -1)
        {
            --arrayLength;
            smokesArray.splice(temp, 1)[0];
        }
        else
        {
            visible = false;
        }
    }
}


