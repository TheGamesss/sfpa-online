import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol1672"))

class WalkingWorker extends InteractObjects
{
    
    public var head : MovieClip;
    
    public var vest : MovieClip;
    
    private var tempN : Int;
    
    private var rotConvert : Float = 0.017453292519943295;
    
    public function new(ex : Dynamic, ey : Dynamic, scale : Dynamic, rail : Dynamic)
    {
        super(rail);
        originX = x = ex;
        y = ey;
        scaleX = scale;
        fakeRL = scaleX * 2;
        ItIs = "WalkingWorker";
        downTime = 0;
        BallRes = 8;
        isTall = 20;
        isWide = as3hx.Compat.parseInt(width * 0.5);
        bounce = 0.5;
        bounceThresh = 2;
        rotPerc = 0;
        overReach = 4;
        mass = 5;
        stop();
        Status = "Walk";
        if (rail == 4)
        {
            this.tempN = StarlingTemporary.Spawn("BlurWalkingWorker", x, y, rotation * this.rotConvert, scaleX, onRail, true);
        }
        else
        {
            this.tempN = StarlingTemporary.Spawn("WalkingWorker", x, y, rotation * this.rotConvert, scaleX, onRail, true);
        }
    }
    
    override public function InteractEnterFrame() : Void
    {
        if (Math.abs(x + moveRL - originX) > 200)
        {
            fakeRL *= -1;
            scaleX *= -1;
            StarlingTemporary.setScales(this.tempN, scaleX, scaleY);
        }
        if (!onGround)
        {
            ++y;
        }
        StarlingTemporary.placeTemp(this.tempN, x, y, rotation * this.rotConvert);
    }
}


