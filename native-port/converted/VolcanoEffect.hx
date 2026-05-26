
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol264"))

class VolcanoEffect extends StaticInteractObjects
{
    
    private var triggered : Bool;
    
    private var from : WarpBox;
    
    public function new(ex : Dynamic, ey : Dynamic, esx : Dynamic, esy : Dynamic, f : Dynamic)
    {
        super("volcanoEffect", ex, ey, esx, esy, 3, "nothing", -1);
        InteractEnterFrameArray.push(this);
        this.from = f;
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (currentFrame == totalFrames)
        {
            this.from.changeProperties("dropBaddie", 1, 5, 10);
            Char.CharArray[0].maxRL = 20;
            rootHUD.HUD.shoutTheBox("RUN");
            Sounds.fadeOutMusic("Volcano_Slow", 0.005, "crossFade", 0.75);
            killInteract.push(this);
        }
        else
        {
            nextFrame();
            x = StarlingBackgrounds.volcanoBackground.x;
            y = StarlingBackgrounds.volcanoBackground.y;
            scaleX = scaleY = StarlingBackgrounds.volcanoBackground.scaleX;
        }
    }
}


