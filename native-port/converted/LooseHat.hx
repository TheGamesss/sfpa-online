import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol5342"))

class LooseHat extends InteractObjects
{
    
    public var hat : MovieClip;
    
    private var hatN : Int;
    
    private var layDown : Bool;
    
    public function new(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, hatn : Dynamic)
    {
        super(rail);
        this.hat.gotoAndStop(hatn);
        var nowSpeed : Float = Math.sqrt(eRL * eRL + eUD * eUD);
        if (nowSpeed < 15)
        {
            eRL *= 15 / nowSpeed;
            eUD *= 15 / nowSpeed;
        }
        x = ex;
        y = ey;
        moveRL = eRL;
        moveUD = eUD;
        ItIs = "looseHat";
        this.hatN = hatn;
        BallRes = 4;
        isTall = 5;
        isWide = as3hx.Compat.parseInt(width * 0.5);
        bounce = 0.5;
        bounceThresh = 2;
        if (height > width)
        {
            rotPerc = 180 / (Math.PI * height);
        }
        else
        {
            rotPerc = 180 / (Math.PI * width);
        }
        overReach = 4;
        mass = 5;
        rotter = eRL * rotPerc;
        downTime = 20;
        Backgrounds.backgroundsArray[rail].addChild(this);
        Status = "Jump";
        this.layDown = hatn == 36;
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (char.Status == "Roll" || char.Status == "DownSlide")
        {
            downTime = 10;
            rotter = -eRL * rotPerc;
            char.hitPause = hitPause = 3;
            Main.shakeScreen(5, 0, true);
            Main.popBetween(this, char);
            Sounds.playSound("Kick", x, getSpeed(eRL, eUD) * 0.05, onRail);
            moveRL = eRL * 0.25;
            moveUD = -Math.abs(eRL);
        }
        else
        {
            char.changeHat(this.hatN);
            Main.parse_saveSettings();
            char.hitPause = 5;
            Main.shakeScreen(20, 0, true);
            killInteract.push(this);
        }
    }
    
    override public function hitBaddie(ex : Float, ey : Float, eRL : Float, eUD : Float, baddie : Baddies) : Bool
    {
        if (baddie.wearHat(this.hatN))
        {
            baddie.hitPause = 5;
            Main.popBetween(this, baddie);
            Main.shakeScreen(5, 0, true);
            killInteract.push(this);
        }
    }
    
    override public function InteractEnterFrame() : Void
    {
        if (moveUD < 30)
        {
            ++moveUD;
        }
        rotter *= 0.9;
        if (fakeUD == 0 && (almostGround || almostPlat || onGround))
        {
            if (Math.abs(moveRL) > 0.2)
            {
                moveRL -= makeOne(moveRL) * 0.2;
            }
            else
            {
                rotter = moveRL = moveUD = 0;
                if (this.layDown)
                {
                    rotation = wallRot + 90;
                }
                else
                {
                    rotation = wallRot;
                }
            }
        }
    }
}


