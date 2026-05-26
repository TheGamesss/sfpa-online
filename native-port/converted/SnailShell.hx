import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol5672"))

class SnailShell extends Baddies
{
    
    public var baddie : MovieClip;
    
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
        wallRot = realRot = rotation = p.rotation;
        facing = scx = scaleX = 1;
        BallRes = 10;
        bounce = 0.8;
        bounceThresh = 4;
        maxRL = 4;
        springy = 5;
        springDecay = 0.7;
        stunMax = 80;
        health = 10000;
        healthMax = 0;
        rotPerc = 360 / (Math.PI * (isTall * 2));
        springTall = as3hx.Compat.parseInt(isTall * 2);
        overReach = 4;
        isABall = true;
        canAggressor = true;
        AggressorArray.push(this);
        currentHitChar = standardBeABall;
        springBounce = standardSpringBounce;
        moveSpringBounce = standardMoveSpringBounce;
        smokeName = "SnailShellSmoke";
        visible = false;
        this.ChangeFrame("Wait");
    }
    
    public function WaitEnterFrame() : Void
    {
        if (inRange())
        {
            tilRangeCheck = 60;
            this.ChangeFrame("Roll");
        }
    }
    
    public function RollEnterFrame() : Bool
    {
        ++moveUD;
        if (moveUD < -10)
        {
            tilRangeCheck = 40;
        }
        if (tilRangeCheck > 0)
        {
            --tilRangeCheck;
        }
        else if (inRange())
        {
            tilRangeCheck = 40;
        }
        else
        {
            this.ChangeFrame("Wait");
        }
    }
    
    override public function ChangeFrame(frame : Dynamic) : Void
    {
        if (frame != "Wait" && frame != "Roll")
        {
            return;
        }
        BaddieEnterFrame = this[frame + "EnterFrame"];
        if (frame == "Wait")
        {
            if (Lambda.indexOf(activeBaddieArray, this) > -1)
            {
                activeBaddieArray.splice(Lambda.indexOf(activeBaddieArray, this), 1);
            }
            cleanUp();
        }
        else
        {
            if (Lambda.indexOf(activeBaddieArray, this) == -1)
            {
                activeBaddieArray.push(this);
                aPlat.resetplatSides(x, y, this);
            }
            if (!hasSmoke)
            {
                hasSmoke = true;
                currentSmoke = StarlingSmoke.Spawn(smokeName, x, y, 0, 1, 0, 0, onRail);
            }
            smokeSetFrame();
            placeSmoke();
        }
        Status = frame;
    }
}


