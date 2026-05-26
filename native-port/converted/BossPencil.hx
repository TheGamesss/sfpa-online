import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol5681"))

class BossPencil extends Baddies
{
    
    public static var Level : Int;
    
    public var baddie : MovieClip;
    
    private var lifetime : Int = 300;
    
    private var b : Int;
    
    private var step : Int;
    
    public function new(p : Dynamic)
    {
        super(height * 0.5, height * 0.5, 0);
        ItIs = "Pencil";
        x = p.x;
        y = p.y;
        Level = 1;
        Backgrounds.backgroundsArray[0].addChild(this);
        rotter = 0;
        BallRes = 0;
        bounce = 0.9;
        bounceThresh = 2;
        maxRL = 4;
        springy = 3;
        stunMax = 120;
        health = 0;
        springTall = isTall * 2;
        overReach = 10;
        mass = 1000;
        attackN = 3;
        currentHitChar = this.pencilHitChar;
        this.step = 0;
        this.b = 60;
        canBall = false;
        BaddieEnterFrame = this.PoundEnterFrame;
        Status = "Roll";
        this.baddie.gotoAndStop(Level);
        springTall = isTall * 2;
        activeBaddieArray.push(this);
        currentGetAttacked = this.PencilGetAttacked;
    }
    
    private function pencilHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : Dynamic
    {
        distRL = ex - x;
        distUD = ey - y;
        if (stunN > 0)
        {
            if (Math.abs(distRL) < char.isWide + 20 && Math.abs(eRL) > 10)
            {
                Sounds.playSound("BadStomp", x, 3, 0);
                char.fakeRL *= 0.75;
                char.moveRL *= 0.75;
                char.Jumper = 12;
                char.FloatUp = 2;
                char.gotoBuffer = "Kick";
                this.damagePencil(char);
                StarlingEffect.Spawn("popEffect", (ex + footX()) * 0.5, (ey + footY()) * 0.5, Math.random() * 3, 2, 0, 0, onRail);
            }
        }
        else if (Status == "deadJump")
        {
            if (Math.abs(distRL) < char.isWide && Math.abs(distUD) < 60)
            {
                char.gotoBuffer = "PencilGet";
                killBaddies.push(this);
            }
        }
        else if (Math.abs(rotter) > 18)
        {
            wallAngle = rotation * (Math.PI / 180);
            ax = Math.cos(wallAngle) * distRL + Math.sin(wallAngle) * distUD;
            ay = Math.cos(wallAngle) * distUD - Math.sin(wallAngle) * distRL;
            if (Math.abs(ax) < 20 + char.isWide && Math.abs(ay) < isTall + char.isTall)
            {
                if (char.downTime == 0 && char.alpha == 1)
                {
                    char.wallRot = char.wallAngle = 0;
                    char.FloatUp = 6;
                    char.hurtChar(30, 20, 10, -rotter * 2, 20, true);
                    hitPause = 10;
                    Main.shakeScreen(60, 0, true);
                    rotter = 0;
                }
            }
        }
        else
        {
            wallAngle = rotation * (Math.PI / 180);
            ax = Math.cos(wallAngle) * distRL + Math.sin(wallAngle) * distUD;
            ay = Math.cos(wallAngle) * distUD - Math.sin(wallAngle) * distRL;
            if (Math.abs(ax) < char.isWide + 20 && Math.abs(ay) < char.isTall + isTall)
            {
                if (char.downTime == 0 && char.alpha == 1)
                {
                    char.FloatUp = 0;
                    char.Jumper = 20;
                    if (Math.abs(rotation) > 90)
                    {
                        char.fakeRL = -makeOne(ax) * 8;
                    }
                    else
                    {
                        char.fakeRL = makeOne(ax) * 8;
                    }
                    char.scaleX = -makeOne(char.fakeRL);
                    char.rotter = char.fakeRL * 1.5;
                    char.hurtChar(40);
                    hitPause = char.hitPause = 10;
                    char.shakeRL = 20;
                    char.downTime = 5;
                    Main.shakeScreen(10, 0, true);
                }
                ax = makeOne(ax) * (20 + char.isTall);
                char.x = x + (Math.cos(wallAngle) * ax - Math.sin(wallAngle) * ay);
                char.y = y + (Math.cos(wallAngle) * ay + Math.sin(wallAngle) * ax);
                if (char.wallsHitTest(char.x, char.y))
                {
                    char.fakeRL *= -1;
                    char.rotter *= -1;
                    char.scaleX *= -1;
                    ax *= -1;
                    char.x = x + (Math.cos(wallAngle) * ax - Math.sin(wallAngle) * ay);
                    char.y = y + (Math.cos(wallAngle) * ay + Math.sin(wallAngle) * ax);
                }
            }
        }
    }
    
