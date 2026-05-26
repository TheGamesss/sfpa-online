
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3732"))

class LooseSquiggle extends InteractObjects
{
    
    public function new(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, rotr : Int = 0)
    {
        super();
        if (rotr == 0)
        {
            rotter = Math.random() * 40 - 20;
        }
        else
        {
            rotter = rotr;
        }
        x = ex;
        y = ey;
        moveRL = eRL;
        moveUD = eUD;
        ItIs = "looseSquiggle";
        downTime = 5;
        ground = Main.AllEverything["ground" + rail];
        platforms = Main.AllEverything["platforms" + rail];
        walls = Main.AllEverything["walls" + rail];
        onRail = rail;
        BallRes = 4;
        isTall = isWide = 10;
        bounce = 0.8;
        bounceThresh = 2;
        rotPerc = 360 / (Math.PI * (isTall * 2));
        overReach = 4;
        mass = 10;
        Backgrounds.backgroundsArray[rail].addChild(this);
        Status = "Fly";
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        char.squiggleGet();
        cachedEffects.spawnCachedEffect("SquigPop", x, y, Math.random() * 360, 1, 0, 0, onRail, char.parent);
        killInteract.push(this);
    }
    
    override public function InteractEnterFrame() : Void
    {
        if (moveUD < 20)
        {
            ++moveUD;
        }
        if (y > Main.MaxY / Main.stageRatios[onRail] + 400)
        {
            killInteract.push(this);
        }
    }
}


