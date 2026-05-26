import flash.display.SimpleButton;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol866"))

class HighScoresButton extends StaticInteractObjects
{
    
    public var highscores : SimpleButton;
    
    public var level : Int;
    
    public function new(p : Dynamic)
    {
        super("highScoresButton", p.x, p.y, 1, 1, 0, "nothing", -1);
        this.level = p.level;
        Backgrounds.backgroundsArray[0].addChild(this);
    }
}


