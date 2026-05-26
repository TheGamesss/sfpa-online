
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol2559"))

class Spinner extends StaticInteractObjects
{
    
    private var rotter : Float = 0;
    
    private var lift : Float = 0;
    
    private var maxLift : Int;
    
    public var myPlat : APlat;
    
    private var fakeRL : Float = 0;
    
    private var on : Bool;
    
    private var lock : Bool;
    
    private var stamp : StarlingSmoke;
    
    public function new(p : Dynamic)
    {
        isWide = 25;
        isTall = 25;
        super("Spinner", p.x, p.y, p.scaleX, p.scaleY, p.onRail, "nothing", -1);
        Backgrounds.backgroundsArray[p.onRail].addChild(this);
        InteractEnterFrameArray.push(this);
        HalfInteractEnterFrameArray.push(this);
        inkCollideArray.push(this);
        pairID = p.pairID;
        this.maxLift = p.maxLift;
        this.lock = p.lock;
        rotation = Math.random() * 180;
        visible = false;
        this.stamp = StarlingSmoke.Spawn("SpinnerStamp", x, y, Math.PI / 180 * rotation, scaleX * 0.6666, 0, 0, onRail);
    }
    
    override public function InteractEnterFrame() : Bool
    {
        this.HalfInteractEnterFrame();
        if (Math.abs(this.lift) * 0.01 < 0.5)
        {
            this.rotter -= this.lift * 0.01;
        }
        else
        {
            this.rotter -= this.lift / Math.abs(this.lift) * 0.5;
        }
        if (cast(this.lock, Bool) && this.lift * this.rotter < 0)
        {
            if (Math.abs(this.rotter) > 0.5)
            {
                this.rotter = this.rotter / Math.abs(this.rotter) * 0.5;
            }
        }
    }
    
    override public function HalfInteractEnterFrame() : Void
    {
        if (this.on)
        {
            this.stamp.rotation += this.rotter * (Math.PI / 180) * framin;
            if (this.lift * (this.lift + this.rotter * 0.5 * framin) < 0)
            {
                this.lift = 0;
                if (Math.abs(this.rotter) < 5)
                {
                    this.rotter = 0;
                    this.on = false;
                }
                else
                {
                    this.rotter *= -0.1;
                }
            }
            else if (Math.abs(this.rotter) > 16)
            {
                this.lift += 8 * this.rotter / Math.abs(this.rotter) * framin;
            }
            else
            {
                this.lift += this.rotter * 0.5 * framin;
            }
            if (Math.abs(this.lift) > this.maxLift)
            {
                this.lift *= this.maxLift / Math.abs(this.lift);
            }
            if (this.lift == 0)
            {
                this.fakeRL = 0;
            }
            else
            {
                this.fakeRL = this.rotter * 0.25 * this.lift / Math.abs(this.lift);
            }
            this.myPlat.fromRemote(Math.abs(this.lift), this.fakeRL);
        }
    }
    
    public function hitInk(ex : Dynamic, ey : Dynamic, eRL : Dynamic, ink : Dynamic) : Bool
    {
        this.on = true;
        this.rotter += (eRL * 0.8 - this.rotter) * 0.1;
        ink.moveRL *= this.rotter / eRL * 0.5;
        ink.moveUD *= this.rotter / eRL * 0.5;
        ink.moveUD -= Math.abs(this.rotter) * 1;
        ink.x = x - isWide * eRL / Math.abs(eRL);
        return true;
    }
    
    override public function cleanUp() : Void
    {
        if (this.stamp != null)
        {
            this.stamp.goSwim();
            this.stamp = null;
        }
    }
}


