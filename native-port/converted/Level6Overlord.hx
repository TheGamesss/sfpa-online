import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol385"))

class Level6Overlord extends MovieClip
{
    
    public var pencilShell : MovieClip;
    
    public var callBack : Dynamic;
    
    private var step : Int = 0;
    
    private var dist : Int;
    
    public function new()
    {
        super();
        staticInteractObjects.InteractEnterFrameArray.push(this);
        stop();
    }
    
    public function InteractEnterFrame() : Dynamic
    {
        var _sw28_ = (this.step);        

        switch (_sw28_)
        {
            case 0:
                this.dist = Char.checkClosest(2725, -730, 0);
                if (this.dist < 1000 && this.dist > 0)
                {
                    ++this.step;
                }
            case 1:
                nextFrame();
                if (currentFrameLabel == "1")
                {
                    ++this.step;
                }
            case 2:
                this.dist = Char.checkClosest(3170, -730, 0);
                if (this.dist < 1000 && this.dist > 0)
                {
                    ++this.step;
                }
            case 3:
                nextFrame();
                if (currentFrameLabel == "2")
                {
                    ++this.step;
                }
            case 4:
                this.dist = Char.checkClosest(3532, -730, 0);
                if (this.dist < 1000 && this.dist > 0)
                {
                    ++this.step;
                }
            case 5:
                nextFrame();
                if (currentFrameLabel == "3")
                {
                    this.pencilShell.sparks.stop();
                    this.pencilShell.sparks.visible = false;
                    ++this.step;
                }
            case 6:
                nextFrame();
                if (currentFrameLabel == "4")
                {
                    gotoAndStop("loop");
                }
        }
    }
}


