
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol1735"))

class WarpBox extends StaticInteractObjects
{
    
    private static var currentShiftID : Int;
    
    private var myTunnel : Dynamic;
    
    private var propX : Float;
    
    private var propY : Float;
    
    private var propZ : Int;
    
    private var propB : Float;
    
    private var boundsShiftX : Int;
    
    private var boundsShiftY : Int;
    
    public var pairBox : Bool;
    
    public var delay : Int = 0;
    
    private var ratioX : Float;
    
    private var ratioY : Float;
    
    private var target : Dynamic;
    
    private var triggered : Bool;
    
    private var hasHitBad : Bool;
    
    public var baddieCount : Int;
    
    private var baddieN : Int;
    
    private var baddieTotal : Int = -1;
    
    private var stringVar : String;
    
    private var setupAgain : Bool = true;
    
    private var oldMusic : String = "nothing";
    
    private var rootPropX : Float;
    
    private var rootPropY : Float;
    
    private var rootPropZ : Float;
    
    public function new(p : Dynamic)
    {
        var i : String = null;
        super(p.ItIs, p.x, p.y, p.scaleX, p.scaleY, p.onRail, p.warpLevel, p.warpDoor);
        for (i in Reflect.fields(p))
        {
            if (i != "componentInspectorSetting")
            {
                Reflect.setField(this, i, Reflect.field(p, i));
            }
        }
        this.rootPropX = this.propX;
        this.rootPropY = this.propY;
        this.rootPropZ = this.propZ;
        visible = false;
        if (ItIs == "TriggerBox")
        {
            this.triggerSetup();
        }
        ID = uniqueCounter;
        ++uniqueCounter;
    }
    
    public static function resetCameras() : Void
    {
        for (i in 0...InteractArray.length)
        {
            if (Reflect.field(InteractArray, Std.string(i)).ItIs == "TriggerBox")
            {
                Reflect.field(InteractArray, Std.string(i)).resetTriggers();
            }
        }
    }
    
    public static function clearShiftID() : Void
    {
        currentShiftID = 1000;
    }
    
    private function resetTriggers() : Void
    {
        if (warpLevel == "cameraShift" || warpLevel == "lockShift")
        {
            this.propX = this.rootPropX;
            this.propY = this.rootPropY;
            this.propZ = this.rootPropZ;
            this.triggerSetup();
        }
    }
    