    private function hitBaddie(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, baddie : Dynamic) : Dynamic
    {
        distRL = ex - x;
        distUD = ey - y;
        if (Math.sqrt(distRL * distRL + distUD * distUD) < isTall + baddie.isTall)
        {
            Sounds.playSound("BadStomp", x, 2, 0);
            baddie.hitPause = hitPause = 20;
            baddie.downTime = 20;
            baddie.shakeRL = shakeRL = 30;
            Main.shakeScreen(80, 0, true);
            baddie.stunN = baddie.stunMax;
            baddie.moveRL = moveRL * 2;
            baddie.moveUD = -20;
            baddie.rotter = -10;
            baddie.health = 0;
            moveRL = -moveRL * 0.2;
            rotter = 0;
            moveUD = -40;
            BaddieEnterFrame = this.WeakEnterFrame;
            this.step = 0;
            Status = "Roll";
            StarlingEffect.Spawn("popEffect", ex, ey, Math.random() * 3, 2, 0, 0, onRail);
            rotation = -Math.atan2(ex - x, ey - y) / (Math.PI / 180) - rotter * 0.1;
            baddie.ChangeFrame("Hit");
        }
    }
    
    private function checkHitBaddies() : Dynamic
    {
        var AggressorArrayLength : Int = as3hx.Compat.parseInt(AggressorArray.length);
        for (n in 0...AggressorArrayLength)
        {
            if (Reflect.field(AggressorArray, Std.string(n)).downTime == 0)
            {
                if (Math.abs(x - Reflect.field(AggressorArray, Std.string(n)).x) < isTall + Reflect.field(AggressorArray, Std.string(n)).isWide && Math.abs(y - Reflect.field(AggressorArray, Std.string(n)).y) < isWide + Reflect.field(AggressorArray, Std.string(n)).isTall)
                {
                    this.hitBaddie(Reflect.field(AggressorArray, Std.string(n)).x, Reflect.field(AggressorArray, Std.string(n)).y, Reflect.field(AggressorArray, Std.string(n)).moveRL, Reflect.field(AggressorArray, Std.string(n)).moveUD, Reflect.field(AggressorArray, Std.string(n)));
                }
            }
        }
    }
    
    private function PencilGetAttacked(ex : Float, ey : Float, angle : Float, char : Collision, hitMove : String, hitPower : Float, pow : Float = 1) : Bool
    {
        if (stunN > 0 && Math.abs(ex + char.pencilTipX - x) < 30)
        {
            char.moveRL *= -2;
            char.moveUD = -20;
            this.damagePencil(char);
            Sounds.playSound("Hit", x, 1, onRail);
            return true;
        }
        return false;
    }
    
    private function damagePencil(char : Char) : Void
    {
        downTime = 60;
        Main.shakeScreen(80, 0, true);
        shakeRL = 40 * char.scaleX;
        hitPause = char.hitPause = 20;
        ++Level;
        stunN = 0;
        this.step = 0;
        attackN = 3;
        this.b = 30;
        if (Level > 3)
        {
            isWide = 0;
            moveRL = 0;
            moveUD = -40;
            rotter = -char.scaleX * 0.01;
            BaddieEnterFrame = this.DeadEnterFrame;
            Status = "deadJump";
            Sounds.stopMusic();
            Sounds.musicPlaying = "nothing";
            killAllSpiders();
        }
        else
        {
            isWide = height * 0.5;
            moveRL = char.scaleX * 20;
            moveUD = -20;
            rotter = -moveRL * 0.75;
            BaddieEnterFrame = this.GoSharpen;
            this.baddie.tip.visible = false;
            new TipFly(wallX, wallY, moveRL * 0.5, -20, moveRL * 5, char);
            Status == "Hit";
        }
    }
    
