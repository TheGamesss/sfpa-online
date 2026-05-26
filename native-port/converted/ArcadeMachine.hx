
class ArcadeMachine extends StaticInteractObjects
{
    
    private static var selected : Bool;
    
    private static var selectedArcade : ArcadeMachine;
    
    private static var waitOnce : Bool;
    
    private static var numPlayers : Int = 0;
    
    private var tempN : Int;
    
    private var screenN : Int;
    
    private var warpDir : String;
    
    private var which : String;
    
    private var delay : Int;
    
    private var myChar : Char;
    
    private var myPants : MenuSelectPants;
    
    private var howMany : HowManyPlayersText;
    
    private var items : Int;
    
    private var selectorN : Int = 0;
    
    private var arrowDown : Bool;
    
    private var tempTime : Float;
    
    private var tempString : String;
    
    private var categoryN : Int;
    
    private var oMouseY : Float;
    
    private var selectNum : Bool;
    
    private var menuItems : Array<MenuItem> = new Array<MenuItem>();
    
    private var playerNumItems : Array<PlayerNumSelect> = new Array<PlayerNumSelect>();
    
    private var loadsArray : Array<Dynamic> = ["Races", "Arena", "Level", "Custom"];
    
    private var namesArray : Array<Dynamic> = ["Race", "Arena", "Extra", "Custom"];
    
    private var dirArray : Array<Dynamic> = ["Arcade", "Arcade", "Extra", "Custom"];
    
    private var listArray : Array<Dynamic> = [5, 1, 4, 5];
    
    public function new(p : Dynamic)
    {
        isWide = 60;
        super("arcadeMachine", p.x, p.y, 1, 1, p.onRail, "nothing", -1);
        warpLevel = p.warpLevel;
        warpDoor = p.warpDoor;
        this.warpDir = p.warpDir;
        this.which = p.which;
        this.categoryN = 0;
        this.oMouseY = Main.stageRoot.stage.mouseY;
        this.tempN = StarlingTemporary.Spawn(p.which, x, y, 0, scaleX, p.onRail);
        if (this.which != "arcadeRemix")
        {
            this.screenN = StarlingTemporary.Spawn("arcadeScreen", x, y, 0, scaleX * 0.25, p.onRail);
            StarlingTemporary.setVisible(this.screenN, false);
        }
        selected = false;
    }
    
    public static function touchItems() : Void
    {
        if (waitOnce)
        {
            waitOnce = false;
        }
        else
        {
            selectedArcade.myClickItems();
        }
    }
    
    public static function clickItems() : Void
    {
        selectedArcade.myClickItems();
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (!selected)
        {
            if (Math.abs(ex - x) < isWide)
            {
                if (char.UpIsDown())
                {
                    char.Still = true;
                    char.superStill = true;
                    this.myChar = char;
                    selected = true;
                    selectedArcade = this;
                    waitOnce = true;
                    Main.pauseStatus = this.which;
                    Main.setArcadeControls();
                    Main.stageRoot.hideAllHUD(false);
                    if (cast(rootHUD.HUD.isReallyMobile, Bool) && this.which == "arcadeRemix")
                    {
                        Main.justSetShifts(x, y - 20, 85);
                        Main.switchScroll("simpleScroll");
                        this.delay = 30;
                    }
                    else
                    {
                        this.delay = -1;
                        Main.setNullScroll();
                        Main.justSetShifts(x, y - 22, 91);
                        Main.switchScroll("quickScroll");
                        this.myPants = new MenuSelectPants();
                        Backgrounds.backgroundsArray[onRail].addChild(this.myPants);
                        if (this.which == "arcadeRemix")
                        {
                            this.howManyPlayers();
                        }
                        else
                        {
                            this.myPants.x = x - 18;
                            this.myPants.y = y - 22 - (this.items - 1) * 1.5;
                            this.buildScreen();
                        }
                    }
                    InteractEnterFrameArray.push(this);
                }
                else
                {
                    Main.showDoorIcon = true;
                }
                StarlingTemporary.setFrame(this.tempN, 2);
                if (this.which != "arcadeRemix")
                {
                    StarlingTemporary.setVisible(this.screenN, true);
                }
            }
            else
            {
                StarlingTemporary.setFrame(this.tempN, 1);
                if (this.which != "arcadeRemix")
                {
                    StarlingTemporary.setVisible(this.screenN, false);
                }
            }
        }
    }
    
