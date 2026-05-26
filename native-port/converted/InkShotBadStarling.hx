
class InkShotBadStarling extends StarlingInteract
{
    
    private var lifetime : Int;
    
    public var inky : Bool = true;
    
    public function new(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, id : Int)
    {
        super(e, ex, ey, rot, scale, eRL, eUD, rail);
        ID = id;
    }
    
    override public function interactsEnterFrame() : Bool
    {
        if (this.lifetime > 0)
        {
            --this.lifetime;
            if (currentFrame == 8)
            {
                currentFrame = 1;
            }
            else
            {
                ++currentFrame;
            }
            return this.halfEnterFrame();
        }
        StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, scaleY * 0.2, moveRL * 0.25, moveUD * 0.25, onRail);
        return true;
    }
    
    override public function halfEnterFrame() : Bool
    {
        x += moveRL * framin;
        y += moveUD * framin;
        if (checkByName("inkShot", x, y, isWide + 20, isTall + 20, onRail) != null)
        {
            StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, scaleY * 0.2, moveRL * 0.5, moveUD * 0.5, onRail);
            return true;
        }
        return false;
    }
    
    override public function reset() : Void
    {
        this.lifetime = ID;
        halfArray.push(this);
        canAttackArray.push(this);
        isWide = as3hx.Compat.parseInt(5 * scaleY);
        isTall = as3hx.Compat.parseInt(5 * scaleY);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (char.hurtChar(30 * scale, 20, 4, moveRL * 0.25, 20))
        {
            char.rotter = moveRL * 3;
            Sounds.playSound("InkBurst", x, scale * 1.2, onRail);
            StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, scaleY * 0.3, moveRL * 0.4, moveUD * 0.4, onRail);
            return true;
        }
    }
    
    public function currentGetAttacked(ex : Float, ey : Float, angle : Float, char : Collision, hitMove : String, hitPower : Float, pow : Float = 1) : Bool
    {
        var ang : Float = -Math.atan2(-moveRL, -moveUD) + 0.1 - Math.random() * 0.2;
        Sounds.playSound("InkBurst", x, scale * 1.2, onRail);
        StarlingEffect.Spawn("Splat", x, y, Math.random() * 3.14, scaleY * 0.3, -moveRL * 0.4, -moveUD * 0.4, onRail);
        StarlingInteract.Spawn("inkShot", x, y, ang, scaleY, -Math.sin(ang) * 40, Math.cos(ang) * 40, onRail, 20);
        char.hitPause = hitPower * 0.2;
        char.updateInk(20);
        return true;
    }
    
    public function smashKnockback(e : Float) : Float
    {
        return e;
    }
}


