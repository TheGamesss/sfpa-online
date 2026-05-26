import flash.display.MovieClip;
import flash.display.SimpleButton;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3740"))

class InterDecal extends MovieClip
{
    
    public static var theThing : Dynamic;
    
    public var button : SimpleButton;
    
    public var startorcontinue : MovieClip;
    
    public function new(p : Dynamic)
    {
        super();
        x = p.x;
        y = p.y;
        Backgrounds.backgroundsArray[0].addChild(this);
        gotoAndStop(p.reallyIs);
        theThing = this;
        var _sw27_ = (p.reallyIs);        

        switch (_sw27_)
        {
            case "startContinue":
                if (Main.localSettings.W1RContProg == 0)
                {
                    this.startorcontinue.gotoAndStop(1);
                }
                else
                {
                    this.startorcontinue.gotoAndStop(2);
                }
            case "soundtrackbutton":
                name = "soundtrack";
                visible = false;
        }
    }
}


