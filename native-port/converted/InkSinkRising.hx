
class InkSinkRising extends StaticInteractObjects
{
    
    private var moveUD : Float = 0;
    
    private var currentSmoke : StarlingSmoke;
    
    private var spacing : Int = 60;
    
    private var disabled : Bool;
    
    private var speedUp : Bool;
    
    private var stagger : Int;
    
    public function new(p : Dynamic)
    {
        isTall = as3hx.Compat.parseInt(p.scaleY * 50 + 20);
        super(p.ItIs, p.x, p.y, p.scaleX, p.scaleY, p.onRail, "nothing", -1);
        visible = false;
        if (p.disabled)
        {
            this.disabled = true;
        }
        var temp : Int = Math.floor(isWide * 2 / this.spacing);
        this.spacing = isWide * 2 / temp;
        for (i in 0...temp)
        {
            new InkBubbleDecalStarling({
                x : x + this.spacing * 0.5 - isWide + i * this.spacing,
                y : y - isTall + 20,
                rotation : 0,
                scaleX : 1,
                scaleY : 1,
                onRail : onRail
            });
        }
        InteractEnterFrameArray.push(this);
        HalfInteractEnterFrameArray.push(this);
        this.currentSmoke = StarlingSmoke.Spawn("blackBlock", x, y, 0, scaleX, 0, 0, onRail);
        this.currentSmoke.scaleY = scaleY;
        this.currentSmoke.textureSmoothing = "none";
        if (p.propX > 0)
        {
            this.moveUD = -2;
        }
        if (p.propY == 0)
        {
            this.speedUp = true;
        }
    }
    
    public function startInk() : Void
    {
        this.moveUD = -0.1;
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (char.Status != "Disabled")
        {
            if (char.lastY + char.isTall < y - isTall + 20)
            {
                char.parent.mask = null;
                if (eUD > 5 && ey + char.isTall > y - isTall + 20)
                {
                    Sounds.playSound("FallInInk", x, 1, onRail);
                    StarlingEffect.Spawn("inkSplash", ex, y - isTall + 20, 0, 2, 0, 0, onRail);
                }
            }
            else if (this.stagger <= 0)
            {
                if (!char.onGround && ey > y - isTall + 60 || char.onGround && ey > y - isTall + 30)
                {
                    this.stagger = 5;
                    char.superHurtChar(30, true, 40);
                    if (Char.ActiveCharArray.length == 1)
                    {
                        char.hitPause = 60;
                        Char.CharArray[0].superTumble = true;
                        Main.FadeItOut("Level1", 8);
                    }
                    else if (char.health == 0)
                    {
                        char.gotoBuffer = "Dead";
                    }
                }
                else
                {
                    char.setMask(ex, y - isTall + 20, 0);
                    char.moveRL -= char.moveRL * 0.05 * Main.framin;
                    char.moveUD -= char.moveUD * 0.1 * Main.framin;
                }
            }
        }
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (this.stagger > 0)
        {
            --this.stagger;
        }
        if (this.moveUD < 0)
        {
            if (this.speedUp)
            {
                this.moveUD = -((anchorY + 500 - y) * 0.002);
            }
            else
            {
                this.moveUD = -2;
            }
            HalfInteractEnterFrames();
        }
    }
    
    override public function HalfInteractEnterFrame() : Void
    {
        if (this.moveUD < 0)
        {
            if (y > Char.CharArray[0].y + 700)
            {
                this.moveUD -= (anchorY - Char.CharArray[0].y + 700) * 0.0008;
            }
            y += this.moveUD * framin;
            this.currentSmoke.y = y;
            StarlingDecals.shiftAllDecals(y - isTall + 20);
            updateCache();
        }
    }
}


