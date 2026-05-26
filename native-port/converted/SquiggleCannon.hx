
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol2555"))

class SquiggleCannon extends StaticInteractObjects
{
    
    private var eRL : Float;
    
    private var eUD : Float;
    
    private var max : Int = 0;
    
    private var speed : Int = 0;
    
    private var b : Int = 0;
    
    private var interval : Int = 0;
    
    public function new(p : Dynamic)
    {
        super("SquiggleCannon", p.x, p.y, 1, 1, p.onRail, "nothing", -1);
        if (p.max != null)
        {
            this.max = p.max;
        }
        if (p.max != null)
        {
            this.speed = p.speed;
        }
        rotation = p.rotation;
        this.interval = p.interval;
        Backgrounds.backgroundsArray[onRail].addChild(this);
        angle = rotation * (Math.PI / 180);
        this.eRL = Math.sin(angle) * this.speed;
        this.eUD = -Math.cos(angle) * this.speed;
        InteractEnterFrameArray.push(this);
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (this.b > 0)
        {
            --this.b;
        }
        else
        {
            this.b = this.interval;
            if (StarlingInteract.arrayLength < this.max)
            {
                StarlingInteract.Spawn("looseSquiggle", x, y, 0, 1, this.eRL + Math.random() * 2, this.eUD + Math.random() * 2, onRail);
            }
        }
    }
}


