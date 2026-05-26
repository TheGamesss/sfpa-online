import flash.display.MovieClip;
import flash.utils.*;

class JustALoop extends MovieClip
{
    
    public var catBody : MovieClip;
    
    public var catTail : MovieClip;
    
    public var head : MovieClip;
    
    public var item : MovieClip;
    
    @:allow()
    private var ItIs : String;
    
    @:allow()
    private var which : String;
    
    @:allow()
    private var loopRand : Int = 0;
    
    @:allow()
    private var rand : Int = 0;
    
    @:allow()
    private var nested : Array<Dynamic> = [];
    
    public function new()
    {
        super();
        staticInteractObjects.InteractEnterFrameArray.push(this);
        gotoAndStop(Math.floor(Math.random() * totalFrames) + 1);
        for (i in 0...this.numChildren)
        {
            if (Type.getClassName(this.getChildAt(i)) == "flash.display::MovieClip")
            {
                this.nested.push(this.getChildAt(i).name);
            }
        }
    }
    
    public static function findByWhich(e : Dynamic) : JustALoop
    {
        var i : Int = 0;
        var l : Int = staticInteractObjects.InteractEnterFrameArray.length;
        while (i < l)
        {
            if (staticInteractObjects.InteractEnterFrameArray[i].ItIs == e)
            {
                return staticInteractObjects.InteractEnterFrameArray[i];
            }
            i++;
        }
    }
    
    public function InteractEnterFrame() : Dynamic
    {
        if (this.rand > 0)
        {
            --this.rand;
        }
        else if (currentFrame == totalFrames)
        {
            gotoAndStop(1);
            this.rand = Math.random() * this.loopRand;
        }
        else
        {
            nextFrame();
        }
        for (i in 0...this.nested.length)
        {
            if (this[this.nested[i]].currentFrame == this[this.nested[i]].totalFrames)
            {
                this[this.nested[i]].gotoAndStop(1);
            }
            else
            {
                this[this.nested[i]].nextFrame();
            }
        }
    }
}


