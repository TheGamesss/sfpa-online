
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3942"))

class InkSpout extends StaticInteractObjects
{
    
    public function new(p : Dynamic)
    {
        isWide = 40;
        isTall = 10;
        super("inkSpout", p.x, p.y, p.scaleX, p.scaleY, 0, "nothing", -1);
        Backgrounds.backgroundsArray[0].addChild(this);
        stop();
        InteractEnterFrameArray.push(this);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        char.updateInk(2);
    }
    
    override public function InteractEnterFrame() : Bool
    {
        nextFrame();
        if (currentFrameLabel == "a")
        {
            gotoAndStop(1);
        }
    }
}


