import flash.display.Sprite;

class BackgroundObjects extends Sprite
{
    
    public static var originalStageX : Int;
    
    public static var originalStageY : Int;
    
    public static var cameraFocalLength : Int = 200;
    
    public static var backgroundObjectssArray : Dynamic = new Array<Dynamic>();
    
    public function new()
    {
        super();
    }
    
    public static function scrollBackgroundObjects(cameraX : Dynamic, cameraY : Dynamic, cameraZ : Dynamic) : Dynamic
    {
        var ratio : Float = Math.NaN;
        for (i in 0...backgroundObjectssArray.length)
        {
            ratio = cameraFocalLength / (cameraFocalLength + Reflect.field(backgroundObjectssArray, Std.string(i)).theZ - cameraZ) * Main.overRatio;
            if (ratio > 0)
            {
                Reflect.setField(backgroundObjectssArray, Std.string(i), true).visible;
                Reflect.setField(backgroundObjectssArray, Std.string(i), (Reflect.field(backgroundObjectssArray, Std.string(i)).theX - cameraX) * ratio + originalStageX).x;
                Reflect.setField(backgroundObjectssArray, Std.string(i), (Reflect.field(backgroundObjectssArray, Std.string(i)).theY - cameraY) * ratio + originalStageY).y;
                Reflect.setField(backgroundObjectssArray, Std.string(i), Reflect.setField(backgroundObjectssArray, Std.string(i), ratio).scaleY).scaleX;
            }
            else
            {
                Reflect.setField(backgroundObjectssArray, Std.string(i), false).visible;
            }
        }
    }
    
    public static function addObject(e : Dynamic, ez : Dynamic) : Dynamic
    {
        e.theX = e.x;
        e.theY = e.y;
        e.theZ = ez;
        backgroundObjectssArray.push(e);
    }
    
    private function objectEnterFrame() : Dynamic
    {
    }
}


