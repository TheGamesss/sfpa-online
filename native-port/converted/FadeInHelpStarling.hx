
class FadeInHelpStarling extends StarlingInteract
{
    
    @:allow()
    private var spring : Float = 0;
    
    @:allow()
    private var hitting : Bool;
    
    public function new(e : String, ex : Int, ey : Int, rot : Float, scale : Float, eRL : Float, eUD : Float, rail : Int, id : Int)
    {
        super(e, ex, ey, rot, scale, 0, 0, rail);
        skipMesh = true;
    }
    
    override public function interactsEnterFrame() : Bool
    {
        if (this.hitting)
        {
            this.spring = (1 - alpha) * 0.1;
        }
        else
        {
            this.spring = -0.2;
        }
        return this.halfEnterFrame();
    }
    
    override public function halfEnterFrame() : Bool
    {
        alpha += this.spring * framin;
        this.hitting = false;
        return false;
    }
    
    override public function reset() : Void
    {
        halfArray.push(this);
        isWide = 200;
        isTall = 200;
        alpha = 0;
        currentFrame = Lambda.indexOf(["English", "Spanish", "French", "Italian", "Portuguese", "German", "Russian"], Main.localSettings.language) + 1;
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (Char.hasPen)
        {
            this.hitting = true;
        }
    }
}


