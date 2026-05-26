
class InkBubbleDecalStarling extends StarlingDecals
{
    
    private var anchorX : Int;
    
    public function new(p : Dynamic)
    {
        isTall = 20;
        isWide = 15;
        this.anchorX = p.x;
        super("inkBubbleDecal", p.x, p.y, p.rotation, 1, 1, p.onRail, "nothing", -1);
        realCurrent = currentFrame = as3hx.Compat.parseInt((numFrames - 1) * Math.random()) + 1;
        this.reset();
        cleanUp = function() : Dynamic
                {
                };
    }
    
    override public function decalEnterFrame() : Void
    {
        realCurrent += framin / scaleY * 0.5 + 0.3;
        currentFrame = as3hx.Compat.parseInt(realCurrent);
        if (realCurrent >= 46)
        {
            this.reset();
            realCurrent = currentFrame = 1;
        }
    }
    
    private function reset() : Void
    {
        scaleX = scaleY = Math.random() * 1 + 0.2;
        x = this.anchorX + Math.random() * 50 - 25;
        if (Math.random() > 0.5)
        {
            scaleX *= -1;
        }
    }
}