    public function triggerSetup() : Void
    {
        var e : Float = Math.NaN;
        switch (warpLevel)
        {
            case "cameraShift":
                this.propX += x;
                this.propY += y;
                this.ratioX = 1 - 1 / (width * 0.5) * (Main.relativeStageX - 200);
                this.ratioY = 1 - 1 / (height * 0.5) * (Main.relativeStageY - 100);
                this.propZ -= Main.zOffset;
            case "throughShift":
                if (Math.abs(rotation) >= 45)
                {
                    e = scaleX;
                    scaleX = scaleY;
                    scaleY = e;
                }
            case "lockShift":
                if (this.propX > -18000)
                {
                    this.propX += x;
                }
                if (this.propY > -18000)
                {
                    this.propY += y;
                }
                this.ratioX = scaleX * 50 / Main.relativeStageX;
                this.ratioY = scaleY * 50 / Main.relativeStageY;
                if (this.ratioX > this.ratioY && this.propX > -18000 || this.propY <= -18000)
                {
                    this.propZ += -(this.ratioX * Main.cameraFocalLength - Main.cameraFocalLength) - Main.zOffset;
                }
                else
                {
                    this.propZ += -(this.ratioY * Main.cameraFocalLength - Main.cameraFocalLength) - Main.zOffset;
                }
            case "boundsShift":
                if (this.propX > 0)
                {
                    this.boundsShiftX = x + scaleX * 50 - Main.originalMaxX + this.propZ;
                }
                else if (this.propX < 0)
                {
                    this.boundsShiftX = x - scaleX * 50 - Main.originalMinX + this.propZ;
                }
                if (this.propY > 0)
                {
                    this.boundsShiftY = y + scaleY * 50 - Main.originalMaxY + this.propZ;
                }
                else if (this.propY < 0)
                {
                    this.boundsShiftY = y - scaleY * 50 - Main.originalMinY + this.propZ;
                }
            case "justForCamera":
                cameraCollideArray.push(this);
                visible = false;
            case "dropBaddie":
                this.baddieCount = this.propY;
                this.baddieN = this.propZ;
                this.ratioX = Math.sin(rotation * (Math.PI / 180));
            case "shoutPopup":
                if (this.stringVar == "reallyGoZip")
                {
                    if (rootHUD.usingGamepad)
                    {
                        this.stringVar = "reallyGoZipPad";
                    }
                    else if (Main.isTouchScreen)
                    {
                        this.stringVar = "reallyGoZipTouch";
                    }
                }
            case "blowVolcano":
                if (Main.world4Progress.volcanoBlown)
                {
                    this.triggered = true;
                }
            case "roomSpawner":
                this.baddieN = 30;
                this.ratioX = scaleX * 50 / Main.relativeStageX;
                this.ratioY = scaleY * 50 / Main.relativeStageY;
                this.baddieCount = this.propX;
                this.baddieTotal = this.propY;
                pairGate = this.propZ;
                if (this.ratioX > this.ratioY)
                {
                    this.propZ = -(this.ratioX * Main.cameraFocalLength - Main.cameraFocalLength) - Main.zOffset;
                }
                else
                {
                    this.propZ = -(this.ratioY * Main.cameraFocalLength - Main.cameraFocalLength) - Main.zOffset;
                }
            case "breakWall":
                this.myTunnel = new WallCover();
                this.myTunnel.x = x - 35;
                this.myTunnel.y = y;
                this.myTunnel.stop();
                Backgrounds.backgroundsArray[onRail].addChild(this.myTunnel);
            case "Skateboard":
                this.myTunnel = new SkateboardWaiting();
                Backgrounds.backgroundsArray[onRail].addChild(this.myTunnel);
                this.myTunnel.x = x;
                this.myTunnel.y = y;
                this.myTunnel.transform.colorTransform = Main.getColorTransform(Main.localSettings.pantsN);
            case "Teleport":
                this.hasHitBad = true;
            case "MusicSwitch":
                if (this.propY == 0)
                {
                    this.propY = 1;
                }
            case "checkTutorial":
                this.setupAgain = false;
                if (this.stringVar == "beforeBoss")
                {
                    if (!Main.world4Progress.defeatBoss1)
                    {
                        this.propX = 1;
                        this.propY = 60;
                    }
                }
                else if (this.stringVar == "spinner")
                {
                    this.propX = 3;
                    this.propY = 400;
                }
                else if (this.stringVar == "goUpgrade")
                {
                    if (cast(Main.world4Progress.iceCreamShop, Bool) && cast(Main.world4Progress.messageUpgrade, Bool))
                    {
                        this.propX = 5;
                        this.propY = 30;
                    }
                }
            case "cueAssistantCutie":
                this.propB = 0;
                if (Main.world4Progress.cutieHasHeyLady)
                {
                    this.triggered = true;
                }
                else if (Main.LevelLoaded == "Bonus1-a")
                {
                    this.triggered = true;
                }
                else if (Main.DoorIt == -1)
                {
                    this.triggered = false;
                }
                else if (Main.DoorIt == 0)
                {
                    this.triggered = false;
                }
                else
                {
                    this.triggered = true;
                }
            case "fallOffWorld":
                if (Main.world4Progress.gotPushed)
                {
                    staticInteractObjects.findByUnique(0).y = staticInteractObjects.findByUnique(0).y - 2000;
                    staticInteractObjects.findByUnique(0).updateCache();
                    staticInteractObjects.findByUnique(1).y = staticInteractObjects.findByUnique(1).y - 2000;
                    staticInteractObjects.findByUnique(1).updateCache();
                    staticInteractObjects.findByUnique(2).y = staticInteractObjects.findByUnique(2).y - 2000;
                    staticInteractObjects.findByUnique(2).updateCache();
                    staticInteractObjects.findByUnique(3).x = staticInteractObjects.findByUnique(3).x + 5000;
                    staticInteractObjects.findByUnique(3).updateCache();
                    staticInteractObjects.findByUnique(4).x = 3500;
                    staticInteractObjects.findByUnique(4).updateCache();
                }
        }
    }
    
