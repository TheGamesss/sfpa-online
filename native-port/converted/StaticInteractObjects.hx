import flash.display.*;

class StaticInteractObjects extends MovieClip
{
    
    public static var backgroundsN : Int;
    
    public static var myPayWall : Dynamic;
    
    public static var framin : Float;
    
    public static var killInteract : Array<MovieClip> = new Array<MovieClip>();
    
    public static var InteractArray : Array<MovieClip> = new Array<MovieClip>();
    
    public static var InteractEnterFrameArray : Array<MovieClip> = new Array<MovieClip>();
    
    public static var HalfInteractEnterFrameArray : Array<MovieClip> = new Array<MovieClip>();
    
    public static var cameraCollideArray : Array<MovieClip> = new Array<MovieClip>();
    
    public static var canAttackArray : Array<StaticInteractObjects> = new Array<StaticInteractObjects>();
    
    public static var inkCollideArray : Array<StaticInteractObjects> = new Array<StaticInteractObjects>();
    
    private static var cacheX : Array<Int> = new Array<Int>();
    
    private static var cacheY : Array<Int> = new Array<Int>();
    
    private static var cacheWide : Array<Int> = new Array<Int>();
    
    private static var cacheTall : Array<Int> = new Array<Int>();
    
    private static var cacheRail : Array<Int> = new Array<Int>();
    
    public static var DoorArray : Array<Dynamic> = [];
    
    public static var textBubbleArray : Array<Dynamic> = [];
    
    public static var dontCheat : Dynamic = { };
    
    public static var uniqueCounter : Int = 0;
    
    public var interactive : Bool = true;
    
    public var predictOffsetY : Int = 0;
    
    public var onRail : Int = 0;
    
    public var isWide : Int = 0;
    
    public var isTall : Int = 0;
    
    public var ItIs : String;
    
    public var warpLevel : String;
    
    public var warpDoor : Int;
    
    public var ID : Int = 0;
    
    public var removeID : Int = -1;
    
    public var pairGate : Int = -1;
    
    public var baddieGate : AWall;
    
    public var pairID : Int = -1;
    
    public var uniqueID : Int = -1;
    
    public var anchorX : Int;
    
    public var anchorY : Int;
    
    public var angle : Float;
    
    public var backEffect : Bool = false;
    
    public function new(itis : Dynamic, ex : Dynamic, ey : Dynamic, xsc : Dynamic, ysc : Dynamic, rail : Dynamic, estring : String = "nothing", enum : Float = -1)
    {
        super();
        this.ItIs = itis;
        this.anchorX = x = ex;
        this.anchorY = y = ey;
        scaleX = xsc;
        scaleY = ysc;
        this.onRail = rail;
        if (this.isWide == 0)
        {
            this.isWide = xsc * 50;
        }
        if (this.isTall == 0)
        {
            this.isTall = ysc * 50;
        }
        InteractArray.push(this);
        this.buildCache();
    }
    
