
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3904"))

class InkThrower extends StaticInteractObjects
{
    
    private var groundY : Int;
    
    private var myDrop : InkDropStarling;
    
    private var dropN : Int = 0;
    
    private var rootN : Int = 0;
    
    private var power : Int = 0;
    
    private var total : Int = -1;
    
    private var type : String = "inkDrop";
    
    public function new(p : Dynamic)
    {
        onRail = p.onRail;
        super("inkThrower", p.x, p.y, p.scaleX, p.scaleY, p.onRail, "nothing", -1);
        Backgrounds.backgroundsArray[p.onRail].addChild(this);
        InteractEnterFrameArray.push(this);
        this.power = p.power;
        this.rootN = p.dropN;
        if (p.total != null)
        {
            this.total = p.total;
        }
        if (p.type != null)
        {
            this.type = p.type;
        }
        if (Math.random() > 0.5)
        {
            scaleX *= -1;
        }
        if (this.type == "inkDrop")
        {
            if (p.offsetX != null && p.offsetX != -1)
            {
                this.dropN = Math.round((x - p.offsetX) * 0.05);
            }
            else
            {
                this.dropN = Math.floor(Math.random() * 20);
            }
        }
        this.groundY = y - 4;
        stop();
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (currentFrame == totalFrames)
        {
            if (Math.random() > 0.5)
            {
                scaleX *= -1;
            }
            gotoAndStop(1);
            visible = false;
        }
        else if (currentFrame > 1)
        {
            nextFrame();
        }
        if (currentFrame == 15)
        {
            this.throwInk();
        }
        if (this.dropN > 0)
        {
            --this.dropN;
        }
        else if (this.total != 0)
        {
            if (this.type == "inkDrop")
            {
                this.dropN = this.rootN;
                gotoAndStop(2);
                visible = true;
            }
            else if (Math.abs(x - Char.CharArray[0].x) < 100)
            {
                --this.total;
                this.dropN = this.rootN;
                gotoAndStop(14);
                visible = true;
            }
        }
    }
    
    private function throwInk() : Void
    {
        if (this.type == "Baddie1")
        {
            new Baddie1({
                ItIs : "Baddie1",
                x : x,
                y : y,
                rotation : 0,
                scaleX : 1,
                scaleY : 0.5 + Math.random() * 0.8,
                onRail : 0,
                hatN : 0,
                moveRL : 0,
                moveUD : -this.power,
                autopilot : false,
                originX : x,
                tether : 400
            });
        }
        else
        {
            if (Math.abs(x - Main.cameraX) < 2000)
            {
                Sounds.playSound("InkJump", x, 1.5, onRail);
            }
            this.myDrop = StarlingInteract.Spawn("inkDrop", x, y, 0, 1.2, 0, 0, onRail);
            this.myDrop.currentFrame = 32;
            this.myDrop.groundY = this.groundY;
            this.myDrop.spawner = this;
            this.myDrop.y = y + 20;
            this.myDrop.moveUD = -this.power;
            this.myDrop.scaleY *= -1;
        }
    }
    
    public function inkLand() : Void
    {
        if (Math.abs(x - Main.cameraX) < 2000)
        {
            Sounds.playSound("FallInInk", x, 0.6, onRail);
        }
        StarlingEffect.Spawn("inkSplash", x, y, 0, 1, 0, 0, onRail);
    }
}


