
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol4297"))

class FadeInSpurt extends StaticInteractObjects
{
    
    private var spring : Float = 0;
    
    private var hitting : Bool;
    
    public var disabled : Bool = true;
    
    public function new(p : Dynamic)
    {
        isWide = 300;
        isTall = 200;
        super("fadeInSpurt", p.x, p.y, p.scaleX, p.scaleY, p.onRail);
        Backgrounds.backgroundsArray[p.onRail].addChild(this);
        InteractEnterFrameArray.push(this);
        this.disabled = !Char.hasShoot;
        gotoAndStop(Main.localSettings.language);
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (this.hitting)
        {
            this.spring = (1 - alpha) * 0.1;
        }
        else
        {
            this.spring = -0.2;
        }
        alpha += this.spring;
        if (alpha < 0)
        {
            alpha = 0;
        }
        else if (alpha > 1)
        {
            alpha = 1;
        }
        this.hitting = false;
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (!this.disabled)
        {
            this.hitting = true;
        }
    }
}


