import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol856"))

class VictoryScreen extends MovieClip
{
    
    public function new()
    {
        super();
    }
    
    public function elementEnterFrame() : Void
    {
        nextFrame();
        if (currentFrameLabel == "a")
        {
            gotoAndStop("loopa");
        }
    }
}


