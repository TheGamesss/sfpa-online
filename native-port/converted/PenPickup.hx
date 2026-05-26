
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3705"))

class PenPickup extends StaticInteractObjects
{
    
    public function new(p : Dynamic)
    {
        super("PenPickup", p.x, p.y, 1, 1, 0, "nothing", -1);
        isTall = 30;
        isWide = 10;
        rotation = p.rotation;
        ItIs = "PenPickup";
        Backgrounds.backgroundsArray[0].addChild(this);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (char.onGround)
        {
            if (char.Status == "PenGet")
            {
                if (char.char.currentFrameLabel == "a")
                {
                    killInteract.push(this);
                }
            }
            else
            {
                char.gotoBuffer = "PenGet";
                char.fakeX = x;
            }
        }
    }
}


