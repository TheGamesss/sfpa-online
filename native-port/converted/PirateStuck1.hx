import flash.media.SoundChannel;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol826"))

class PirateStuck1 extends StaticInteractObjects
{
    
    private var shakeN : Int = 10;
    
    private var shakeRL : Float = 2;
    
    private var stuck : Bool = true;
    
    private var dance : Bool;
    
    private var disabled : Bool;
    
    private var currentSound : SoundChannel;
    
    public function new(p : Dynamic)
    {
        isTall = 200;
        isWide = 600;
        ID = p.ID;
        super(p.ItIs, p.x, p.y, 1, 1, p.onRail, "nothing", -1);
        Backgrounds.backgroundsArray[onRail].addChild(this);
        staticInteractObjects.InteractEnterFrameArray.push(this);
        if (Main.world4Progress["bentPipe" + ID] != null)
        {
            this.dance = true;
            gotoAndStop(2);
            findByUnique(0).changeProperties("nothing", -1, -1, -1, "Wind_Cave");
            this.disabled = true;
        }
        else
        {
            this.buildThatWall();
            gotoAndStop(1);
        }
    }
    
    public function buildThatWall() : Void
    {
        new AWall({
            x : 3866,
            y : -1390,
            scaleX : 2,
            scaleY : 5.3,
            rotation : 0,
            ID : 2,
            status : "Gate"
        });
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (this.dance)
        {
            nextFrame();
            if (currentFrameLabel == "a")
            {
                gotoAndStop(2);
            }
        }
        else if (this.stuck)
        {
            if (this.shakeN > 0)
            {
                --this.shakeN;
                if (this.shakeN < 10)
                {
                    x = anchorX + this.shakeRL;
                    this.shakeRL *= -1;
                }
            }
            else
            {
                this.shakeN = 20 + Math.random() * 40;
            }
        }
        else if (this.shakeN < 60)
        {
            ++this.shakeN;
            this.shakeRL *= -1;
            this.shakeRL += this.shakeRL / Math.abs(this.shakeRL) * 0.3;
            x = anchorX + this.shakeRL;
            Main.shakeScreen(this.shakeN * 0.2, 0, true);
            Sounds.updateSound(this.currentSound, x, this.shakeN * 0.1, onRail);
        }
        else
        {
            x = anchorX;
            StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, 1.5, 0, 0, onRail);
            gotoAndStop(2);
            Main.shakeScreen(60, 0, true);
            this.dance = true;
            Sounds.fadeOutMusic("Lounge", 0.2);
            Sounds.playSound("InkExplode", x, 2, onRail);
            Sounds.stopSound(this.currentSound);
        }
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (cast(this.dance, Bool) && !this.disabled)
        {
            if (!staticInteractObjects.textBubbleArray[0].popupText(char.UpIsDown()))
            {
            }
        }
    }
    
    public function finish() : Void
    {
        this.stuck = false;
        this.shakeN = 0;
        this.shakeRL = 0.1;
        this.currentSound = Sounds.playSoundContinuous("LowRumble", x, 0, onRail);
        findByUnique(0).changeProperties("nothing", 0.02, -1, -1, "Wind_Cave");
        Sounds.fadeOutMusic("Wind_Cave", 0.05);
    }
}


