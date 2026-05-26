
class InkShotStarling extends StarlingInteract
{
    
    private var lifetime : Int;
    
    public function new(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, id : Int)
    {
        super(e, ex, ey, rot, scale, eRL, eUD, rail);
        isWide = isTall = 5;
        ID = id;
    }
    
    override public function interactsEnterFrame() : Bool
    {
        if (this.lifetime > 0)
        {
            --this.lifetime;
            StarlingEffect.Spawn("inkTrail" + as3hx.Compat.parseInt(Math.random() * 3), x, y, rotation, 1, moveRL * 0.05, moveUD * 0.05, onRail);
            this.halfEnterFrame();
            if (aWall.checkOutlines(x, y, isWide, isTall, onRail))
            {
                Sounds.playSound("InkSplat", x, 1, onRail);
                StarlingEffect.Spawn("inkImpact" + as3hx.Compat.parseInt(Math.random() * 3), x, y, rotation, 1, -moveRL * 0.2, -moveUD * 0.2, onRail);
                StarlingEffect.Spawn("Splat", x, y, Math.random() * 6, scaleY * 0.3, moveRL * 0.4, moveUD * 0.4, onRail);
                return true;
            }
            if (staticInteractObjects.checkInk(x, y, moveRL, isWide, isTall, onRail, this))
            {
                Sounds.playSound("InkSplat", x, 0.5, onRail);
                StarlingEffect.Spawn("Splat", x, y, Math.random() * 6, scaleY * 0.3, moveRL * 0.4, moveUD * 0.4, onRail);
                return true;
            }
            return;
        }
        StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, scaleY * 0.2, moveRL * 0.5, moveUD * 0.5, onRail);
        return true;
    }
    
    override public function halfEnterFrame() : Bool
    {
        if (currentFrame == 8)
        {
            currentFrame = 1;
        }
        else
        {
            ++currentFrame;
        }
        x += moveRL * framin;
        y += moveUD * framin;
    }
    
    override public function reset() : Void
    {
        this.lifetime = ID;
        halfArray.push(this);
    }
    
    override public function hitBaddie(ex : Float, ey : Float, eRL : Float, eUD : Float, bad : Baddies) : Bool
    {
        if (bad.canGetShot && bad.downTime == 0)
        {
            if (bad.Projectile(x, y, moveRL))
            {
                StarlingEffect.Spawn("inkImpact" + as3hx.Compat.parseInt(Math.random() * 3), x + moveRL * 0.3, y + moveUD * 0.3, rotation, -scaleX * 1.3, 0, 0, onRail);
                StarlingEffect.Spawn("Splat", x, y, Math.random() * 6, scaleY * 0.3, moveRL * 0.3, moveUD * 0.3, onRail);
                if (bad.isWide > 200)
                {
                    return true;
                }
                scaleY -= 0.3;
                scaleX *= scaleY / scaleX;
                return scaleY < 0.3;
            }
            return false;
        }
    }
}


