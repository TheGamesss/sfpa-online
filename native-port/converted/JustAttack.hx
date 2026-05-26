
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3735"))

class JustAttack extends StaticInteractObjects
{
    
    public var downTime : Int = 0;
    
    public var health : Int = 1;
    
    public var myObject : Dynamic = [];
    
    private var canHit : Bool = true;
    
    public var inky : Bool = true;
    
    public function new(p : Dynamic)
    {
        super("inkPipe", p.x, p.y, p.scaleX, p.scaleY, p.onRail, "nothing", -1);
        Backgrounds.backgroundsArray[onRail].addChild(this);
        rotation = p.rotation;
        InteractEnterFrameArray.push(this);
        ID = p.warpDoor;
        scaleY = p.scaleX;
        visible = false;
        canAttackArray.push(this);
        stop();
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (this.downTime > 0)
        {
            --this.downTime;
        }
    }
    
    public function currentGetAttacked(ex : Float, ey : Float, angle : Float, char : Collision, hitMove : String, hitPower : Float, pow : Float = 1) : Bool
    {
        if (cast(this.canHit, Bool) && this.downTime == 0)
        {
            if (hitPower < 20)
            {
                this.downTime = 5;
            }
            else
            {
                this.downTime = 10;
            }
            char.hitPause = hitPower * 0.1 + 1;
            this.downTime += hitPower * 0.1 + 1;
            char.fakeRL = -2 * char.scaleX;
            char.moveRL = -2 * char.scaleX;
            if (this.myObject.fromJustAttack(hitPower, ID))
            {
                this.canHit = false;
            }
            return true;
        }
        return false;
    }
    
    public function setCanHit(e : Bool) : Void
    {
        this.canHit = e;
    }
    
    public function onKilled() : Void
    {
    }
    
    public function smashKnockback(e : Float) : Float
    {
        return e;
    }
}


