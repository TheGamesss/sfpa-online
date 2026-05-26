
class SpikeDecalStarling extends StarlingDecals
{
    
    private var hurtPointX : Int;
    
    private var hurtPointY : Int;
    
    private var centerPointX : Int;
    
    private var centerPointY : Int;
    
    public function new(p : Dynamic)
    {
        isTall = 50;
        isWide = 50;
        super("spikeDecal", p.x, p.y, p.rotation, p.scaleX, p.scaleY, p.onRail, "nothing", -1);
        this.hurtPointX = x + Math.sin(rotation) * (40 * p.scaleY);
        this.hurtPointY = y + -Math.cos(rotation) * (40 * p.scaleY);
        this.centerPointX = x + Math.sin(rotation) * (20 * p.scaleY);
        this.centerPointY = y + -Math.cos(rotation) * (20 * p.scaleY);
        cleanUp = function() : Dynamic
                {
                };
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Void
    {
        if (char.gotoBuffer != "Hurt" && char.Status != "Hurt")
        {
            if (Math.abs(this.hurtPointX - ex) < char.isWide + 10 && Math.abs(this.hurtPointY - ey) < char.isTall || Math.abs(this.centerPointX - ex) < char.isWide + 10 && Math.abs(this.centerPointY - ey) < char.isTall)
            {
                char.superHurtChar(10, true);
            }
        }
    }
    
    override public function hitBaddie(ex : Float, ey : Float, eRL : Float, eUD : Float, baddie : Baddies) : Void
    {
        if ((ex - x) * baddie.facing < 0 && Math.abs(this.centerPointX - ex) < baddie.isWide + 40 && Math.abs(this.centerPointY - ey) < baddie.isTall)
        {
            baddie.facing *= -1;
            baddie.scaleX *= -1;
        }
    }
}


