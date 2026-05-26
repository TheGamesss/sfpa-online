import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol423"))

class Level3Overlord extends MovieClip
{
    
    public var callBack : Dynamic;
    
    public function new()
    {
        super();
        staticInteractObjects.InteractEnterFrameArray.push(this);
        if (Main.LevelStatus == "Normal")
        {
            if (Main.crossLevelStatus != "speechBubbled")
            {
                new BigSpeechBubble(15, 15, function() : Dynamic
                {
                });
                Main.crossLevelStatus = "speechBubbled";
            }
            else
            {
                new BigSpeechBubble(16, 16, function() : Dynamic
                {
                });
            }
        }
    }
    
    public function InteractEnterFrame() : Dynamic
    {
        if (currentFrameLabel != "2" && currentFrameLabel != "9")
        {
            nextFrame();
        }
        if (currentFrame == 158)
        {
            Main.MinY -= 200;
            Main.setMaxZ();
        }
        switch (currentFrameLabel)
        {
            case "1", "3", "5":
                Main.shakeScreen(20, 0, true);
            case "4", "6", "7", "8":
                ++this.callBack.step;
        }
    }
}