    private function PoundEnterFrame() : Dynamic
    {
        var char : Char = Char.findClosest(x, y, onRail);
        var _sw2_ = (this.step);        

        switch (_sw2_)
        {
            case 0:
                moveRL = (char.x - x) * 0.2;
                moveUD = (char.groundY - 560 - y) * 0.2;
                if (Math.abs(moveRL) < 5)
                {
                    this.b = 10 + 5 * (3 - Level);
                    ++this.step;
                }
                else if (Math.abs(moveRL) > 30)
                {
                    moveRL = 30 * makeOne(moveRL);
                }
            case 1:
                moveRL += ((char.x + char.moveRL * 10 - x) * 0.2 - moveRL) * 0.1;
                moveUD = (char.groundY - 560 - y) * 0.2;
                if (this.b > 0)
                {
                    --this.b;
                }
                else
                {
                    ++this.step;
                }
            case 2:
                moveRL += ((char.x + char.moveRL * 10 - x) * 0.2 - moveRL) * 0.1;
                moveUD = (char.groundY - 700 - y) * 0.2;
                if (this.b < 15)
                {
                    ++this.b;
                    this.baddie.x = Math.random() * this.b * 5 - this.b * 2.5;
                    this.baddie.y = Math.random() * this.b * 5 - this.b * 2.5;
                }
                else
                {
                    ++this.step;
                }
            case 3:
                moveRL += ((char.x + char.moveRL * 2 - x) * 0.1 - moveRL) * 0.05;
                moveUD += 5;
                if (this.b > 0)
                {
                    this.b -= 0.5;
                    this.baddie.x = Math.random() * this.b * 5 - this.b * 2.5;
                    this.baddie.y = Math.random() * this.b * 5 - this.b * 2.5;
                }
                if (groundHitTest(x, y + isTall))
                {
                    while (groundHitTest(x, y + isTall))
                    {
                        --y;
                    }
                    wallX = footX();
                    wallY = footY();
                    Sounds.playSound("Crash", x, 1, 0);
                    landPuffs(5, 0, 2.5);
                    Main.shakeScreen(60, 0, true);
                    moveRL = moveUD = 0;
                    this.b = 10;
                    ++this.step;
                }
            case 4:
                if (this.b > 0)
                {
                    --this.b;
                }
                else
                {
                    --attackN;
                    this.step = 1;
                    if (attackN == 0)
                    {
                        attackN = Level;
                        rotter = 0;
                        BaddieEnterFrame = this.DrawEnterFrame;
                    }
                    else
                    {
                        this.b = (5 + Math.random() * 10) * (3 - Level);
                    }
                }
        }
        rotter = (-Math.atan2(moveRL, 60) / (Math.PI / 180) - rotation) * 0.05;
        if (this.step != 0 && this.step != 4)
        {
            if (moveRL * x > 0)
            {
                if (wallsHitTest(x + cast((isTall), UDx), y + cast((isTall), UDy)))
                {
                    moveRL = 0.2 * Math.abs(moveRL) * -makeOne(x);
                }
            }
            wallRot = rotation;
        }
    }
    
    private function DrawEnterFrame() : Dynamic
    {
        var spider : Dynamic = null;
        rotter = -rotation * 0.05;
        var _sw3_ = (this.step);        

        switch (_sw3_)
        {
            case 1:
                moveRL = (450 - x) * 0.1;
                moveUD = (-500 - y) * 0.1;
                if (Math.abs(moveRL) < 5 && Math.abs(moveUD) < 2)
                {
                    wallX = x;
                    wallY = as3hx.Compat.parseInt(y + 20);
                    wallRot = wallAngle = 0;
                    moveRL = moveUD = 0;
                    ++this.step;
                }
            case 2:
                Sounds.playSound("scribble", x, 1, 0);
                wallRot = rotation;
                spider = {
                            ItIs : "Spider",
                            x : wallX + cast((isTall), UDx),
                            y : wallY + cast((isTall), UDy),
                            rotation : 0,
                            scaleX : makeOne(Char.CharArray[0].x - x),
                            onRail : 0,
                            hatN : 0,
                            moveRL : makeOne(Char.CharArray[0].x - x) * 5,
                            moveUD : -15,
                            startStatus : "fadeIn"
                        };
                new Spider(spider);
                ++this.step;
            case 3:
                wallAngle += 0.7;
                x = wallX + cast((-25 + Math.random() * 10), UDx);
                y = wallY + cast((-25 + Math.random() * 10), UDy);
                if (wallAngle >= 18.84)
                {
                    wallAngle = 0;
                    this.b = 30;
                    ++this.step;
                }
            case 4:
                if (this.b > 0)
                {
                    --this.b;
                }
                else
                {
                    --attackN;
                    if (attackN == 0)
                    {
                        attackN = 3;
                        if (Char.CharArray[0].x < x)
                        {
                            this.step = 0;
                        }
                        else
                        {
                            this.step = 3;
                        }
                        BaddieEnterFrame = this.SpinEnterFrame;
                    }
                    else
                    {
                        this.step = 2;
                    }
                }
        }
    }
    
