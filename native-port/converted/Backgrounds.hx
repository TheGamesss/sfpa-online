import flash.display.*;
import flash.utils.*;

class Backgrounds extends Sprite
{
    
    public static var backgroundsN : Int;
    
    public static var backgroundsArray : Array<Dynamic> = new Array<Dynamic>();
    
    public static var AllBitmaps : Array<Dynamic> = new Array<Dynamic>();
    
    public var container : Dynamic;
    
    public var backContainer : Dynamic;
    
    public function new(toFront : Dynamic)
    {
        super();
        this.container = new Sprite();
        addChild(this.container);
        this.backContainer = new Sprite();
        addChild(this.backContainer);
        if (toFront != null)
        {
            backgroundsArray.unshift(this);
        }
        else
        {
            backgroundsArray.push(this);
        }
    }
    
    public static function flushOne(i : Dynamic) : Dynamic
    {
        var b : Int = as3hx.Compat.parseInt(Reflect.field(backgroundsArray, Std.string(i)).numChildren);
        for (n in 0...b)
        {
            if (Reflect.field(backgroundsArray, Std.string(i)).parent != null)
            {
                Reflect.field(backgroundsArray, Std.string(i)).removeChildAt(0);
            }
        }
        Reflect.field(backgroundsArray, Std.string(i)).parent.removeChild(Reflect.field(backgroundsArray, Std.string(i)));
    }
    
    public static function flushBackgrounds() : Dynamic
    {
        var b : Int = 0;
        for (i in 0...backgroundsN)
        {
            b = as3hx.Compat.parseInt(Reflect.field(backgroundsArray, Std.string(i)).numChildren);
            for (n in 0...b)
            {
                if (Reflect.field(backgroundsArray, Std.string(i)).parent != null)
                {
                    Reflect.field(backgroundsArray, Std.string(i)).removeChildAt(0);
                }
            }
            Reflect.field(backgroundsArray, Std.string(i)).parent.removeChild(Reflect.field(backgroundsArray, Std.string(i)));
        }
        for (i in 0...AllBitmaps.length)
        {
            Reflect.field(AllBitmaps, Std.string(i)).dispose();
        }
        backgroundsArray = [];
        AllBitmaps = [];
    }
    
    public static function flushStranglers() : Dynamic
    {
        var b : Dynamic = 0;
        for (i in 0...backgroundsN)
        {
            b = as3hx.Compat.parseInt(Reflect.field(backgroundsArray, Std.string(i)).numChildren);
            for (n in 0...b)
            {
                if (Type.getClassName(Reflect.field(backgroundsArray, Std.string(i)).getChildAt(n)) != "flash.display::Sprite" && Type.getClassName(Reflect.field(backgroundsArray, Std.string(i)).getChildAt(n)) != "flash.display::MovieClip")
                {
                    Reflect.field(backgroundsArray, Std.string(i)).removeChildAt(n);
                    --n;
                    b--;
                }
            }
        }
    }
}


