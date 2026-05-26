import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol7768"))

class Baddie1 extends Baddies
{
    
    public var baddie : MovieClip;
    
    public var stars : MovieClip;
    
    private var faceN : Int;
    
    private var concernedN : Int = -1;
    
    private var freeze : Bool;
    
    private var lifetimeN : Int = -1;
    
    public function new(p : Dynamic)
    {
        var i : String = null;
        onKilled = p.onKilled;
        spawner = p.spawner;
        if (p.hatN < 0)
        {
            p.hatN = 0;
        }
        super(30 * Math.abs(p.scaleY), 20 * Math.abs(p.scaleY), p.onRail);
        for (i in Reflect.fields(p))
        {
            if (i != "componentInspectorSetting")
            {
                Reflect.setField(this, i, Reflect.field(p, i));
            }
        }
        while (groundHitTest(p.x, p.y + isTall * 0.8))
        {
            --p.y;
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
        scaleY = scale = Math.abs(p.scaleY);
        scaleX = scale * facing;
        BallRes = 6;
        bounce = 0.5;
        bounceThresh = 20;
        maxRL = 6 / ((scale - 1) * 0.5 + 1);
        springy = 10;
        stunMax = 120;
        health = as3hx.Compat.parseInt(isTall * isWide / 15);
        power = scale + 0.5;
        if (health > 500)
        {
            health = 500;
        }
        if (power > 2.5)
        {
            power = 2.5;
        }
        healthMax = health;
        if (scale > 4)
        {
            retreatThresh = health - 50 - Math.random() * 50;
        }
        else
        {
            retreatThresh = 0;
        }
        attackN = -1;
        rotPerc = 360 / (Math.PI * (isTall * 2));
        springTall = isTall * 2;
        overReach = 5;
        knockback = 0.5;
        spring = 0;
        if (scale > 2)
        {
            grounded = true;
        }
        launchThresh = mass * 0.6;
        attentionRange = 300 + isWide * 2;
        if (tether == -1)
        {
            tether = 10000;
        }
        if (tether > 800)
        {
            insomnia = true;
        }
        currentHitChar = inkyHitChar;
        springBounce = standardSpringBounce;
        if (scale < 2.5)
        {
            visible = false;
            smokeName = "Baddie1Smoke";
        }
        backEffect = hasSmoke;
        if (moveUD != 0)
        {
            cast(("Drop"), ChangeFrame);
            if (moveUD > 10)
            {
                this.baddie.gotoAndStop(this.baddie.totalFrames);
            }
            if (hasSmoke)
            {
                currentSmoke.currentFrame = 120 + this.baddie.currentFrame;
            }
        }
        else if (insomnia)
        {
            cast(("Walk"), ChangeFrame);
        }
        else
        {
            cast(("Wait"), ChangeFrame);
        }
        placeSmoke();
    }
    
    override public function chooseCharInteract(frame : Dynamic) : Void
    {
        ledgeTimer = 10;
        if (groundStatus(frame))
        {
            moveSpringBounce = standardIdleMoveBounce;
        }
        else
        {
            moveSpringBounce = standardMoveSpringBounce;
        }
        if (!hasSmoke)
        {
            smokeFrameOffset = -1;
        }
        else if (frame == "Wait" || frame == "Idle")
        {
            smokeFrameOffset = 190;
        }
        else if (frame == "Walk" || frame == "Crouch" || frame == "Freeze")
        {
            smokeFrameOffset = 0;
        }
        else if (frame == "Jump")
        {
            smokeFrameOffset = 82;
        }
        else if (frame == "Land")
        {
            smokeFrameOffset = 104;
        }
        else if (frame == "Hit")
        {
            smokeFrameOffset = 116;
        }
        else if (frame == "stunJump")
        {
            smokeFrameOffset = 117;
        }
        else if (frame == "deadJump")
        {
            smokeFrameOffset = 118;
        }
        else if (frame == "Drop")
        {
            smokeFrameOffset = 119;
        }
        else if (frame == "Sink" || frame == "unSink")
        {
            smokeFrameOffset = 156;
        }
        if (hasSmoke && RedHurt > 0)
        {
            visible = true;
        }
        switch (frame)
        {
            case "Wait":
                scaleX = makeOne(scaleX) * scale;
                scaleY = Math.abs(scaleX);
                spring = 0;
                this.baddie.gotoAndStop(this.baddie.totalFrames);
            case "Jump", "Drop":
                Sounds.playSound("InkJump", x, 1, onRail);
                wallRot = 0;
                rotation = -Math.atan2(-moveRL, -moveUD) / (Math.PI / 180);
                springBounce = standardSpringBounce;
                this.baddie.x = this.baddie.y = 0;
                if (hasSmoke)
                {
                    currentSmoke.pivotY = 0;
                }
            case "Crouch", "Idle", "Land", "Walk", "Freeze":

                switch (frame)
                {case "Crouch":
                        springTall = isTall * 2;
                }

                switch (frame)
                {case "Idle":
                        if (Status == "Idle" || Status == "Wait")
                        {
                            this.baddie.gotoAndStop(this.baddie.totalFrames);
                        }
                }

                switch (frame)
                {case "Land":
                        Sounds.playSound("InkLand", x, 1, onRail);
                }
                rotter = 0;
                springBounce = standardIdleBounce;
                if (hasSmoke)
                {
                    currentSmoke.pivotY = 20;
                }
                currentHitChar = inkyHitChar;
            case "deadJump", "stunJump", "Hit":
                wallRot = 0;
                if (rotter * facing > 0)
                {
                    facing *= -1;
                    scaleX *= -1;
                }
                springBounce = standardSpringBounce;
                currentHitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : String
                        {
                        };
                this.baddie.x = this.baddie.y = 0;
                if (hasSmoke)
                {
                    currentSmoke.pivotY = 0;
                }
            case "Stunned":
            case "unSink", "Sink":

                switch (frame)
                {case "unSink":
                        Sounds.playSound("InkJump", x, 1, onRail);
                        this.baddie.gotoAndStop(34);
                }
                if (showHealthBar)
                {
                    healthBarSmoke.goSwim();
                    healthBarOutlineSmoke.goSwim();
                    healthBarSmoke = healthBarOutlineSmoke = null;
                    showHealthBar = false;
                }
        }
        smokeSetFrame();
    }
    
    public function WaitEnterFrame() : Dynamic
    {
        if (inRange())
        {
            tilRangeCheck = 100;
            if (this.freeze)
            {
                cast(("Freeze"), ChangeFrame);
                Status = "Wait";
            }
            else if (autopilot)
            {
                cast(("Walk"), ChangeFrame);
            }
            else
            {
                cast(("Idle"), ChangeFrame);
            }
            if (Main.LevelLoaded == "Lockd3")
            {
                transform.colorTransform = Main.getColorTransform(-1);
            }
        }
    }
    
    public function IdleEnterFrame() : Dynamic
    {
        if (autopilot)
        {
            cast(("Walk"), ChangeFrame);
        }
        else
        {
            spring *= 0.9;
            if (onLedge * fakeRL > 0)
            {
                if (Math.abs(fakeRL) > 2)
                {
                    fakeRL -= makeOne(2);
                }
                else
                {
                    facing *= -1;
                    scaleX *= -1;
                    fakeRL *= -1;
                }
            }
            else if (fakeRL * facing > 0.2)
            {
                fakeRL -= facing * 0.2;
            }
            else
            {
                fakeRL = 0;
            }
            if (CharRail == onRail && Math.abs(CharX - x) < attentionRange && Math.abs(CharY - y) < attentionRange * 1.5)
            {
                if (this.baddie.currentFrame == 1)
                {
                    cast(("Walk"), ChangeFrame);
                }
                else
                {
                    setFacing(makeOne(CharX - x));
                    this.baddie.prevFrame();
                    this.baddie.prevFrame();
                }
            }
            else
            {
                this.baddie.nextFrame();
            }
            smokeSetFrame();
        }
        if (!insomnia)
        {
            if (tilRangeCheck > 0)
            {
                --tilRangeCheck;
            }
            else if (inRange())
            {
                tilRangeCheck = 100;
            }
            else
            {
                cast(("Wait"), ChangeFrame);
            }
        }
    }
    
    public function WalkEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            this.baddie.gotoAndStop(1);
        }
        smokeSetFrame();
        if (CharRail == onRail)
        {
            CharDistX = CharX - x;
        }
        else
        {
            CharDistX = 2000;
        }
        if (this.lifetimeN > 0)
        {
            --this.lifetimeN;
        }
        if (Math.abs(fakeRL) > maxRL)
        {
            if (Math.abs(fakeRL) > maxRL + scale + 1.5)
            {
                fakeRL -= makeOne(fakeRL) * (scale + 1.5);
            }
            else
            {
                fakeRL = makeOne(fakeRL) * maxRL;
            }
        }
        else
        {
            if (onLedge * fakeRL > 0)
            {
                if (autopilot || CharDistX * fakeRL > 0 && Math.abs(CharDistX) < attentionRange * 0.8 && Math.abs(x - originX) < tether)
                {
                    aPlatOn = null;
                    moveRL = onLedge * 8;
                    moveUD = -8 - 6 * Math.random();
                    cast(("Jump"), ChangeFrame);
                }
                else if (Math.abs(fakeRL) > maxRL / 10)
                {
                    fakeRL -= maxRL * onLedge / 10;
                }
                else
                {
                    setFacing(-onLedge);
                }
            }
            else if (Math.abs(x - originX) > tether && (originX - x) * facing < 0)
            {
                if (Math.abs(fakeRL) > maxRL / 20)
                {
                    fakeRL -= maxRL * makeOne(fakeRL) / 20;
                }
                else
                {
                    setFacing(makeOne(originX - x));
                }
            }
            else if (fakeRL != facing * maxRL)
            {
                if (Math.abs(fakeRL - facing * maxRL) > maxRL / 20)
                {
                    if (fakeRL * facing > maxRL)
                    {
                        fakeRL -= maxRL * facing / 20;
                    }
                    else
                    {
                        fakeRL += maxRL * facing / 20;
                    }
                }
                else
                {
                    fakeRL = facing * maxRL;
                }
            }
            if (fakeRL * facing < 0)
            {
                fakeRL *= 0.8;
            }
            if (retreatThresh > health)
            {
                this.lifetimeN = 0;
                if (this.baddie.currentFrame < 37 || this.baddie.currentFrame > 63)
                {
                    cast(("Sink"), ChangeFrame);
                }
            }
            else if (this.lifetimeN == 0)
            {
                if (this.baddie.currentFrame < 37 || this.baddie.currentFrame > 63)
                {
                    cast(("Sink"), ChangeFrame);
                }
            }
            else if (Math.abs(CharDistX) < attentionRange * 0.5 && Math.abs(CharY - y) < 100 + isTall && CharDistX * facing > 0)
            {
                if (attackN > 0)
                {
                    --attackN;
                }
                else if (attackN < 0)
                {
                    attackN = mass * 0.05 + Math.random() * mass * 0.05;
                }
                else
                {
                    spring = -7 * scale;
                    cast(("Crouch"), ChangeFrame);
                    attackN = -1;
                }
            }
            else if (autopilot)
            {
                attackN = -1;
            }
            else if (Math.abs(CharDistX) > attentionRange * 1.5 && Math.abs(CharY - y) < attentionRange * 2 && Math.abs(x - originX) > tether)
            {
                cast(("Idle"), ChangeFrame);
            }
            else
            {
                attackN = -1;
            }
        }
        if (!insomnia)
        {
            if (tilRangeCheck > 0)
            {
                --tilRangeCheck;
            }
            else if (inRange())
            {
                tilRangeCheck = 100;
            }
            else
            {
                cast(("Wait"), ChangeFrame);
            }
        }
        if (scaleX * facing < 0)
        {
            scaleX *= -1;
        }
        ++ledgeTimer;
    }
    
    public function CrouchEnterFrame() : Dynamic
    {
        if (Math.abs(fakeRL) > maxRL)
        {
            if (Math.abs(fakeRL) > maxRL + scale + 1.5)
            {
                fakeRL -= makeOne(fakeRL) * (scale + 1.5);
            }
            else
            {
                fakeRL = makeOne(fakeRL) * maxRL;
            }
        }
        else
        {
            if (onLedge * fakeRL > 0)
            {
                if (Math.abs(fakeRL) > 2)
                {
                    fakeRL -= makeOne(2);
                }
                else
                {
                    facing *= -1;
                    scaleX *= -1;
                    fakeRL *= -1;
                }
            }
            else if (fakeRL != 0)
            {
                if (fakeRL * facing > maxRL * 0.2)
                {
                    fakeRL -= maxRL * facing * 0.2;
                }
                else
                {
                    fakeRL = 0;
                }
            }
            spring += 2;
            if (spring > 0 && springTall + spring > originalSpringTall)
            {
                spring = 0;
                fakeRL = facing * (10 + scale * 2);
                simpleJump(8);
            }
        }
    }
    
    public function SinkEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        smokeSetFrame();
        if (showHealthBar)
        {
            healthBarSmoke.goSwim();
            healthBarOutlineSmoke.goSwim();
            healthBarSmoke = healthBarOutlineSmoke = null;
            showHealthBar = false;
        }
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            if (temporary)
            {
                killBaddies.push(this);
            }
            else
            {
                downTime = 5;
                fakeRL += (facing * 50 - fakeRL) * 0.1;
                if (Math.random() < 0.05)
                {
                    new BaddiePuddle({
                        ItIs : baddiePuddle,
                        x : footX(),
                        y : footY(),
                        scaleX : 6,
                        scaleY : 3,
                        rotation : rotation,
                        onRail : onRail,
                        badArray : [1, 1, 1],
                        baddieN : 3
                    });
                }
                if (this.lifetimeN == 0)
                {
                    currentHitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : Dynamic
                            {
                            };
                    this.lifetimeN = -1;
                }
                else if (this.lifetimeN > -10)
                {
                    --this.lifetimeN;
                    if (onWall != 0 || onWallPlat != 0)
                    {
                        facing *= -1;
                    }
                }
                else if (CharRail == onRail && Math.abs(CharX - x) < attentionRange * 0.6)
                {
                    if (onWall != 0 || onWallPlat != 0)
                    {
                        facing *= -1;
                    }
                }
                else
                {
                    if (retreatThresh > health)
                    {
                        retreatThresh = health - 80 - Math.random() * 20;
                    }
                    visible = true;
                    facing = makeOne(CharX - x);
                    if (scaleX * facing < 0)
                    {
                        scaleX *= -1;
                    }
                    cast(("unSink"), ChangeFrame);
                }
                downTime = 10;
            }
        }
        else if (onLedge * fakeRL > 0)
        {
            if (Math.abs(fakeRL) > 2)
            {
                fakeRL -= makeOne(2);
            }
            else
            {
                facing *= -1;
                scaleX *= -1;
                fakeRL *= -1;
            }
        }
        else if (fakeRL != 0)
        {
            if (Math.abs(fakeRL) > 0.1)
            {
                fakeRL -= makeOne(fakeRL) * 0.1;
            }
            else
            {
                fakeRL = 0;
            }
        }
    }
    
    public function unSinkEnterFrame() : Dynamic
    {
        if (Math.abs(fakeRL) > 5)
        {
            fakeRL -= makeOne(fakeRL) * 5;
        }
        if (this.baddie.currentFrame == 1)
        {
            currentHitChar = inkyHitChar;
            cast(("Idle"), ChangeFrame);
        }
        else
        {
            this.baddie.prevFrame();
            if (this.baddie.currentFrame > 8)
            {
                this.baddie.prevFrame();
            }
            smokeSetFrame();
        }
    }
    
    public function FreezeEnterFrame() : Dynamic
    {
    }
    
    public function JumpEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            this.baddie.gotoAndStop("loop");
        }
        smokeSetFrame();
        rotter = rotCompare(-Math.atan2(-moveRL, -moveUD) / (Math.PI / 180), rotation);
        if (facing * moveRL < 0)
        {
            facing *= -1;
            if (scaleX * facing < 0)
            {
                scaleX *= -1;
            }
        }
        if (moveUD < 15)
        {
            ++moveUD;
        }
    }
    
    public function DropEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        if (moveUD < 0 && this.baddie.currentFrame == 21)
        {
            this.baddie.gotoAndStop(3);
        }
        smokeSetFrame();
        rotter = rotCompare(-Math.atan2(-moveRL, -moveUD) / (Math.PI / 180), rotation);
        if (Math.abs(rotter) > 10)
        {
            makeOne(rotter) * 10;
        }
        if (facing * moveRL < 0)
        {
            facing *= -1;
            if (scaleX * facing < 0)
            {
                scaleX *= -1;
            }
        }
        if (moveUD < 15)
        {
            ++moveUD;
        }
    }
    
    public function LandEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        smokeSetFrame();
        slopeStuff();
        slideSlow(2);
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            cast(("Idle"), ChangeFrame);
        }
    }
    
    override public function deadJumpEnterFrame() : Void
    {
        var rand : Float = Math.NaN;
        this.baddie.nextFrame();
        smokeSetFrame();
        if (Math.abs(rotter) > 40)
        {
            rotter *= 0.95;
        }
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
            Sounds.playSound("InkBurst", x, scale * 1.2, onRail);
            StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, (scale - 0.5) * 0.4 + 0.6, moveRL, moveUD, onRail);
            Main.shakeScreen(6 * scale, 0, true);
            killBaddies.push(this);
        }
    }
}


