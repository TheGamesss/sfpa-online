import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol6138"))

class Ninja extends Baddies
{
    
    public var baddie : MovieClip;
    
    public var stars : MovieClip;
    
    private var popN : Int = 0;
    
    private var freeze : Bool;
    
    public function new(p : Dynamic)
    {
        var i : String = null;
        super(15, 15, p.onRail);
        for (i in Reflect.fields(p))
        {
            if (i != "componentInspectorSetting")
            {
                Reflect.setField(this, i, Reflect.field(p, i));
            }
        }
        originX = x = p.x;
        originY = y = p.y;
        wallRot = rotation = p.rotation;
        facing = scx = scaleX = p.scaleX;
        BallRes = 10;
        bounce = 0;
        bounceThresh = 100;
        launchThresh = 20;
        maxRL = 4;
        springy = 3;
        springDecay = 0.8;
        stunMax = 0;
        health = healthMax = 60;
        rotPerc = 0.2;
        overReach = 5;
        this.popN = Math.random() * 20;
        currentHitChar = standardHitChar;
        springBounce = standardSpringBounce;
        smokeName = "NinjaSmoke";
        visible = false;
        cast(("Wait"), ChangeFrame);
    }
    
    override public function chooseCharInteract(frame : Dynamic) : Void
    {
        if (groundStatus(frame))
        {
            if (hasSmoke)
            {
                currentSmoke.pivotY = 15;
            }
        }
        else if (hasSmoke)
        {
            currentSmoke.pivotY = 0;
        }
        if (!hasSmoke)
        {
            smokeFrameOffset = -1;
        }
        else if (frame == "Idle")
        {
            smokeFrameOffset = 0;
        }
        else if (frame == "Jump")
        {
            smokeFrameOffset = 28;
        }
        else if (frame == "Land")
        {
            smokeFrameOffset = 69;
        }
        else if (frame == "Attack")
        {
            smokeFrameOffset = 86;
        }
        else if (frame == "stunJump" || frame == "Hit" || frame == "deadJump")
        {
            smokeFrameOffset = 133;
        }
        switch (frame)
        {
            case "Wait":
                spring = 0;
                cleanUp();
            case "Jump":
                if (moveUD < -5)
                {
                    Sounds.playSound("NinjaJump", x, 1.5, onRail);
                }
            case "Stomped":
                springy = 5;
                springdecay = 0.92;
                scaleX = makeOne(scaleX);
                scaleY = 1;
                moveSpringBounce = stompedMoveSpringBounce;
            case "deadJump":
                Sounds.playSound("NinjaDie", x, 1, onRail);
                currentHitChar = standardBeABall;
                scaleX = makeOne(scaleX);
                scaleY = 1;
                spring = 0;
                springTall = originalSpringTall;
                moveSpringBounce = function() : Dynamic
                        {
                        };
            default:
                scaleX = makeOne(scaleX);
                scaleY = 1;
                spring = 0;
                springTall = originalSpringTall;
                moveSpringBounce = function() : Dynamic
                        {
                        };
        }
        smokeSetFrame();
    }
    
    private function checkPop() : Bool
    {
        var dist : Int = 0;
        var originDist : Int = 0;
        if (this.popN > 0)
        {
            --this.popN;
            return false;
        }
        spring = 0;
        this.popN = Math.random() * 20;
        dist = Char.checkClosest(x, y, onRail);
        if (dist == 1000)
        {
            moveRL = facing * 5;
            simpleJump(10);
            return true;
        }
        if (Math.abs(dist) < 400)
        {
            if (Math.random() < 0.8)
            {
                if (dist != 0)
                {
                    fakeRL = dist / 30;
                    facing = scaleX = makeOne(fakeRL);
                }
                simpleJump(10);
            }
            else
            {
                if (dist != 0)
                {
                    fakeRL = dist / 20;
                    facing = scaleX = makeOne(fakeRL);
                }
                simpleJump(15);
            }
            return true;
        }
        originDist = as3hx.Compat.parseInt(originX - x);
        if (originDist == 0)
        {
            moveRL = Math.random() * 6 - 3;
        }
        else
        {
            moveRL = makeOne(originDist) * Math.random() * 5;
        }
        moveUD = -(5 + Math.random() * 10);
        cast(("Jump"), ChangeFrame);
        return true;
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
    
    public function FadeInEnterFrame() : Dynamic
    {
        if (alpha < 1)
        {
            alpha += 0.05;
        }
        else
        {
            alpha = 1;
            cast(("Jump"), ChangeFrame);
        }
    }
    
    public function IdleEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        if (this.baddie.currentFrameLabel == "a")
        {
            this.baddie.gotoAndStop("loop");
        }
        smokeSetFrame();
        slideSlow(1);
        if (!this.checkPop())
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
    
    public function ChargeEnterFrame() : Dynamic
    {
        fakeRL += (facing * 12 - fakeRL) * 0.2;
    }
    
    public function FreezeEnterFrame() : Dynamic
    {
    }
    
    public function JumpEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        rotter *= 0.92;
        if (Math.abs(rotter) < 5 && this.baddie.currentFrame > 10)
        {
            rotter = 0;
            rotation *= 0.9;
        }
        ++moveUD;
        if (this.baddie.currentFrame < 11 && moveUD < 0)
        {
            this.baddie.nextFrame();
        }
        var _sw31_ = (this.baddie.currentFrame);        

        switch (_sw31_)
        {
            case 10:
                if (moveUD < -4)
                {
                    this.baddie.prevFrame();
                }
            case this.baddie.totalFrames:
                this.baddie.gotoAndStop("loop");
        }
        smokeSetFrame();
        if (tilRangeCheck > 0)
        {
            --tilRangeCheck;
        }
        else if (inRange())
        {
            tilRangeCheck = 100;
        }
    }
    