    public static function InteractEnterFrames() : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(InteractEnterFrameArray.length - 1);
        while (i >= 0)
        {
            Reflect.field(InteractEnterFrameArray, Std.string(i)).InteractEnterFrame() && spliceEnterByInt(i);
            i--;
        }
    }
    
    public static function HalfInteractEnterFrames() : Void
    {
        for (i in 0...HalfInteractEnterFrameArray.length)
        {
            HalfInteractEnterFrameArray[i].HalfInteractEnterFrame();
        }
    }
    
    @:allow()
    private static function clearAllInteractsOnRail(rail : Dynamic) : Dynamic
    {
        var i : Dynamic = as3hx.Compat.parseInt(InteractArray.length - 1);
        while (i >= 0)
        {
            if (Reflect.field(cacheRail, Std.string(i)) == rail)
            {
                Reflect.field(InteractArray, Std.string(i)).parent.removeChild(Reflect.field(InteractArray, Std.string(i)));
                Reflect.field(InteractArray, Std.string(i)).cleanUp();
                spliceAll(i);
            }
            i--;
        }
        i = as3hx.Compat.parseInt(cameraCollideArray.length - 1);
        while (i >= 0)
        {
            if (cameraCollideArray[i].onRail == rail)
            {
                cameraCollideArray.splice(i, 1);
            }
            i--;
        }
        i = as3hx.Compat.parseInt(InteractEnterFrameArray.length - 1);
        while (i >= 0)
        {
            if (InteractEnterFrameArray[i].onRail == rail)
            {
                if (InteractEnterFrameArray[i].parent != null)
                {
                    InteractEnterFrameArray[i].parent.removeChild(InteractEnterFrameArray[i]);
                }
                InteractEnterFrameArray.splice(i, 1);
            }
            i--;
        }
    }
    
    @:allow()
    private static function clearAllInteracts(clearAll : Bool) : Dynamic
    {
        checkKillInteracts();
        if (myPayWall != null)
        {
            if (myPayWall.parent != null)
            {
                myPayWall.parent.removeChild(myPayWall);
            }
            myPayWall = null;
        }
        var i : Dynamic = as3hx.Compat.parseInt(InteractArray.length - 1);
        while (i >= 0)
        {
            if (clearAll || Reflect.field(InteractArray, Std.string(i)).ItIs != "inkBoard")
            {
                if (Reflect.field(InteractArray, Std.string(i)).parent != null)
                {
                    Reflect.field(InteractArray, Std.string(i)).parent.removeChild(Reflect.field(InteractArray, Std.string(i)));
                }
                if (Lambda.indexOf(InteractEnterFrameArray, Reflect.field(InteractArray, Std.string(i))) > -1)
                {
                    InteractEnterFrameArray.splice(Lambda.indexOf(InteractEnterFrameArray, Reflect.field(InteractArray, Std.string(i))), 1);
                }
                Reflect.field(InteractArray, Std.string(i)).cleanUp();
                if (Lambda.indexOf(InteractArray, Reflect.field(InteractArray, Std.string(i))) > -1)
                {
                    InteractArray.splice(Lambda.indexOf(InteractArray, Reflect.field(InteractArray, Std.string(i))), 1);
                }
            }
            i--;
        }
        canAttackArray = new Array<StaticInteractObjects>();
        inkCollideArray = new Array<StaticInteractObjects>();
        cacheX = new Array<Int>();
        cacheY = new Array<Int>();
        cacheWide = new Array<Int>();
        cacheTall = new Array<Int>();
        cacheRail = new Array<Int>();
        textBubbleArray = [];
        uniqueCounter = 0;
        n = InteractEnterFrameArray.length;
        for (i in 0...n)
        {
            if (InteractEnterFrameArray[0].parent != null)
            {
                InteractEnterFrameArray[0].parent.removeChild(InteractEnterFrameArray[0]);
            }
            InteractEnterFrameArray.shift();
        }
        HalfInteractEnterFrameArray = new Array<MovieClip>();
        cameraCollideArray = new Array<MovieClip>();
        DoorArray = [];
        Checkpoint.resetCheckpoints();
        if (!clearAll)
        {
            for (i in 0...InteractArray.length)
            {
                InteractArray[i].buildCache();
            }
        }
    }
    
    public static function clearByName(e : String) : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(InteractArray.length - 1);
        while (i >= 0)
        {
            if (Reflect.field(InteractArray, Std.string(i)).ItIs == e)
            {
                if (Reflect.field(InteractArray, Std.string(i)).parent != null)
                {
                    Reflect.field(InteractArray, Std.string(i)).parent.removeChild(Reflect.field(InteractArray, Std.string(i)));
                }
                spliceAll(i);
            }
            i--;
        }
        i = as3hx.Compat.parseInt(cameraCollideArray.length - 1);
        while (i >= 0)
        {
            if (cameraCollideArray[i].ItIs == e)
            {
                cameraCollideArray.splice(i, 1);
                i--;
            }
            i--;
        }
        i = as3hx.Compat.parseInt(InteractEnterFrameArray.length - 1);
        while (i >= 0)
        {
            if (InteractEnterFrameArray[i].ItIs == e)
            {
                if (InteractEnterFrameArray[i].parent != null)
                {
                    InteractEnterFrameArray[i].parent.removeChild(InteractEnterFrameArray[i]);
                }
                InteractEnterFrameArray.splice(i, 1);
            }
            i--;
        }
    }
    
    public static function clearByID(e : Int) : Void
    {
        var i : Int = 0;
        var l : Int = InteractArray.length;
        while (i < l)
        {
            if (InteractArray[i].removeID == e)
            {
                killInteract.push(InteractArray[i]);
            }
            i++;
        }
    }
    
    public static function findByName(e : Dynamic) : StaticInteractObjects
    {
        var i : Int = 0;
        var l : Int = InteractArray.length;
        while (i < l)
        {
            if (InteractArray[i].ItIs == e)
            {
                return InteractArray[i];
            }
            i++;
        }
    }
    
    public static function findByPairID(e : Dynamic) : StaticInteractObjects
    {
        var i : Int = 0;
        var l : Int = InteractArray.length;
        while (i < l)
        {
            if (InteractArray[i].pairID == e)
            {
                return InteractArray[i];
            }
            i++;
        }
    }
    
    public static function findByUnique(e : Dynamic) : StaticInteractObjects
    {
        var i : Int = 0;
        var l : Int = InteractArray.length;
        while (i < l)
        {
            if (InteractArray[i].uniqueID == e)
            {
                return InteractArray[i];
            }
            i++;
        }
    }
    
    public static function moveAllAttackablesY(ey : Dynamic, e : Dynamic) : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(canAttackArray.length - 1);
        while (i >= 0)
        {
            Reflect.setField(canAttackArray, Std.string(i), ey).y;
            Reflect.setField(canAttackArray, Std.string(i), e).myObject;
            i--;
        }
    }
    
    public static function charCheckObjects(ex : Float, ey : Float, eWide : Int, eTall : Int, rail : Int, char : Collision) : Bool
    {
        var n : Int = 0;
        var l : Int = InteractArray.length;
        while (n < l)
        {
            if (cacheRail[n] == rail && Math.abs(ex - cacheX[n]) < eWide + cacheWide[n] + 10 && Math.abs(ey - cacheY[n]) < eTall + cacheTall[n] + 10)
            {
                InteractArray[n].hitChar(ex, ey, char.moveRL, char.moveUD, char);
            }
            n++;
        }
    }
    
    public static function charCheckForCamera(ex : Float, ey : Float, eWide : Int, eTall : Int, rail : Int, char : Collision) : Bool
    {
        var n : Int = 0;
        var l : Int = InteractArray.length;
        while (n < l)
        {
            if (cacheRail[n] == rail && InteractArray[n].ItIs != "WarpBox")
            {
                if (Math.abs(ex - cacheX[n]) < eWide + cacheWide[n] + 10 && Math.abs(ey - cacheY[n]) < eTall + cacheTall[n] + 10)
                {
                    InteractArray[n].hitChar(ex, ey, char.moveRL, char.moveUD, char);
                }
            }
            n++;
        }
    }
    
    public static function checkAttackables(char : Dynamic, rail : Dynamic) : Bool
    {
        var i : Dynamic = as3hx.Compat.parseInt(canAttackArray.length - 1);
        while (i >= 0)
        {
            if (Reflect.field(canAttackArray, Std.string(i)).onRail == rail)
            {
                char.CheckAttack(Reflect.field(canAttackArray, Std.string(i)));
            }
            i--;
        }
        return false;
    }
    
    @:allow()
    private static function findClosestCast(ex : Dynamic, ey : Dynamic, angle : Dynamic, rail : Dynamic) : Float
    {
        var distX : Int = 0;
        var distY : Int = 0;
        var angleDist : Float = Math.NaN;
        var returnAngle : Float = angle;
        var dist : Int = 600;
        var i : Int = 0;
        var l : Int = inkCollideArray.length;
        while (i < l)
        {
            if (rail == inkCollideArray[i].onRail)
            {
                distX = as3hx.Compat.parseInt(inkCollideArray[i].x - ex);
                distY = as3hx.Compat.parseInt(inkCollideArray[i].y - ey);
                if (Math.abs(distX) < dist)
                {
                    angleDist = Math.abs(-Math.atan2(distX, distY) - angle);
                    if (angleDist < 0.2)
                    {
                        dist = Math.abs(distX);
                        returnAngle = -Math.atan2(distX, distY);
                    }
                }
            }
            i++;
        }
        return returnAngle;
    }
    
    public static function checkInk(ex : Dynamic, ey : Dynamic, eRL : Dynamic, wide : Dynamic, tall : Dynamic, rail : Dynamic, ink : Dynamic) : Bool
    {
        var i : Dynamic = as3hx.Compat.parseInt(inkCollideArray.length - 1);
        while (i >= 0)
        {
            if (Reflect.field(inkCollideArray, Std.string(i)).quickCheckDist(ex, ey, wide + Math.abs(eRL * 0.5), tall, rail))
            {
                return Reflect.field(inkCollideArray, Std.string(i)).hitInk(ex, ey, eRL, ink);
            }
            i--;
        }
        return false;
    }
    
    public static function cameraCheckObjects(ex : Float, ey : Float, wide : Int, tall : Int, rail : Int, char : Collision) : Bool
    {
        var n : Int = 0;
        var l : Int = cameraCollideArray.length;
        while (n < l)
        {
            if (cameraCollideArray[n].quickCheckDist(ex, ey, wide, tall, rail))
            {
                char.predictOffsetY = cameraCollideArray[n].predictOffsetY;
                return true;
            }
            n++;
        }
        return false;
    }
    
    public static function baddieCheckObjects(ex : Float, ey : Float, wide : Int, tall : Int, rail : Int, char : Collision) : Dynamic
    {
        for (n in 0...InteractArray.length)
        {
            if (cacheRail[n] == rail)
            {
                if (Math.abs(ex - cacheX[n]) < wide + cacheWide[n] && Math.abs(ey - cacheY[n]) < tall + cacheTall[n])
                {
                    InteractArray[n].hitBaddie(ex, ey, char.moveRL, char.moveUD, char);
                }
            }
        }
    }
    
    public static function checkKillInteracts() : Dynamic
    {
        var i : Int = 0;
        var tempN : Int = 0;
        var n : Int = 0;
        if (killInteract.length > 0)
        {
            for (i in 0...killInteract.length)
            {
                tempN = Lambda.indexOf(InteractArray, killInteract[i]);
                if (tempN > -1)
                {
                    spliceAll(tempN);
                }
                if (Lambda.indexOf(InteractEnterFrameArray, killInteract[i]) > -1)
                {
                    InteractEnterFrameArray.splice(Lambda.indexOf(InteractEnterFrameArray, killInteract[i]), 1);
                }
                if (Lambda.indexOf(HalfInteractEnterFrameArray, killInteract[i]) > -1)
                {
                    HalfInteractEnterFrameArray.splice(Lambda.indexOf(HalfInteractEnterFrameArray, killInteract[i]), 1);
                }
                if (Lambda.indexOf(canAttackArray, killInteract[i]) > -1)
                {
                    canAttackArray.splice(Lambda.indexOf(canAttackArray, killInteract[i]), 1);
                }
                if (Lambda.indexOf(cameraCollideArray, killInteract[i]) > -1)
                {
                    cameraCollideArray.splice(Lambda.indexOf(cameraCollideArray, killInteract[i]), 1);
                }
                if (Lambda.indexOf(inkCollideArray, killInteract[i]) > -1)
                {
                    inkCollideArray.splice(Lambda.indexOf(inkCollideArray, killInteract[i]), 1);
                }
                if (killInteract[i].onRail >= Main.backgroundsN)
                {
                    for (n in 0...Main.AllBoxObjects.length)
                    {
                        if (killInteract[i].x == Main.AllBoxObjects[n][1] && killInteract[i].y == Main.AllBoxObjects[n][2])
                        {
                            Main.AllBoxObjects.splice(n, 1);
                            break;
                        }
                    }
                }
                if (killInteract[i].parent != null)
                {
                    killInteract[i].parent.removeChild(killInteract[i]);
                }
            }
            killInteract = new Array<MovieClip>();
        }
    }
    
    private static function spliceAll(i : Dynamic) : Void
    {
        InteractArray.splice(i, 1);
        cacheX.splice(i, 1);
        cacheY.splice(i, 1);
        cacheWide.splice(i, 1);
        cacheTall.splice(i, 1);
        cacheRail.splice(i, 1);
    }
    
    private static function spliceEnterByInt(i : Dynamic) : Void
    {
        InteractEnterFrameArray.splice(i, 1);
    }
    
    public static function pairMyGate(n : Dynamic, gate : Dynamic) : Void
    {
        for (i in 0...InteractArray.length)
        {
            if (Reflect.field(InteractArray, Std.string(i)).pairGate == n)
            {
                Reflect.setField(InteractArray, Std.string(i), gate).baddieGate;
            }
        }
    }
    
    public static function findLevelDoor(level : Dynamic) : Int
    {
        var i : Int = 0;
        var l : Int = as3hx.Compat.parseInt(DoorArray.length);
        while (i < l)
        {
            if (DoorArray[i].warpLevel == level)
            {
                return i;
            }
            i++;
        }
        return 0;
    }
    
    public static function swapTextBubbles(lang : Dynamic) : Void
    {
        textBubbles.spawnTextStamp();
        var i : Int = 0;
        var l : Int = textBubbleArray.length;
        while (i < l)
        {
            if (textBubbleArray[i] != null && cast(textBubbleArray[i].out, Bool))
            {
                textBubbleArray[i].setupLanguage();
            }
            i++;
        }
    }
    
    public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
    }
    
    public function hitBaddie(ex : Float, ey : Float, eRL : Float, eUD : Float, baddie : Baddies) : Bool
    {
    }
    
    public function InteractEnterFrame() : Bool
    {
    }
    
    public function HalfInteractEnterFrame() : Void
    {
    }
    
    public function cleanUp() : Void
    {
    }
    
    private function buildCache() : Void
    {
        cacheX.push(x);
        cacheY.push(y);
        cacheWide.push(this.isWide);
        cacheTall.push(this.isTall);
        cacheRail.push(this.onRail);
    }
    
    public function updateCache() : Void
    {
        var i : Int = Lambda.indexOf(InteractArray, this);
        if (i > -1)
        {
            cacheX[i] = x;
            cacheY[i] = y;
            cacheWide[i] = this.isWide;
            cacheTall[i] = this.isTall;
            cacheRail[i] = this.onRail;
        }
    }
    
    public function spliceEnterFrames() : Void
    {
        if (Lambda.indexOf(InteractEnterFrameArray, this) > -1)
        {
            InteractEnterFrameArray.splice(Lambda.indexOf(InteractEnterFrameArray, this), 1);
        }
        if (Lambda.indexOf(HalfInteractEnterFrameArray, this) > -1)
        {
            HalfInteractEnterFrameArray.splice(Lambda.indexOf(HalfInteractEnterFrameArray, this), 1);
        }
    }
    
    public function quickCheckDist(ex : Dynamic, ey : Dynamic, wide : Dynamic, tall : Dynamic, rail : Dynamic) : Bool
    {
        return rail == this.onRail && Math.abs(ex - x) < wide + this.isWide && Math.abs(ey - y) < tall + this.isTall;
    }
}


