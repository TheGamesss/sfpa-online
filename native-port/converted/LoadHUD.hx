import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol1258"))

class LoadHUD extends MovieClip
{
    
    public var bar : MovieClip;
    
    public function new()
    {
        super();
        stop();
        x = Main.realStageX;
        y = Main.realStageY;
        scaleX = Main.originalStageX / 400;
        scaleY = Main.originalStageY / 250;
    }
}


