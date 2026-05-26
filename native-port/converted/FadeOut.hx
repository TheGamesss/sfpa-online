import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol1466"))

class FadeOut extends MovieClip
{
    
    public var LoadIt : String;
    
    public var DoorIt : String;
    
    public var fadeMusic : Bool;
    
    public function new(load : Dynamic, door : Dynamic)
    {
        super();
        this.LoadIt = load;
        this.DoorIt = door;
        staticInteractObjects.InteractEnterFrameArray.push(this);
        stop();
        x = Main.realStageX;
        y = Main.realStageY;
        scaleX = Main.originalStageX / 400;
        scaleY = Main.originalStageY / 250;
        mouseEnabled = false;
    }
    
    public function InteractEnterFrame() : Dynamic
    {
        if (currentFrame == totalFrames)
        {
            Main.FadeClip = null;
            Main.LoadIt = this.LoadIt;
            Main.DoorIt = this.DoorIt;
            staticInteractObjects.InteractEnterFrameArray.splice(staticInteractObjects.InteractEnterFrameArray.indexOf(this), 1);
            parent.removeChild(this);
        }
        else
        {
            nextFrame();
        }
    }
}


