
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol4043"))

class InkDripper extends StaticInteractObjects
{
    
    private var groundY : Int;
    
    private var myDrop : InkDropStarling;
    
    private var mySmoke : StarlingSmoke;
    
    public function new(p : Dynamic)
    {
        isWide = 2;
        isTall = 100;
        onRail = p.onRail;
        super("inkDripper", p.x, p.y, p.scaleX, p.scaleY, p.onRail, "nothing", -1);
        visible = false;
        InteractEnterFrameArray.push(this);
        this.groundY = y;
        for (i in 0...80)
        {
            if (collision.hitTestAllRaw(x, this.groundY + 24, onRail))
            {
                while (!collision.hitTestAllRaw(x, this.groundY + 15, onRail))
                {
                    ++this.groundY;
                }
                break;
            }
            this.groundY += 10;
        }
        gotoAndStop(Math.floor(Math.random() * 100) + 1);
        this.mySmoke = StarlingSmoke.Spawn("inkDripper", x, y, 0, scaleY, 0, 0, onRail);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (currentFrame < 44 && ey - y < char.isTall + height && char.alpha == 1 && visible)
        {
            char.wallRot = 0;
            char.hurtChar(10, 20, 5, char.makeOne(ex - x) * 8, 20);
            char.downTime = 60;
        }
    }
    
    override public function InteractEnterFrame() : Bool
    {
        nextFrame();
        isTall = as3hx.Compat.parseInt(height * 0.5);
        if (currentFrame == 20)
        {
            if (Math.abs(x - Main.cameraX) < 2000)
            {
                Sounds.playSound("InkJump", x, 1, onRail);
            }
        }
        if (currentFrameLabel == "a")
        {
            this.dripInk();
        }
        else if (currentFrame == totalFrames)
        {
            gotoAndStop(1);
        }
        this.mySmoke.currentFrame = currentFrame;
    }
    
    private function dripInk() : Void
    {
        this.myDrop = StarlingInteract.Spawn("inkDrop", x, y, 0, 1, 0, 0, onRail);
        this.myDrop.currentFrame = 1;
        this.myDrop.groundY = this.groundY;
        this.myDrop.spawner = this;
        this.myDrop.y = y + 121;
        this.myDrop.moveUD = 0;
    }
    
    public function inkLand() : Void
    {
        if (Math.abs(x - Main.cameraX) < 2000)
        {
            Sounds.playSound("InkLand", x, 1, onRail);
        }
    }
}


