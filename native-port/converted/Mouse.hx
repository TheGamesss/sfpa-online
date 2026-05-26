import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol6264"))

class Mouse extends Baddies
{
    
    public var baddie : MovieClip;
    
    public var stars : MovieClip;
    
    private var shootN : Int;
    
    private var rootShootN : Int;
    
    private var inARow : Int;
    
    private var shotSpeed : Int;
    
    public function new(p : Dynamic)
    {
        super(30, 20, p.onRail);
        x = p.x;
        y = p.y;
        rotation = realRot = p.rotation;
        scaleX = facing = p.scaleX;
        onRail = p.onRail;
        ItIs = "Mouse";
        smokeName = "MouseSmoke";
        BallRes = 10;
        bounce = 0.5;
        bounceThresh = 8;
        maxRL = 4;
        springy = 5;
        springDecay = 0.9;
        stunMax = 120;
        health = healthMax = 60;
        rotPerc = 360 / (Math.PI * (isWide * 2));
        springTall = as3hx.Compat.parseInt(isTall * 2);
        overReach = 10;
        if (p.interval == null || p.interval == -1)
        {
            this.rootShootN = 90;
        }
        else
        {
            this.rootShootN = p.interval;
        }
        if (p.shotSpeed == null || p.shotSpeed == -1)
        {
            this.shotSpeed = 10;
        }
        else
        {
            this.shotSpeed = p.shotSpeed;
        }
        this.shootN = this.rootShootN / 3;
        this.inARow = 3;
        currentHitChar = standardHitChar;
        springBounce = standardSpringBounce;
        this.baddie.stop();
        mass = 65;
        visible = false;
        cast(("Wait"), ChangeFrame);
    }
    
    override public function chooseCharInteract(frame : Dynamic) : Void
    {
        if (groundStatus(frame))
        {
            springy = 5;
            springdecay = 0.92;
            scaleX = makeOne(scaleX);
            scaleY = 1;
            moveSpringBounce = stompedMoveSpringBounce;
            if (frame == "Roll")
            {
                if (hasSmoke)
                {
                    currentSmoke.pivotY = 0;
                }
            }
            else if (hasSmoke)
            {
                currentSmoke.pivotY = 20;
            }
        }
        else
        {
            springy = 3;
            springDecay = 0.85;
            this.baddie.scaleX = 1;
            this.baddie.scaleY = 1;
            moveSpringBounce = standardMoveSpringBounce;
            wallRot = 0;
            if (hasSmoke)
            {
                currentSmoke.pivotY = 0;
            }
        }
        this.baddie.gotoAndStop(1);
        if (!hasSmoke)
        {
            smokeFrameOffset = -1;
        }
        else if (frame == "Idle")
        {
            smokeFrameOffset = 0;
        }
        else if (frame == "Roll" || frame == "stunJump" || frame == "Stunned" || frame == "Hit")
        {
            smokeFrameOffset = 72;
        }
        else if (frame == "deadJump")
        {
            smokeFrameOffset = 73;
        }
        switch (frame)
        {
            case "Wait":
            case "Jump", "Idle":

                switch (frame)
                {case "Jump":
                        wallRot = 0;
                }
                isWide = 30;
                currentHitChar = standardHitChar;
                rotter = 0;
                isABall = false;
                canAggressor = false;
                if (Lambda.indexOf(AggressorArray, this) > -1)
                {
                    AggressorArray.splice(Lambda.indexOf(AggressorArray, this), 1);
                }
            case "Roll":
                this.stars.rotation = -rotation * makeOne(scaleX);
                angle = this.stars.rotation * (Math.PI / 180);
                this.stars.x = Math.sin(angle) * 35;
                this.stars.y = Math.cos(angle) * -35;
                wallRot = 0;
                isWide = 15;
                currentHitChar = standardBeABall;
                isABall = true;
                canAggressor = true;
                if (Lambda.indexOf(AggressorArray, this) == -1)
                {
                    AggressorArray.push(this);
                }
            case "deadJump", "stunJump", "Stunned":

                switch (frame)
                {case "deadJump":
                        Sounds.playSound("MouseDie", x, 1, onRail);
                }
                wallRot = 0;
                isWide = 15;
                currentHitChar = standardBeABall;
                isABall = true;
                canAggressor = true;
                if (Lambda.indexOf(AggressorArray, this) == -1)
                {
                    AggressorArray.push(this);
                }
            case "Stomped":
                scaleX = makeOne(scaleX);
                scaleY = 1;
            case "Hit":
        }
        smokeSetFrame();
    }
    
    public function WaitEnterFrame() : Dynamic
    {
        if (inRange())
        {
            cast(("Idle"), ChangeFrame);
        }
    }
    
    public function IdleEnterFrame() : Dynamic
    {
        var ang : Float = Math.NaN;
        if (inRange())
        {
            this.baddie.nextFrame();
            if (this.baddie.currentFrame == this.baddie.totalFrames || this.baddie.currentFrame == 31)
            {
                this.baddie.gotoAndStop(1);
            }
            if (this.baddie.currentFrame < 32)
            {
                this.baddie.baddie.nextFrame();
                if (this.baddie.baddie.currentFrame == this.baddie.baddie.totalFrames)
                {
                    this.baddie.baddie.gotoAndStop(1);
                }
            }
            tempX = Char.CharArray[0].x - x;
            if (facing * tempX < -50)
            {
                facing *= -1;
                scaleX *= -1;
            }
            if (fakeRL != 0)
            {
                if (Math.abs(fakeRL) > 2)
                {
                    fakeRL -= makeOne(fakeRL) * 2;
                }
                else
                {
                    fakeRL = 0;
                }
            }
            if (this.shootN > 0)
            {
                --this.shootN;
                if (this.shootN == 10)
                {
                    this.baddie.gotoAndStop("shoot");
                }
            }
            else
            {
                Sounds.playSound("MouseShoot", x, 2, onRail);
                ang = wallAngle - 1.57 * facing;
                StarlingInteract.Spawn("Scratch", x + -Math.sin(ang) * 40, y + Math.cos(ang) * 40 - 10, 0, 1, -Math.sin(ang) * this.shotSpeed, Math.cos(ang) * this.shotSpeed, onRail, 100);
                this.shootN = this.rootShootN;
            }
            smokeSetFrame();
        }
        else
        {
            this.shootN = this.rootShootN / 3;
            cleanUp();
            cast(("Wait"), ChangeFrame);
        }
    }
    
    public function RollEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        if (this.baddie.currentFrame == this.baddie.totalFrames || this.baddie.currentFrame == 31)
        {
            this.baddie.gotoAndStop(1);
        }
        this.stars.nextFrame();
        this.stars.scaleX = this.stars.scaleY = stunN / stunMax;
        if (this.stars.currentFrame == this.stars.totalFrames)
        {
            this.stars.gotoAndStop(1);
        }
        ++moveUD;
        if (Math.abs(moveRL) > 15)
        {
            moveRL *= 0.96;
        }
        if (Math.abs(moveUD) > 20)
        {
            moveUD *= 0.9;
        }
        if (stunN > 0)
        {
            --stunN;
        }
        else if (onGround || almostGround || almostPlat)
        {
            rotation = realRot = wallRot;
            onGround = true;
            y += 2;
            cast(("Idle"), ChangeFrame);
        }
    }
    
    public function JumpEnterFrame() : Dynamic
    {
        cast(("Roll"), ChangeFrame);
        this.RollEnterFrame();
    }
    
    public function LandEnterFrame() : Dynamic
    {
        cast(("Idle"), ChangeFrame);
        this.IdleEnterFrame();
    }
}


