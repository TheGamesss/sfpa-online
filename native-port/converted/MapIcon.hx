import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3730"))

class MapIcon extends StaticInteractObjects
{
    public var getDisabled(get, never) : Bool;

    
    public var jump : MovieClip;
    
    private var disabled : Bool;
    
    private var spring : Float;
    
    private var b : Int;
    
    private var select : Int = -1;
    
    public function new(p : Dynamic)
    {
        isWide = 20;
        isTall = 20;
        alpha = 0.8;
        this.b = 120;
        if (p.select != null)
        {
            this.select = p.select;
        }
        super("MapIcon", p.x, p.y, 1, 1, p.onRail);
        if (Main.world4Progress.canMapAround)
        {
            this.patch();
        }
        else
        {
            this.disabled = true;
        }
        this.jump.upgrades.visible = false;
    }
    
    private function get_getDisabled() : Bool
    {
        return this.disabled;
    }
    
    public function patch() : Void
    {
        this.disabled = false;
        InteractEnterFrameArray.push(this);
        Backgrounds.backgroundsArray[onRail].addChild(this);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (!this.disabled)
        {
            this.disabled = true;
            this.spring = 0.2;
            this.jump.y = 0;
            Sounds.playSoundSimple("Pause");
        }
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (this.disabled)
        {
            if (scaleX + this.spring > 0)
            {
                scaleX += this.spring;
                this.spring += -scaleX * 0.05;
            }
            else if (!(scaleX == 0 && this.spring == 0))
            {
                this.spring = scaleX = scaleY = 0;
                Main.FadeItOut("MapScreen", this.select);
            }
            scaleY = scaleX;
        }
        else
        {
            if (this.b > 0)
            {
                --this.b;
            }
            else
            {
                this.b = 90;
            }
            if (this.b == 8 || this.b == 20)
            {
                this.spring = -10;
            }
            this.spring += 1.5;
            this.jump.y += this.spring;
            if (this.jump.y > 0)
            {
                this.jump.y = 0;
                this.spring = 0;
            }
        }
    }
}


