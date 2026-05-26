
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol1445"))

class FadeOutTBC extends FadeOut
{
    
    public function new(load : Dynamic, door : Dynamic)
    {
        super(load, door);
    }
    
    override public function InteractEnterFrame() : Dynamic
    {
        if (currentFrameLabel == "wait")
        {
            if (Main.LevelLoaded != "TurtleWarp")
            {
                Main.LoadIt = "TurtleWarp";
            }
        }
        else if (currentFrame == totalFrames)
        {
            Main.LoadIt = LoadIt;
        }
        else
        {
            nextFrame();
        }
    }
}


