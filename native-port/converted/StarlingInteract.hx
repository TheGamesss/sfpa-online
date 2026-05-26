import flash.utils.*;
import starling.display.*;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

class StarlingInteract extends MovieClip
{
    
    public static var framin : Float;
    
    public static var backgroundsN : Int;
    
    public static var localSquiggles : Int;
    
    public static var arrayLength : Int;
    
    public static var interactsAtlas : TextureAtlas;
    
    public static var meshBatch : MeshBatch;
    
    private static var looseSquiggleTextures : Array<Texture>;
    
    private static var SquiggleTextures : Array<Texture>;
    
    private static var shadowSquiggleTextures : Array<Texture>;
    
    private static var SquigglePopTextures : Array<Texture>;
    
    private static var grassPopTextures : Array<Texture>;
    
    private static var inkShotTextures : Array<Texture>;
    
    private static var inkShotBadTextures : Array<Texture>;
    
    private static var inkDropTextures : Array<Texture>;
    
    private static var fadeInHelpTextures : Array<Texture>;
    
    private static var paySquiggleTextures : Array<Texture>;
    
    private static var inkSpoutTextures : Array<Texture>;
    
    private static var ScratchTextures : Array<Texture>;
    
    private static var inkPipeTextures : Array<Texture>;
    
    private static var aScratchTextures : Array<Texture>;
    
    public static var dontCheat : Dynamic = { };
    
    public static var interactsArray : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    public static var halfArray : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    public static var cameraCollideArray : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    public static var canAttackArray : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    public static var meshArray : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var interactNames : Array<String> = ["looseSquiggle", "Squiggle", "shadowSquiggle", "SquigglePop", "grassPop", "inkShot", "inkShotBad", "inkDrop", "fadeInHelp", "paySquiggle", "inkSpout", "Scratch", "inkPipe", "aScratch"];
    
    private static var looseSquigglePool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var SquigglePool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var shadowSquigglePool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var SquigglePopPool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var grassPopPool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var inkShotPool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var inkShotBadPool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var inkDropPool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var fadeInHelpPool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var paySquigglePool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var inkSpoutPool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var ScratchPool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var inkPipePool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
    private static var aScratchPool : Array<StarlingInteract> = new Array<StarlingInteract>();
    
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
    
    public var skipMesh : Bool;
    
    public var backEffect : Bool = true;
    
    public var killOnAttack : Bool = true;
    
    public function new(e : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, scale : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, id : Int = -1)
    {
        super(StarlingInteract[e + "Textures"]);
        this.setVariables(e, ex, ey, rot, scale, eRL, eUD, rail, id);
    }
    
    public static function createAtlas(atlas : Dynamic) : Void
    {
        var i : Int = 0;
        while (i < interactNames.length)
        {
            StarlingInteract[interactNames[i] + "Textures"] = atlas.getTextures(interactNames[i]);
            i++;
        }
    }
    
    public static function Spawn(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, id : Int = -1) : StarlingInteract
    {
        var interact : StarlingInteract = null;
        var classTemp : Class<Dynamic> = null;
        if (StarlingInteract[e + "Pool"].length > 0)
        {
            interact = StarlingInteract[e + "Pool"].pop();
            interact.setVariables(e, ex, ey, rot, scale, eRL, eUD, rail, id);
            interactsArray[arrayLength] = interact;
            interact.visible = true;
            interact.currentFrame = 1;
        }
        else
        {
            classTemp = Type.getClass(Type.resolveClass(e + "Starling"));
            interact = Type.createInstance(classTemp, [e, ex, ey, rot, scale, eRL, eUD, rail, id]);
            interact.textureSmoothing = "bilinear";
        }
        interact.reset();
        if (rail > 0 || interact.skipMesh)
        {
            StarlingBackgrounds.addObject(interact, rail);
        }
        else
        {
            meshArray.push(interact);
        }
        interactsArray[arrayLength] = interact;
        ++arrayLength;
        return interact;
    }
    
    public static function meshCache(background : Dynamic) : Void
    {
        meshBatch = new MeshBatch();
        background.addChild(meshBatch);
    }
    
    public static function pressMeshes() : Void
    {
        meshBatch.clear();
        var i : Int = 0;
        var l : Int = meshArray.length;
        while (i < l)
        {
            meshBatch.addMesh(meshArray[i]);
            i++;
        }
    }
    
    public static function InteractPopulate(p : Dynamic) : Void
    {
        Spawn(p.ItIs, p.x, p.y, p.rotation * (Math.PI / 180), p.scaleX, 0, 0, p.onRail, p.ID);
    }
    
