
class GrassPopStarling extends StarlingInteract
{
    
    private var canPop : Bool = true;
    
    public function new(e : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, scale : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, id : Int = -1)
    {
        super("grassPop", ex, ey, rot, scale, eRL, eUD, rail, id);
        isTall = 25;
        isWide = 25;
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        distRL = x - ex;
        distUD = y - ey;
        if (char.Status == "DownSlide" || char.Status == "Roll")
        {
            if (Math.abs(distRL) < char.isWide + isWide && Math.abs(distUD) < char.isTall + isTall)
            {
                dontCheat[Main.LevelLoaded][ID] = true;
                Sounds.playSound("Popper", x, 1, onRail);
                StarlingInteract.Spawn("looseSquiggle", x + Math.sin(rotation) * 5, y + -Math.cos(rotation) * 5, 0, 1, Math.sin(rotation) * 15, -Math.cos(rotation) * 15, onRail);
                StarlingEffect.Spawn("popEffect", x, y, Math.random() * 3, 1, 0, 0, onRail);
                this.canPop = false;
                return true;
            }
            return;
        }
        return false;
    }
}


