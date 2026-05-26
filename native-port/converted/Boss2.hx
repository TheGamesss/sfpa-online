import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol7074"))

class Boss2 extends Baddies
{
    
    public var baddie : MovieClip;
    
    private var b : Int;
    
    private var concernedN : Int = -1;
    
    private var freeze : Bool;
    
    private var lifetimeN : Int = -1;
    
    private var distX : Int;
    
    private var distY : Int;
    
    private var dist : Int;
    
    private var shootN : Int;
    
    private var state : Int;
    
    public function new(p : Dynamic)
    {
        var i : String = null;
        onKilled = p.onKilled;
        spawner = p.spawner;
        if (p.hatN < 0)
        {
            p.hatN = 0;
        }
        super(220, 160, p.onRail);
        for (i in Reflect.fields(p))
        {
            if (i != "componentInspectorSetting")
            {
                Reflect.setField(this, i, Reflect.field(p, i));
            }
        }
        x = p.x;
        originY = y = p.y;
        if (p.originX == null)
        {
            originX = x;
        }
        wallRot = rotation = p.rotation;
        facing = makeOne(p.scaleX);
        inky = true;
        backEffect = false;
        scaleY = scale = Math.abs(p.scaleY);
        scaleX = scale * p.scaleX;
        BallRes = 0;
        bounce = 0.5;
        bounceThresh = 20;
        maxRL = 6 / ((scale - 1) * 0.5 + 1);
        springy = 10;
        stunMax = 120;
        health = as3hx.Compat.parseInt(isTall * isWide / 20);
        retreatThresh = as3hx.Compat.parseInt(health - 50 - Math.random() * 50);
        attackN = 0;
        rotPerc = 360 / (Math.PI * (isTall * 2));
        springTall = isTall * 2;
        overReach = 5;
        knockback = 0.5;
        spring = 0;
        if (scale > 2)
        {
            grounded = true;
        }
        launchThresh = 1000;
        attentionRange = as3hx.Compat.parseInt(300 + isWide * 2);
        if (tether == -1)
        {
            tether = 10000;
        }
        currentHitChar = inkyHitChar;
        springBounce = standardSpringBounce;
        moveSpringBounce = standardMoveSpringBounce;
        currentGetAttacked = this.boss2GetAttacked;
        if (Main.LoadIt == "Level3-j")
        {
            if (Main.world4Progress.defeatBoss2)
            {
                this.state = 20;
                new MapIcon({
                    x : 1616,
                    y : 198,
                    ItIs : "MapIcon",
                    onRail : 0,
                    select : 4
                });
            }
            else if (Main.world4Progress.peekBoss2)
            {
                this.state = 20;
            }
            else
            {
                currentGetAttacked = function(ex : Dynamic, ey : Dynamic, angle : Dynamic, char : Dynamic, hitMove : Dynamic, hitPower : Dynamic, power : Dynamic) : Bool
                        {
                        };
            }
        }
        else if (Main.world4Progress.defeatBoss2)
        {
            this.state = 20;
            visible = false;
        }
        else
        {
            this.state = 10;
            this.baddie.gotoAndStop(20);
        }
        gonnaStomp = function(e : Dynamic) : Dynamic
                {
                };
        cast(("Fly"), ChangeFrame);
        springThresh = spring = 1.5;
        this.shootN = 1;
        currentSound = Sounds.playSoundContinuous("LowRumble", x, 0, 0);
    }
    
    override public function chooseCharInteract(frame : Dynamic) : Void
    {
        switch (frame)
        {
            case "Fly":
                rotter = 0;
        }
    }
    
