import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.*;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol131"))

class KongIntro extends MovieClip
{
    
    public var KongButton : SimpleButton;
    
    public function new(ex : Dynamic, ey : Dynamic)
    {
        super();
        this.KongButton.addEventListener(MouseEvent.MOUSE_DOWN, this.goToKong, false, 0, true);
        x = ex;
        y = ey;
        stop();
    }
    
    private function goToKong(e : MouseEvent) : Dynamic
    {
        Main.launchURL("http://www.kongregate.com?haref=fpa_remix&src=spon&cm=fpa_remix");
    }
}


