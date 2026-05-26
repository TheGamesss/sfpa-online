import flash.display.MovieClip;
import flash.text.TextField;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol4219"))

class IceCreamBox extends StaticInteractObjects
{
    
    public var popup : MovieClip;
    
    public var priceText : TextField;
    
    private var moveUD : Int;
    
    private var rotOffset : Float;
    
    private var level : Int;
    
    private var max : Int;
    
    private var price : Int;
    
    private var under : Bool;
    
    public function new(p : Dynamic)
    {
        isTall = 200;
        super("IceCreamBox", p.x, p.y, p.scaleX, p.scaleY, p.onRail);
        ID = p.ID;
        this.loadLevel();
        this.price = Reflect.field([20, 50, 400, 600, 800, 0], Std.string(ID));
        this.max = Reflect.field([10, 6, 1, 1, 1, 0], Std.string(ID));
        Backgrounds.backgroundsArray[p.onRail].addChild(this);
        InteractEnterFrameArray.push(this);
        HalfInteractEnterFrameArray.push(this);
        this.updateAlpha();
        if (this.level >= this.max)
        {
            this.priceText.text = " ---";
        }
        else
        {
            this.priceText.text = this.price * (this.level + 1);
        }
        if (Main.localSettings.language == "English")
        {
            gotoAndStop(ID + 1);
        }
        else if (Main.localSettings.language == "Spanish")
        {
            gotoAndStop(8 + ID);
        }
        else if (Main.localSettings.language == "French")
        {
            gotoAndStop(15 + ID);
        }
        else if (Main.localSettings.language == "Italian")
        {
            gotoAndStop(22 + ID);
        }
        else if (Main.localSettings.language == "Portuguese")
        {
            gotoAndStop(29 + ID);
        }
        else if (Main.localSettings.language == "German")
        {
            gotoAndStop(36 + ID);
        }
        else if (Main.localSettings.language == "Russian")
        {
            gotoAndStop(43 + ID);
        }
        this.popup.gotoAndStop(ID + 1);
        this.popup.alpha = 0;
    }
    
    private static function updateAlphas() : Void
    {
        for (i in 0...InteractArray.length)
        {
            if (InteractArray[i].ItIs == "IceCreamBox")
            {
                InteractArray[i].updateAlpha();
            }
        }
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (Math.abs(ex - x) < 50)
        {
            this.under = true;
        }
        if (alpha < 1)
        {
            return false;
        }
        if (Math.abs(ey - y) < 50 + char.isTall)
        {
            if (ey - eUD > y + 50 + char.isTall)
            {
                char.moveUD = 0;
                char.y = y + 50 + char.isTall;
                this.moveUD = -30;
                this.rotOffset = (x - ex) * 0.003;
                char.spendSquiggles(this.price * (this.level + 1));
                new IceCreamPickup(x, y - 50 - 20, (x - ex) * 0.08 + eRL * 0.3, -(14 + 6 * Math.random()), 4, ID);
                ++this.level;
                this.saveLevel();
                if (this.level >= this.max)
                {
                    this.priceText.text = " ---";
                }
                else
                {
                    this.priceText.text = this.price * (this.level + 1);
                }
                updateAlphas();
                Achievements.SendScore("icecreamsBought", 1);
                this.popup.alpha = 0;
            }
            else if (Math.abs(ex - x) < isWide + char.isWide && Math.abs(ex - eRL - x) > isWide + char.isWide)
            {
                char.moveRL = 0;
                if (ex > x)
                {
                    char.x = x + isWide + char.isWide;
                }
                else
                {
                    char.x = x - isWide - char.isWide;
                }
            }
            return true;
        }
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (y != anchorY)
        {
            if (y < anchorY)
            {
                this.moveUD += 5;
            }
        }
        if (cast(this.under, Bool) && this.level < this.max && y == anchorY)
        {
            if (this.popup.alpha < 1)
            {
                this.popup.alpha += 0.2;
            }
        }
        else
        {
            this.popup.alpha += -this.popup.alpha * 0.2;
        }
        this.under = false;
    }
    
    override public function HalfInteractEnterFrame() : Void
    {
        rotation = (anchorY - y) * this.rotOffset;
        y += this.moveUD * Main.framin;
        if (y > anchorY)
        {
            this.moveUD = 0;
            y = anchorY;
        }
    }
    
    public function updateAlpha() : Void
    {
        if (Char.Squiggles < this.price * (this.level + 1))
        {
            alpha = 0.5;
        }
        else if (this.level >= this.max)
        {
            alpha = 0.5;
        }
    }
    
    private function loadLevel() : Void
    {
        if (ID == 0)
        {
            this.level = Main.world4Progress.healthLevel;
        }
        else if (ID == 1)
        {
            this.level = Main.world4Progress.powerLevel;
        }
        else if (ID == 2)
        {
            this.level = Main.world4Progress.threeLevel;
        }
        else if (ID == 3)
        {
            this.level = Main.world4Progress.fourLevel;
        }
        else if (ID == 4)
        {
            this.level = Main.world4Progress.fiveLevel;
        }
        else if (ID == 5)
        {
            this.level = Main.world4Progress.sixLevel;
        }
    }
    
    private function saveLevel() : Void
    {
        if (ID == 0)
        {
            Main.saveProgress("healthLevel", this.level);
        }
        else if (ID == 1)
        {
            Main.saveProgress("powerLevel", this.level);
        }
        else if (ID == 2)
        {
            Main.saveProgress("threeLevel", this.level);
        }
        else if (ID == 3)
        {
            Main.saveProgress("fourLevel", this.level);
        }
        else if (ID == 4)
        {
            Main.saveProgress("fiveLevel", this.level);
        }
        else if (ID == 5)
        {
            Main.saveProgress("sixLevel", this.level);
        }
    }
}