    override public function checkAfterMove() : Bool
    {
        var i : Int;
        var l : Int;
        StarlingInteract.baddieCheckObjects(x, y, isWide + Math.abs(moveRL), isTall + Math.abs(moveUD), onRail, this);
        i = 0;
        l = activeBaddieArray.length;
        while (i < l)
        {
            if (activeBaddieArray[i].ItIs == "InkBall")
            {
                this.distX = activeBaddieArray[i].x - x;
                this.distY = activeBaddieArray[i].y - y;
                this.dist = Math.sqrt(this.distX * this.distX + this.distY * this.distY);
                if (this.dist < 230)
                {
                    if (!(Math.abs(activeBaddieArray[i].moveRL) < 5 && Math.abs(activeBaddieArray[i].moveUD) < 5))
                    {
                        StarlingEffect.Spawn("Splat", activeBaddieArray[i].x, activeBaddieArray[i].y, Math.random() * 3.14, 2, 0, 0, onRail);
                        Sounds.playSound("InkExplode", activeBaddieArray[i].x, 3, onRail);
                        killBaddies.push(activeBaddieArray[i]);
                        moveRL = -this.distX * 0.5;
                        moveUD = -this.distY * 0.5;
                        smokeB = 60;
                        hitPause = 4;
                        shakeRL = 60;
                        rotter = moveRL * 0.2;
                        RedHurt = 4;
                        transform.colorTransform = Main.getTint(1, 1, 1);
                        if (attackN == 0)
                        {
                            if (facing > 0)
                            {
                                this.baddie.horn2.visible = false;
                            }
                            else
                            {
                                this.baddie.horn1.visible = false;
                            }
                        }
                        else if (attackN == 1)
                        {
                            this.baddie.horn1.visible = this.baddie.horn2.visible = false;
                        }
                        else
                        {
                            this.state = 20;
                            this.baddie.gotoAndStop(35);
                            springBounce = function() : Dynamic
                                    {
                                    };
                            moveSpringBounce = wholeMoveSpringBounce;
                            spring = 0;
                            this.baddie.horn1.visible = this.baddie.horn2.visible = false;
                            fakeRL = 2;
                            currentGetAttacked = function(ex : Dynamic, ey : Dynamic, angle : Dynamic, char : Dynamic, hitMove : Dynamic, hitPower : Dynamic, power : Dynamic) : Bool
                                    {
                                    };
                            currentHitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : String
                                    {
                                    };
                            if (Sounds.fadeOutMusic())
                            {
                                Main.stageRoot.fadingMusic = true;
                            }
                        }
                        ++attackN;
                    }
                }
            }
            i++;
        }
        if (attackN == 1)
        {
            if (facing > 0)
            {
                this.baddie.horn1.visible = true;
                this.baddie.horn2.visible = false;
            }
            else
            {
                this.baddie.horn1.visible = false;
                this.baddie.horn2.visible = true;
            }
        }
    }
    
    public function FlyEnterFrame() : Void
    {
        rotter *= 0.5;
        if (this.state == 0)
        {
            if (Char.CharArray[0].x > x - 600)
            {
                this.state = 1;
                this.shootN = 20;
                Main.saveProgress("peekBoss2", true);
                Sounds.fadeOutMusic("BossMusic", 0.1);
            }
        }
        else if (this.state == 1)
        {
            if (this.shootN > 0)
            {
                --this.shootN;
            }
            else
            {
                this.shootN = 1;
            }
            moveUD = (70 - y) * 0.08;
            if (this.shootN == 0)
            {
                if (this.baddie.currentFrame < 20)
                {
                    this.baddie.nextFrame();
                }
                else
                {
                    this.state = 2;
                    moveUD = -0.1;
                }
            }
        }
        else if (this.state == 2)
        {
            if (moveUD > -20)
            {
                moveUD *= 1.1;
            }
            if (y < -1000)
            {
                moveUD = 0;
                killBaddies.push(this);
            }
        }
        else if (this.state == 10)
        {
            moveRL = 1;
            moveUD = 6;
            if (y >= 600)
            {
                if (this.shootN > 0)
                {
                    --this.shootN;
                }
                else
                {
                    this.shootN = 1;
                    this.baddie.prevFrame();
                    if (this.baddie.currentFrame == 1)
                    {
                        this.baddie.gotoAndStop(21);
                        this.state = 11;
                    }
                }
            }
        }
        else if (this.state == 20)
        {
            moveRL *= 0.5;
            moveUD *= 0.5;
            fakeRL *= -1.05;
            moveRL = fakeRL;
            if (fakeRL > 60)
            {
                this.state = 21;
                Main.saveProgress("defeatBoss2", true);
                Main.saveProgress("volcanoUnlocked", true);
                MapScreen.revealVolcano = true;
                Main.FadeItOut("MapScreen");
            }
        }
        else if (this.state == 21)
        {
            moveRL *= 0.5;
            moveUD *= 0.5;
            fakeRL *= -1.05;
            moveRL = fakeRL;
        }
        else
        {
            if (this.shootN > 0)
            {
                --this.shootN;
            }
            else
            {
                this.shootN = 1;
                this.baddie.nextFrame();
                if (this.baddie.currentFrame == this.baddie.totalFrames)
                {
                    this.baddie.gotoAndStop(21);
                }
            }
            rotter += -rotation * 0.05;
            if (smokeB == 0)
            {
                this.distX = (Char.CharArray[0].x - x) * 0.02;
                this.distY = (Char.CharArray[0].y - y) * 0.02;
                this.dist = Math.sqrt(this.distX * this.distX + this.distY * this.distY);
                if (this.dist > 8)
                {
                    this.distX *= 8 / this.dist;
                    this.distY *= 8 / this.dist;
                }
                moveRL += (this.distX - moveRL) * 0.05;
                moveUD += (this.distY - moveUD) * 0.05;
                this.distX = Char.CharArray[0].x - x;
                this.distY = Char.CharArray[0].y - y;
                this.dist = Math.sqrt(this.distX * this.distX + this.distY * this.distY);
                if (this.dist < 800)
                {
                    if (this.dist < 200)
                    {
                        this.dist = 200;
                    }
                    Main.shakeScreen((800 - this.dist) * 0.02, 0, true);
                    Sounds.updateSound(currentSound, x, (800 - this.dist) * 0.01, 0);
                }
            }
            else
            {
                --smokeB;
                this.dist = Math.sqrt(moveRL * moveRL + moveUD * moveUD);
                if (this.dist > 20)
                {
                    moveRL *= 20 / this.dist;
                    moveUD *= 20 / this.dist;
                }
                moveRL *= 0.9;
                moveUD *= 0.9;
            }
        }
    }
    
