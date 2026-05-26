
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol5128"))

class BaddiePuddle extends StaticInteractObjects
{
    
    private var releasing : Bool;
    
    private var baddieArray : Array<Dynamic>;
    
    private var baddiesOut : Int;
    
    private var baddiesAtOnce : Int;
    
    private var baddieCount : Int;
    
    private var baddieCountRoot : Int;
    
    private var b : Int = 0;
    
    private var stamp : StarlingSmoke;
    
    public function new(p : Dynamic)
    {
        super("baddiePuddle", p.x, p.y, p.scaleX, p.scaleY, p.onRail, "nothing", -1);
        scaleX = scaleY = 1;
        rotation = p.rotation;
        if (p.pairGate != null)
        {
            pairGate = p.pairGate;
        }
        this.baddieArray = p.badArray;
        this.baddieCountRoot = this.baddieCount = this.baddieArray.length;
        if (p.baddieN < 0)
        {
            this.baddiesAtOnce = this.baddieCount;
        }
        else
        {
            this.baddiesAtOnce = p.baddieN;
        }
        visible = false;
        this.stamp = StarlingSmoke.Spawn("baddiePuddleStamp", x, y, rotation * (Math.PI / 180), scaleX, 0, 0, onRail);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (!this.releasing)
        {
            this.releasing = true;
            InteractEnterFrameArray.push(this);
        }
    }
    
    override public function InteractEnterFrame() : Bool
    {
        var eRL : Float = Math.NaN;
        if (this.baddiesOut < this.baddiesAtOnce && this.baddieCount > 0)
        {
            if (this.b > 0)
            {
                --this.b;
            }
            else
            {
                this.b = 2;
                eRL = 10 * Math.random() - 5 + 10 * Math.sin(rotation * (Math.PI / 180));
                StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, 0.5, eRL, -5, onRail);
                if (this.baddieArray[this.baddieCountRoot - this.baddieCount] == 1)
                {
                    new Baddie1({
                        ItIs : "Baddie1",
                        x : x,
                        y : y - 30,
                        rotation : 0,
                        scaleX : 1,
                        scaleY : 0.5 + Math.random() * 0.3,
                        onRail : onRail,
                        hatN : 0,
                        moveRL : eRL,
                        moveUD : -(15 + Math.random() * 10),
                        autopilot : true,
                        lifetimeN : -1,
                        spawner : this,
                        tether : 100 + Math.random() * 200,
                        downTime : 10
                    });
                }
                else
                {
                    new InkFly({
                        ItIs : "InkFly",
                        x : x,
                        y : y - 30,
                        rotation : 0,
                        scaleX : 1,
                        scaleY : 0.6 + Math.random() * 0.6,
                        onRail : onRail,
                        hatN : 0,
                        moveRL : eRL,
                        moveUD : -(15 + Math.random() * 10),
                        autopilot : true,
                        lifetimeN : -1,
                        spawner : this,
                        tether : 100 + Math.random() * 200,
                        downTime : 10
                    });
                }
                ++this.baddiesOut;
                --this.baddieCount;
                this.stamp.scaleX = this.stamp.scaleY = this.baddieCount / this.baddieCountRoot;
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
    
    override public function cleanUp() : Void
    {
        if (this.stamp != null)
        {
            this.stamp.goSwim();
            this.stamp = null;
        }
    }
}


