
class AScratchStarling extends StarlingInteract
{
    
    private var fakeX : Float = 0;
    
    private var fakeRL : Float = 0;
    
    private var fakeDist : Float = 0;
    
    private var RLx : Float = 0;
    
    private var RLy : Float = 0;
    
    private var wallAngle : Float = 0;
    
    private var originX : Float = 0;
    
    private var originY : Float = 0;
    
    private var distX : Float = 0;
    
    private var distY : Float = 0;
    
    public function new(e : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, scale : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, id : Int = -1)
    {
        isTall = 15;
        isWide = 15;
        super(e, ex, ey, rot, scale, eRL, eUD, rail, id);
    }
    
    override public function reset() : Void
    {
        this.RLx = Math.sin(rotation + 1.57);
        this.RLy = -Math.cos(rotation + 1.57);
        rotation = Math.random() * 3;
        currentFrame = as3hx.Compat.parseInt(Math.random() * 20) + 1;
        this.originX = x;
        this.originY = y;
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        this.distX = ex - x;
        this.distY = ey - y;
        if (Math.abs(this.distX) < isWide + char.isWide && Math.abs(this.distY) < isTall + char.isTall)
        {
            char.superHurtChar(20, true);
            if (Math.abs(this.distX) > Math.abs(this.distY) * 0.6)
            {
                char.x = x + (char.isWide + isWide) * makeOne(this.distX);
                if (char.moveRL * this.distX < 0)
                {
                    trace("stop");
                    char.moveRL = char.fakeRL = 0;
                }
            }
            else
            {
                char.y = y + (char.isTall + isTall) * makeOne(this.distY);
                if (char.moveUD * this.distY < 0)
                {
                    char.moveUD = 0;
                }
            }
        }
    }
    
    override public function interactsEnterFrame() : Bool
    {
        if (currentFrame == 26)
        {
            currentFrame = 1;
        }
        else
        {
            ++currentFrame;
        }
        if (Math.abs(this.fakeX) > this.fakeDist)
        {
            this.fakeRL -= (this.fakeX - this.fakeDist * this.fakeX / Math.abs(this.fakeX)) / bounce;
        }
        this.fakeX += this.fakeRL;
        moveRL = this.RLx * this.fakeRL;
        moveUD = this.RLy * this.fakeRL;
        x = this.originX + this.RLx * this.fakeX;
        y = this.originY + this.RLy * this.fakeX;
    }
}


