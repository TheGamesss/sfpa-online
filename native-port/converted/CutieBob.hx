
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol4966"))

class CutieBob extends StaticInteractObjects
{
    
    private var loopRand : Int = 60;
    
    private var rand : Int = 0;
    
    private var disabled : Bool;
    
    private var tempN : Int;
    
    public function new(p : Dynamic)
    {
        isWide = 150;
        super("cutieBob", p.x, p.y, 1, 1, p.onRail);
        this.disabled = Main.world4Progress.cutieLeftWindow;
        if (this.disabled)
        {
            if (Main.AllEverything.walls0.doorWall != null)
            {
                Main.AllEverything.walls0.removeChild(Main.AllEverything.walls0.doorWall);
                Main.AllEverything.walls0.doorWall = null;
            }
        }
        else
        {
            this.tempN = StarlingTemporary.Spawn("cutieBob", x, y, rotation * (Math.PI / 180), scaleX, onRail, true, 60);
            InteractEnterFrameArray.push(this);
            StarlingBackgrounds.addScrollObject(new HouseFrontDoor(), 0);
            Main.stageRoot.houseFrontDoor = StarlingBackgrounds.backgroundObjectsArray[StarlingBackgrounds.backgroundObjectsArray.length - 1];
        }
        if (!Main.world4Progress.cutieIsGone)
        {
            new WarpBox({
                x : 91.6,
                y : -349.65,
                scaleX : 1.673065,
                scaleY : 2.177261,
                ItIs : "TriggerBox",
                onRail : 0,
                warpLevel : "cueCutieRun"
            });
        }
        StarlingBackgrounds.addScrollObject(new HouseUber(), 0);
        StarlingBackgrounds.addScrollObject(new CaveUber(), 0);
        StarlingBackgrounds.addScrollObject(new HouseFront(), 0);
        Main.stageRoot.houseFront = StarlingBackgrounds.backgroundObjectsArray[StarlingBackgrounds.backgroundObjectsArray.length - 1];
        Main.stageRoot.houseFront.alpha = 0;
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (!this.disabled)
        {
            if (ex < x + 50)
            {
                staticInteractObjects.textBubbleArray[0].popupText(char.UpIsDown());
            }
        }
    }
    
    override public function cleanUp() : Void
    {
    }
}


