import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol5669"))

class Spider extends Baddies
{
    
    public var baddie : MovieClip;
    
    public var stars : MovieClip;
    
    private var faceN : Int;
    
    private var concernedN : Int = -1;
    
    private var freeze : Bool;
    
    private var startStatus : String = "nothing";
    
    public function new(p : Dynamic)
    {
        var i : String = null;
        super(40, 15, p.onRail);
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
        maxRL = 4;
        springy = 3;
        springDecay = 0.9;
        stunMax = 120;
        BallRes = 6;
        bounce = 0.5;
        bounceThresh = 8;
        springThresh = 2;
        if (cast(this.freeze, Bool) || Main.LevelStatus != "Normal")
        {
            health = 1;
        }
        else
        {
            health = healthMax = 40;
        }
        rotPerc = 360 / (Math.PI * (isTall * 2));
        overReach = 5;
        camDistU = 100;
        if (hatN > 100 || hatN < 0 || Main.localSettings.hasHatsString.substr(hatN - 1, 1) == "y" || !Main.hasFull())
        {
            hatN = 0;
        }
        currentHitChar = standardHitChar;
        springBounce = standardSpringBounce;
        if (hatN > 0)
        {
            this.faceN = 10;
        }
        if (this.startStatus == "fadeIn")
        {
            alpha = -0.3;
            cast(("FadeIn"), ChangeFrame);
            Status = "Wait";
            Backgrounds.backgroundsArray[onRail].addChild(this);
            tilRangeCheck = 100;
            bounce = 0;
        }
        else if (moveUD > 0)
        {
            visible = false;
            smokeName = "SpiderSmoke";
            cast(("Jump"), ChangeFrame);
            this.baddie.gotoAndStop("loop");
            bounce = 0;
        }
        else
        {
            if (hatN <= 0)
            {
                visible = false;
                smokeName = "SpiderSmoke";
            }
            cast(("Wait"), ChangeFrame);
        }
    }
    
    override public function chooseCharInteract(frame : Dynamic) : Void
    {
        if (frame != "Idle" && frame != "Freeze")
        {
            gonnaStomp = function(e : Dynamic) : Dynamic
                    {
                    };
        }
        if (frame != "Wait")
        {
            if (groundStatus(frame))
            {
                springy = 5;
                springdecay = 0.92;
                scaleX = makeOne(scaleX);
                scaleY = 1;
                moveSpringBounce = stompedMoveSpringBounce;
                if (hasSmoke)
                {
                    currentSmoke.pivotY = 15;
                }
            }
            else
            {
                springy = 3;
                springDecay = 0.85;
                this.baddie.scaleX = 1;
                this.baddie.scaleY = 1;
                this.baddie.y = 0;
                moveSpringBounce = standardMoveSpringBounce;
                if (hasSmoke)
                {
                    currentSmoke.pivotY = 0;
                }
                wallRot = 0;
            }
        }
        if (!hasSmoke)
        {
            smokeFrameOffset = -1;
        }
        else if (frame == "Walk")
        {
            smokeFrameOffset = 0;
        }
        else if (frame == "Stomped")
        {
            smokeFrameOffset = 60;
        }
        else if (frame == "Stunned")
        {
            smokeFrameOffset = 61;
        }
        else if (frame == "Hit" || frame == "stunJump")
        {
            smokeFrameOffset = 125;
        }
        else if (frame == "deadJump")
        {
            smokeFrameOffset = 133;
        }
        else if (frame == "Land")
        {
            smokeFrameOffset = 146;
        }
        else if (frame == "Jump")
        {
            smokeFrameOffset = 158;
        }
        else if (frame == "Freeze")
        {
            smokeFrameOffset = 191;
        }
        else if (frame == "Wait")
        {
            smokeFrameOffset = -1;
        }
        else
        {
            smokeFrameOffset = 0;
        }
        switch (frame)
        {
            case "Wait":
                spring = 0;
            case "Jump":
                isWide = 40;
                currentHitChar = standardHitChar;
                isABall = false;
                this.baddie.head.gotoAndStop(24);
                this.setupHat();
            case "Land":
                canAggressor = false;
                if (Lambda.indexOf(AggressorArray, this) > -1)
                {
                    AggressorArray.splice(Lambda.indexOf(AggressorArray, this), 1);
                }
                isWide = 40;
                currentHitChar = standardHitChar;
                isABall = false;
                this.baddie.head.gotoAndStop(24);
                if (moveRL != 0)
                {
                    facing = makeOne(moveRL);
                    scaleX = scale * facing;
                }
                else
                {
                    facing = makeOne(scaleX);
                }
                this.setupHat();
            case "Idle", "Freeze":
                this.setupHat();
                rotter = 0;
                isWide = 40;
                springThresh = 0;
                currentHitChar = standardHitChar;
                isABall = false;
                if (this.concernedN > 0)
                {
                    this.baddie.head.gotoAndStop(11);
                }
                else
                {
                    this.baddie.head.gotoAndStop(this.faceN);
                }
                gonnaStomp = this.gonnaStompHalp;
            case "deadJump", "stunJump":

                switch (frame)
                {case "deadJump":
                        Sounds.playSound("SpiderDie", x, 1, onRail);
                        onGround = false;
                }
                if (Math.abs(moveRL) > 10 || Math.abs(moveUD) > 15)
                {
                    canAggressor = true;
                    if (Lambda.indexOf(AggressorArray, this) == -1)
                    {
                        AggressorArray.push(this);
                    }
                }
                isWide = 25;
                springThresh = 3;
                currentHitChar = standardBeABall;
                isABall = true;
                if (lastStomped != null)
                {
                    this.concernedN = 120;
                }
                this.faceN = 1;
            case "Stunned":
                canAggressor = false;
                if (Lambda.indexOf(AggressorArray, this) > -1)
                {
                    AggressorArray.splice(Lambda.indexOf(AggressorArray, this), 1);
                }
                this.stars.stop();
                isWide = 25;
                springThresh = 0;
                currentHitChar = standardBeABall;
                isABall = true;
                if (lastStomped != null)
                {
                    this.concernedN = 120;
                }
                this.faceN = 1;
                if (moveRL != 0)
                {
                    facing = makeOne(moveRL);
                    scaleX = scale * facing;
                }
                else
                {
                    facing = makeOne(scaleX);
                }
            case "Stomped", "Hit":
            case "FadeIn":
                this.baddie.head.gotoAndStop(24);
                this.setupHat();
        }
        smokeSetFrame();
    }
    
