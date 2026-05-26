import flash.display.Sprite;
import starling.display.MovieClip;

class LevelDecals extends Sprite
{
    
    public static var InteractArray : Array<Dynamic> = [];
    
    public static var staticOnDeckArray : Array<Dynamic> = [];
    
    public static var onDeckN : Int = -1;
    
    public static var onDeckN2 : Int = -1;
    
    public var hitChar : Dynamic;
    
    public var cleanUp : Dynamic;
    
    public var hitBaddie : Dynamic;
    
    public var decalEnterFrame : Dynamic;
    
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
    
    private var obj : Sprite;
    
    public var ItIs : String;
    
    public var myStarlingClip : MovieClip;
    
    public var hasStarling : Bool;
    
    public function new(itis : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, xsc : Dynamic, ysc : Dynamic, rail : Dynamic, estring : Dynamic, enum : Dynamic)
    {
        this.cleanUp = function() : Dynamic
                {
                };
        super();
        this.ItIs = itis;
        x = ex;
        y = ey;
        rotation = rot;
        scaleX = xsc;
        scaleY = ysc;
        onRail = rail;
        this.myStarlingClip = StarlingBackgrounds.addEffect(itis, x, y, rotation, 1, 0, 0, true, false);
        staticOnDeckArray.push({
                    ex : x,
                    ey : y,
                    rot : rotation,
                    ItIs : this.ItIs,
                    clip : this
                });
        this.myStarlingClip.stop();
        this.myStarlingClip.visible = false;
        this.hitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, baddie : Dynamic) : Dynamic
                {
                    return null;
                };
        this.hitBaddie = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, baddie : Dynamic) : Dynamic
                {
                    return null;
                };
        if (!Main.isScaleForm)
        {
            visible = false;
            this.hasStarling = true;
        }
        this.decalEnterFrame = function() : Dynamic
                {
                };
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
                    staticOnDeckArray[onDeckN].clip.myStarlingClip.visible = true;
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
                    interact.myStarlingClip.visible = false;
                }
            }
            if (onDeckN2 < staticOnDeckArray.length - 1)
            {
                while (staticOnDeckArray[onDeckN2 + 1].ex < Main.cameraX - (Main.stageX + 50))
                {
                    interact = InteractArray.shift();
                    ++onDeckN2;
                    interact.myStarlingClip.visible = false;
                    if (onDeckN2 == staticOnDeckArray.length - 1)
                    {
                        break;
                    }
                }
            }
            if (onDeckN2 > -1)
            {
                while (staticOnDeckArray[onDeckN2].ex > Main.cameraX - (Main.stageX + 50))
                {
                    InteractArray.push(staticOnDeckArray[onDeckN2].clip);
                    InteractArray.unshift(InteractArray.pop());
                    staticOnDeckArray[onDeckN2].clip.myStarlingClip.visible = true;
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
    
    public static function charCheckObjects(ex : Dynamic, ey : Dynamic, eWide : Dynamic, eTall : Dynamic, char : Dynamic) : Dynamic
    {
        for (n in 0...InteractArray.length)
        {
            if (Math.abs(ex - Reflect.field(InteractArray, Std.string(n)).x) < eWide + Reflect.field(InteractArray, Std.string(n)).isWide && Math.abs(ey - Reflect.field(InteractArray, Std.string(n)).y) < eTall + Reflect.field(InteractArray, Std.string(n)).isTall)
            {
                Reflect.field(InteractArray, Std.string(n)).hitChar(ex, ey, char.fakeRL, char.moveUD, char);
            }
        }
    }
    
    public static function baddieCheckObjects(ex : Dynamic, ey : Dynamic, eWide : Dynamic, eTall : Dynamic, char : Dynamic) : Dynamic
    {
        for (n in 0...InteractArray.length)
        {
            if (Math.abs(ex - Reflect.field(InteractArray, Std.string(n)).x) < eWide + Reflect.field(InteractArray, Std.string(n)).isWide && Math.abs(ey - Reflect.field(InteractArray, Std.string(n)).y) < eTall + Reflect.field(InteractArray, Std.string(n)).isTall)
            {
                Reflect.field(InteractArray, Std.string(n)).hitBaddie(ex, ey, char.fakeRL, char.moveUD, char);
            }
        }
    }
    
    public static function clearAllInteracts() : Dynamic
    {
        staticOnDeckArray = [];
        onDeckN = onDeckN2 = -1;
        var n : Int = as3hx.Compat.parseInt(InteractArray.length);
        for (i in 0...n)
        {
            InteractArray[0].cleanUp();
            if (InteractArray[0].parent != null)
            {
                InteractArray[0].parent.removeChild(InteractArray[0]);
            }
            InteractArray.shift();
        }
    }
    
    public function inRange() : Dynamic
    {
        return Math.abs(x - Main.cameraX) < Main.stageX + 50 && Math.abs(y - Main.cameraY) < Main.stageY / 2 + 50;
    }
}


