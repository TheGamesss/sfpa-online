
class StarlingShrapnel extends StarlingEffect
{
    
    private var rotter : Float;
    
    public function new(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, lop : Bool)
    {
        super(e, ex, ey, rot, scale, eRL, eUD, rail, lop);
    }
    
    override public function effectsEnterFrame() : Bool
    {
        moveUD += 1.5 * framin;
        rotation += this.rotter * (Math.PI / 180) * framin;
        x += moveRL * framin;
        y += moveUD * framin;
        return y > Main.MaxY / Main.stageRatios[onRail] + 400;
    }
    
    override public function setupEffect() : Void
    {
        this.rotter = Math.sqrt(moveRL * moveRL + moveUD * moveUD) * (Math.random() * 0.5 + 0.5) * moveRL / Math.abs(moveRL);
    }
}


