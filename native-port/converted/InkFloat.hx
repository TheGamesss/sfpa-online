import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol6418"))

class InkFloat extends Baddies
{
    
    public var baddie : MovieClip;
    
    public var stars : MovieClip;
    
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
        p.hatN = 0;
        super(20 * Math.abs(p.scaleY), 35 * Math.abs(p.scaleY), p.onRail);
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
        BallRes = 10;
        bounce = 0.5;
        bounceThresh = 20;
        maxRL = 6 / ((scale - 1) * 0.5 + 1);
        springy = 10;
        stunMax = 120;
        health = 1;
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
        moveSpringBounce = standardMoveSpringBounce;
        visible = false;
        smokeName = "InkFloatSmoke";
        cast(("Wait"), ChangeFrame);
    }
    
    override public function chooseCharInteract(frame : Dynamic) : Void
    {
        if (hasSmoke)
        {
            if (frame == "Fly")
            {
                smokeFrameOffset = 0;
            }
            else if (frame == "Hit")
            {
                smokeFrameOffset = 2;
            }
            else if (frame == "deadJump")
            {
                smokeFrameOffset = 4;
            }
        }
        switch (frame)
        {
            case "Wait":
                scaleX = makeOne(scaleX) * scale;
                scaleY = Math.abs(scaleX);
                spring = 0;
            case "Fly":
                springBounce = standardSpringBounce;
                moveSpringBounce = standardMoveSpringBounce;
                this.baddie.x = this.baddie.y = 0;
                moveUD = 2;
                health = 1;
                spring = 0;
                currentSmoke.currentFrame = 1;
            case "deadJump":
                currentHitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : String
                        {
                        };
                wallRot = 0;
                spring = 5 * scale;
                springBounce = standardSpringBounce;
                this.baddie.x = this.baddie.y = 0;
                this.b = 0;
                currentSmoke.currentFrame = 5;
            case "return":
                this.b = 60;
                moveRL = moveUD = rotter = 0;
                scaleX = scaleY = currentSmoke.scaleX = currentSmoke.scaleY = 0;
                explode = false;
                currentSmoke.currentFrame = 1;
        }
    }
    
    public function WaitEnterFrame() : Dynamic
    {
        if (inRange())
        {
            tilRangeCheck = 300;
            cast(("Fly"), ChangeFrame);
            this.state = 0;
        }
    }
    
    public function FlyEnterFrame() : Dynamic
    {
        if (currentSmoke.currentFrame == 4)
        {
            currentSmoke.currentFrame = 1;
        }
        else
        {
            ++currentSmoke.currentFrame;
        }
        moveUD += as3hx.Compat.parseInt((originY - y) * 0.05);
        springTall = as3hx.Compat.parseInt(originalSpringTall - (originY - y) * 0.5);
    }
    
    public function returnEnterFrame() : Dynamic
    {
        --this.b;
        if (this.b <= 30)
        {
            if (this.b == 30)
            {
                x = originX;
                y = originY;
                moveRL = moveUD = rotter = rotation = 0;
                springTall = 0;
                currentHitChar = inkyHitChar;
                springBounce = standardSpringBounce;
                moveSpringBounce = wholeMoveSpringBounce;
            }
            else if (this.b > 0)
            {
                if (currentSmoke.currentFrame == 4)
                {
                    currentSmoke.currentFrame = 1;
                }
                else
                {
                    ++currentSmoke.currentFrame;
                }
            }
            else
            {
                cast(("Fly"), ChangeFrame);
            }
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
            StarlingEffect.Spawn("Splat", x, y, Math.random() * 6, (scale - 0.5) * 0.4 + 0.6, moveRL, moveUD, onRail);
            cast(("return"), ChangeFrame);
        }
    }
}


