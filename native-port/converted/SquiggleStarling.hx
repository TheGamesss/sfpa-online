
class SquiggleStarling extends StarlingInteract
{
    
    public function new(e : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, scale : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, id : Int = -1)
    {
        super(e, ex, ey, rot, scale, eRL, eUD, rail, id);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (onRail < backgroundsN)
        {
            dontCheat[Main.LevelLoaded][ID] = true;
        }
        else
        {
            dontCheat[Main.LevelLoaded + "_" + onRail][ID] = true;
        }
        ++char.squiggleBuffer;
        char.squiggleBuffer > 0 && StarlingEffect.Spawn("SquigPop", x, y, Math.random() * 3, 1, eRL * 0.25, eUD * 0.25, onRail);
        return true;
    }
}


