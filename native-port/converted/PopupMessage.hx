import flash.display.MovieClip;
import flash.text.TextField;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol1169"))

class PopupMessage extends MovieClip
{
    
    public var smoke : TextField;
    
    public var anchorY : Int = 450;
    
    private var lifetime : Int;
    
    private var rootlife : Int = 90;
    
    private var moveRL : Float = 0;
    
    private var moveUD : Float = 0;
    
    public function new(e : Dynamic)
    {
        super();
        x = 690;
        y = 570;
        this.lifetime = (rootHUD.popupsArray.length + 1) * 10 + this.rootlife;
        this.smoke.text = e;
    }
    
    public function popupEnterFrame() : Dynamic
    {
        if (this.lifetime > 0)
        {
            --this.lifetime;
            this.moveUD = (this.anchorY - y) * 0.4;
            if (this.moveUD < -10)
            {
                y -= 10;
            }
            else
            {
                y += this.moveUD;
            }
            if (y == 540)
            {
                for (i in 0...rootHUD.popupsArray.length - 1)
                {
                    rootHUD.popupsArray[i].lifetime = (i + 1) * 10 + this.rootlife;
                    rootHUD.popupsArray[i].anchorY -= this.rootlife;
                }
            }
        }
        else if (x < 900)
        {
            this.moveRL += 2;
            x += this.moveRL;
        }
        else
        {
            rootHUD.popupsArray.splice(rootHUD.popupsArray.indexOf(this), 1);
            parent.removeChild(this);
        }
    }
}


