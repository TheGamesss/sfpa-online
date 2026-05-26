import flash.display.*;

class Baddies extends Collision
{
    
    @:allow()
    private static var baddieContainer : MovieClip;
    
    public static var BaddieArray : Array<Baddies> = new Array<Baddies>();
    
    public static var activeBaddieArray : Array<Baddies> = new Array<Baddies>();
    
    public static var AggressorArray : Array<Baddies> = new Array<Baddies>();
    
    public static var JumpPadArray : Array<Baddies> = new Array<Baddies>();
    
    public static var CharX : Int = 0;
    
    public static var CharY : Int = 0;
    
    public static var CharRail : Int = 0;
    
    public static var killBaddies : Array<Baddies> = new Array<Baddies>();
    
    public var CharDistX : Int = 0;
    
    public var CharDistY : Int = 0;
    
    public var BaddieEnterFrame : Dynamic;
    
    public var isWearing : String = "nothing";
    
    public var smokeName : String = "nothing";
    
    public var thrust : Int = 16;
    
    public var float : Int;
    
    public var hopRail : Int = -1;
    
    public var forceStill : Bool;
    
    public var canBall : Bool = true;
    
    public var currentHitChar : Dynamic;
    
    public var currentGetAttacked : Dynamic = this.standardGetAttacked;
    
    public var solid : Bool;
    
    public var lastStomped : Dynamic;
    
    public function gonnaStomp(e : Dynamic) : Dynamic
    {
    }
    public var stompingOn : Array<Char> = new Array<Char>();
    
    public var tilRangeCheck : Int;
    
    public var hatN : Int = 0;
    
    public var knockback : Float = 1;
    
    public var grounded : Bool;
    
    public var autopilot : Bool;
    
    public var attentionRange : Int;
    
    public var tether : Int = 10000;
    
    public var insomnia : Bool;
    
    public var spawner : StaticInteractObjects;
    
    public var onKilled : String;
    
    public var ledgeTimer : Int;
    
    public var attackN : Int;
    
    public var temporary : Bool;
    
    public var retreatThresh : Int = 0;
    
    public var hasSmoke : Bool;
    
    public var currentSmoke : StarlingSmoke;
    
    public var baddieFrame : Int = 1;
    
    public var resetOnFall : Bool;
    
    public var backEffect : Bool = true;
    
    public var canGetShot : Bool = true;
    
    private var hasSpawner : Bool;
    
    private var hasOnKilled : Bool;
    
    public var explode : Bool;
    
    public var smokeFrameOffset : Int = -1;
    
    public var healthBarSmoke : StarlingSmoke;
    
    public var healthBarOutlineSmoke : StarlingSmoke;
    
    public function new(wide : Int = 0, tall : Int = 0, rail : Int = -20)
    {
        super(rail);
        isWide = wide;
        isTall = tall;
        mass = as3hx.Compat.parseInt(wide * tall / 20);
        originalSpringTall = springTall = tall * 2;
        BaddieArray.push(this);
        if (this.spawner != null)
        {
            this.hasOnKilled = this.hasSpawner = true;
        }
        if (this.onKilled != null && this.onKilled != "nothing")
        {
            this.hasOnKilled = true;
        }
    }
    
    public static function BaddieEnterFrames() : Void
    {
        CharX = Char.CharArray[0].x;
        CharY = Char.CharArray[0].y;
        CharRail = Char.CharArray[0].onRail;
        var i : Int = 0;
        var l : Int = BaddieArray.length;
        while (i < l)
        {
            BaddieArray[i].doEnterFrames();
            i++;
        }
    }
    
    public static function BaddiesCheckMoving() : Void
    {
        var i : Int = 0;
        var l : Int = BaddieArray.length;
        while (i < l)
        {
            if (BaddieArray[i].BallRes > 0)
            {
                BaddieArray[i].CheckMovingStuff();
            }
            i++;
        }
    }
    
    public static function checkGonnaStomps(ex : Dynamic, ey : Dynamic, eWide : Dynamic, rail : Dynamic, hit : Dynamic, e : Dynamic) : Bool
    {
        var i : Int = 0;
        var l : Int = activeBaddieArray.length;
        while (i < l)
        {
            if (activeBaddieArray[i].onRail == rail && !activeBaddieArray[i].inky && activeBaddieArray[i].Status != "deadJump" && !activeBaddieArray[i].isABall)
            {
                if (Math.abs(ex - activeBaddieArray[i].x) < activeBaddieArray[i].isWide + eWide + 30 && Math.abs(ey - activeBaddieArray[i].y) < activeBaddieArray[i].isTall)
                {
                    e.tempY = activeBaddieArray[i].y + activeBaddieArray[i].isTall;
                    if (hit < 10)
                    {
                        activeBaddieArray[i].gonnaStomp(e);
                    }
                    return true;
                }
            }
            i++;
        }
        return false;
    }
    
    public static function EveryCollisions() : Void
    {
        var i : Int = 0;
        var l : Int = activeBaddieArray.length;
        while (i < l)
        {
            activeBaddieArray[i].EveryCollision();
            i++;
        }
        if (killBaddies.length > 0)
        {
            for (i in 0...killBaddies.length)
            {
                removeBaddie(killBaddies[i]);
            }
            killBaddies = new Array<Baddies>();
        }
    }
    
    public static function BaddiesRootStuff() : Void
    {
        var i : Int = 0;
        var l : Int = activeBaddieArray.length;
        while (i < l)
        {
            activeBaddieArray[i].baddieRootStuff();
            i++;
        }
    }
    
