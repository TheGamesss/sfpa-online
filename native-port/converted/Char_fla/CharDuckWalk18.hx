package char_fla;

import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol11343"))

class CharDuckWalk18 extends MovieClip
{
    
    public var Ducked : MovieClip;
    
    public function new()
    {
        super();
        addFrameScript(0, this.frame1);
    }
    
    @:allow(char_fla)
    private function frame1() : Dynamic
    {
        stop();
    }
}


