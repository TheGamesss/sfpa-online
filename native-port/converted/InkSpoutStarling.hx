
class InkSpoutStarling extends StarlingInteract
{
    
    public function new(e : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, scale : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, id : Int = -1)
    {
        isWide = 40;
        isTall = 10;
        super(e, ex, ey, rot, scale, eRL, eUD, rail, id);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        char.updateInk(20);
    }
    
    override public function interactsEnterFrame() : Bool
    {
        ++currentFrame;
        if (currentFrame > 36)
        {
            currentFrame = 1;
        }
    }
}


