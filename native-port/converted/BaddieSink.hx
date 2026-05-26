
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol5127"))

class BaddieSink extends StaticInteractObjects
{
    
    private var releasing : Bool;
    
    private var baddieArray : Array<Dynamic>;
    
    private var baddiesOut : Int;
    
    private var baddiesAtOnce : Int;
    
    private var baddieCount : Int;
    
    private var baddieCountRoot : Int;
    
    private var baddieInterval : Int;
    
    private var b : Int = 0;
    
    public function new(p : Dynamic)
    {
        super("baddiePuddle", p.x, p.y, p.scaleX, p.scaleY, p.onRail, "nothing", -1);
        Backgrounds.backgroundsArray[onRail].addChild(this);
        scaleX = scaleY = 1;
        rotation = p.rotation;
        this.baddieCount = this.baddieCountRoot = p.total;
        this.baddiesAtOnce = p.amount;
        InteractEnterFrameArray.push(this);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
    }
    
    override public function InteractEnterFrame() : Bool
    {
        var eRL : Float = Math.NaN;
        if (this.baddiesOut < this.baddiesAtOnce && (this.baddieCount > 0 || this.baddieCount < 0))
        {
            if (this.b > 0)
            {
                --this.b;
            }
            else
            {
                this.b = this.baddieInterval;
                ++this.baddiesOut;
                if (this.baddieCount > -1)
                {
                    --this.baddieCount;
                }
                eRL = 10 * Math.random() - 5;
                trace(onRail);
                new Baddie1({
                    ItIs : "Baddie1",
                    x : x,
                    y : y - 30,
                    rotation : 0,
                    scaleX : 1,
                    scaleY : 0.3 + Math.random() * 0.5,
                    onRail : onRail,
                    hatN : 0,
                    moveRL : eRL,
                    moveUD : -(15 + Math.random() * 10),
                    autopilot : true,
                    lifetimeN : -1,
                    spawner : this,
                    tether : 100 + Math.random() * 200
                });
            }
        }
    }
    
    public function onKilled() : Void
    {
        --this.baddiesOut;
        if (pairGate > -1)
        {
            if (baddieGate == null)
            {
                trace("null gate " + pairGate);
            }
            if (this.baddieCount + this.baddiesOut == 0 && baddieGate != null)
            {
                baddieGate.inkGateBreak();
            }
        }
    }
}


