
class InkDropStarling extends StarlingInteract
{
    
    public var groundY : Int;
    
    public var spawner : StaticInteractObjects;
    
    public function new(e : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, scale : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, id : Int = -1)
    {
        isWide = 2;
        isTall = 10;
        super(e, ex, ey, rot, scale, eRL, eUD, rail, id);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (char.alpha == 1 && y < this.groundY && visible)
        {
            char.wallRot = 0;
            char.hurtChar(35, 20, 5, char.makeOne(ex - x) * 8, 20);
            char.downTime = 60;
        }
    }
    
    override public function interactsEnterFrame() : Bool
    {
        if (visible)
        {
            if (currentFrame == 70)
            {
                return true;
            }
            if (y == this.groundY)
            {
                ++currentFrame;
            }
            else if (y + moveUD * 0.5 > this.groundY && moveUD > 0)
            {
                currentFrame = 38;
                moveUD = 0;
                y = this.groundY;
                scaleX *= -1;
                this.spawner.inkLand();
            }
            else if (currentFrame == 37)
            {
                currentFrame = 36;
            }
            else
            {
                moveUD += 0.8;
                if (currentFrame > 21 && moveUD < 0)
                {
                    if (currentFrame > 1)
                    {
                        --currentFrame;
                    }
                }
                else
                {
                    ++currentFrame;
                    if (scaleY < 0)
                    {
                        scaleY *= -1;
                    }
                }
            }
        }
        if (moveUD < 5 && currentFrame == 21)
        {
            currentFrame = 3;
        }
        this.halfEnterFrame();
        return false;
    }
    
    override public function halfEnterFrame() : Bool
    {
        y += moveUD * framin;
    }
    
    override public function reset() : Void
    {
        originY = Math.floor(y);
        halfArray.push(this);
    }
}