    public static function InkPipePopulate(p : Dynamic) : Void
    {
        Spawn(p.ItIs, p.x, p.y, p.rotation * (Math.PI / 180), p.scaleX, 0, 0, p.onRail, p.lifetime * 1000 + p.interval);
    }
    
    public static function interactsEnterFrames(f : Float) : Void
    {
        framin = f;
        var i : Dynamic = as3hx.Compat.parseInt(arrayLength - 1);
        while (i >= 0)
        {
            Reflect.field(interactsArray, Std.string(i)).interactsEnterFrame() && Reflect.field(interactsArray, Std.string(i)).killWithInt(i);
            i--;
        }
    }
    
    public static function halfEnterFrames(f : Float) : Void
    {
        framin = f;
        var i : Dynamic = as3hx.Compat.parseInt(halfArray.length - 1);
        while (i >= 0)
        {
            Reflect.field(halfArray, Std.string(i)).halfEnterFrame() && Reflect.field(interactsArray, Std.string(i)).killWithInt(i);
            i--;
        }
    }
    
    public static function charCheckObjects(ex : Float, ey : Float, eWide : Int, eTall : Int, rail : Int, char : Char) : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(arrayLength - 1);
        while (i >= 0)
        {
            if (Reflect.field(interactsArray, Std.string(i)).onRail == rail && Math.abs(ex - Reflect.field(interactsArray, Std.string(i)).x) < eWide + Reflect.field(interactsArray, Std.string(i)).isWide + 10 && Math.abs(ey - Reflect.field(interactsArray, Std.string(i)).y) < eTall + Reflect.field(interactsArray, Std.string(i)).isTall + 10)
            {
                Reflect.field(interactsArray, Std.string(i)).hitChar(ex, ey, char.moveRL, char.moveUD, char) && Reflect.field(interactsArray, Std.string(i)).killWithInt(i);
            }
            i--;
        }
    }
    
    public static function baddieCheckObjects(ex : Float, ey : Float, eWide : Int, eTall : Int, rail : Int, char : Baddies) : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(arrayLength - 1);
        while (i >= 0)
        {
            if (Reflect.field(interactsArray, Std.string(i)).onRail == char.onRail)
            {
                if (Math.abs(ex - Reflect.field(interactsArray, Std.string(i)).x) < eWide + Reflect.field(interactsArray, Std.string(i)).isWide + 10 && Math.abs(ey - Reflect.field(interactsArray, Std.string(i)).y) < eTall + Reflect.field(interactsArray, Std.string(i)).isTall + 10)
                {
                    Reflect.field(interactsArray, Std.string(i)).hitBaddie(ex, ey, char.moveRL, char.moveUD, char) && Reflect.field(interactsArray, Std.string(i)).killWithInt(i);
                }
            }
            i--;
        }
    }
    
    public static function cameraCheckObjects(ex : Float, ey : Float, eWide : Int, eTall : Int, rail : Int, char : Char) : Bool
    {
        for (n in 0...cameraCollideArray.length)
        {
            if (Reflect.field(cameraCollideArray, Std.string(n)).onRail == rail)
            {
                if (Math.abs(ex - Reflect.field(cameraCollideArray, Std.string(n)).x) < eWide + Reflect.field(cameraCollideArray, Std.string(n)).isWide && Math.abs(ey - Reflect.field(cameraCollideArray, Std.string(n)).y) < eTall + Reflect.field(cameraCollideArray, Std.string(n)).isTall)
                {
                    char.predictOffsetY = Reflect.field(cameraCollideArray, Std.string(n)).predictOffsetY;
                    return true;
                }
            }
        }
        return false;
    }
    
    public static function checkAttackables(char : Dynamic, rail : Dynamic) : Bool
    {
        var temp : Int = 0;
        var i : Dynamic = as3hx.Compat.parseInt(canAttackArray.length - 1);
        while (i >= 0)
        {
            if (Reflect.field(canAttackArray, Std.string(i)).onRail == rail)
            {
                if (cast(char.CheckAttack(Reflect.field(canAttackArray, Std.string(i))), Bool) && Reflect.field(canAttackArray, Std.string(i)).killOnAttack)
                {
                    temp = Lambda.indexOf(interactsArray, Reflect.field(canAttackArray, Std.string(i)));
                    Reflect.field(canAttackArray, Std.string(i)).killWithInt(temp);
                }
            }
            i--;
        }
        return false;
    }
    
    public static function checkByName(e : String, ex : Int, ey : Int, wide : Int, tall : Int, rail : Int) : StarlingInteract
    {
        var i : Dynamic = as3hx.Compat.parseInt(arrayLength - 1);
        while (i >= 0)
        {
            if (Reflect.field(interactsArray, Std.string(i)).ItIs == e && Reflect.field(interactsArray, Std.string(i)).onRail == rail)
            {
                if (Math.abs(ex - Reflect.field(interactsArray, Std.string(i)).x) < wide + Reflect.field(interactsArray, Std.string(i)).isWide && Math.abs(ey - Reflect.field(interactsArray, Std.string(i)).y) < tall + Reflect.field(interactsArray, Std.string(i)).isTall)
                {
                    return Reflect.field(interactsArray, Std.string(i));
                }
            }
            i--;
        }
    }
    
    public static function findByName(e : Dynamic) : StarlingInteract
    {
        var i : Dynamic = as3hx.Compat.parseInt(arrayLength - 1);
        while (i >= 0)
        {
            if (Reflect.field(interactsArray, Std.string(i)).ItIs == e)
            {
                return Reflect.field(interactsArray, Std.string(i));
            }
            i--;
        }
    }
    
    public static function clearAllInteracts() : Dynamic
    {
        var i : Dynamic = as3hx.Compat.parseInt(arrayLength - 1);
        while (i >= 0)
        {
            if (Reflect.field(interactsArray, Std.string(i)).parent != null)
            {
                Reflect.field(interactsArray, Std.string(i)).parent.removeChild(Reflect.field(interactsArray, Std.string(i)));
            }
            Reflect.setField(interactsArray, Std.string(i), false).visible;
            Reflect.field(interactsArray, Std.string(i)).cleanUp();
            StarlingInteract[Reflect.field(interactsArray, Std.string(i)).ItIs + "Pool"].push(Reflect.field(interactsArray, Std.string(i)));
            i--;
        }
        interactsArray = new Array<StarlingInteract>();
        halfArray = new Array<StarlingInteract>();
        cameraCollideArray = new Array<StarlingInteract>();
        canAttackArray = new Array<StarlingInteract>();
        meshArray = new Array<StarlingInteract>();
        arrayLength = 0;
        detachPools();
        meshBatch.dispose();
    }
    
    public static function detachPools() : Dynamic
    {
        var i : Dynamic = 0;
        var n : Dynamic = as3hx.Compat.parseInt(interactNames.length - 1);
        while (n >= 0)
        {
            i = as3hx.Compat.parseInt(StarlingInteract[Reflect.field(interactNames, Std.string(n)) + "Pool"].length - 1);
            while (i >= 0)
            {
                if (StarlingInteract[Reflect.field(interactNames, Std.string(n)) + "Pool"][i].parent != null)
                {
                    StarlingInteract[Reflect.field(interactNames, Std.string(n)) + "Pool"][i].parent.removeChild(StarlingInteract[Reflect.field(interactNames, Std.string(n)) + "Pool"][i]);
                }
                i--;
            }
            n--;
        }
    }
    
    public static function elevate() : Dynamic
    {
        var i : Dynamic = as3hx.Compat.parseInt(interactsArray.length - 1);
        while (i >= 0)
        {
            if (Reflect.field(interactsArray, Std.string(i)) != null)
            {
                StarlingBackgrounds.addObject(Reflect.field(interactsArray, Std.string(i)), 0);
            }
            i--;
        }
    }
    
    private function setVariables(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, id : Int) : Dynamic
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
        this.ID = id;
    }
    
    public function makeOne(e : Dynamic) : Int
    {
        if (e == 0)
        {
            return 0;
        }
        return as3hx.Compat.parseInt(e / Math.abs(e));
    }
    
    public function interactsEnterFrame() : Bool
    {
    }
    
    public function halfEnterFrame() : Bool
    {
    }
    
    public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
    }
    
    public function hitBaddie(ex : Float, ey : Float, eRL : Float, eUD : Float, bad : Baddies) : Bool
    {
    }
    
    public function reset() : Void
    {
    }
    
    public function cleanUp() : Void
    {
    }
    
    private function killWithInt(i : Int) : Void
    {
        var temp : Int = 0;
        interactsArray.splice(i, 1)[0];
        StarlingInteract[this.ItIs + "Pool"].push(this);
        temp = Lambda.indexOf(halfArray, this);
        if (temp > -1)
        {
            halfArray.splice(temp, 1)[0];
        }
        temp = Lambda.indexOf(cameraCollideArray, this);
        if (temp > -1)
        {
            cameraCollideArray.splice(temp, 1)[0];
        }
        temp = Lambda.indexOf(canAttackArray, this);
        if (temp > -1)
        {
            canAttackArray.splice(temp, 1)[0];
        }
        temp = Lambda.indexOf(meshArray, this);
        if (temp > -1)
        {
            meshArray.splice(temp, 1)[0];
        }
        if (this.onRail > 0)
        {
            parent.removeChild(this);
        }
        visible = false;
        this.cleanUp();
        --arrayLength;
    }
}