    private static function removeBaddie(e : Dynamic) : Void
    {
        var n : Int = 0;
        e.cleanUp();
        e.clearHealthBar();
        if (Lambda.indexOf(BaddieArray, e) > -1)
        {
            BaddieArray.splice(Lambda.indexOf(BaddieArray, e), 1);
        }
        if (Lambda.indexOf(activeBaddieArray, e) > -1)
        {
            activeBaddieArray.splice(Lambda.indexOf(activeBaddieArray, e), 1);
        }
        if (Lambda.indexOf(AggressorArray, e) > -1)
        {
            AggressorArray.splice(Lambda.indexOf(AggressorArray, e), 1);
        }
        e.removeFromFollow();
        if (e.onRail >= Main.backgroundsN)
        {
            for (n in 0...Main.AllBoxObjects.length)
            {
                if (e.originX == Main.AllBoxObjects[n][1] && e.originY == Main.AllBoxObjects[n][2])
                {
                    Main.AllBoxObjects.splice(n, 1);
                    break;
                }
            }
        }
        if (e.parent != null)
        {
            e.parent.removeChild(e);
        }
        if (e.hasOnKilled)
        {
            if (e.hasSpawner)
            {
                e.spawner.onKilled();
                e.spawner = null;
            }
            else if (e.onKilled == "removeGate0")
            {
                Main.saveProgress("defeatBigBad1", true);
                staticInteractObjects.findByName("Mayor").mayorArrive();
            }
        }
    }
    
