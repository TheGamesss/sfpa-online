import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol332"))

class ShipAndBaddie extends MovieClip
{
    
    public var onRail : Int;
    
    public var ItIs : String = "cutieBob";
    
    public function new(p : Dynamic)
    {
        super();
        x = p.x;
        y = p.y;
        this.onRail = p.onRail;
        Backgrounds.backgroundsArray[this.onRail].addChild(this);
        staticInteractObjects.InteractEnterFrameArray.push(this);
        staticInteractObjects.HalfInteractEnterFrameArray.push(this);
    }
    
    public function InteractEnterFrame() : Dynamic
    {
    }
    
    public function HalfInteractEnterFrame() : Void
    {
        x -= 8;
    }
}


