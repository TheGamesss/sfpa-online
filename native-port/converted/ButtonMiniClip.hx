import flash.display.SimpleButton;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol869"))

class ButtonMiniClip extends StaticInteractObjects
{
    
    public var MiniClip : SimpleButton;
    
    public function new(p : Dynamic)
    {
        super("buttonMiniClip", p.x, p.y, 1, 1, 0, "nothing", -1);
        Backgrounds.backgroundsArray[0].addChild(this);
    }
}