    private function checkTutorialHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (this.propY > 0)
        {
            --this.propY;
        }
        else if (this.propX != 0)
        {
            if (this.propX == 1)
            {
                rootHUD.HUD.shoutTheBox("findSource2");
            }
            else if (this.propX == 2)
            {
                rootHUD.HUD.shoutTheBox("tutOutlines");
                this.propX = 0;
            }
            else if (this.propX == 3)
            {
                rootHUD.HUD.shoutTheBox("tutSpinners");
                this.propX = 0;
            }
            else if (this.propX == 4)
            {
                if (Char.hasPen)
                {
                    rootHUD.HUD.shoutTheBox("inkboarding");
                }
            }
            else if (this.propX == 5)
            {
                rootHUD.HUD.shoutTheBox("goUpgrade");
            }
        }
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        if (ItIs == "WarpBox")
        {
            this.WarpBoxHitChar(ex, ey, eRL, eUD, char);
        }
        else if (ItIs == "KillaBoxHitChar")
        {
            this.KillaBoxHitChar(ex, ey, eRL, eUD, char);
        }
        else if (ItIs == "TriggerBox")
        {
            this[warpLevel + "HitChar"](ex, ey, eRL, eUD, char);
        }
    }
    
    override public function hitBaddie(ex : Float, ey : Float, eRL : Float, eUD : Float, baddie : Baddies) : Bool
    {
        if (this.hasHitBad)
        {
            if (ItIs == "TriggerBox")
            {
                this[warpLevel + "HitChar"](ex, ey, eRL, eUD, baddie);
            }
        }
    }
    
    public function changeProperties(level : String = "nothing", ex : Int = -1, ey : Int = -1, ez : Int = -1, string : String = "nothing") : Void
    {
        if (level != "nothing")
        {
            warpLevel = level;
        }
        if (ex > -1)
        {
            this.propX = ex;
        }
        if (ey > -1)
        {
            this.propY = ey;
        }
        if (ez > -1)
        {
            this.propZ = ez;
        }
        if (string != "nothing")
        {
            this.stringVar = string;
        }
        if (this.setupAgain)
        {
            this.triggerSetup();
        }
    }
    
    private function WarpBoxHitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Void
    {
        var i : Int = 0;
        if (scaleX < scaleY && (ex - x) * (char.lastX - x) < 0 || scaleX > scaleY && (ey - y) * (char.lastY - y) < 0)
        {
            if (this.pairBox)
            {
                if (warpLevel == "nothing" || warpLevel == Main.LevelLoaded)
                {
                    for (i in 0...InteractArray.length)
                    {
                        if (InteractArray[i].ItIs == "WarpBox" && InteractArray[i].warpDoor == warpDoor)
                        {
                            if (InteractArray[i] != this)
                            {
                                char.x = char.lastX = InteractArray[i].x + (ex - x);
                                char.y = char.lastY = InteractArray[i].y + (ey - y);
                            }
                        }
                    }
                }
                else
                {
                    char.downTime = char.hitPause = 1000;
                    Char.pauseCurrentLoop();
                    char.hideAll();
                    if (this.triggered)
                    {
                        char.myTransLevelOffsetX = ex - x;
                        char.myTransLevelOffsetY = ey - y;
                        if (120 - this.propY - this.propB < 15)
                        {
                            char.myTransLevelOffsetDelay = 120 - this.propY;
                        }
                        else
                        {
                            char.myTransLevelOffsetDelay = this.propB + 15;
                        }
                        this.propB = char.myTransLevelOffsetDelay;
                        ++this.propX;
                    }
                    else
                    {
                        this.triggered = true;
                        char.myTransLevelOffsetX = Main.transLevelOffsetX = ex - x;
                        char.myTransLevelOffsetY = Main.transLevelOffsetY = ey - y;
                        this.propB = 0;
                        this.propX = 1;
                        this.propY = 120;
                        InteractEnterFrameArray.push(this);
                    }
                    if (this.propX == Char.ActiveCharArray.length)
                    {
                        Main.FadeItOut(warpLevel, warpDoor);
                        InteractEnterFrameArray.splice(Lambda.indexOf(InteractEnterFrameArray, this), 1);
                    }
                }
            }
            else
            {
                char.disableChar();
                if (warpLevel == Main.LevelLoaded)
                {
                    Main.DoorIt = warpDoor;
                }
                else if (!this.triggered)
                {
                    this.triggered = true;
                    Main.FadeItOut(warpLevel, warpDoor);
                }
            }
        }
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (this.propY > 0)
        {
            --this.propY;
        }
        else if (this.propY == 0)
        {
            --this.propY;
            Main.FadeItOut(warpLevel, warpDoor);
        }
    }
    
    private function KillaBoxHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        char.superHurtChar(5);
    }
    
    private function SwitchBoxHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (Reflect.field(Main, warpLevel) != warpDoor)
        {
            Reflect.setField(Main, warpLevel, warpDoor);
        }
    }
    
    private function cameraShiftHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        var ratio : Float = Math.abs(ex - x) / (width * 0.5);
        ratio *= 1.5;
        ratio -= 0.5;
        if (ratio < 0)
        {
            ratio = 0;
        }
        if (ratio < 1)
        {
            Main.toCameraShiftRatio = ratio;
            Main.cameraShift = true;
            Main.cameraShiftX = this.propX + (ex - this.propX) * this.ratioX;
            Main.cameraShiftY = this.propY + (char.groundY - this.propY) * this.ratioY;
            Main.cameraShiftZ = this.propZ;
        }
    }
    
    private function charShiftHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        char.toVOffset = this.propY;
        char.zOffset = this.propZ;
    }
    
    private function throughShiftHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (Math.abs(rotation) < 45)
        {
            if (Math.abs(ex - x) < Math.abs(scaleX) * 50)
            {
                char.toVOffset += (this.propX * (((ex - x) / scaleX - 50) * -0.01) + this.propY * (((ex - x) / scaleX + 50) * 0.01) - char.toVOffset) * 0.5;
            }
        }
        else if (Math.abs(ey - y) < Math.abs(scaleY) * 50)
        {
            char.toVOffset += (this.propX * (((ey - y) / scaleY - 50) * -0.01) + this.propY * (((ey - y) / scaleY + 50) * 0.01) - char.toVOffset) * 0.5;
        }
    }
    
    private function lockShiftHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (Main.lockShiftRatio == 0)
        {
            currentShiftID = ID;
            Main.lockShiftX = this.propX + (ex - x) * 0.1;
            Main.lockShiftY = this.propY + (char.groundY - y) * 0.1;
            Main.lockShiftZ = this.propZ;
        }
        else
        {
            if (currentShiftID != ID)
            {
                return;
            }
            Main.lockShiftX += (this.propX + (ex - x) * 0.1 - Main.lockShiftX) * 0.05;
            Main.lockShiftY += (this.propY + (char.groundY - y) * 0.1 - Main.lockShiftY) * 0.05;
            Main.lockShiftZ += (this.propZ - Main.lockShiftZ) * 0.05;
        }
        Main.lockShift = true;
        if (Math.abs(this.propX) > 18500)
        {
            Main.lockShiftMinX = x - scaleX * 50;
            Main.lockShiftMaxX = x + scaleX * 50;
        }
        if (Math.abs(this.propY) > 18500)
        {
            Main.lockShiftMinY = y - scaleY * 50;
            Main.lockShiftMaxY = y + scaleY * 50;
        }
    }
    
    private function boundsShiftHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (char.Status != "Disabled")
        {
            Main.startShiftBounds(this.propX, this.propY, this.boundsShiftX, this.boundsShiftY);
        }
    }
    
    private function superBoundsShiftHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        Main.boundsShiftX = Main.boundsShiftY = 0;
        if (this.propY == 0)
        {
            Main.MinX = this.propX;
        }
        else if (this.propY == 1)
        {
            Main.MinY = this.propX;
        }
        else if (this.propY == 2)
        {
            Main.MaxX = this.propX;
        }
        else if (this.propY == 3)
        {
            Main.MaxY = this.propX;
        }
        Main.setMaxZ();
    }
    
    private function roomSpawnerHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (!this.triggered)
        {
            this.triggered = true;
            if (this.stringVar != "nothing")
            {
                this.oldMusic = Sounds.musicPlaying;
                Sounds.fadeOutMusic(this.stringVar, 0.03, "crossSync", 1);
            }
        }
        if (this.baddieCount > 0)
        {
            if (this.baddieN > 0)
            {
                --this.baddieN;
            }
            else if (this.baddieTotal > 0)
            {
                this.baddieN = this.propX;
                --this.baddieCount;
                --this.baddieTotal;
                if (Math.random() > 0.5)
                {
                    eRL = 1;
                }
                else
                {
                    eRL = -1;
                }
                ex = x + isWide * Math.random() * eRL;
                ey = y - isTall - 50;
                new Baddie1({
                    ItIs : "Baddie1",
                    x : ex,
                    y : ey,
                    rotation : 0,
                    scaleX : eRL * -1,
                    scaleY : 0.5 + Math.random() * 0.8 * this.propB,
                    onRail : 0,
                    hatN : 0,
                    moveRL : 0,
                    moveUD : 1,
                    autopilot : true,
                    originX : x,
                    tether : 400,
                    spawner : this
                });
            }
        }
        if (!(this.baddieCount == this.propX && this.baddieTotal == 0))
        {
            Main.lockShift = true;
            if (Main.lockShiftRatio == 0)
            {
                Main.lockShiftX = x + (ex - x) * 0.1;
                Main.lockShiftY = y + (char.groundY - y) * 0.1;
                Main.lockShiftZ = this.propZ;
            }
            else
            {
                Main.lockShiftX += (x + (ex - x) * 0.1 - Main.lockShiftX) * 0.02;
                Main.lockShiftY += (y + (char.groundY - y) * 0.1 - Main.lockShiftY) * 0.02;
                Main.lockShiftZ += (this.propZ - Main.lockShiftZ) * 0.05;
            }
            Main.startShiftBounds(ex - x, 0, this.boundsShiftX, this.boundsShiftY);
        }
    }
    
    private function speedShiftHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (this.propY == 0)
        {
            char.maxRL = this.propX;
        }
        else if (eRL * this.propY > 0)
        {
            char.maxRL = this.propX;
        }
        else
        {
            char.maxRL = 20;
        }
    }
    
    private function triggerTextHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        staticInteractObjects.textBubbleArray[this.propX].popupText(char.UpIsDown());
    }
    
    private function triggerTextSupressHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        Char.suppressAll();
        staticInteractObjects.textBubbleArray[this.propX].popupText(char.UpIsDown());
    }
    
    private function justForCameraHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
    }
    
    private function breakWallHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        var land : Int = 0;
        var scale : Int = 0;
        if (!this.triggered)
        {
            Main.levelStates.secondBox = true;
            Main.shakeScreen(60, 0, true);
            char.hitPause = 20;
            char.shakeRL = 10;
            char.Jumper = -char.moveUD;
            char.gotoBuffer = "Hurt";
            char.rotter = 30;
            char.wallRot = char.wallAngle = 0;
            Sounds.playSound("Crash", x, 2, onRail);
            land = 10;
            scale = 3;
            StarlingEffect.Spawn("smokePuff", char.x, char.y, -0.78, scale, -land, -land, onRail);
            StarlingEffect.Spawn("smokePuff", char.x, char.y, 0.78, scale, land, -land, onRail);
            StarlingEffect.Spawn("smokePuff", char.x, char.y, -2.34, scale, land, -land, onRail);
            StarlingEffect.Spawn("smokePuff", char.x, char.y, 2.34, scale, -land, land, onRail);
            Main.popBetween(char, this.myTunnel, 2);
            this.myTunnel.nextFrame();
            this.triggered = true;
        }
        else
        {
            if (Main.stageRoot.tick)
            {
                this.myTunnel.nextFrame();
            }
            if (char.x > x)
            {
                char.disableChar();
                Main.FadeItOut("Bonus5", 0);
                killInteract.push(this);
            }
        }
    }
    
    private function CueCutsceneHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
    }
    
    private function cueCutieRunHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        Main.lockShift = true;
        Main.lockShiftX = x + 600;
        Main.lockShiftY = y;
        Main.lockShiftZ = 0;
        char.Still = true;
        if (ex > x)
        {
            char.x = x;
        }
        if (eRL < 0)
        {
            char.fakeRL = char.moveRL = 0;
        }
        if (!this.triggered)
        {
            new CutieRun(600, -160, onRail);
            this.triggered = true;
        }
        if (staticInteractObjects.textBubbleArray[1].popupText(char.UpIsDown()))
        {
            killInteract.push(this);
        }
    }
    
    private function cueAssistantCutieHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        var temp : JustALoop = null;
        if (this.triggered)
        {
            return;
        }
        char.Still = true;
        if (this.propB == 0)
        {
            temp = new CutieStand();
            temp.x = -1790;
            temp.y = 594;
            temp.ItIs = "cutieStand";
            Backgrounds.backgroundsArray[0].addChild(temp);
            temp = new AssistantStand();
            temp.x = -1448;
            temp.y = 488;
            temp.ItIs = "assistantStand";
            Backgrounds.backgroundsArray[0].addChild(temp);
            temp = null;
            Main.lockShiftX = -1620;
            Main.lockShiftY = 530;
            Main.lockShiftZ = 40;
        }
        if (this.propB < 41)
        {
            this.propB += Main.framin;
        }
        else if (this.propB < 51)
        {
            this.propB = 51;
        }
        if (this.propB > 20 && this.propB < 70)
        {
            Main.lockShift = true;
        }
        if (this.propB > 60)
        {
            this.propB += Main.framin;
            if (this.propB > 90)
            {
                staticInteractObjects.killInteract.push(justALoop.findByWhich("cutieStand"));
                staticInteractObjects.killInteract.push(justALoop.findByWhich("assistantStand"));
                char.Still = false;
                killInteract.push(this);
            }
        }
        else if (this.propB > 50)
        {
            if (staticInteractObjects.textBubbleArray[3].popupText(char.UpIsDown()))
            {
                ++this.propB;
                if (this.propB == 59)
                {
                    this.propB = 61;
                }
            }
        }
    }
    
    private function dropBaddieHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (this.baddieCount > 0)
        {
            Main.shakeScreen(1, Math.random() * 3.14);
            if (this.baddieN > 0)
            {
                --this.baddieN;
            }
            else
            {
                this.baddieN = this.propZ;
                --this.baddieCount;
                ex = Main.cameraX;
                if (ex < x - isWide + 500)
                {
                    ex = x - isWide + 500;
                }
                else if (ex > x + isWide - 500)
                {
                    ex = x + isWide - 500;
                }
                ex += Math.random() * 900 - 450;
                ey = Main.cameraY - Main.stageY - 50;
                if (this.propX == 0)
                {
                    new Spider({
                        ItIs : "Spider",
                        x : ex,
                        y : ey,
                        rotation : 0,
                        scaleX : 1,
                        onRail : 0,
                        hatN : 0,
                        moveRL : 0,
                        moveUD : 15,
                        spawner : this
                    });
                }
                else if (this.propX == 1)
                {
                    new Baddie1({
                        ItIs : "Baddie1",
                        x : ex,
                        y : ey,
                        rotation : 0,
                        scaleX : 1,
                        scaleY : 0.3 + Math.random() * 0.5,
                        onRail : 0,
                        hatN : 0,
                        moveRL : 0,
                        moveUD : 20,
                        autopilot : true,
                        lifetimeN : 60,
                        temporary : true,
                        spawner : this
                    });
                }
            }
        }
    }
    
    private function justRumbleHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        Main.shakeScreen(this.propX, Math.random() * 6.28, true, true);
    }
    
    private function blowVolcanoHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (!this.triggered)
        {
            Main.shakeScreen(200, Math.random() * 6.28, true);
            Sounds.fadeOutMusic("nothing", 0.05);
            Sounds.playSound("InkBoom", x, 3, 0);
            Sounds.playSound("VolcanoExplode", x, 1, 0);
            char.maxRL = 5;
            this.triggered = true;
            this.target = new VolcanoEffect(-Main.cameraX * 0.02, -Main.cameraY * 0.02, Main.originalStageX / 400, Main.originalStageY / 250, this);
            Main.saveProgress("volcanoBlown", true);
            Main.stageRoot.addChild(this.target);
        }
    }
    
    private function shoutPopupHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (!this.triggered)
        {
            if (this.propX > 0)
            {
                --this.propX;
            }
            else
            {
                rootHUD.HUD.shoutTheBox(this.stringVar);
                if (this.propY == 0)
                {
                    this.triggered = true;
                }
            }
        }
    }
    
    private function PeerAtInkHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (this.triggered)
        {
            return;
        }
        if (ex > x + 10)
        {
            char.x = x + 10;
        }
        if (char.Status != "PeerAtInk")
        {
            if (ex > x && char.scaleX > 0)
            {
                if (char.Status == "Idle")
                {
                    if (char.onGround)
                    {
                        this.triggered = true;
                        char.gotoBuffer = "PeerAtInk";
                        Sounds.fadeOutMusic();
                        Sounds.playOnce("Volcano_Pushed");
                    }
                }
                else if (eRL > 0)
                {
                    char.Still = true;
                    char.superStill = true;
                }
            }
            else
            {
                char.Still = false;
                char.superStill = false;
            }
        }
    }
    
    private function fallOffWorldHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        char.Status = "Disabled";
        char.CharEnterFrame = char.InkWarpEnterFrame;
        char.x = 5000;
        char.y = -2000;
        char.b = 0;
        char.parent.mask = null;
        Main.switchScroll("nullScroll");
        Main.charScrollX = 5000;
        Main.charScrollY = -2000;
        Main.world4Progress.gotPushed = true;
        rootHUD.spawnMyBlackBlank();
    }
    
    private function justLongGetUpHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (!this.triggered)
        {
            if (char.Status == "GetUp")
            {
                char.gotoBuffer = "LongGetUp";
                this.triggered = true;
            }
        }
    }
    
    private function forceThumbHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (!this.triggered)
        {
            if (char.Status == "Idle")
            {
                if (this.propB < 15)
                {
                    ++this.propB;
                }
                else
                {
                    char.gotoBuffer = "Celebrate";
                    this.triggered = true;
                }
            }
        }
    }
    
    private function giveZipHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (!this.triggered)
        {
            this.triggered = true;
            Char.giveZip();
        }
    }
    
    private function saveProgressHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (!this.triggered)
        {
            this.triggered = true;
            Main.saveProgress(this.stringVar, true);
        }
    }
    
    public function onKilled() : Void
    {
        ++this.baddieCount;
        if (pairGate > -1)
        {
            if (baddieGate == null)
            {
                trace("null gate " + pairGate);
            }
            else if (this.baddieCount == this.propX && this.baddieTotal == 0)
            {
                if (this.oldMusic != "nothing")
                {
                    Sounds.fadeOutMusic(this.oldMusic, 0.015, "crossFade", 1);
                    this.oldMusic = "nothing";
                }
                baddieGate.inkGateBreak();
            }
        }
    }
    
    private function SkateboardHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (Math.abs(x - ex) < 30 && ey + eUD > y && char.Status != "Skateboard")
        {
            if (Main.numPlayers == 1)
            {
                this.myTunnel.visible = false;
            }
            char.y = y;
            char.Status = "Skateboard";
            char.changeFrame("Skateboard");
            char.SkateboardSetupFrame();
            char.CharEnterFrame = char.SkateboardEnterFrame;
            char.char.stop();
            char.placeHead(char.char);
        }
    }
    
    private function getColorHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Dynamic
    {
    }
    
    private function TeleportHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        var i : Int = 0;
        if ((ex - x) * (char.lastX - x) < 0)
        {
            for (i in 0...InteractArray.length)
            {
                if (InteractArray[i].warpLevel == "Teleport" && InteractArray[i].warpDoor == warpDoor)
                {
                    if (InteractArray[i] != this)
                    {
                        char.x = char.lastX = InteractArray[i].x + (ex - x);
                        char.y = char.lastY = InteractArray[i].y + (ey - y);
                        if (char.onRail != InteractArray[i].onRail)
                        {
                            char.changeRails(InteractArray[i].onRail);
                        }
                        aPlat.resetplatSides(char.x, char.y, char);
                    }
                }
            }
        }
    }
    
    private function MusicSwitchHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (this.propZ == 1)
        {
            Sounds.fadeOutMusic(this.stringVar, this.propX, "crossSync", this.propY);
        }
        else
        {
            Sounds.fadeOutMusic(this.stringVar, this.propX, "crossFade", this.propY);
        }
    }
    
    private function houseFadeHitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Void
    {
        if (ex < x)
        {
            if (Main.stageRoot.houseFront.alpha > 0)
            {
                Main.stageRoot.houseFront.alpha -= 0.05;
            }
        }
        else if (Main.stageRoot.houseFront.alpha < 1)
        {
            Main.stageRoot.houseFront.alpha += 0.05;
        }
    }
}


