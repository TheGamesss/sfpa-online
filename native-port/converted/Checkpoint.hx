
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol4967"))

class Checkpoint extends StaticInteractObjects
{
    
    private static var checkpointArray : Array<Checkpoint> = new Array<Checkpoint>();
    
    private static var currentCheckpoint : Int = -1;
    
    private static var currentScaleX : Int = 1;
    
    public function new(p : Dynamic)
    {
        super("Checkpoint", p.x, p.y, p.scaleX, p.scaleY, p.onRail, "nothing", -1);
        ID = checkpointArray.length;
        checkpointArray.push(this);
    }
    
    public static function getcurrentCheckpoint() : Int
    {
        return currentCheckpoint;
    }
    
    public static function resetCurrent() : Void
    {
        currentCheckpoint = -1;
    }
    
    public static function checkpointX() : Int
    {
        return checkpointArray[currentCheckpoint].x;
    }
    
    public static function checkpointY() : Int
    {
        return as3hx.Compat.parseInt(checkpointArray[currentCheckpoint].y + checkpointArray[currentCheckpoint].isTall);
    }
    
    public static function checkpointRail() : Int
    {
        return checkpointArray[currentCheckpoint].onRail;
    }
    
    public static function checkpointScaleX() : Int
    {
        return as3hx.Compat.parseInt(currentScaleX / Math.abs(currentScaleX));
    }
    
    public static function resetCheckpoints() : Void
    {
        checkpointArray = new Array<Checkpoint>();
        currentCheckpoint = -1;
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (currentCheckpoint != ID)
        {
            currentCheckpoint = as3hx.Compat.parseInt(ID);
        }
        if (Math.abs(eRL) > 1)
        {
            currentScaleX = as3hx.Compat.parseInt(eRL);
        }
    }
}


