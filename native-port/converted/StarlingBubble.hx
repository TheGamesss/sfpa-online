
class StarlingBubble extends StarlingEffect
{
    
    public function new(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, lop : Bool)
    {
        super(e, ex, ey, rot, scale, eRL, eUD, rail, lop);
    }
    
    override public function effectsEnterFrame() : Bool
    {
        x += moveRL * Main.framin;
        y += moveUD * Main.framin;
        return nextFrameStep(framin);
    }
}


