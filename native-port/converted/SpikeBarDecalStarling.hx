
class SpikeBarDecalStarling extends StarlingDecals
{
    
    private var rotter : Float = 0;
    
    public function new(p : Dynamic)
    {
        isTall = as3hx.Compat.parseInt(p.scaleY * 100);
        isWide = as3hx.Compat.parseInt(p.scaleY * 100);
        super("spikeBarDecal", p.x, p.y, p.rotation, p.scaleX, p.scaleY, p.onRail, "nothing", -1);
        this.rotter = p.rotter;
        cleanUp = function() : Dynamic
                {
                };
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Void
    {
        if (char.gotoBuffer != "Hurt" && char.Status != "Hurt")
        {
            ax = Math.cos(rotation) * (x - ex) + Math.sin(rotation) * (y - ey);
            ay = Math.cos(rotation) * (y - ey) - Math.sin(rotation) * (x - ex);
            if (Math.abs(ax) < char.isTall + 10 && Math.abs(ay) < isTall + char.isTall)
            {
                char.superHurtChar(10, true);
            }
        }
    }
    
    override public function hitBaddie(ex : Float, ey : Float, eRL : Float, eUD : Float, baddie : Baddies) : Void
    {
        this.hitChar(ex, ey, eRL, eUD, baddie);
    }
    
    override public function decalEnterFrame() : Void
    {
        rotation += this.rotter * framin;
    }
}


