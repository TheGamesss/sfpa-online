import starling.display.Sprite;

class ScrollingObject extends Sprite
{
    
    public var theX : Int;
    
    public var theY : Int;
    
    public var theZ : Int;
    
    public function new(ex : Dynamic, ey : Dynamic, ez : Dynamic)
    {
        super();
        this.theX = ex;
        this.theY = ey;
        this.theZ = ez;
    }
}