    private function buildScreen() : Void
    {
        var i : Int = 0;
        this.items = this.listArray[this.categoryN];
        this.selectorN = 0;
        this.myPants.y = y - 22 - (this.items - 1) * 1.5 + this.selectorN * 3;
        for (i in 0...this.items)
        {
            this.menuItems[i] = new MenuItem();
            this.menuItems[i].x = x;
            this.menuItems[i].y = y - 22 - (this.items - 1) * 1.5 + i * 3;
            this.menuItems[i].itemText.text = this.namesArray[this.categoryN] + "  " + (i + 1) + "       ";
            if (Math.isNaN(Main.localScores[this.loadsArray[this.categoryN] + i + "_Time"]))
            {
                ;
            }
            if (!(Main.localScores[this.loadsArray[this.categoryN] + i + "_Time"] == null || Main.localScores[this.loadsArray[this.categoryN] + i + "_Time"] == 0))
            {
                this.tempTime = Main.localScores[this.loadsArray[this.categoryN] + i + "_Time"];
                this.tempTime *= 100;
                this.tempTime = Math.round(this.tempTime);
                this.tempTime /= 100;
                this.tempString = Std.string(this.tempTime);
                if (this.tempString.indexOf(".") == -1)
                {
                    this.tempString += ".00";
                }
                else if (this.tempString.length - this.tempString.indexOf(".") < 3)
                {
                    this.tempString += "0";
                }
                this.menuItems[i].itemTextTime.text = this.tempString;
            }
            Backgrounds.backgroundsArray[onRail].addChild(this.menuItems[i]);
        }
    }
    
    private function killScreen() : Void
    {
        var i : Int = 0;
        if (this.selectNum)
        {
            for (i in 0...this.playerNumItems.length)
            {
                this.playerNumItems[i].parent.removeChild(this.playerNumItems[i]);
            }
            this.playerNumItems = new Array<PlayerNumSelect>();
            this.howMany.parent.removeChild(this.howMany);
            this.myPants.parent.removeChild(this.myPants);
            this.myPants = null;
        }
        else
        {
            for (i in 0...this.menuItems.length)
            {
                this.menuItems[i].parent.removeChild(this.menuItems[i]);
            }
            this.menuItems = new Array<MenuItem>();
        }
    }
    
    private function howManyPlayers() : Void
    {
        var i : Int = 0;
        this.howMany = new HowManyPlayersText();
        this.howMany.x = x;
        this.howMany.y = y - 26;
        this.howMany.scaleX = this.howMany.scaleY = 0.07;
        Backgrounds.backgroundsArray[onRail].addChild(this.howMany);
        this.myPants.x = x - 15 + 10 * numPlayers;
        this.myPants.y = y - 11.5;
        this.myPants.rotation = -90;
        this.selectNum = true;
        for (i in 0...4)
        {
            this.playerNumItems.push(new PlayerNumSelect());
            this.playerNumItems[i].x = x - 15 + 10 * i;
            this.playerNumItems[i].y = y - 17;
            this.playerNumItems[i].scaleX = 0.2;
            this.playerNumItems[i].scaleY = 0.2;
            this.playerNumItems[i].gotoAndStop(i + 1);
            Backgrounds.backgroundsArray[onRail].addChild(this.playerNumItems[i]);
        }
    }
    
    private function loadLevel() : Void
    {
        Main.numPlayers = numPlayers + 1;
        if (this.which == "arcadeRemix")
        {
            Main.LoadIt = warpLevel;
            Main.DirIt = this.warpDir;
        }
        else
        {
            Main.LoadIt = this.loadsArray[this.categoryN] + this.selectorN;
            Main.DirIt = this.dirArray[this.categoryN];
        }
        Sounds.fadeOutMusic(Sounds.getMusic(Main.LoadIt, 0));
        Main.removeArcadeControls();
    }
    
    private function myClickItems() : Void
    {
        var temp : Float = Math.NaN;
        if (!this.selectNum)
        {
            if (Main.stageRoot.stage.mouseY / (Main.realStageY * 2) > 0.85)
            {
                this.stepBack();
            }
            else if (Main.stageRoot.stage.mouseX / (Main.realStageX * 2) < 0.28)
            {
                if (this.categoryN > 0)
                {
                    --this.categoryN;
                    this.killScreen();
                    this.buildScreen();
                }
            }
            else if (Main.stageRoot.stage.mouseX / (Main.realStageX * 2) > 0.69)
            {
                if (this.categoryN < this.listArray.length - 1)
                {
                    ++this.categoryN;
                    this.killScreen();
                    this.buildScreen();
                }
            }
            else
            {
                temp = (Main.stageRoot.stage.mouseY / (Main.realStageY * 2) - 0.486) / 0.056;
                this.selectorN = this.items * 0.5 + temp;
                if (this.selectorN < 0)
                {
                    this.selectorN = 0;
                }
                else if (this.selectorN > this.items - 1)
                {
                    this.selectorN = this.items - 1;
                }
                this.myPants.y = y - 22 - (this.items - 1) * 1.5 + this.selectorN * 3;
                this.startLoadItem();
            }
        }
    }
    
