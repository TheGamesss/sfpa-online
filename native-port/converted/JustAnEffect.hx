import flash.display.MovieClip;

class JustAnEffect extends MovieClip
{
    
    public function new()
    {
        super();
        staticInteractObjects.InteractEnterFrameArray.push(this);
        stop();
    }
    
    public function InteractEnterFrame() : Dynamic
    {
        if (currentFrame == totalFrames)
        {
            staticInteractObjects.killInteract.push(this);
        }
        else
        {
            nextFrame();
        }
    }
}


