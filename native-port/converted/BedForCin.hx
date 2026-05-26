
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol5125"))

class BedForCin extends StaticInteractObjects
{
    
    private var disabled : Bool;
    
    public function new(p : Dynamic)
    {
        isWide = 120;
        isTall = 40;
        super("bedForCin", p.x, p.y, 1, 1, 0);
        Backgrounds.backgroundsArray[0].addChild(this);
        stop();
        visible = false;
    }
}