    private function stepBack() : Void
    {
        Main.setScroll();
        Main.stageRoot.hideAllHUD(true);
        this.myChar.Status = "Idle";
        this.myChar.Still = false;
        this.myChar.superStill = false;
        this.myChar.parent.alpha = 1;
        Main.pauseStatus = "nothing";
        Main.removeArcadeControls();
        this.killScreen();
        if (this.myPants != null)
        {
            this.myPants.parent.removeChild(this.myPants);
            this.myPants = null;
        }
        selected = false;
        this.selectNum = false;
        InteractEnterFrameArray.splice(InteractEnterFrameArray.indexOf(this), 1);
    }
    
    private function startLoadItem() : Void
    {
        this.killScreen();
        if (rootHUD.HUD.isReallyMobile)
        {
            this.loadLevel();
        }
        else
        {
            this.howManyPlayers();
        }
    }
    
    override public function InteractEnterFrame() : Bool
    {
        var temp : Float = Math.NaN;
        this.myChar.forceGamepads();
        this.myChar.suppressJump = true;
        if (this.myChar.parent.alpha > 0)
        {
            this.myChar.parent.alpha -= 0.1;
        }
        if (this.selectNum)
        {
            if (this.myChar.JumpIsDown())
            {
                if (!this.arrowDown)
                {
                    this.loadLevel();
                }
            }
            else if (cast(this.myChar.AttackIsDown(), Bool) || cast(this.myChar.DownIsDown(), Bool))
            {
                this.stepBack();
            }
            else if (this.myChar.wantRL < -0.5 || cast(this.myChar.LeftIsDown(), Bool))
            {
                if (!this.arrowDown && numPlayers > 0)
                {
                    this.arrowDown = true;
                    --numPlayers;
                    this.myPants.x = x - 15 + 10 * numPlayers;
                }
            }
            else if (this.myChar.wantRL > 0.5 || cast(this.myChar.RightIsDown(), Bool))
            {
                if (!this.arrowDown && numPlayers < 3)
                {
                    this.arrowDown = true;
                    ++numPlayers;
                    this.myPants.x = x - 15 + 10 * numPlayers;
                }
            }
            else
            {
                this.arrowDown = false;
            }
        }
        else if (this.which != "arcadeRemix")
        {
            if (this.myChar.JumpIsDown())
            {
                this.startLoadItem();
                this.arrowDown = true;
            }
            else if (this.myChar.AttackIsDown())
            {
                this.stepBack();
            }
            else if (this.myChar.UpIsDown())
            {
                if (!this.arrowDown && this.selectorN > 0)
                {
                    --this.selectorN;
                    this.myPants.y = y - 22 - (this.items - 1) * 1.5 + this.selectorN * 3;
                    this.arrowDown = true;
                }
            }
            else if (this.myChar.DownIsDown())
            {
                if (!this.arrowDown && this.selectorN < this.items - 1)
                {
                    ++this.selectorN;
                    this.myPants.y = y - 22 - (this.items - 1) * 1.5 + this.selectorN * 3;
                    this.arrowDown = true;
                }
            }
            else if (this.myChar.wantRL < -0.5 || cast(this.myChar.LeftIsDown(), Bool))
            {
                if (!this.arrowDown && this.categoryN > 0)
                {
                    --this.categoryN;
                    this.killScreen();
                    this.buildScreen();
                    this.arrowDown = true;
                }
            }
            else if (this.myChar.wantRL > 0.5 || cast(this.myChar.RightIsDown(), Bool))
            {
                if (!this.arrowDown && this.categoryN < this.listArray.length - 1)
                {
                    ++this.categoryN;
                    this.killScreen();
                    this.buildScreen();
                    this.arrowDown = true;
                }
            }
            else
            {
                this.arrowDown = false;
                if (Main.stageRoot.stage.mouseY != this.oMouseY)
                {
                    temp = (Main.stageRoot.stage.mouseY / (Main.realStageY * 2) - 0.486) / 0.056;
                    this.selectorN = this.items * 0.5 + temp;
                    if (this.selectorN < 0)
                    {
                        this.selectorN = 0;
                    }
                    else if (this.selectorN > this.items - 1)
                    {
                        this.selectorN = this.items - 1;
                    }
                    this.myPants.y = y - 22 - (this.items - 1) * 1.5 + this.selectorN * 3;
                    this.oMouseY = Main.stageRoot.stage.mouseY;
                }
            }
        }
        if (this.delay > 0)
        {
            --this.delay;
        }
        else if (this.delay == 0)
        {
            Main.DirIt = this.warpDir;
            Main.FadeItOutWhite(warpLevel, 0);
            this.delay = -1;
        }
    }
}


