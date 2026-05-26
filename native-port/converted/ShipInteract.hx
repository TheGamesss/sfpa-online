import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3673"))

class ShipInteract extends MovieClip
{
    
    public var capt : MovieClip;
    
    public var compellerSkew : MovieClip;
    
    public var ink0 : MovieClip;
    
    public var ink1 : MovieClip;
    
    public var ink2 : MovieClip;
    
    public var ink3 : MovieClip;
    
    public var tentacleIntro : MovieClip;
    
    public function new()
    {
        super();
    }
    
    public function captSteer() : Void
    {
        this.capt.nextFrame();
        if (this.capt.currentFrameLabel == "steerLoop")
        {
            this.capt.gotoAndStop("steer");
        }
    }
    
    public function tentacleAttack(b : Dynamic) : String
    {
        var i : Int = 0;
        this.tentacleIntro.gotoAndStop(Math.floor(b - 280));
        if (this.tentacleIntro.currentFrame == 4)
        {
            Sounds.playSound("InkJump", x + 200, 1);
        }
        else if (this.tentacleIntro.currentFrame == 8)
        {
            Sounds.playSound("InkJump", x - 200, 1);
        }
        else if (this.tentacleIntro.currentFrame == 14)
        {
            Sounds.playSound("InkJump", x + 100, 1);
        }
        else if (this.tentacleIntro.currentFrame == 21)
        {
            Sounds.playSound("InkJump", x - 100, 1);
        }
        if (this.tentacleIntro.currentFrameLabel == "d")
        {
            Main.shakeScreen(100, 0, true);
            Sounds.playSoundSimple("InkBoom_1", 2);
            return "d";
        }
        if (this.tentacleIntro.currentFrame == 20)
        {
            this.capt.gotoAndStop("surprised");
        }
        else if (this.tentacleIntro.currentFrameLabel == "a" || this.tentacleIntro.currentFrameLabel == "b" || this.tentacleIntro.currentFrameLabel == "c")
        {
            Main.shakeScreen(50, 0, true);
            Sounds.playSoundSimple("InkBoom_0");
        }
        else
        {
            if (this.tentacleIntro.currentFrameLabel == "e")
            {
                gotoAndStop(2);
                for (i in 0...4)
                {
                    this["ink" + i].RedHurt = 0;
                    this["ink" + i].disabled = false;
                    this["ink" + i].gotoAndStop(1);
                }
                return "e";
            }
            Main.shakeScreen(10, 0, true);
        }
    }
}


