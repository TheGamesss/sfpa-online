import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol6409"))

class InkFly extends Baddies
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
        super(25 * Math.abs(p.scaleY), 20 * Math.abs(p.scaleY), p.onRail);
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
        scaleY = scale = Math.abs(p.scaleY);
        scaleX = scale * p.scaleX;
        BallRes = 0;
        bounce = 0.5;
        bounceThresh = 20;
        maxRL = 6 / ((scale - 1) * 0.5 + 1);
        springy = 10;
        stunMax = 120;
        health = healthMax = as3hx.Compat.parseInt(isTall * isWide / 20);
        retreatThresh = as3hx.Compat.parseInt(health - 50 - Math.random() * 50);
        attackN = -1;
        rotPerc = 360 / (Math.PI * (isTall * 2));
        springTall = as3hx.Compat.parseInt(isTall * 2);
        overReach = 5;
        knockback = 0.5;
        spring = 0;
        if (scale > 2)
        {
            grounded = true;
        }
        launchThresh = as3hx.Compat.parseInt(mass * 0.5);
        attentionRange = as3hx.Compat.parseInt(300 + isWide * 2);
        if (tether == -1)
        {
            tether = 10000;
        }
        currentHitChar = inkyHitChar;
        springBounce = standardSpringBounce;
        camDistU = 10;
        smokeName = "InkFlySmoke";
        visible = false;
        if (moveUD == 0)
        {
            cast(("Wait"), ChangeFrame);
        }
        else
        {
            cast(("Drop"), ChangeFrame);
        }
        spring = 5 * scale;
        this.shootN = 50 + 50 * Math.random();
    }
    
    override public function chooseCharInteract(frame : Dynamic) : Void
    {
        if (groundStatus(frame))
        {
            moveSpringBounce = function() : Dynamic
                    {
                    };
        }
        else
        {
            moveSpringBounce = standardMoveSpringBounce;
        }
        switch (frame)
        {
            case "Wait":
                scaleX = makeOne(scaleX) * scale;
                scaleY = Math.abs(scaleX);
                spring = 0;
            case "Jump":
                currentSmoke.currentFrame = 17;
            case "Drop":
                wallRot = 0;
                rotation = -Math.atan2(-moveRL, -moveUD) / (Math.PI / 180);
                springBounce = standardSpringBounce;
                this.baddie.x = this.baddie.y = 0;
                currentSmoke.currentFrame = 53;
            case "Crouch", "Idle", "Walk", "Freeze", "Land":

                switch (frame)
                {case "Crouch":
                        springTall = as3hx.Compat.parseInt(isTall * 2);
                }
                rotter = 0;
                springBounce = standardIdleBounce;
            case "deadJump", "stunJump":

                switch (frame)
                {case "deadJump":
                        currentHitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : String
                                {
                                };
                        currentSmoke.currentFrame = 91;
                }
                wallRot = 0;
                spring = 5 * scale;
                springBounce = standardSpringBounce;
                this.baddie.x = this.baddie.y = 0;
            case "Stunned":
            case "Hit":
                currentSmoke.currentFrame = 90;
        }
    }
    
    public function WaitEnterFrame() : Dynamic
    {
        if (inRange())
        {
            tilRangeCheck = 300;
            cast(("Jump"), ChangeFrame);
            this.state = 0;
        }
    }
    
    public function IdleEnterFrame() : Dynamic
    {
    }
    
    public function WalkEnterFrame() : Dynamic
    {
    }
    
    public function FreezeEnterFrame() : Dynamic
    {
    }
    
    public function JumpEnterFrame() : Dynamic
    {
        ++currentSmoke.currentFrame;
        if (currentSmoke.currentFrame == 24 || currentSmoke.currentFrame == 52)
        {
            currentSmoke.currentFrame = 17;
        }
        moveRL += (originX - x) * 0.02;
        moveRL *= 0.8;
        moveUD += as3hx.Compat.parseInt((originY - y) * 0.02);
        moveUD *= 0.8;
        if (Math.abs(Char.CharArray[0].x - x) < 800 && Math.abs(Char.CharArray[0].y - y) < 400)
        {
            cast(("Fly"), ChangeFrame);
        }
    }
    
    public function FlyEnterFrame() : Dynamic
    {
        ++currentSmoke.currentFrame;
        if (currentSmoke.currentFrame == 24 || currentSmoke.currentFrame == 52)
        {
            currentSmoke.currentFrame = 17;
        }
        rotter += (-rotation * 0.1 - rotter) * 0.5;
        rotter *= 0.9;
        this.distX = Char.CharArray[0].x - x;
        this.distY = Char.CharArray[0].y - y;
        this.dist = Math.sqrt(this.distX * this.distX + this.distY * this.distY);
        if (Math.abs(this.distX) < 800 && Math.abs(this.distY) < 600)
        {
            this.state = 1;
            addToFollow(5);
        }
        else
        {
            cast(("Jump"), ChangeFrame);
        }
        if (this.b > 0)
        {
            --this.b;
        }
        else
        {
            facing = makeOne(Char.CharArray[0].x - x);
            scaleX = facing * scale;
            this.b = 20;
            originX += 50 - Math.random() * 100;
            originY += 50 - Math.random() * 100;
            if (this.state != 0)
            {
                if (this.dist > 600)
                {
                    originX += this.distX * 0.1;
                    originY += this.distY * 0.1;
                }
                else if (this.dist > 300)
                {
                    originX += this.distX * 0.05;
                    originY += this.distY * 0.05;
                }
                else
                {
                    originX -= makeOne(this.distX) * 200;
                    originY -= 20;
                }
            }
        }
        moveRL += (originX - x) * 0.02;
        moveRL *= 0.8;
        moveUD += as3hx.Compat.parseInt((originY - y) * 0.02);
        moveUD *= 0.8;
        if (this.shootN > 0)
        {
            --this.shootN;
            if (this.shootN == 14)
            {
                currentSmoke.currentFrame = 25;
            }
        }
        else
        {
            this.shootN = 50 + 50 * Math.random();
            if (this.dist > 12)
            {
                this.distX *= 12 / this.dist;
                this.distY *= 12 / this.dist;
            }
            StarlingInteract.Spawn("inkShotBad", x + this.distX, y + this.distY, -Math.atan2(this.distX, this.distY), scale * 1.5, this.distX, this.distY, onRail, 60);
            StarlingEffect.Spawn("Splat", x + this.distX, y + this.distY, Math.random() * 6.28, scaleY * 0.3, this.distX, this.distY, onRail);
            Sounds.playSound("InkSpit", x, 1, onRail);
        }
    }
    
    public function DropEnterFrame() : Dynamic
    {
        ++currentSmoke.currentFrame;
        currentSmoke.currentFrame = 55;
        rotter = rotCompare(-Math.atan2(-moveRL, -moveUD) / (Math.PI / 180), rotation);
        if (Math.abs(rotter) > 10)
        {
            makeOne(rotter) * 10;
        }
        if (facing * moveRL < 0)
        {
            facing *= -1;
            scaleX = scale * facing;
        }
        if (moveUD < 2)
        {
            ++moveUD;
        }
        else
        {
            originX = x;
            originY = y;
            currentSmoke.currentFrame = 1;
            cast(("Fly"), ChangeFrame);
        }
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
            Sounds.playSound("InkBurst", x, scale * 1.2, onRail);
            StarlingEffect.Spawn("Splat", x, y, Math.random() * 6.28, (scale - 0.5) * 0.4 + 0.6, moveRL, moveUD, onRail);
            killBaddies.push(this);
        }
    }
}