    private function SpinEnterFrame() : Dynamic
    {
        var _sw4_ = (this.step);        

        switch (_sw4_)
        {
            case 0:
                moveRL = (2000 - x) * 0.1;
                if (Math.abs(moveRL) > 30)
                {
                    moveRL = makeOne(moveRL) * 30;
                }
                if (x > 1990)
                {
                    rotter = 5 + Level * 5;
                    moveRL = -10 * Level;
                    ++this.step;
                }
                rotter = (-Math.atan2(-moveRL, 120) / (Math.PI / 180) - rotation) * 0.05;
            case 1:
                while (groundHitTest(x, y + isTall + 30))
                {
                    --y;
                }
                while (!groundHitTest(x, y + isTall + 32))
                {
                    ++y;
                }
                if (x < -1000)
                {
                    BaddieEnterFrame = this.PoundEnterFrame;
                    rotter = wallAngle = rotation = 0;
                    Status = "Roll";
                    this.step = 0;
                }
                rotter = 10 - moveRL;
            case 3:
                moveRL = (-1000 - x) * 0.1;
                if (Math.abs(moveRL) > 30)
                {
                    moveRL = makeOne(moveRL) * 30;
                }
                if (x < -990)
                {
                    rotter = -(5 + Level * 5);
                    moveRL = 10 * Level;
                    ++this.step;
                }
            case 4:
                while (groundHitTest(x, y + isTall + 40))
                {
                    --y;
                }
                while (!groundHitTest(x, y + isTall + 42))
                {
                    ++y;
                }
                if (x > 1990)
                {
                    BaddieEnterFrame = this.PoundEnterFrame;
                    rotter = wallAngle = rotation = 0;
                    Status = "Roll";
                    this.step = 0;
                }
                rotter = -10 - moveRL;
        }
    }
    
    private function WeakEnterFrame() : Dynamic
    {
        var _sw5_ = (this.step);        

        switch (_sw5_)
        {
            case 0:
                ++moveUD;
                rotter = -moveRL * 5;
                if (moveUD > 0)
                {
                    if (x < -600)
                    {
                        x = -600;
                    }
                    if (x > 1400)
                    {
                        x = 1400;
                    }
                }
                if (groundHitTest(x, y + isTall - 20))
                {
                    while (groundHitTest(x, y + isTall - 20))
                    {
                        --y;
                    }
                    rotation = wallAngle = 0;
                    wallX = footX();
                    wallY = footY();
                    Sounds.playSound("Crash", x, 1, 0);
                    landPuffs(5, 0, 2.5);
                    Main.shakeScreen(200, 0, true);
                    rotter = moveRL = moveUD = 0;
                    stunN = 120;
                    ++this.step;
                }
            case 1:
                if (stunN > 0)
                {
                    --stunN;
                }
                else
                {
                    this.b = 10;
                    this.step = 0;
                    attackN = 3;
                    BaddieEnterFrame = this.PoundEnterFrame;
                }
        }
    }
    
    override public function checkAfterMove() : Bool
    {
        if (Math.abs(rotter) > 18)
        {
            this.checkHitBaddies();
        }
    }
    
    private function GoSharpen() : Dynamic
    {
        var _sw6_ = (this.step);        

        switch (_sw6_)
        {
            case 0:
                moveRL *= 0.9;
                moveUD *= 0.9;
                rotter *= 0.5;
                if (this.b > 0)
                {
                    --this.b;
                }
                else
                {
                    moveRL = makeOne(Char.CharArray[0].x - x) * 40;
                    ++this.step;
                }
                this.baddie.x = Math.random() * this.b * 2 - this.b;
                this.baddie.y = Math.random() * this.b * 2 - this.b;
            case 1:
                rotter = (-Math.atan2(moveRL, 60) / (Math.PI / 180) - rotation) * 0.05;
                if (x > 1990 || x < -990)
                {
                    Sounds.playSound("sharpener", x, 1, 0);
                    moveRL = moveUD = rotter = 0;
                    this.baddie.nextFrame();
                    isWide = isTall = this.baddie.height * 0.5;
                    springTall = isTall * 2;
                    ++this.step;
                    this.b = 120;
                    this.baddie.tip.visible = true;
                }
            case 2:
                if (this.b > 0)
                {
                    --this.b;
                }
                else
                {
                    BaddieEnterFrame = this.PoundEnterFrame;
                    this.b = 30;
                    this.step = 0;
                }
        }
    }
    
    private function DeadEnterFrame() : Dynamic
    {
        var _sw7_ = (this.step);        

        switch (_sw7_)
        {
            case 0:
                rotter = makeOne(rotter) * 40;
                ++moveUD;
                if (moveUD > 0)
                {
                    this.baddie.nextFrame();
                    isTall = this.baddie.height * 0.5;
                    isWide = 20;
                    springTall = isTall * 2;
                    ++this.step;
                }
            case 1:
                ++moveUD;
                if (groundHitTest(x, y + isTall - 5))
                {
                    while (groundHitTest(x, y + isTall - 5))
                    {
                        --y;
                    }
                    wallX = footX();
                    wallY = footY();
                    Sounds.playSound("Kick", x, 1, 0);
                    landPuffs(2, 0, 1);
                    Main.shakeScreen(-moveUD * 0.2, 0, true);
                    moveUD *= -0.5;
                    rotter *= -0.8;
                    if (moveUD > -10)
                    {
                        isWide = 5;
                        rotation = moveUD = rotter = 0;
                        ++this.step;
                    }
                }
        }
    }
}


