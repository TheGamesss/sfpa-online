
class InkPipeStarling extends StarlingInteract
{
    
    private var baddieInterval : Int;
    
    private var b : Int = 0;
    
    private var shootX : Int;
    
    private var shootY : Int;
    
    private var shootRL : Float;
    
    private var shootUD : Float;
    
    private var lifetime : Int;
    
    private var spring : Float;
    
    private var anchorX : Int;
    
    private var anchorY : Int;
    
    public function new(e : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, scale : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, id : Int = -1)
    {
        super(e, ex, ey, rot, scale, eRL, eUD, rail, id);
    }
    
    override public function interactsEnterFrame() : Bool
    {
        if (this.b > 0)
        {
            --this.b;
        }
        else
        {
            this.b = this.baddieInterval;
            Sounds.playSound("ExitBox", x, 0.5, onRail);
            Sounds.playSound("InkJump", x, 1, onRail);
            StarlingInteract.Spawn("inkShotBad", this.shootX, this.shootY, rotation, 1.8 * scaleY, this.shootRL, this.shootUD, onRail, this.lifetime);
            StarlingEffect.Spawn("Splat", x, y, Math.random() * 6.28, scaleY * 0.3, this.shootRL * 0.5, this.shootUD * 0.5, onRail);
            this.spring = 0.25;
        }
        this.spring += (1 - scaleY) * 0.2;
        this.spring *= 0.8;
        scaleY += this.spring;
        scaleX = 1 + 1 - scaleY;
        x = this.anchorX + this.shootRL * scaleY;
        y = this.anchorY + this.shootUD * scaleY;
        return false;
    }
    
    override public function reset() : Void
    {
        this.lifetime = Math.floor(ID * 0.001);
        this.baddieInterval = ID - this.lifetime * 1000;
        this.spring = 0;
        this.shootX = x + -Math.sin(rotation) * 10;
        this.shootY = y + Math.cos(rotation) * 10;
        this.shootRL = -Math.sin(rotation) * 20;
        this.shootUD = Math.cos(rotation) * 20;
        this.anchorX = x - this.shootRL;
        this.anchorY = y - this.shootUD;
    }
}


