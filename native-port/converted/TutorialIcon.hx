
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol886"))

class TutorialIcon extends StaticInteractObjects
{
    
    private var disabled : Bool;
    
    private var b : Int;
    
    private var frame : Int;
    
    private var stamp : StarlingSmoke;
    
    public function new(p : Dynamic)
    {
        isWide = 20;
        isTall = 20;
        onRail = p.onRail;
        this.frame = p.frame;
        super("tutorialIcon", p.x, p.y, p.scaleX, p.scaleY, p.onRail);
        visible = false;
        if (p.hide)
        {
            this.disabled = true;
            isWide = 0;
        }
        else
        {
            this.stamp = StarlingSmoke.Spawn("tutorialIconStamp", x, y, 0, scaleX, 0, 0, onRail);
        }
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (!this.disabled)
        {
            this.disabled = true;
            Main.TutorialGame(true, this.frame);
            InteractEnterFrameArray.push(this);
        }
        if (isWide > 0)
        {
            this.stamp.alpha = 0.5;
        }
    }
    
    override public function InteractEnterFrame() : Bool
    {
        this.stamp.alpha += 0.02;
        if (this.stamp.alpha > 0.9)
        {
            this.stamp.alpha = 1;
            InteractEnterFrameArray.splice(Lambda.indexOf(InteractEnterFrameArray, this), 1);
            this.disabled = false;
        }
    }
    
    public function enable(e : Bool) : Void
    {
        if (this.disabled)
        {
            this.stamp = StarlingSmoke.Spawn("tutorialIconStamp", x, y, 0, scaleX, 0, 0, onRail);
        }
        this.disabled = !e;
        isWide = 20;
    }
    
    override public function cleanUp() : Void
    {
        if (this.stamp != null)
        {
            this.stamp.goSwim();
            this.stamp = null;
        }
    }
}