    private function setupHat() : Dynamic
    {
        if (hatN == 0)
        {
            this.baddie.head.hat.gotoAndStop(1);
            this.baddie.head.hat.visible = false;
        }
        else
        {
            this.baddie.head.hat.gotoAndStop(hatN);
        }
    }
    
    override public function wearHat(n : Int) : Bool
    {
        if (Status == "Idle")
        {
            hatN = n;
            this.baddie.head.hat.gotoAndStop(n);
            this.baddie.head.hat.visible = true;
            visible = true;
            Backgrounds.backgroundsArray[onRail].addChild(this);
            cleanUp();
            return true;
        }
        return false;
    }
    
    override public function loseHat() : Void
    {
        hatN = 0;
        parent.removeChild(this);
        visible = false;
        smokeName = "SpiderSmoke";
        currentSmoke = StarlingSmoke.Spawn("SpiderSmoke", x, y, 0, 1, 0, 0, onRail);
        hasSmoke = true;
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
                this.baddie.gotoAndStop(as3hx.Compat.parseInt(Math.random() * 50));
            }
            smokeSetFrame();
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
            this.loseHat();
            cast(("Jump"), ChangeFrame);
        }
    }
    
    public function IdleEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        this.animateFace();
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            this.baddie.gotoAndStop("loop");
        }
        smokeSetFrame();
        if (fakeRL != facing * maxRL)
        {
            if (Math.abs(fakeRL - facing * maxRL) > maxRL / 4)
            {
                if (fakeRL > facing * maxRL)
                {
                    fakeRL -= maxRL / 4;
                }
                else
                {
                    fakeRL += maxRL / 4;
                }
            }
            else
            {
                fakeRL = facing * maxRL;
            }
        }
        if (scaleX * wallRot < -50)
        {
            facing *= -1;
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
    
    public function FreezeEnterFrame() : Dynamic
    {
        this.animateFace();
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
        if (this.baddie.currentFrame > 6 && moveUD < 0)
        {
            this.baddie.gotoAndStop("short");
        }
        var _sw33_ = (this.baddie.currentFrame);        

        switch (_sw33_)
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
        if (fallOffscreen())
        {
            killBaddies.push(this);
        }
    }
    
    public function LandEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        smokeSetFrame();
        slopeStuff();
        slideSlow(1);
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            cast(("Idle"), ChangeFrame);
        }
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
        smokeSetFrame();
    }
    
    private function animateFace() : Dynamic
    {
        if (this.baddie.head.currentFrame > 23)
        {
            if (this.baddie.head.currentFrame == 29)
            {
                this.baddie.head.gotoAndStop(this.faceN);
            }
            else
            {
                this.baddie.head.nextFrame();
            }
        }
        else if (this.baddie.head.currentFrame > 11)
        {
            if (this.baddie.head.currentFrame == 23)
            {
                this.concernedN = 60;
                this.baddie.head.gotoAndStop(11);
            }
            else
            {
                this.baddie.head.nextFrame();
                this.baddie.head.eyeL.rotation = this.baddie.head.eyeR.rotation = -Math.atan2(x - lastStomped.x, y - lastStomped.y) / (Math.PI / 180) * scaleX;
            }
        }
        if (this.concernedN > 0)
        {
            --this.concernedN;
            this.baddie.head.eyeL.rotation = this.baddie.head.eyeR.rotation = -Math.atan2(x - lastStomped.x, y - lastStomped.y) / (Math.PI / 180) * scaleX;
        }
        else if (this.concernedN == 0)
        {
            this.baddie.head.gotoAndStop(24);
            this.concernedN = -1;
            lastStomped = null;
        }
    }
    
    private function gonnaStompHalp(e : Dynamic) : Dynamic
    {
        if (this.baddie.head.currentFrame < 12)
        {
            lastStomped = e;
            this.baddie.head.gotoAndStop(12);
        }
    }
}


