
class DoodleGrassStarling extends StarlingDecals
{
    
    public function new(p : Dynamic)
    {
        isTall = 20;
        isWide = 15;
        super("doodleGrass", p.x, p.y, p.rotation, 1, 1, p.onRail, "nothing", -1);
        cleanUp = function() : Dynamic
                {
                };
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Void
    {
        this.hitAny(eRL, eUD);
    }
    
    override public function hitBaddie(ex : Float, ey : Float, eRL : Float, eUD : Float, baddie : Baddies) : Void
    {
        this.hitAny(eRL, eUD);
    }
    
    private function hitAny(eRL : Float, eUD : Float) : Void
    {
        if (currentFrame < 22 || currentFrame > 31 && currentFrame < 59 || currentFrame > 131 && currentFrame < 159)
        {
            if (eUD > 10 && Math.abs(eRL) < 10)
            {
                currentFrame = 25;
            }
            else if (eRL < 0)
            {
                currentFrame = 122;
            }
            else
            {
                currentFrame = 22;
            }
            realCurrent = currentFrame;
        }
        else if (currentFrame == 131)
        {
            realCurrent = currentFrame = 130;
        }
        else if (currentFrame == 31)
        {
            realCurrent = currentFrame = 30;
        }
        else if (Math.abs(eRL) > 10 && currentFrame != 130 && currentFrame != 30)
        {
            this.decalEnterFrame();
        }
    }
    
    override public function decalEnterFrame() : Void
    {
        realCurrent += framin;
        currentFrame = as3hx.Compat.parseInt(realCurrent);
        if (currentFrame == 20 || currentFrame == 66 || currentFrame == 166)
        {
            realCurrent = currentFrame = 1;
        }
    }
}


