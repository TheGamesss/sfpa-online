import starling.display.MovieClip;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

class StarlingDecals extends MovieClip
{
    
    public static var framin : Float;
    
    public static var interactsAtlas : TextureAtlas;
    
    private static var doodleGrasTextures : Array<Texture>;
    
    public static var InteractArray : Array<Dynamic> = [];
    
    public static var staticOnDeckArray : Array<Dynamic> = [];
    
    public static var onDeckN : Int = -1;
    
    public static var onDeckN2 : Int = -1;
    
    private static var decalNames : Array<String> = ["doodleGrass", "spikeDecal", "spikeBarDecal", "inkBubbleDecal"];
    
    public function cleanUp() : Dynamic
    {
    }
    public var isTall : Int = 0;
    
    public var isWide : Int = 0;
    
    public var distRL : Float = 0;
    
    public var distUD : Float = 0;
    
    public var tempRot : Float = 0;
    
    public var angle : Float;
    
    public var ex : Float = 0;
    
    public var ey : Float = 0;
    
    public var ax : Float = 0;
    
    public var ay : Float = 0;
    
    public var tempRL : Float = 0;
    
    public var tempUD : Float = 0;
    
    public var ItIs : String;
    
    public var realCurrent : Float = 1;
    
    public function new(itis : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, xsc : Dynamic, ysc : Dynamic, rail : Dynamic, estring : Dynamic, enum : Dynamic)
    {
        if (rail == null || rail == -1)
        {
            rail = 0;
        }
        super(StarlingDecals[itis + "Textures"]);
        this.ItIs = itis;
        x = ex;
        y = ey;
        rotation = rot * (Math.PI / 180);
        scaleX = xsc;
        scaleY = ysc;
        onRail = rail;
        staticOnDeckArray.push({
                    ex : x,
                    ey : y,
                    rot : rotation,
                    ItIs : this.ItIs,
                    clip : this
                });
        StarlingBackgrounds.addObject(this, rail);
        visible = false;
    }
    
    public static function createAtlas(atlas : Dynamic) : Void
    {
        var i : Int = 0;
        while (i < decalNames.length)
        {
            StarlingDecals[decalNames[i] + "Textures"] = atlas.getTextures(decalNames[i]);
            i++;
        }
    }
    
    @:allow()
    private static function staticOnDeckOverlord() : Dynamic
    {
        var interact : Dynamic = null;
        if (staticOnDeckArray.length > 0)
        {
            if (onDeckN < staticOnDeckArray.length - 1)
            {
                while (staticOnDeckArray[onDeckN + 1].ex - Main.cameraX < Main.stageX + 50)
                {
                    ++onDeckN;
                    InteractArray.push(staticOnDeckArray[onDeckN].clip);
                    staticOnDeckArray[onDeckN].clip.visible = true;
                    if (onDeckN == staticOnDeckArray.length - 1)
                    {
                        break;
                    }
                }
            }
            if (onDeckN > 0)
            {
                while (staticOnDeckArray[onDeckN].ex - Main.cameraX > Main.stageX + 50 && onDeckN > 0)
                {
                    --onDeckN;
                    interact = InteractArray.pop();
                    interact.visible = false;
                }
            }
            if (onDeckN2 < staticOnDeckArray.length - 1)
            {
                while (staticOnDeckArray[onDeckN2 + 1].ex - Main.cameraX < -(Main.stageX + 50))
                {
                    ++onDeckN2;
                    interact = InteractArray.shift();
                    interact.visible = false;
                    if (onDeckN2 == staticOnDeckArray.length - 1)
                    {
                        break;
                    }
                }
            }
            if (onDeckN2 > -1)
            {
                while (staticOnDeckArray[onDeckN2].ex - Main.cameraX > -(Main.stageX + 50))
                {
                    InteractArray.push(staticOnDeckArray[onDeckN2].clip);
                    InteractArray.unshift(InteractArray.pop());
                    staticOnDeckArray[onDeckN2].clip.visible = true;
                    --onDeckN2;
                    if (onDeckN2 < 0)
                    {
                        break;
                    }
                }
            }
        }
    }
    
    public static function InteractEnterFrames() : Dynamic
    {
        for (n in 0...InteractArray.length)
        {
            Reflect.field(InteractArray, Std.string(n)).decalEnterFrame();
        }
    }
    
    public static function charCheckObjects(ex : Float, ey : Float, eWide : Int, eTall : Int, rail : Int, char : Char) : Dynamic
    {
        for (n in 0...InteractArray.length)
        {
            if (rail == 0 && Math.abs(ex - Reflect.field(InteractArray, Std.string(n)).x) < eWide + Reflect.field(InteractArray, Std.string(n)).isWide && Math.abs(ey - Reflect.field(InteractArray, Std.string(n)).y) < eTall + Reflect.field(InteractArray, Std.string(n)).isTall)
            {
                Reflect.field(InteractArray, Std.string(n)).hitChar(ex, ey, char.fakeRL, char.moveUD, char);
            }
        }
    }
    
    public static function baddieCheckObjects(ex : Float, ey : Float, eWide : Int, eTall : Int, rail : Int, char : Baddies) : Dynamic
    {
        for (n in 0...InteractArray.length)
        {
            if (rail == 0 && Math.abs(ex - Reflect.field(InteractArray, Std.string(n)).x) < eWide + Reflect.field(InteractArray, Std.string(n)).isWide && Math.abs(ey - Reflect.field(InteractArray, Std.string(n)).y) < eTall + Reflect.field(InteractArray, Std.string(n)).isTall)
            {
                Reflect.field(InteractArray, Std.string(n)).hitBaddie(ex, ey, char.fakeRL, char.moveUD, char);
            }
        }
    }
    
    public static function shiftAllDecals(ey : Float) : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(staticOnDeckArray.length - 1);
        while (i >= 0)
        {
            Reflect.setField(staticOnDeckArray, Std.string(i), ey).ey;
            Reflect.setField(staticOnDeckArray, Std.string(i), ey).clip.y;
            i--;
        }
    }
    
    public static function clearAllInteracts() : Dynamic
    {
        onDeckN = onDeckN2 = -1;
        var n : Int = as3hx.Compat.parseInt(InteractArray.length);
        for (i in 0...n)
        {
            Reflect.field(InteractArray, Std.string(i)).removeFromParent();
            Reflect.field(InteractArray, Std.string(i)).dispose();
        }
        n = as3hx.Compat.parseInt(staticOnDeckArray.length);
        for (i in 0...n)
        {
            Reflect.field(staticOnDeckArray, Std.string(i)).clip.removeFromParent();
            Reflect.field(staticOnDeckArray, Std.string(i)).clip.dispose();
            Reflect.setField(staticOnDeckArray, Std.string(i), null).clip;
        }
        InteractArray = [];
        staticOnDeckArray = [];
    }
    
    public static function elevate() : Dynamic
    {
        var i : Dynamic = as3hx.Compat.parseInt(staticOnDeckArray.length - 1);
        while (i >= 0)
        {
            StarlingBackgrounds.addObject(Reflect.field(staticOnDeckArray, Std.string(i)).clip, 0);
            i--;
        }
    }
    
    public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Void
    {
    }
    
    public function hitBaddie(ex : Float, ey : Float, eRL : Float, eUD : Float, baddie : Baddies) : Void
    {
    }
    
    public function decalEnterFrame() : Void
    {
    }
    
    public function inRange() : Dynamic
    {
        return Math.abs(x - Main.cameraX) < Main.stageX + 50 && Math.abs(y - Main.cameraY) < Main.stageY / 2 + 50;
    }
}


