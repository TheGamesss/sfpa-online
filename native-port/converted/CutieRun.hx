import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol4679"))

class CutieRun extends MovieClip
{
    
    public var head : MovieClip;
    
    public var onRail : Int;
    
    public var ItIs : String = "cutieBob";
    
    public function new(ex : Dynamic, ey : Dynamic, rail : Dynamic)
    {
        super();
        x = ex;
        y = ey;
        this.onRail = rail;
        Backgrounds.backgroundsArray[rail].addChild(this);
        staticInteractObjects.InteractEnterFrameArray.push(this);
        staticInteractObjects.HalfInteractEnterFrameArray.push(this);
        this.head.gotoAndStop("forwardWindHair");
    }
    
    public function InteractEnterFrame() : Dynamic
    {
        if (currentFrame == totalFrames)
        {
            gotoAndStop(1);
        }
        else
        {
            nextFrame();
        }
        this.HalfInteractEnterFrame();
    }
    
    public function HalfInteractEnterFrame() : Void
    {
        if (x < 1220)
        {
            x += 8 * Main.framin;
            while (Main.AllEverything.ground0.hitTestPoint(x, y + 3, true))
            {
                --y;
            }
            while (!Main.AllEverything.ground0.hitTestPoint(x, y + 4, true))
            {
                ++y;
            }
        }
        else
        {
            Main.saveProgress("cutieIsGone", true);
            staticInteractObjects.killInteract.push(this);
        }
    }
}


