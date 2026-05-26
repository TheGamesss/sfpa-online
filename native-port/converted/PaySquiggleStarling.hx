
class PaySquiggleStarling extends StarlingInteract
{
    
    public function new(e : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, scale : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, id : Int = -1)
    {
        super(e, ex, ey, rot, scale, eRL, eUD, rail, id);
    }
    
    override public function interactsEnterFrame() : Bool
    {
        moveUD -= 2;
        this.halfEnterFrame();
    }
    
    override public function halfEnterFrame() : Bool
    {
        x += moveRL * framin;
        y += moveUD * framin;
        rotation -= 1 * framin;
        return y < -400;
    }
    
    override public function reset() : Void
    {
        halfArray.push(this);
    }
}


