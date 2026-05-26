import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol5674"))

class TipFly extends MovieClip
{
    
    private var moveRL : Float;
    
    private var moveUD : Float;
    
    private var rotter : Float;
    
    public var b : Int = 100;
    
    public function new(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, rot : Dynamic, char : Dynamic)
    {
        super();
        char.parent.addChild(this);
        staticInteractObjects.InteractEnterFrameArray.push(this);
        staticInteractObjects.HalfInteractEnterFrameArray.push(this);
        x = ex;
        y = ey;
        this.moveRL = eRL;
        this.moveUD = eUD;
        this.rotter = rot;
        stop();
    }
    
    public function InteractEnterFrame() : Dynamic
    {
        ++this.moveUD;
        x += this.moveRL * Main.framin;
        y += this.moveUD * Main.framin;
        rotation += this.rotter * Main.framin;
        if (this.b > 0)
        {
            --this.b;
        }
        else
        {
            staticInteractObjects.InteractEnterFrameArray.splice(staticInteractObjects.InteractEnterFrameArray.indexOf(this), 1);
            staticInteractObjects.HalfInteractEnterFrameArray.splice(staticInteractObjects.HalfInteractEnterFrameArray.indexOf(this), 1);
            this.parent.removeChild(this);
        }
    }
    
    public function HalfInteractEnterFrame() : Dynamic
    {
        x += this.moveRL * Main.framin;
        y += this.moveUD * Main.framin;
        rotation += this.rotter * Main.framin;
    }
    
    public function hitChar() : Dynamic
    {
    }
}


