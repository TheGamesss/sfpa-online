
class SuperMask extends StaticInteractObjects
{
    
    private var tempForce : Bool;
    
    public function new(p : Dynamic)
    {
        isWide = as3hx.Compat.parseInt(p.scaleX * 50 + 50);
        isTall = as3hx.Compat.parseInt(p.scaleY * 50 + 60);
        super("superMask", p.x, p.y, p.scaleX, p.scaleY, 0);
        Backgrounds.backgroundsArray[onRail].addChild(this);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (Math.abs(ex - x) > isWide - 30 || Math.abs(ey - y) > isTall - 30)
        {
            char.toggleForceBitmap(false);
        }
        else
        {
            char.toggleForceBitmap(true);
        }
    }
}


