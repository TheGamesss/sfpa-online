
class LooseSquiggleStarling extends StarlingInteract
{
    
    public var myCollision : Collision;
    
    public function new(e : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, scale : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, id : Int = -1)
    {
        super(e, ex, ey, rot, scale, eRL, eUD, rail, id);
        this.myCollision = new Collision(rail);
        onRail = rail;
        this.myCollision.ItIs = e;
        this.myCollision.myVisible = this;
        this.myCollision.visible = false;
        this.myCollision.BallRes = 4;
        this.myCollision.isTall = this.myCollision.isWide = 10;
        this.myCollision.bounce = 0.8;
        this.myCollision.bounceThresh = 2;
        this.myCollision.rotPerc = 1 / this.myCollision.isTall;
        this.myCollision.overReach = 10;
        this.myCollision.mass = 5;
        ID = id;
    }
    
    override public function reset() : Void
    {
        downTime = 5;
        this.myCollision.resetOnPlatSides();
        this.myCollision.x = x;
        this.myCollision.y = y;
        this.myCollision.rotation = rotation;
        this.myCollision.moveRL = moveRL;
        this.myCollision.moveUD = moveUD;
        this.myCollision.onRail = onRail;
        collision.InteractObjectsArray.push(this.myCollision);
        this.myCollision.setGroundRail();
    }
    
    override public function interactsEnterFrame() : Bool
    {
        if (moveUD < 30)
        {
            moveUD += 1.5;
        }
        this.myCollision.moveUD = moveUD;
        if (downTime > 0)
        {
            --downTime;
        }
        return this.myCollision.fallOffscreen();
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (downTime == 0)
        {
            ++char.squiggleBuffer;
            char.squiggleBuffer > 0 && StarlingEffect.Spawn("SquigPop", x, y, Math.random() * 3.14, 1, moveRL, moveUD, onRail);
            return true;
        }
        return false;
    }
    
    override public function cleanUp() : Void
    {
        this.myCollision.interactRemoveFromArray(this.myCollision);
    }
}