    @:allow()
    private static function spawnSnailShell(ex : Dynamic, ey : Dynamic, rot : Dynamic) : Void
    {
        var baddie : SnailShell = new SnailShell();
        baddie.x = ex;
        baddie.y = ey;
        baddie.rotation = rot;
        baddie.ItIs = "SnailShell";
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
        var l : Int = activeBaddieArray.length;
        while (i < l)
        {
            if (rail == activeBaddieArray[i].onRail && activeBaddieArray[i].health > 0)
            {
                distX = as3hx.Compat.parseInt(activeBaddieArray[i].x - ex);
                distY = as3hx.Compat.parseInt(activeBaddieArray[i].y - ey);
                if (Math.abs(distX) < dist)
                {
                    angleDist = Math.abs(-Math.atan2(distX, distY) - angle);
                    if (angleDist < 0.3)
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
    
    @:allow()
    private static function clearAllBaddies() : Void
    {
        var baddieArrayLength : Int = as3hx.Compat.parseInt(BaddieArray.length);
        for (i in 0...baddieArrayLength)
        {
            BaddieArray[0].cleanUp();
            BaddieArray[0].clearHealthBar();
            if (BaddieArray[0].parent != null)
            {
                BaddieArray[0].parent.removeChild(BaddieArray[0]);
            }
            BaddieArray.shift();
        }
        AggressorArray = new Array<Baddies>();
        activeBaddieArray = new Array<Baddies>();
    }
    
    @:allow()
    private static function clearAllBaddiesOnRail(rail : Dynamic) : Void
    {
        for (i in 0...BaddieArray.length)
        {
            if (Reflect.field(BaddieArray, Std.string(i)).onRail == rail)
            {
                Reflect.field(BaddieArray, Std.string(i)).cleanUp();
                Reflect.field(BaddieArray, Std.string(i)).clearHealthBar();
                if (Reflect.field(BaddieArray, Std.string(i)).parent != null)
                {
                    Reflect.field(BaddieArray, Std.string(i)).parent.removeChild(Reflect.field(BaddieArray, Std.string(i)));
                }
                if (Lambda.indexOf(activeBaddieArray, Reflect.field(BaddieArray, Std.string(i))) > -1)
                {
                    activeBaddieArray.splice(Lambda.indexOf(activeBaddieArray, Reflect.field(BaddieArray, Std.string(i))), 1);
                }
                if (Lambda.indexOf(AggressorArray, Reflect.field(BaddieArray, Std.string(i))) > -1)
                {
                    AggressorArray.splice(Lambda.indexOf(AggressorArray, Reflect.field(BaddieArray, Std.string(i))), 1);
                }
                BaddieArray.splice(i, 1);
                i--;
            }
        }
    }
    
    @:allow()
    private static function killAllSpiders() : Void
    {
        var baddieArrayLength : Int = as3hx.Compat.parseInt(BaddieArray.length);
        for (i in 0...baddieArrayLength)
        {
            if (Reflect.field(BaddieArray, Std.string(i)).ItIs == "Spider")
            {
                Reflect.field(BaddieArray, Std.string(i)).ChangeFrame("deadJump");
                Reflect.setField(BaddieArray, Std.string(i), -12).moveUD;
            }
        }
    }
    
    @:allow()
    private static function findByItIs(itis : Dynamic) : Baddies
    {
        var i : Int = 0;
        var l : Dynamic = BaddieArray.length;
        while (i < l)
        {
            if (BaddieArray[i].ItIs == itis)
            {
                return BaddieArray[i];
            }
            i++;
        }
    }
    
    public function resetBad() : Void
    {
    }
    
    private function doEnterFrames() : Void
    {
        if (hitPause > 0)
        {
            --hitPause;
            if (hitPause == 0 && this.explode)
            {
                Sounds.playSound("InkExplode", x, scale * 1.5, onRail);
                StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, (scale - 0.5) * 0.4 + 0.6, moveRL, moveUD, onRail);
                Main.shakeScreen(10, 0, true);
                if (this.resetOnFall)
                {
                    this.resetBad();
                }
                else if (ItIs == "InkFloat")
                {
                    this.ChangeFrame("return");
                }
                else
                {
                    killBaddies.push(this);
                }
            }
        }
        if (hitPause == 0)
        {
            if (downTime > 0)
            {
                --downTime;
            }
            this.CharDistX = CharX - x;
            springBounce();
            this.BaddieEnterFrame();
        }
    }
    
    override public function checkAfterMove() : Bool
    {
        InteractObjects.baddieCheckObjects(x, y, isWide + Math.abs(moveRL), isTall + Math.abs(moveUD), onRail, this);
        StarlingInteract.baddieCheckObjects(x, y, isWide + Math.abs(moveRL), isTall + Math.abs(moveUD), onRail, this);
        staticInteractObjects.baddieCheckObjects(x, y, isWide + Math.abs(moveRL), isTall + Math.abs(moveUD), onRail, this);
        StarlingDecals.baddieCheckObjects(x, y, isWide + Math.abs(moveRL), isTall + Math.abs(moveUD), onRail, this);
    }
    
    private function EveryCollision() : Void
    {
        if (downTime == 0)
        {
            this.CheckBadOnBad();
        }
        if (Status != "Wait")
        {
            if (Status == "Fly")
            {
                if (hitPause == 0)
                {
                    x += moveRL * framin;
                    y += moveUD * framin;
                    rotation += rotter * framin;
                    this.checkAfterMove();
                }
            }
            else if (BallRes == 0 || health == 0)
            {
                if (hitPause == 0)
                {
                    x += moveRL * framin;
                    y += moveUD * framin;
                    if (Status == "Roll")
                    {
                        rotation += rotter * framin;
                    }
                    this.checkAfterMove();
                }
                if (Status == "Hit")
                {
                    rotation += rotter * 0.5 * framin;
                }
                else if (Status == "deadJump")
                {
                    rotation += rotter * framin;
                }
            }
            else if (hitPause > 0)
            {
                CheckAllPaused();
                if (Status == "Hit")
                {
                    rotation += rotter * 0.5 * framin;
                }
            }
            else if (Status == "Move" || Status == "Bullet")
            {
                x += moveRL * framin;
                y += moveUD * framin;
                rotation += rotter * framin;
            }
            else if (Status == "Stomped")
            {
                CheckAllGrounds();
            }
            else if (Status == "Roll")
            {
                CheckAllAir();
                if (!onGround)
                {
                    wallRot = wallAngle = 0;
                    if (almostPlat || almostGround)
                    {
                        rotter = rotPerc * fakeRL;
                    }
                    else
                    {
                        rotter += (moveRL * 3 - rotter) / 20 * framin;
                    }
                }
                if (y > MaxY + 400)
                {
                    resetCombo();
                    if (this.resetOnFall)
                    {
                        this.resetBad();
                    }
                    else
                    {
                        killBaddies.push(this);
                    }
                }
            }
            else if (Status == "Jump" || Status == "stunJump" || Status == "Hit" || Status == "Drop")
            {
                CheckAllAir();
                if (Status != "Hit")
                {
                    if (onGround)
                    {
                        if (fakeUD == 0 && Math.abs(wallRot) < 90)
                        {
                            rotation = wallRot;
                            this.JumpLand();
                        }
                        else
                        {
                            wallRot = wallAngle = 0;
                        }
                    }
                    else
                    {
                        wallRot = wallAngle = 0;
                        if (landSpeed * bounce > bounceThresh)
                        {
                            rotter = landSpeed * makeOne(moveRL);
                            spring = landSpeed * 0.5;
                            landSpeed = 0;
                            Sounds.playSound("Impact", x, landSpeed * 0.03, onRail);
                            this.baddie.gotoAndStop(1);
                        }
                    }
                }
                if (y > MaxY + 400)
                {
                    resetCombo();
                    killBaddies.push(this);
                }
            }
            else
            {
                CheckAllGrounds();
                if (Status != "Hit")
                {
                    if (onGround)
                    {
                        if (Status != "Attack")
                        {
                            if (onWall * scaleX > 0)
                            {
                                this.changeDirection(-onWall);
                                moveSpringBounce();
                                fakeRL = 0;
                            }
                            if (onWallPlat * scaleX > 0)
                            {
                                this.changeDirection(-onWallPlat);
                                moveSpringBounce();
                                fakeRL = 0;
                            }
                            if (!inky)
                            {
                                if (onLedge * scaleX > 0 && fakeRL * scaleX > 1)
                                {
                                    this.changeDirection(-onLedge);
                                    moveSpringBounce();
                                    fakeRL = 0;
                                }
                            }
                        }
                        if (Math.abs(wallRot) > 120)
                        {
                            rotter = fakeRL * rotPerc * 0.5;
                            this.ChangeFrame("Jump");
                        }
                    }
                    else if (stunN == 0)
                    {
                        rotter = fakeRL * rotPerc * 0.5;
                        this.ChangeFrame("Jump");
                    }
                    else
                    {
                        this.ChangeFrame("stunJump");
                    }
                }
                rotation += rotCompare(wallRot, rotation) * (1 - Math.pow(1 - 1 / 3, framin));
            }
        }
        moveSpringBounce();
        if (showHealthBar)
        {
            this.healthBarSmoke.x = x - 24;
            this.healthBarSmoke.y = y - isTall * 1.8 - 10;
            this.healthBarOutlineSmoke.x = x;
            this.healthBarOutlineSmoke.y = y - isTall * 1.8 - 10;
        }
        if (hitPause == 0)
        {
            if (ItIs == "Mouse" && Status == "Roll" && stunN > 0)
            {
                this.stars.rotation = -rotation * makeOne(scaleX);
                angle = this.stars.rotation * (Math.PI / 180);
                this.stars.x = Math.sin(angle) * 35;
                this.stars.y = Math.cos(angle) * -35;
            }
        }
        this.placeSmoke();
    }
    
    private function baddieRootStuff() : Void
    {
        if (Math.abs(shakeRL) > 1)
        {
            this.baddie.x = (shakeRL * 0.5 - Math.random() * shakeRL) / scale;
            this.baddie.y = (shakeRL * 0.5 - Math.random() * shakeRL) / scale;
        }
        if (hitPause > 0)
        {
            if (currentSound != null)
            {
                Sounds.updateSound(currentSound, x, 0, onRail);
            }
            shakeRL *= -0.8;
        }
        else
        {
            shakeRL *= -0.6;
        }
        if (RedHurt > 0)
        {
            if (RedHurt == 3)
            {
                transform.colorTransform = Main.getTint(1, -0.6, -0.6);
            }
            else if (RedHurt == 1)
            {
                transform.colorTransform = Main.getTint(0, 0, 0);
                if (this.hasSmoke)
                {
                    this.currentSmoke.returnToMesh(onRail, false);
                    visible = false;
                    if (parent != null)
                    {
                        parent.removeChild(this);
                    }
                }
            }
            --RedHurt;
        }
    }
    
    private function CheckBadOnBad() : Void
    {
        var n : Int = 0;
        for (n in 0...AggressorArray.length)
        {
            if (AggressorArray[n].downTime == 0 && this.canBall && this != AggressorArray[n])
            {
                if (AggressorArray[n].mass > mass * 2 && Math.abs(AggressorArray[n].moveRL) > 5)
                {
                    if (ballCollision(AggressorArray[n], this))
                    {
                        Sounds.playSound("Hit", x, 2, onRail);
                        hitPause = AggressorArray[n].hitPause = 7;
                        downTime = 5;
                        shakeRL = AggressorArray[n].shakeRL = 20;
                        Main.shakeScreen(10, 0, true);
                        stunN = stunMax;
                        moveRL = makeOne(AggressorArray[n].moveRL) * 10;
                        moveUD = -20;
                        rotter = makeOne(AggressorArray[n].moveRL) * -10;
                        AggressorArray[n].hurtBaddie(health * 0.2);
                        this.hurtBaddie(100);
                        if (AggressorArray[n].ItIs == "Mouse")
                        {
                            Achievements.unlock("Mouse_Bowling");
                            Achievements.SendScore("Mouse_Bowling", 1);
                        }
                        if (AggressorArray[n].health > 0)
                        {
                            if (stunN < stunMax * 0.5)
                            {
                                stunN = stunMax;
                            }
                        }
                        else
                        {
                            AggressorArray[n].moveUD = -(Math.abs(AggressorArray[n].moveRL) + 5);
                            AggressorArray[n].moveRL *= 0.5;
                            AggressorArray[n].ChangeFrame("deadJump");
                        }
                        Main.popBetween(AggressorArray[n], this, 1.5);
                        if (Status != "deadJump")
                        {
                            this.ChangeFrame("Hit");
                        }
                    }
                }
                else if (!canAggressor)
                {
                    this.hitByAggressor(AggressorArray[n]);
                }
                else if (downTime == 0)
                {
                    solveBalls(this, AggressorArray[n]);
                }
            }
        }
    }
    
    public function hitByAggressor(bad : Dynamic) : Void
    {
        if (solveUneven(bad, this))
        {
            bad.hitPause = hitPause = 3;
            bad.shakeRL = shakeRL = 10;
            Main.shakeScreen(10, 0, true);
            Sounds.playSound("Hit", x, 1, onRail);
            Main.popBetween(bad, this, 1);
            stunN = stunMax;
            spring = 10;
            this.hurtBaddie(10);
            if (parent == null)
            {
                Backgrounds.backgroundsArray[onRail].addChild(this);
            }
            if (Status != "deadJump")
            {
                this.ChangeFrame("Hit");
            }
        }
    }
    
    public function chooseCharInteract(frame : Dynamic) : Void
    {
    }
    
    public function cleanUp() : Void
    {
        if (this.hasSmoke)
        {
            this.smokeFrameOffset = -1;
            this.currentSmoke.goSwim();
            this.currentSmoke = null;
            this.hasSmoke = false;
        }
    }
    
    public function changeDirection(e : Float) : Void
    {
        if (e * facing < 0)
        {
            facing *= -1;
        }
        if (e * scaleX < 0)
        {
            scaleX *= -1;
        }
    }
    
    private function clearHealthBar() : Void
    {
        if (showHealthBar)
        {
            this.healthBarSmoke.goSwim();
            this.healthBarOutlineSmoke.goSwim();
            this.healthBarSmoke = this.healthBarOutlineSmoke = null;
            showHealthBar = false;
        }
    }
    
    public function ChangeFrame(frame : Dynamic) : Void
    {
        this.BaddieEnterFrame = this[frame + "EnterFrame"];
        gotoAndStop(frame);
        if (frame == "Wait")
        {
            if (Lambda.indexOf(activeBaddieArray, this) > -1)
            {
                activeBaddieArray.splice(Lambda.indexOf(activeBaddieArray, this), 1);
            }
            if (parent != null)
            {
                parent.removeChild(this);
            }
            this.cleanUp();
        }
        else
        {
            cast((this), MovieClip).baddie.gotoAndStop(1);
            if (Lambda.indexOf(activeBaddieArray, this) == -1)
            {
                activeBaddieArray.push(this);
                aPlat.resetplatSides(x, y, this);
            }
            if (!this.hasSmoke)
            {
                if (this.smokeName == "nothing")
                {
                    if (parent == null)
                    {
                        Backgrounds.backgroundsArray[onRail].addChild(this);
                    }
                }
                else
                {
                    if (this.currentSmoke == null)
                    {
                        this.currentSmoke = StarlingSmoke.Spawn(this.smokeName, x, y, 0, 1, 0, 0, onRail);
                    }
                    this.hasSmoke = true;
                }
            }
            this.smokeSetFrame();
            this.placeSmoke();
        }
        this.chooseCharInteract(frame);
        Status = frame;
    }
    
    public function smokeSetFrame() : Void
    {
        if (this.smokeFrameOffset > -1)
        {
            this.currentSmoke.currentFrame = this.smokeFrameOffset + this.baddie.currentFrame;
        }
    }
    
    public function groundStatus(frame : Dynamic) : Bool
    {
        return !(frame == "Jump" || frame == "stunJump" || frame == "deadJump");
    }
    
    public function slopeStuff() : Void
    {
        cast((wallRot), RotToAccel);
        if (Math.abs(rotAccel) > 2)
        {
            rotAccel = rotAccel / Math.abs(rotAccel) * 2;
        }
        if (Math.abs(fakeRL + rotAccel) < 40)
        {
            fakeRL += rotAccel;
        }
        else
        {
            fakeRL *= 40 / Math.abs(fakeRL);
        }
    }
    
    public function JumpLand() : Void
    {
        downTime = 0;
        if (inky)
        {
            rotation = wallRot;
            rotter = 0;
            this.ChangeFrame("Land");
        }
        else if (stunN > 0)
        {
            if (ItIs == "Mouse")
            {
                this.ChangeFrame("Roll");
            }
            else
            {
                rotter = 0;
                this.ChangeFrame("Stunned");
            }
        }
        else
        {
            rotter = 0;
            this.ChangeFrame("Land");
        }
    }
    
    public function hurtBaddie(hurt : Float, hrx : Float = 0, hry : Float = 0) : Bool
    {
        if (health > 0)
        {
            if (this.hatN > 0)
            {
                if (hrx == 0)
                {
                    hrx = moveRL * 0.5;
                }
                if (hry == 0)
                {
                    hry = moveUD * 0.5;
                }
                new LooseHat(x, y - isTall, hrx, hry, onRail, this.hatN);
                this.loseHat();
            }
            if (health - hurt > 0)
            {
                health -= as3hx.Compat.parseInt(hurt);
                if (healthMax > 0)
                {
                    if (!showHealthBar)
                    {
                        this.healthBarSmoke = StarlingSmoke.Spawn("healthBar", x - 24, y - 30, 0, 1, 0, 0, onRail);
                        this.healthBarOutlineSmoke = StarlingSmoke.Spawn("healthBar", x, y - 30, 0, 1, 0, 0, onRail);
                        this.healthBarOutlineSmoke.currentFrame = 2;
                        showHealthBar = true;
                    }
                    this.healthBarSmoke.scaleX = health / healthMax;
                }
                return false;
            }
            health = 0;
            aPlatOn = null;
            ++Main.baddiesSession;
            if (showHealthBar)
            {
                this.healthBarSmoke.goSwim();
                this.healthBarOutlineSmoke.goSwim();
                this.healthBarSmoke = this.healthBarOutlineSmoke = null;
                showHealthBar = false;
            }
            if (inky)
            {
                Achievements.track("Untouchable", -1, 20, true);
            }
            return true;
        }
    }
    
    public function wearHat(n : Int) : Bool
    {
        return false;
    }
    
    public function loseHat() : Void
    {
    }
    
    public function standardHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : String
    {
        angle = rotation * (Math.PI / 180);
        aRL = Math.cos(angle) * eRL + Math.sin(angle) * eUD;
        aUD = Math.cos(angle) * eUD - Math.sin(angle) * eRL;
        if (Math.abs(ax) > isWide + char.isWide || Math.abs(ay) > isTall + char.isTall)
        {
            return "nothing";
        }
        if (char.Status == "Zip" || char.Status == "ZipAir")
        {
            char.hitPause = 3;
            char.justAttackHit = char.justAttackQuick = true;
            if (char.JumpIsDown())
            {
                StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, (scale - 0.5) * 0.4 + 0.6, eRL * 0.2, 0, onRail);
                char.jumpFromZip(true);
            }
            hitPause = 4;
            shakeRL = 20;
            downTime = 5;
            moveRL = eRL * 0.5;
            if (char.SpecialIsDown())
            {
                char.char.gotoAndStop(4);
                char.smokeB = 2 + isWide * 2 / 60;
            }
            moveUD = -20;
            spring = 0;
            StarlingEffect.Spawn("impactEffect", x, y, 1.57 * char.scaleX, 1, 0, 0, onRail);
            hurtPower = 20;
            return "Hit";
        }
        if (char.Status == "Kick" && char.char.currentFrame < 16)
        {
            angle = 30 * makeOne(eRL * 0.5) * Math.PI / 180;
            tempRL = 0;
            tempUD = -(20 + Math.abs(eRL));
            moveRL = Math.cos(angle) * tempRL - Math.sin(angle) * tempUD;
            moveUD = Math.cos(angle) * tempUD + Math.sin(angle) * tempRL;
            shakeRL = -tempUD;
            Main.shakeScreen(-tempUD / 2, 0, true);
            rotter = moveRL * rotPerc;
            char.moveUD = -10;
            char.FloatUp = 2;
            char.char.gotoAndStop(1);
            char.placeHead(char.char);
            downTime = 5;
            hitPause = char.hitPause = 2;
            hurtPower = 20;
            return "Hit";
        }
        if (char.Status == "Roll" || char.Status == "DownSlide")
        {
            if (char.Status == "Roll")
            {
                Sounds.playSound("PinCrash", char.x, 1, onRail);
            }
            Achievements.track("Super_Slider", 120, 4, true);
            if (CheckHead())
            {
                fakeRL = eRL * 1.3;
                moveRL = Math.cos(angle) * fakeRL;
                moveUD = Math.sin(angle) * fakeRL;
                hurtPower = 5;
                downTime = 20;
                shakeRL = eRL;
                Main.shakeScreen(-tempUD / 5, 0, true);
            }
            else
            {
                angle = (char.wallRot + 35 * makeOne(eRL)) * Math.PI / 180;
                tempRL = 0;
                tempUD = -(5 + Math.abs(eRL * 1.5));
                Main.shakeScreen(-tempUD / 5, 0, true);
                shakeRL = -tempUD;
                moveRL = Math.cos(angle) * tempRL - Math.sin(angle) * tempUD;
                moveUD = Math.cos(angle) * tempUD + Math.sin(angle) * tempRL;
                if (Math.abs(char.fakeRL) < 15)
                {
                    char.Jumper = 10;
                    char.fakeRL = -makeOne(char.scaleX) * 4;
                    char.FloatUp = 4;
                    char.gotoBuffer = "Jump";
                }
                if (stunN < 0)
                {
                    hurtPower = 60;
                }
                else
                {
                    hurtPower = 5;
                }
                rotter = Math.abs(moveUD) * rotPerc * -makeOne(moveRL);
                downTime = 5;
            }
            return "Hit";
        }
        if (char.StompedOn != null)
        {
            if (Status != "Stomped")
            {
                return;
            }
            return "nothing";
        }
        if (char.Status == "Skateboard")
        {
            angle = char.wallRot * Math.PI / 180;
            tempRL = 0;
            tempUD = -(5 + Math.abs(eRL * 1.5));
            Main.shakeScreen(-tempUD / 10, 0, true);
            shakeRL = -tempUD;
            moveRL = Math.cos(angle) * tempRL - Math.sin(angle) * tempUD;
            moveUD = Math.cos(angle) * tempUD + Math.sin(angle) * tempRL;
            hurtPower = 60;
            rotter = Math.abs(moveUD) * rotPerc * -makeOne(moveRL);
            downTime = 5;
            hitPause = char.hitPause = 4;
            return "Hit";
        }
        if (ay + aUD * 2 + Math.abs(moveUD) + 5 > isTall + char.isTall && aUD > -2 && char.Status != "Hurt" && char.gotoBuffer != "Hurt" && char.Status != "Hang")
        {
            wallX = x;
            char.wallY = wallY = as3hx.Compat.parseInt(y + isTall);
            char.rotation = (char.rotation + rotation) * 0.5;
            char.rotter = (rotation - char.rotation) / 3;
            this.lastStomped = char;
            Sounds.playSound("BadStomp", x, 3, onRail);
            if (this.hatN > 0)
            {
                spring = -3;
                springTall -= 5;
                char.downTime = 5;
                downTime = 10;
                char.FloatLock = false;
                if (char.JumpIsDown())
                {
                    char.Jumper = this.thrust * 1.3;
                    char.FloatUp = 0;
                }
                else
                {
                    char.Jumper = this.thrust;
                    char.FloatUp = 6;
                }
                char.resetPencil();
                char.wallRot = wallRot;
                char.wallAngle = wallAngle;
                char.fakeRL = char.moveRL;
                char.gotoBuffer = "Jump";
            }
            else
            {
                spring = -10;
                fakeRL = moveRL = fakeUD = moveUD = rotter = 0;
                rotter = 0;
                char.StompedOn = this;
                char.gotoBuffer = "Stomp";
                Achievements.track("Floor_Is_Lava", 150, 5, true);
                this.ChangeFrame("Stomped");
            }
            return "Stomped";
        }
        if (char.downTime == 0 && char.alpha == 1)
        {
            if (Math.abs(ax) < (isWide + char.isWide) * 0.75)
            {
                if (char.hurtChar(20, 20, 5, makeOne(ex - x) * 8, 20, true))
                {
                    spring = 10 * scale;
                    springy = 10;
                    springDecay = 0.8;
                }
            }
            return "Attack";
        }
        return "nothing";
    }
    
    public function inkyHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : String
    {
        angle = rotation * (Math.PI / 180);
        aRL = Math.cos(angle) * eRL + Math.sin(angle) * eUD;
        aUD = Math.cos(angle) * eUD - Math.sin(angle) * eRL;
        if (Math.abs(ax) > isWide + char.isWide || Math.abs(ay) > isTall + char.isTall)
        {
            return "nothing";
        }
        if (char.Status == "Zip" || char.Status == "ZipAir")
        {
            char.justAttackHit = char.justAttackQuick = true;
            if (char.JumpIsDown())
            {
                char.jumpFromZip(true);
            }
            StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, (scale - 0.5) * 0.4 + 0.8, eRL * 0.5, 0, onRail);
            Main.shakeScreen(10, Math.random() * 6.28, true);
            hitPause = 3;
            shakeRL = 20;
            downTime = 10;
            moveRL = eRL * 0.5;
            if (ItIs == "Boss2")
            {
                rotter = -eRL;
            }
            else
            {
                rotter = -eRL * 10;
            }
            if (char.SpecialIsDown())
            {
                char.char.gotoAndStop(4);
                if (char.smokeB < 3 + isWide * 2 / 60)
                {
                    char.smokeB = 3 + isWide * 2 / 60;
                }
                if (Math.abs(char.attackRL) < 15)
                {
                    char.attackRL = 15 * makeOne(char.attackRL);
                }
            }
            moveUD = -20;
            spring = 0;
            StarlingEffect.Spawn("impactEffect", x, y, 1.57 * char.scaleX, 1, 0, 0, onRail);
            hurtPower = 20;
            return "Hit";
        }
        if (Status == "Roll")
        {
            if (char.hurtChar(30 * power, 20, 5, makeOne(ex - x) * 6, 15 + Math.abs(moveRL), true))
            {
                spring = 5 * scale;
                Achievements.clearTracked("Untouchable");
            }
            return "Attack";
        }
        if (char.hurtChar(30 * power, 20, 5, makeOne(ex - x) * 12, 16, true))
        {
            spring = 5 * scale;
            Achievements.clearTracked("Untouchable");
        }
    }
    
    public function smokeTrail() : Dynamic
    {
        var rand : Float = Math.NaN;
        if (smokeB > 0)
        {
            if (smokeN > 0)
            {
                --smokeB;
                --smokeN;
            }
            else
            {
                rand = Math.random() * 0.5 + 0.5;
                StarlingEffect.Spawn("smokePuff", footX(), footY(), Math.random() * 6, -scaleX * rand, cast((-2 * rand), UDx), cast((-2 * rand), UDy), onRail);
                smokeN = 2;
            }
        }
    }
    
    public function standardGetAttacked(ex : Float, ey : Float, angle : Float, char : Collision, hitMove : String, hitPower : Float, pow : Float = 1) : Bool
    {
        if (char.justAttackHit)
        {
            if (char.hitPause > hitPower * 0.06 + 1)
            {
                hitPause = char.hitPause;
            }
            else
            {
                char.hitPause = hitPower * 0.06 + 1;
                hitPause = char.hitPause;
            }
        }
        else
        {
            char.hitPause = hitPower * 0.1 + 1;
            hitPause = char.hitPause;
        }
        this.lastStomped = char;
        facing = makeOne(char.x - x);
        moveSpringBounce();
        this.hurtBaddie(hitPower * pow, -(12 + hitPower * 0.5) * facing, -(4 + hitPower * 0.5));
        getAttackedShared(ex, ey, angle, char, hitMove, hitPower);
        ++combo;
        smokeN = 0;
        smokeB = 20;
        if (combo >= 20)
        {
            Achievements.unlock("combo20");
        }
        if (inky)
        {
            Sounds.playSound("InkHurt", x, 1, onRail);
        }
        else
        {
            Sounds.playSound("Hit", x, 1, onRail);
        }
        if (hitPower > 20)
        {
            if (char.Status == "Pencil" || this.grounded)
            {
                char.fakeRL = char.moveRL = scaleX * 4;
            }
            else
            {
                char.moveRL = char.scaleX * 2;
            }
        }
        if (Status == "Fly" && health > 0)
        {
            rotter *= 0.1;
        }
        else if (Status == "deadJump")
        {
            cast((this), MovieClip).baddie.gotoAndStop(1);
            this.smokeSetFrame();
        }
        else if ((onGround || scale >= 4) && hitPower < launchThresh && health > 0)
        {
            moveUD = 0;
        }
        else if (!(Status == "Roll" && health > 0))
        {
            if (aPlatOn != null)
            {
                aPlat.aPlatOnClear(this);
            }
            if (aWallOn != null)
            {
                aWall.aWallOnClear(this);
            }
            this.ChangeFrame("Hit");
        }
        if (Status != "Hit" || !inky)
        {
            if (this.hasSmoke)
            {
                this.currentSmoke.hideFromMesh();
                visible = true;
                if (parent == null)
                {
                    Backgrounds.backgroundsArray[onRail].addChild(this);
                }
            }
            if (scale > 2)
            {
                transform.colorTransform = Main.getTint(1, -0.6, -0.6);
            }
            else
            {
                transform.colorTransform = Main.getTint(1, 1, 1);
            }
            RedHurt = 5;
        }
        return true;
    }
    
    public function standardBeAFireball(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : Void
    {
        var distX : Int = Math.abs(ex - x);
        var distY : Int = Math.abs(ey - y);
        if (distX < isWide + char.isWide && distY < isTall + char.isTall)
        {
            if (!char.hurtChar(20, 20, 5, makeOne(moveRL) * 10, 20, true))
            {
            }
            if (this.solid)
            {
                if (distX > distY * 0.6)
                {
                    char.x = x + (char.isWide + isWide) * makeOne(ex - x);
                    if (char.moveRL * makeOne(ex - x) < 0)
                    {
                        char.moveRL = char.fakeRL = 0;
                    }
                }
                else
                {
                    char.y = y + (char.isTall + isTall) * makeOne(ey - y);
                    if (char.moveUD * makeOne(ey - y) < 0)
                    {
                        char.moveUD = 0;
                    }
                }
            }
        }
    }
    
    public function simpleJump(jumper : Dynamic) : Void
    {
        angle = rotation * (Math.PI / 180);
        moveRL = Math.cos(angle) * fakeRL - Math.sin(angle) * -jumper;
        moveUD = Math.cos(angle) * -jumper + Math.sin(angle) * fakeRL;
        this.ChangeFrame("Jump");
    }
    
    public function StompedEnterFrame() : Void
    {
        if (spring > 0 && springTall + spring > originalSpringTall)
        {
            stunN = stunMax;
            moveRL = fakeRL = -makeOne(facing) * 5;
            rotter = fakeRL * 10;
            moveUD = -12;
            scaleX = facing;
            downTime = 30;
            if (health > 0)
            {
                this.ChangeFrame("stunJump");
            }
            else
            {
                this.ChangeFrame("deadJump");
            }
        }
    }
    
    public function HitEnterFrame() : Void
    {
        if (Math.abs(moveUD) >= 0.5)
        {
            if (health > 0)
            {
                this.stunJumpEnterFrame();
            }
            else
            {
                this.deadJumpEnterFrame();
            }
        }
        if (hitPause == 0)
        {
            if (health == 0)
            {
                this.ChangeFrame("deadJump");
            }
            else if (inky)
            {
                if (Math.abs(moveUD) < 0.5)
                {
                    this.ChangeFrame("Idle");
                }
                else
                {
                    this.ChangeFrame("stunJump");
                }
            }
            else if (Math.abs(moveUD) < 2 || CheckHead())
            {
                canAggressor = false;
                this.ChangeFrame("Stunned");
            }
            else
            {
                this.ChangeFrame("stunJump");
            }
        }
    }
    
    public function stunJumpEnterFrame() : Void
    {
        cast((this), MovieClip).baddie.nextFrame();
        this.smokeSetFrame();
        if (Math.abs(rotter) > 40)
        {
            rotter *= 0.95;
        }
        if (moveUD < 20)
        {
            moveUD += 1.5;
        }
        if (Math.abs(moveRL) > 4)
        {
            moveRL *= 0.96;
        }
        if (Math.abs(moveUD) > 20)
        {
            moveUD *= 0.9;
        }
        this.smokeTrail();
        if (cast((this), MovieClip).baddie.currentFrame == cast((this), MovieClip).baddie.totalFrames)
        {
            cast((this), MovieClip).baddie.gotoAndStop("loop");
        }
        if (y > Main.cameraY + Main.stageYs[onRail] + 50 || x < Main.MinX / Main.stageRatios[onRail] || x > Main.MaxX / Main.stageRatios[onRail])
        {
            resetCombo();
            killBaddies.push(this);
        }
    }
    
    public function deadJumpEnterFrame() : Void
    {
        cast((this), MovieClip).baddie.nextFrame();
        if (Math.abs(rotter) > 15)
        {
            rotter *= 0.95;
        }
        if (FloatUp > 0)
        {
            --FloatUp;
        }
        else
        {
            if (moveUD < 20)
            {
                moveUD += 1;
            }
            if (Math.abs(moveRL) > 4)
            {
                moveRL *= 0.98;
            }
            if (Math.abs(moveUD) > 20)
            {
                moveUD *= 0.9;
            }
        }
        this.smokeTrail();
        if (cast((this), MovieClip).baddie.currentFrame == cast((this), MovieClip).baddie.totalFrames)
        {
            cast((this), MovieClip).baddie.gotoAndStop("loop");
        }
        this.smokeSetFrame();
        if (y > Main.cameraY + Main.stageYs[onRail] + 50 || x < Main.MinX / Main.stageRatios[onRail] || x > Main.MaxX / Main.stageRatios[onRail])
        {
            resetCombo();
            killBaddies.push(this);
        }
    }
    
    public function baddieHitChar(char : Dynamic) : String
    {
        var temp : String = this.currentHitChar(char.x, char.y, char.moveRL, char.moveUD, char.ax, char.ay, char);
        if (temp == "Hit")
        {
            if (inky)
            {
                Sounds.playSound("InkSpit", x, 1.3, onRail);
            }
            else
            {
                Sounds.playSound("BadStomp", x, getSpeed(moveRL, moveUD) * 0.1, onRail);
            }
            ++combo;
            stunN = stunMax;
            smokeN = 0;
            smokeB = 20;
            if (combo >= 20)
            {
                Achievements.unlock("combo20");
            }
            Main.popBetween(char, this);
            this.lastStomped = char;
            this.hurtBaddie(hurtPower);
            if (platRL != 0)
            {
                x += platRL;
                moveRL += platRL;
                platRL = 0;
            }
            if (platUD != 0)
            {
                moveUD += platUD;
                platUD = 0;
            }
            if (wallRL != 0)
            {
                x += wallRL;
                moveRL += wallRL;
                wallRL = 0;
            }
            if (wallUD != 0)
            {
                moveUD += wallUD;
                wallUD = 0;
            }
            if (aPlatOn != null)
            {
                aPlat.aPlatOnClear(this);
            }
            if (aWallOn != null)
            {
                aWall.aWallOnClear(this);
            }
            if ((Status != "Roll" && Status != "Fly" || health == 0) && Status != "deadJump")
            {
                rotation = 0;
                this.ChangeFrame("Hit");
            }
            springTall += spring;
            scaleY = springTall / originalSpringTall * scale;
            scaleX = (scale - scaleY + scale) * makeOne(scaleX);
        }
        else if (temp != "nothing")
        {
            moveSpringBounce();
        }
        return temp;
    }
    
    override public function addToFollow(b : Int, ex : Float = -10000, ey : Float = -10000) : Void
    {
        if (Main.tempFollow.indexOf(this) == -1)
        {
            Main.tempFollow.push(this);
            Main.tempFollowB.push(b);
            if (Math.abs(ex - x) < 100 && Math.abs(ey - y) < 100)
            {
                Main.tempFollowR.push(1);
            }
            else
            {
                Main.tempFollowR.push(0);
            }
        }
        else
        {
            Main.tempFollowB[Main.tempFollow.indexOf(this)] = b;
        }
    }
    
    public function removeFromFollow() : Void
    {
        if (Main.tempFollow.indexOf(this) > -1)
        {
            Main.tempFollowB.splice(Main.tempFollow.indexOf(this), 1);
            Main.tempFollow.splice(Main.tempFollow.indexOf(this), 1);
        }
    }
    
    public function Projectile(ex : Dynamic, ey : Dynamic, eRL : Dynamic) : Bool
    {
        if (Math.abs(x - (ex - eRL * framin)) < isWide + 15)
        {
            return false;
        }
        if (scale > 1)
        {
            eRL = 30 / mass * (60 * eRL / Math.abs(eRL));
        }
        hitPause = 3;
        this.hurtBaddie(10);
        shakeRL = 15;
        moveRL += (eRL * 0.4 - moveRL) * 0.8;
        fakeRL = moveRL;
        rotter = moveRL * 5;
        moveUD = -5;
        if (scale > 1)
        {
            spring = 2 * (20 / mass);
        }
        else
        {
            spring += 2 * scale;
        }
        if (onGround)
        {
            facing = makeOne(-eRL);
        }
        else
        {
            facing = makeOne(-eRL);
            if (facing * rotation < 0)
            {
                rotation *= -1;
            }
        }
        smokeN = 0;
        smokeB = 20;
        Sounds.playSound("InkBurst", x, 0.8, onRail);
        Sounds.playSound("InkSpit", x, 0.8, onRail);
        if (false && health == 0 && inky)
        {
            cachedEffects.spawnCachedEffect("Splat", x, y, rotation * (Math.PI / 180), (scale - 0.5) * 0.4 + 0.6, eRL * 0.2, 0, onRail, parent);
            killBaddies.push(this);
        }
        else if (Status == "deadJump")
        {
            this.baddie.gotoAndStop(1);
            this.smokeSetFrame();
        }
        else if (!((Status == "Roll" || Status == "Fly") && health > 0))
        {
            if (inky)
            {
                if (health == 0)
                {
                    Achievements.track("Inkinator", 300, 10);
                    this.explode = true;
                    hitPause = 3;
                    spring = 0;
                }
                else if (onGround)
                {
                    moveUD = 0;
                    rotter = 0;
                }
                else
                {
                    spring = 0;
                    this.ChangeFrame("Hit");
                }
            }
            else
            {
                if (health > 0)
                {
                    moveRL = eRL * 0.1;
                    moveUD = -15;
                    rotter = eRL * 0.2;
                    stunN = stunMax;
                }
                else
                {
                    moveRL = eRL * 0.3;
                    moveUD = -15;
                    rotter = eRL * 1.2;
                    shakeRL += 20;
                    hitPause += 4;
                }
                hitPause = 4;
                this.ChangeFrame("Hit");
            }
        }
        if (Status != "Hit")
        {
            RedHurt = 2;
            transform.colorTransform = Main.getTint(1, -0.6, -0.6);
            if (this.hasSmoke)
            {
                this.currentSmoke.hideFromMesh();
                visible = true;
                if (parent == null)
                {
                    Backgrounds.backgroundsArray[onRail].addChild(this);
                }
            }
            this.baddie.x = (shakeRL * 0.5 - Math.random() * shakeRL) / scale;
            this.baddie.y = (shakeRL * 0.5 - Math.random() * shakeRL) / scale;
        }
        return true;
    }
    
    public function setFacing(n : Dynamic) : Void
    {
        if (this.ledgeTimer < 5 && n * facing < 0)
        {
            trace("facing jump! " + Status + " " + facing);
            if (onWall != 0 || onLedge != 0)
            {
                originX = x + (x - originX) * 0.5;
            }
            this.simpleJump(16);
        }
        else
        {
            this.ledgeTimer = 0;
        }
        facing = n;
        if (scaleX * n < 0)
        {
            scaleX *= -1;
        }
        fakeRL = 0;
    }
    
    public function placeSmoke() : Void
    {
        if (this.hasSmoke)
        {
            if (this.currentSmoke.pivotY == 0)
            {
                this.currentSmoke.x = x;
                this.currentSmoke.y = y;
            }
            else
            {
                this.currentSmoke.x = footX();
                this.currentSmoke.y = footY();
            }
            if (Math.abs(shakeRL) > 1)
            {
                this.currentSmoke.x += this.baddie.x;
                this.currentSmoke.y += this.baddie.y;
            }
            this.currentSmoke.scaleX = scaleX;
            this.currentSmoke.scaleY = scaleY;
            this.currentSmoke.rotation = rotation * (Math.PI / 180);
        }
    }
    
    @:allow()
    private function nullHitChar() : Bool
    {
    }
}


