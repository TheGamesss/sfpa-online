
class InteractObjects extends Collision
{
    
    public static var killInteract : Array<InteractObjects> = new Array<InteractObjects>();
    
    public static var InteractArray : Array<InteractObjects> = new Array<InteractObjects>();
    
    public static var canAttackArray : Array<InteractObjects> = new Array<InteractObjects>();
    
    public var interactive : Bool = true;
    
    public function new(rail : Int = -20)
    {
        InteractArray.push(this);
        super(rail);
    }
    
    public static function InteractEnterFrames() : Void
    {
        for (i in 0...InteractArray.length)
        {
            if (InteractArray[i].downTime > 0)
            {
                --InteractArray[i].downTime;
            }
            InteractArray[i].InteractEnterFrame();
        }
    }
    
    public static function InteractsCheckMoving() : Void
    {
        for (i in 0...InteractArray.length)
        {
            InteractArray[i].CheckMovingStuff();
        }
    }
    
    public static function runCollisions() : Void
    {
        for (i in 0...InteractArray.length)
        {
            InteractArray[i].EveryCollision();
        }
    }
    
    @:allow()
    private static function clearIceCream() : Void
    {
        var temp : Bool = false;
        var n : Int = as3hx.Compat.parseInt(InteractArray.length);
        for (i in 0...n)
        {
            if (InteractArray[i].ItIs == "iceCreamPickup")
            {
                temp = true;
                InteractArray[i].updateStats(Char.CharArray[0]);
            }
        }
        if (temp)
        {
            Sounds.playSoundSimple("success");
        }
    }
    
    @:allow()
    private static function clearAllInteracts() : Dynamic
    {
        checkKillInteracts();
        var n : Int = as3hx.Compat.parseInt(InteractArray.length);
        for (i in 0...n)
        {
            InteractArray[i].cleanUp();
            if (InteractArray[i].parent != null)
            {
                InteractArray[i].parent.removeChild(InteractArray[i]);
            }
        }
        InteractArray = new Array<InteractObjects>();
        canAttackArray = new Array<InteractObjects>();
    }
    
    public static function charCheckObjects(ex : Float, ey : Float, eWide : Int, eTall : Int, rail : Int, char : Char) : Void
    {
        for (n in 0...InteractArray.length)
        {
            if (Reflect.field(InteractArray, Std.string(n)).onRail == rail && Reflect.field(InteractArray, Std.string(n)).downTime == 0 && Math.abs(ex - Reflect.field(InteractArray, Std.string(n)).x) < eWide + Reflect.field(InteractArray, Std.string(n)).isWide && Math.abs(ey - Reflect.field(InteractArray, Std.string(n)).y) < eTall + Reflect.field(InteractArray, Std.string(n)).isTall)
            {
                Reflect.field(InteractArray, Std.string(n)).hitChar(ex, ey, char.moveRL, char.moveUD, char);
            }
        }
    }
    
    public static function baddieCheckObjects(ex : Float, ey : Float, eWide : Int, eTall : Int, rail : Int, char : Baddies) : Dynamic
    {
        for (n in 0...InteractArray.length)
        {
            if (Reflect.field(InteractArray, Std.string(n)).onRail == rail && Math.abs(ex - Reflect.field(InteractArray, Std.string(n)).x) < eWide + Reflect.field(InteractArray, Std.string(n)).isWide && Math.abs(ey - Reflect.field(InteractArray, Std.string(n)).y) < eTall + Reflect.field(InteractArray, Std.string(n)).isTall)
            {
                Reflect.field(InteractArray, Std.string(n)).hitBaddie(ex, ey, char.moveRL, char.moveUD, char);
            }
        }
    }
    
    public static function checkAttackables(char : Dynamic, rail : Dynamic) : Bool
    {
        var i : Dynamic = as3hx.Compat.parseInt(canAttackArray.length - 1);
        while (i >= 0)
        {
            if (Reflect.field(canAttackArray, Std.string(i)).onRail == rail)
            {
                if (!char.CheckAttack(Reflect.field(canAttackArray, Std.string(i))))
                {
                }
            }
            i--;
        }
        return false;
    }
    
    public static function checkKillInteracts() : Dynamic
    {
        var i : Int = 0;
        if (killInteract.length > 0)
        {
            for (i in 0...killInteract.length)
            {
                InteractArray.splice(Lambda.indexOf(InteractArray, killInteract[i]), 1);
                killInteract[i].cleanUp();
                killInteract[i].parent.removeChild(killInteract[i]);
                if (Lambda.indexOf(canAttackArray, killInteract[i]) > -1)
                {
                    canAttackArray.splice(Lambda.indexOf(canAttackArray, killInteract[i]), 1);
                }
            }
            killInteract = new Array<InteractObjects>();
        }
    }
    
    public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
    }
    
    public function hitBaddie(ex : Float, ey : Float, eRL : Float, eUD : Float, baddie : Baddies) : Bool
    {
    }
    
    public function InteractEnterFrame() : Void
    {
    }
    
    public function EveryCollision() : Void
    {
        if (BallRes == 0)
        {
            x += moveRL * Main.framin;
            y += moveUD * Main.framin;
        }
        else if (Status == "Walk")
        {
            CheckAllGrounds();
            rotter = (wallRot - rotation) / 3 * Main.framin;
        }
        else if (CheckAllAir())
        {
            rotter = (fakeRL - platRL - wallRL) * rotPerc;
            wallRL = wallUD = platRL = platUD = 0;
        }
        else
        {
            wallRot = 0;
            rotter += (moveRL * 3 - rotter) / 20 * Main.framin;
        }
        rotation += rotter * Main.framin;
    }
    
    public function cleanUp() : Void
    {
    }
}