    override public function stunJumpEnterFrame() : Void
    {
        rotter += -rotation * 0.5;
        rotter *= 0.5;
        moveRL *= 0.9;
        moveUD *= 0.9;
    }
    
    override public function deadJumpEnterFrame() : Void
    {
        var rand : Float = Math.NaN;
        rotter *= 0.95;
        if (FloatUp > 0)
        {
            --FloatUp;
        }
        else
        {
            ++moveUD;
        }
        if (smokeB > 0)
        {
            --smokeB;
            if (smokeN > 0)
            {
                --smokeN;
            }
            else
            {
                rand = Math.random() * 0.5 + 0.5;
                StarlingEffect.Spawn("smokePuff", footX(), footY(), Math.random() * 3, -scaleX * rand, cast((-2 * rand), UDx), cast((-2 * rand), UDy), onRail);
                smokeN = 2;
            }
        }
        else
        {
            StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, (scale - 0.5) * 0.4 + 0.4, moveRL, moveUD, onRail);
            killBaddies.push(this);
        }
    }
    
    override public function Projectile(ex : Dynamic, ey : Dynamic, eRL : Dynamic) : Bool
    {
        eRL = eRL;
        rotter += eRL * 0.05;
        Sounds.playSound("InkSplat", x, 1, onRail);
        if (Math.abs(moveRL) < 20 || moveRL * eRL < 0)
        {
            moveRL += (eRL * 0.2 - moveRL) * 0.8;
        }
        fakeRL = moveRL;
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
            facing = makeOne(ex - eRL - x);
        }
        else
        {
            facing = makeOne(moveRL);
            if (facing * rotation < 0)
            {
                rotation *= -1;
            }
        }
        if (attackN == 1)
        {
            if (facing > 0)
            {
                this.baddie.horn1.visible = true;
                this.baddie.horn2.visible = false;
            }
            else
            {
                this.baddie.horn1.visible = false;
                this.baddie.horn2.visible = true;
            }
        }
        scaleX = scale * facing;
        smokeN = 0;
        smokeB = 20;
        return true;
    }
    
    public function boss2GetAttacked(ex : Float, ey : Float, angle : Float, char : Collision, hitMove : String, hitPower : Float, pow : Float = 1) : Bool
    {
        char.hitPause = hitPause = hitPower * 0.1 + 1;
        facing = makeOne(char.x - x);
        scaleX = scale * facing;
        if (attackN == 1)
        {
            if (facing > 0)
            {
                this.baddie.horn1.visible = true;
                this.baddie.horn2.visible = false;
            }
            else
            {
                this.baddie.horn1.visible = false;
                this.baddie.horn2.visible = true;
            }
        }
        getAttackedShared(ex, ey, angle, char, hitMove, hitPower);
        Sounds.playSound("InkSplat", x, 1, 0);
        if (hitPower > 20)
        {
            if (char.Status == "Pencil" || grounded)
            {
                char.fakeRL = char.moveRL = scaleX * 4;
            }
            else
            {
                char.moveRL = char.scaleX * 2;
            }
        }
        rotter *= 0.1;
        return true;
    }
    
    override public function cleanUp() : Void
    {
        Sounds.stopSound(currentSound);
    }
}