    public function LandEnterFrame() : Dynamic
    {
        var dist : Int = 0;
        this.baddie.nextFrame();
        slopeStuff();
        slideSlow(1);
        smokeSetFrame();
        if (!this.checkPop())
        {
            if (this.baddie.currentFrameLabel == "a")
            {
                dist = Char.checkClosest(x, y, onRail);
                if (Math.abs(dist) < 150 && dist != 0)
                {
                    scaleX = facing = makeOne(dist);
                    cast(("Attack"), ChangeFrame);
                    this.baddie.gotoAndStop(5);
                    smokeSetFrame();
                }
            }
            else if (this.baddie.currentFrame == this.baddie.totalFrames)
            {
                cast(("Idle"), ChangeFrame);
            }
        }
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
    
    public function AttackEnterFrame() : Dynamic
    {
        var dist : Int = 0;
        this.baddie.nextFrame();
        smokeSetFrame();
        if (this.baddie.currentFrame == 38)
        {
            Sounds.playSound("NinjaSwipe", x, 1, onRail);
        }
        if (this.baddie.currentFrameLabel == "b")
        {
            if (Char.checkAttackFromBad(x, y, 100, isTall, scaleX, 70, 20) || aWall.checkAttackFromBad(x, y, 100, isTall, scaleX, 70, 20))
            {
                hitPause = 3;
            }
        }
        if (this.baddie.currentFrame > 26 && this.baddie.currentFrame < 43)
        {
            dist = Char.checkClosest(x, y, onRail);
            if (Math.abs(dist) < 50)
            {
                fakeRL = 0;
            }
            else if (Math.abs(fakeRL) < 10)
            {
                fakeRL += facing;
            }
        }
        else if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            cast(("Land"), ChangeFrame);
        }
        else
        {
            slopeStuff();
            slideSlow(1);
        }
    }
    
    override public function stunJumpEnterFrame() : Void
    {
        this.baddie.nextFrame();
        smokeSetFrame();
        if (Math.abs(rotter) > 15)
        {
            rotter *= 0.8;
        }
        if (moveUD < 30)
        {
            moveUD += 2;
        }
        if (Math.abs(moveRL) > 20)
        {
            moveRL *= 0.96;
        }
        if (Math.abs(moveUD) > 20)
        {
            moveUD *= 0.9;
        }
        smokeTrail();
    }
    
    public function StunnedEnterFrame() : Dynamic
    {
        var rand : Float = Math.NaN;
        this.baddie.nextFrame();
        this.stars.nextFrame();
        this.stars.scaleX = this.stars.scaleY = stunN / stunMax;
        slopeStuff();
        slideSlow(1);
        if (smokeN > 0)
        {
            smokeN -= Math.abs(fakeRL);
        }
        else
        {
            rand = Math.random() * 0.5 + 0.5;
            StarlingEffect.Spawn("smokePuff", footX(), footY(), wallAngle - Math.random() * 0.2 * scaleX, -scaleX * rand, cast((-2 * rand), UDx), cast((-2 * rand), UDy), onRail);
            smokeN = 20;
        }
        if (stunN > 0)
        {
            --stunN;
        }
        else if (this.baddie.currentFrame < 45)
        {
            this.baddie.gotoAndStop("shake");
        }
        if (this.stars.currentFrame == this.stars.totalFrames)
        {
            this.stars.gotoAndStop(1);
        }
        if (this.baddie.currentFrameLabel == "1")
        {
            this.baddie.gotoAndStop("loop");
        }
        else if (this.baddie.currentFrameLabel == "2")
        {
            cast(("Idle"), ChangeFrame);
        }
    }
}


