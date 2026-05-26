import flash.media.SoundChannel;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3871"))

class InkVein extends StaticInteractObjects
{
    
    private var currentSound : SoundChannel;
    
    public function new(p : Dynamic)
    {
        super("inkVein", p.x, p.y, p.scaleX, p.scaleY, p.onRail, "nothing", -1);
        Backgrounds.backgroundsArray[0].addChild(this);
        isWide = 400;
        isTall = 50;
        stop();
        InteractEnterFrameArray.push(this);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        char.fakeX = x - 60;
        if (char.Status != "PenUpgradeStab" && char.onGround)
        {
            char.gotoBuffer = "PenUpgradeStab";
        }
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (currentFrame > 1 && currentFrameLabel != "b")
        {
            Sounds.updateSound(this.currentSound, x, 1, onRail);
            nextFrame();
        }
        if (currentFrameLabel == "a")
        {
            gotoAndStop("d");
        }
    }
    
    public function start() : Void
    {
        nextFrame();
        this.currentSound = Sounds.playSoundContinuous("InkVeinLoop", x, 1, onRail);
    }
    
    public function finishSound() : Void
    {
        Sounds.stopSound(this.currentSound);
    }
}


