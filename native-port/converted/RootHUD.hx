import flash.errors.Error;
import flash.display.*;
import flash.events.*;
import flash.system.*;
import flash.text.TextField;
import flash.ui.Mouse;
import flash.utils.*;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol1432"))

class RootHUD extends MovieClip
{
    
    public static var HUD : Dynamic;
    
    public static var popup : Dynamic;
    
    public static var popoutN : Int;
    
    public static var isTouchScreen : Bool;
    
    public static var usingGamepad : Bool;
    
    private static var pourSquiggles : Int;
    
    public static var myUpgradePanel : UpgradePanel;
    
    public static var myLanguageSelector : LanguageSelector;
    
    public static var elements : Array<Dynamic> = new Array<Dynamic>();
    
    public static var toPopupArray : Array<Dynamic> = new Array<Dynamic>();
    
    public static var popupsArray : Array<Dynamic> = new Array<Dynamic>();
    
    public static var popupN : Int = 60;
    
    private static function ShakeEnterFrame() : Dynamic
    {
        this.shake -= (25 - this.shake) * 0.2;
        this.x = this.originX + Math.random() * this.shake - this.shake * 0.5;
        this.y = this.originY + Math.random() * this.shake - this.shake * 0.5;
        this.scaleX = this.scaleY = 1 + this.shake * 0.025;
        if (this.shake <= 0)
        {
            this.shake = 0;
            this.x = this.originX;
            this.y = this.originY;
            this.scaleX = this.scaleY = 1;
            elements.splice(Lambda.indexOf(elements, this), 1);
        }
    }
    private static function BulgeEnterFrame() : Dynamic
    {
        this.shake += (1 - this.scaleX) * 0.2;
        this.scaleX += this.shake;
        this.scaleY = this.scaleX;
        this.x += (this.originX - this.x) * 0.05;
        this.y += (this.originY - this.y) * 0.05;
        this.shake *= 0.5;
        if (this.b > 0)
        {
            --this.b;
        }
        else
        {
            this.scaleX = this.scaleY = 1;
            elements.splice(Lambda.indexOf(elements, this), 1);
        }
    }
    private static function SpringEnterFrame() : Dynamic
    {
        if (this.b > 0)
        {
            this.spring += (1 - this.scaleX) * 40;
            this.spring *= 0.6;
            this.scaleX += this.spring * 0.01;
            this.scaleX += this.spring * 0.01;
            this.scaleY = this.scaleX;
            this.x += (this.originX - this.x) * 0.05;
            this.y += (this.originY - this.y) * 0.05;
            --this.b;
        }
        else
        {
            this.scaleX = this.scaleY = 1;
            elements.splice(Lambda.indexOf(elements, this), 1);
        }
    }
    private static function PayEnterFrame() : Dynamic
    {
        var tempX : Float = Math.NaN;
        var tempY : Float = Math.NaN;
        if (pourSquiggles > 0)
        {
            pourSquiggles -= 5;
            HUD.counterSquiggles.smoke.text = Char.Squiggles + pourSquiggles;
            tempX = -((Main.relativeStageX - 50 - Math.random() * 30) / 0.75);
            tempY = -((Main.relativeStageY - 30 - Math.random() * 10) / 0.75) + 60 / Main.overRatio;
            StarlingInteract.Spawn("paySquiggle", tempX, tempY, 0, 1, 10 + Math.random() * 8, 20 + Math.random() * 10, 4);
        }
        else
        {
            this.shake -= (25 - this.shake) * 0.2;
        }
        this.x = this.originX + Math.random() * this.shake - this.shake * 0.5;
        this.y = this.originY + Math.random() * this.shake - this.shake * 0.5;
        this.scaleX = this.scaleY = 1 + this.shake * 0.025;
        if (this.shake <= 0)
        {
            this.shake = 0;
            this.x = this.originX;
            this.y = this.originY;
            this.scaleX = this.scaleY = 1;
            elements.splice(Lambda.indexOf(elements, this), 1);
        }
    }
    public var AddictingGames : SimpleButton;
    
    public var HealthBar0 : MovieClip;
    
    public var HealthBar1 : MovieClip;
    
    public var HealthBar2 : MovieClip;
    
    public var HealthBar3 : MovieClip;
    
    public var InkBar0 : MovieClip;
    
    public var InkBar1 : MovieClip;
    
    public var InkBar2 : MovieClip;
    
    public var InkBar3 : MovieClip;
    
    public var Kong : SimpleButton;
    
    public var MGorMC : MovieClip;
    
    public var MiniClip : SimpleButton;
    
    public var __id0_ : MovieClip;
    
    public var __id10_ : MovieClip;
    
    public var __id11_ : MovieClip;
    
    public var __id12_ : MovieClip;
    
    public var __id13_ : MovieClip;
    
    public var __id14_ : MovieClip;
    
    public var __id15_ : MovieClip;
    
    public var __id16_ : MovieClip;
    
    public var __id17_ : MovieClip;
    
    public var __id18_ : MovieClip;
    
    public var __id19_ : MovieClip;
    
    public var __id1_ : MovieClip;
    
    public var __id20_ : MovieClip;
    
    public var __id21_ : MovieClip;
    
    public var __id22_ : MovieClip;
    
    public var __id23_ : MovieClip;
    
    public var __id24_ : MovieClip;
    
    public var __id25_ : MovieClip;
    
    public var __id26_ : MovieClip;
    
    public var __id27_ : MovieClip;
    
    public var __id28_ : MovieClip;
    
    public var __id29_ : MovieClip;
    
    public var __id2_ : MovieClip;
    
    public var __id30_ : MovieClip;
    
    public var __id31_ : MovieClip;
    
    public var __id32_ : MovieClip;
    
    public var __id33_ : MovieClip;
    
    public var __id34_ : MovieClip;
    
    public var __id35_ : MovieClip;
    
    public var __id36_ : MovieClip;
    
    public var __id37_ : MovieClip;
    
    public var __id38_ : MovieClip;
    
    public var __id39_ : MovieClip;
    
    public var __id3_ : MovieClip;
    
    public var __id40_ : MovieClip;
    
    public var __id41_ : MovieClip;
    
    public var __id42_ : MovieClip;
    
    public var __id43_ : MovieClip;
    
    public var __id44_ : MovieClip;
    
    public var __id45_ : MovieClip;
    
    public var __id46_ : MovieClip;
    
    public var __id47_ : MovieClip;
    
    public var __id48_ : MovieClip;
    
    public var __id49_ : MovieClip;
    
    public var __id4_ : MovieClip;
    
    public var __id50_ : MovieClip;
    
    public var __id51_ : MovieClip;
    
    public var __id52_ : MovieClip;
    
    public var __id53_ : MovieClip;
    
    public var __id54_ : MovieClip;
    
    public var __id55_ : MovieClip;
    
    public var __id56_ : MovieClip;
    
    public var __id57_ : MovieClip;
    
    public var __id58_ : MovieClip;
    
    public var __id59_ : MovieClip;
    
    public var __id5_ : MovieClip;
    
    public var __id60_ : MovieClip;
    
    public var __id61_ : MovieClip;
    
    public var __id62_ : MovieClip;
    
    public var __id63_ : MovieClip;
    
    public var __id64_ : MovieClip;
    
    public var __id65_ : MovieClip;
    
    public var __id66_ : MovieClip;
    
    public var __id67_ : MovieClip;
    
    public var __id68_ : MovieClip;
    
    public var __id69_ : MovieClip;
    
    public var __id6_ : MovieClip;
    
    public var __id70_ : MovieClip;
    
    public var __id71_ : MovieClip;
    
    public var __id72_ : MovieClip;
    
    public var __id73_ : MovieClip;
    
    public var __id74_ : MovieClip;
    
    public var __id7_ : MovieClip;
    
    public var __id8_ : MovieClip;
    
    public var __id9_ : MovieClip;
    
    public var attackButton : MovieClip;
    
    public var centerText : TextField;
    
    public var counterLives0 : MovieClip;
    
    public var counterLives1 : MovieClip;
    
    public var counterLives2 : MovieClip;
    
    public var counterLives3 : MovieClip;
    
    public var counterSmash0 : MovieClip;
    
    public var counterSmash1 : MovieClip;
    
    public var counterSmash2 : MovieClip;
    
    public var counterSmash3 : MovieClip;
    
    public var counterSquiggles : MovieClip;
    
    public var debug : TextField;
    
    public var doorButton : MovieClip;
    
    public var downButton : MovieClip;
    
    public var jumpButton : MovieClip;
    
    public var keySwitch : MovieClip;
    
    public var language : TextField;
    
    public var leftButton : MovieClip;
    
    public var logoKizi : MovieClip;
    
    public var muteButton : MovieClip;
    
    public var rightButton : MovieClip;
    
    public var specialButton : MovieClip;
    
    public var straightToBonus : MovieClip;
    
    public var __setPropDict : Dictionary = new Dictionary(true);
    
    public var __lastFrameProp : Int = -1;
    
    public var lastMouseX : Float;
    
    public var lastMouseY : Float;
    
    private var movePressedLast : Float = 0;
    
    public var deviceID : String;
    
    private var inkboarding : Bool;
    
    private var sliding : Bool;
    
    public var barBitmapDatas : Array<BitmapData> = new Array<BitmapData>();
    
    private var barBitmaps : Array<Bitmap> = new Array<Bitmap>();
    
    public var iconBitmapDatas : Array<BitmapData> = new Array<BitmapData>();
    
    private var iconBitmaps : Array<Bitmap> = new Array<Bitmap>();
    
    private var jumpduckSplit : Int;
    
    private var showHoldMe : HoldMe;
    
    private var shouldShowHold : Bool;
    
    public var isReallyMobile : Bool;
    
    private var victory : VictoryScreen;
    
    private var toggleBonus : Bool;
    
    private var myBlackBlank : BlackBlank;
    
    public var overRatio : Float;
    
    public var myBossHealth : FinalBossHealth;
    
    public var myShoutBox : MovieClip;
    
    private var nowShouting : String = "nothing";
    
    private var onlyMove : Bool;
    
    private var inkReach : Int;
    
    private var udReach : Int;
    
    public var ratioX : Float;
    
    public var ratioY : Float;
    
    private var inkboardRatio : Float;
    
    private var specialDown : Bool;
    
    private var specialDown2 : Bool;
    
    private var specialDownX : Float;
    
    private var specialDownN : Int;
    
    private var specialDownRL : Float;
    
    private var specialDownUD : Float;
    
    public function new()
    {
        super();
        addFrameScript(9, this.frame10);
        stop();
        var ex : Float = as3hx.Compat.parseFloat(Capabilities.screenResolutionX);
        var ey : Float = as3hx.Compat.parseFloat(Capabilities.screenResolutionY);
        this.inkboardRatio = Math.sqrt(ex * ex + ey * ey) / Capabilities.screenDPI / 4;
        HUD = this;
        popoutN = 60;
        this.deviceID = Main.deviceID;
        PauseIconCache.createStamp();
        addEventListener(Event.FRAME_CONSTRUCTED, this.__setProp_handler, false, 0, true);
    }
    
    public static function setOnlyMove(e : Bool) : Void
    {
        HUD.onlyMove = e;
    }
    
    public static function removeLanguageSelector() : Void
    {
        HUD.language.text = Main.localSettings.language;
        myLanguageSelector.parent.removeChild(myLanguageSelector);
        myLanguageSelector = null;
    }
    
    public static function updateHealth(id : Int, e : Float) : Dynamic
    {
        Reflect.setField(HUD, Std.string("HealthBar" + id), id).bar.scaleX;
        Reflect.setField(HUD, Std.string("HealthBar" + id), id).shake;
        Reflect.setField(HUD, Std.string("HealthBar" + id), id).elementEnterFrame;
        if (Lambda.indexOf(elements, Reflect.field(HUD, Std.string("HealthBar" + id))) == -1)
        {
            elements.push(Reflect.field(HUD, Std.string("HealthBar" + id)));
        }
    }
    
    public static function updateInk(id : Int, scale : Float, fill : Float) : Void
    {
        if (Reflect.field(HUD, Std.string("InkBar" + id)) != null)
        {
            Reflect.setField(HUD, Std.string("InkBar" + id), id).shake;
            Reflect.setField(HUD, Std.string("InkBar" + id), id).b;
            Reflect.setField(HUD, Std.string("InkBar" + id), id).bar.scaleX;
            Reflect.setField(HUD, Std.string("InkBar" + id), id).elementEnterFrame;
            if (Lambda.indexOf(elements, Reflect.field(HUD, Std.string("InkBar" + id))) == -1)
            {
                elements.push(Reflect.field(HUD, Std.string("InkBar" + id)));
            }
        }
    }
    
    public static function restoreHealth(id : Dynamic, e : Dynamic) : Dynamic
    {
        if (Reflect.field(HUD, Std.string("HealthBar" + id)).bar.scaleX < e / 100)
        {
            Reflect.setField(HUD, Std.string("HealthBar" + id), id).bar.scaleX;
            Reflect.setField(HUD, Std.string("HealthBar" + id), id).shake;
            Reflect.setField(HUD, Std.string("HealthBar" + id), id).b;
            Reflect.setField(HUD, Std.string("HealthBar" + id), id).scaleX;
            if (Lambda.indexOf(elements, Reflect.field(HUD, Std.string("HealthBar" + id))) == -1)
            {
                elements.push(Reflect.field(HUD, Std.string("HealthBar" + id)));
            }
            Reflect.setField(HUD, Std.string("HealthBar" + id), id).elementEnterFrame;
        }
    }
    
    public static function upgradeHealth(id : Int, health : Int, healthMax : Int) : Void
    {
        if (myUpgradePanel != null)
        {
            myUpgradePanel.updateHealthText(healthMax / 100);
        }
        HUD.arrangeHUD(id, health, healthMax);
        Reflect.setField(HUD, Std.string("HealthBar" + id), id).bar.scaleX;
        Reflect.setField(HUD, Std.string("HealthBar" + id), id).shake;
        Reflect.setField(HUD, Std.string("HealthBar" + id), id).b;
        Reflect.setField(HUD, Std.string("HealthBar" + id), id).scaleX;
        if (Lambda.indexOf(elements, Reflect.field(HUD, Std.string("HealthBar" + id))) == -1)
        {
            elements.push(Reflect.field(HUD, Std.string("HealthBar" + id)));
        }
        Reflect.setField(HUD, Std.string("HealthBar" + id), id).elementEnterFrame;
    }
    
    public static function updateLives(id : Int, e : Int, shake : Bool = true) : Void
    {
        if (Reflect.field(HUD, Std.string("counterLives" + id)).smoke.text != Std.string(e))
        {
            Reflect.setField(HUD, Std.string("counterLives" + id), id).smoke.text;
            Reflect.setField(HUD, Std.string("counterLives" + id), id).shake;
            if (Lambda.indexOf(elements, Reflect.field(HUD, Std.string("counterLives" + id))) == -1)
            {
                elements.push(Reflect.field(HUD, Std.string("counterLives" + id)));
            }
            Reflect.setField(HUD, Std.string("counterLives" + id), id).elementEnterFrame;
        }
    }
    
    public static function restoreLives(id : Dynamic, e : Dynamic) : Dynamic
    {
        Reflect.setField(HUD, Std.string("counterLives" + id), id).smoke.text;
        Reflect.setField(HUD, Std.string("counterLives" + id), id).shake;
        Reflect.setField(HUD, Std.string("counterLives" + id), id).b;
        if (Lambda.indexOf(elements, Reflect.field(HUD, Std.string("counterLives" + id))) == -1)
        {
            elements.push(Reflect.field(HUD, Std.string("counterLives" + id)));
        }
        Reflect.setField(HUD, Std.string("counterLives" + id), id).elementEnterFrame;
    }
    
    public static function updateSquiggles(e : Dynamic) : Dynamic
    {
        HUD.counterSquiggles.smoke.text = e;
        if (Lambda.indexOf(elements, HUD.counterSquiggles) == -1)
        {
            elements.push(HUD.counterSquiggles);
        }
        HUD.counterSquiggles.spring = 40;
        HUD.counterSquiggles.b = 30;
        HUD.counterSquiggles.elementEnterFrame = SpringEnterFrame;
    }
    
    public static function paySquiggles(e : Dynamic) : Dynamic
    {
        if (Lambda.indexOf(elements, HUD.counterSquiggles) == -1)
        {
            elements.push(HUD.counterSquiggles);
        }
        HUD.counterSquiggles.shake = 10;
        pourSquiggles = e;
        HUD.counterSquiggles.elementEnterFrame = PayEnterFrame;
    }
    
    public static function updateCounter(damage : Dynamic, hit : Dynamic, n : Dynamic) : Dynamic
    {
        Reflect.setField(HUD, Std.string("counterSmash" + n), n).smoke.text;
        Reflect.setField(HUD, Std.string("counterSmash" + n), n).b;
        if (Lambda.indexOf(elements, Reflect.field(HUD, Std.string("counterSmash" + n))) == -1)
        {
            elements.push(Reflect.field(HUD, Std.string("counterSmash" + n)));
        }
        Reflect.setField(HUD, Std.string("counterSmash" + n), n).spring;
        Reflect.setField(HUD, Std.string("counterSmash" + n), n).elementEnterFrame;
    }
    
    public static function spawnPopup(e : Dynamic) : Void
    {
    }
    
    public static function spawnMyBlackBlank() : Void
    {
        HUD.myBlackBlank = new BlackBlank();
        HUD.addChild(HUD.myBlackBlank);
    }
    
    public static function toggleMyBlackBlank(e : Bool) : Void
    {
        HUD.myBlackBlank.visible = e;
    }
    
    public static function removeMyBlackBlank() : Void
    {
        if (HUD.myBlackBlank != null)
        {
            HUD.myBlackBlank.parent.removeChild(HUD.myBlackBlank);
            HUD.myBlackBlank = null;
        }
    }
    
    public static function spawnUpgradePanel() : Void
    {
        if (myUpgradePanel == null)
        {
            myUpgradePanel = new UpgradePanel();
            myUpgradePanel.x = 700;
            myUpgradePanel.y = -100;
            HUD.addChild(myUpgradePanel);
            elements.push(myUpgradePanel);
        }
    }
    
    public static function removeUpgradePanel() : Void
    {
        if (myUpgradePanel != null)
        {
            elements.splice(Lambda.indexOf(elements, myUpgradePanel), 1);
            myUpgradePanel.parent.removeChild(myUpgradePanel);
            myUpgradePanel = null;
        }
    }
    
    public static function popoutMenuMenu(e : Dynamic) : Void
    {
    }
    
    public static function popoutWait() : Dynamic
    {
        if (popoutN > 0)
        {
            --popoutN;
        }
        else
        {
            popoutMenuMenu("in");
        }
    }
    
    public static function popoutOut() : Dynamic
    {
        if (HUD.popoutMenu.alpha < 1)
        {
            HUD.popoutMenu.alpha += 0.2;
        }
        if (HUD.popoutMenu.alpha > 1)
        {
            HUD.popoutMenu.alpha = 1;
        }
        HUD.popoutMenu.x += (800 - 160 - HUD.popoutMenu.x) * 0.2;
        if (HUD.popoutMenu.x == 800 - 160 && HUD.popoutMenu.alpha == 1)
        {
            if (Main.LevelLoaded.substr(0, 5) == "Menus")
            {
                popoutMenuMenu("nothing");
            }
            else
            {
                popoutMenuMenu("fadeout");
            }
        }
    }
    
    public static function popoutIn() : Dynamic
    {
        HUD.popoutMenu.x += (800 - 10 - HUD.popoutMenu.x) * 0.2;
        if (HUD.popoutMenu.x >= 800 - 10.2)
        {
            if (Main.LevelLoaded.substr(0, 5) == "Menus")
            {
                popoutMenuMenu("nothing");
            }
            else
            {
                popoutMenuMenu("fadeout");
            }
        }
    }
    
    public static function popoutFadeOut() : Dynamic
    {
        if (popoutN > 0)
        {
            --popoutN;
        }
        else if (HUD.popoutMenu.alpha > 0)
        {
            HUD.popoutMenu.alpha -= 0.05;
        }
        else
        {
            if (!isTouchScreen)
            {
                flash.ui.Mouse.hide();
            }
            HUD.popoutMenu.alpha = 0;
            elements.splice(Lambda.indexOf(elements, HUD.popoutMenu), 1);
        }
    }
    
    public static function popoutFadeIn() : Dynamic
    {
        if (HUD.popoutMenu.alpha < 1)
        {
            HUD.popoutMenu.alpha += 0.2;
        }
        else if (Main.LevelLoaded.substr(0, 5) == "Menus")
        {
            popoutMenuMenu("nothing");
        }
        else
        {
            popoutMenuMenu("fadeout");
        }
    }
    
    public static function allElements() : Dynamic
    {
        var popup : PopupMessage = null;
        for (i in 0...elements.length)
        {
            elements[i].elementEnterFrame();
        }
        if (popupN > 0)
        {
            --popupN;
        }
        else if (toPopupArray.length > 0)
        {
            popup = new PopupMessage(toPopupArray.shift());
            popupsArray.push(popup);
            HUD.addChild(popup);
            popupN = 30;
        }
        for (i in 0...popupsArray.length)
        {
            popupsArray[i].popupEnterFrame();
        }
        if (isTouchScreen && !usingGamepad)
        {
            HUD.showDoor(Main.showDoorIcon);
            if (Main.deviceID == "iPhone")
            {
                HUD.showAttack(Char.CharArray[0].pencilOut > 0 && Char.CharArray[0].Status != "InkBoard");
            }
            HUD.showInkboard();
        }
    }
    
    public function finishChallenge() : Void
    {
        this.victory = new VictoryScreen();
        elements.push(this.victory);
        addChild(this.victory);
    }
    
    public function clearSplashScreens() : Void
    {
        if (this.victory != null)
        {
            removeChild(this.victory);
            elements.splice(Lambda.indexOf(elements, this.victory), 1);
            this.victory = null;
        }
        if (this.myShoutBox != null)
        {
            removeChild(this.myShoutBox);
            elements.splice(Lambda.indexOf(elements, this.myShoutBox), 1)[0];
            this.myShoutBox = null;
            this.nowShouting = "nothing";
        }
    }
    
    public function setupLevelSelect() : Void
    {
        this.clearBars();
        if (isTouchScreen || true)
        {
            gotoAndStop("pitchSelect");
        }
        else
        {
            gotoAndStop("LevelSelect");
        }
        this.keySwitch.stop();
        alpha = 1;
        this.language.text = Main.localSettings.language;
        this.language.mouseEnabled = false;
        mouseEnabled = true;
        mouseChildren = true;
        if (this.showHoldMe != null)
        {
            removeChild(this.showHoldMe);
            this.showHoldMe = null;
        }
        this.toggleBonus = false;
        this.straightToBonus.gotoAndStop(1);
        this.straightToBonus.button.addEventListener(MouseEvent.CLICK, this.toggleBonusClick);
        var n : Int = numChildren;
        for (i in 0...n)
        {
            if (Type.getClassName(getChildAt(i)) == "flash.display::MovieClip" && getChildAt(i).name.substr(0, 2) == "__")
            {
                getChildAt(i).button.addEventListener(MouseEvent.CLICK, this.levelClicked);
            }
        }
    }
    
    public function startTouchControls(start : Bool) : Dynamic
    {
        if (this.shouldShowHold)
        {
            movementButton.addEventListener(TouchEvent.TOUCH_BEGIN, this.moveButtonAfterTip);
            buttonsButton.addEventListener(TouchEvent.TOUCH_BEGIN, this.actionButtonAfterTip);
            this.buttonsVisible(false);
        }
        else
        {
            this.setTouchControls(start);
        }
    }
    
    public function buttonsVisible(vis : Bool) : Void
    {
        if (this.leftButton != null)
        {
            this.leftButton.visible = vis;
            this.rightButton.visible = vis;
            if (!this.onlyMove || !vis)
            {
                this.attackButton.visible = vis;
                if (Char.hasShoot)
                {
                    this.specialButton.visible = vis;
                }
                this.jumpButton.visible = vis;
                this.downButton.visible = vis;
            }
            if (!vis)
            {
                this.doorButton.visible = false;
            }
        }
    }
    
    public function justArrowsVisible(vis : Bool) : Void
    {
        if (!usingGamepad)
        {
            this.leftButton.visible = vis;
            this.rightButton.visible = vis;
        }
    }
    
    public function giveShoot() : Void
    {
        if (isTouchScreen && !usingGamepad)
        {
            this.specialButton.visible = this.attackButton.visible;
        }
    }
    
    private function moveButtonAfterTip(event : TouchEvent) : Dynamic
    {
        movementButton.removeEventListener(TouchEvent.TOUCH_BEGIN, this.moveButtonAfterTip);
        buttonsButton.removeEventListener(TouchEvent.TOUCH_BEGIN, this.actionButtonAfterTip);
        this.shiftAllButtons(event.localY);
        this.checkMoveButtons(event.localX, event.localY);
        this.buttonsVisible(true);
        removeChild(this.showHoldMe);
        this.showHoldMe = null;
        this.shouldShowHold = false;
        this.setTouchControls();
    }
    
    private function actionButtonAfterTip(event : TouchEvent) : Dynamic
    {
        if (event.localY < 80)
        {
            Main.PauseGame(true, 0);
        }
        else
        {
            movementButton.removeEventListener(TouchEvent.TOUCH_BEGIN, this.moveButtonAfterTip);
            buttonsButton.removeEventListener(TouchEvent.TOUCH_BEGIN, this.actionButtonAfterTip);
            this.shiftAllButtons((event.stageY + 70) / this.overRatio);
            this.checkButtonsButtons(event.localX, event.localY);
            this.buttonsVisible(true);
            removeChild(this.showHoldMe);
            this.showHoldMe = null;
            this.shouldShowHold = false;
            this.setTouchControls();
        }
    }
    
    private function setTouchControls(start : Bool) : Dynamic
    {
        if (cast(this.onlyMove, Bool) && start)
        {
            movementButton.addEventListener(MouseEvent.MOUSE_DOWN, this.cinButtonStart);
            movementButton.addEventListener(MouseEvent.MOUSE_UP, this.cinButtonEnd);
            buttonsButton.addEventListener(MouseEvent.MOUSE_DOWN, this.cinButtonStart);
            buttonsButton.addEventListener(MouseEvent.MOUSE_UP, this.cinButtonEnd);
        }
    }
    
    private function setOnlyPauseControls() : Void
    {
        if (isTouchScreen && !this.isReallyMobile)
        {
            buttonsButton.addEventListener(MouseEvent.MOUSE_DOWN, this.buttonsButtonPause);
        }
        else
        {
            buttonsButton.addEventListener(TouchEvent.TOUCH_BEGIN, this.buttonsButtonPause);
        }
    }
    
    public function removePauseControls() : Void
    {
        if (isTouchScreen && !this.isReallyMobile)
        {
            buttonsButton.removeEventListener(MouseEvent.MOUSE_DOWN, this.buttonsButtonPause);
        }
        else
        {
            buttonsButton.removeEventListener(TouchEvent.TOUCH_BEGIN, this.buttonsButtonPause);
        }
    }
    
    private function downPressed(event : TouchEvent) : Dynamic
    {
        Char.CharArray[0].fakeDownIsDown = true;
    }
    
    private function upPressed(event : Event) : Dynamic
    {
        Char.CharArray[0].fakeUpIsDown = true;
    }
    
    private function jumpPressed(event : TouchEvent) : Dynamic
    {
        Char.CharArray[0].fakeJumpIsDown = true;
    }
    
    private function downReleased(event : TouchEvent) : Dynamic
    {
        Char.CharArray[0].fakeDownIsDown = false;
    }
    
    private function upReleased(event : Event) : Dynamic
    {
        Char.CharArray[0].fakeUpIsDown = false;
    }
    
    private function jumpReleased(event : TouchEvent) : Dynamic
    {
        Char.CharArray[0].fakeJumpIsDown = false;
    }
    
    private function cinButtonStart(event : Event) : Void
    {
        Char.CharArray[0].attackUD = -1;
    }
    
    private function cinButtonEnd(event : Event) : Void
    {
        Char.CharArray[0].attackUD = 0;
    }
    
    public function checkDoorButton(ex : Int, ey : Int) : Bool
    {
        if (this.doorButton.visible)
        {
            if (Math.abs(ex - this.doorButton.x) < 60 && Math.abs(ey - this.doorButton.y) < 60)
            {
                Char.CharArray[0].fakeUpIsDown = true;
                this.doorButton.gotoAndStop(2);
                return true;
            }
        }
        return false;
    }
    
    public function moveButtonStart(ex : Float, ey : Float) : Void
    {
        if (this.deviceID == "iPad")
        {
            this.shiftAllButtons(ey);
        }
        this.lastMouseY = ey;
        if (Math.round(haxe.Timer.stamp() * 1000) - this.movePressedLast > 800)
        {
            this.lastMouseX = ex;
            if (!this.inkboarding)
            {
                this.checkMoveButtons(ex, ey);
            }
        }
        else if (ex > this.lastMouseX + 40)
        {
            this.checkMoveButtons(40, ey);
            this.lastMouseX = ex;
        }
        else if (ex < this.lastMouseX - 40)
        {
            this.checkMoveButtons(-40, ey);
            this.lastMouseX = ex;
        }
        else
        {
            this.lastMouseX = ex;
            if (!this.inkboarding)
            {
                this.checkMoveButtons(ex, ey);
            }
        }
    }
    
    public function moveButtonEnd(ex : Float, ey : Float) : Dynamic
    {
        Char.CharArray[0].fakeLeftIsDown = false;
        Char.CharArray[0].fakeRightIsDown = false;
        this.leftButton.gotoAndStop(1);
        this.rightButton.gotoAndStop(1);
        this.lastMouseX = ex;
        this.lastMouseY = ey;
        if (cast(this.sliding, Bool) && !this.inkboarding)
        {
            this.leftButton.visible = true;
            this.rightButton.visible = true;
        }
        this.movePressedLast = Math.round(haxe.Timer.stamp() * 1000);
        this.sliding = false;
    }
    
    public function moveButtonMove(ex : Float, ey : Float) : Dynamic
    {
        if (this.inkboarding)
        {
            Char.CharArray[0].wantRL += (ex - this.lastMouseX) * 0.04 * this.inkboardRatio;
            Char.CharArray[0].wantUD += (ey - this.lastMouseY) * 0.04 * this.inkboardRatio;
            this.lastMouseX = ex;
            this.lastMouseY = ey;
            this.sliding = true;
        }
        else
        {
            if (ex > this.lastMouseX + 20)
            {
                Char.CharArray[0].fakeLeftIsDown = false;
                Char.CharArray[0].fakeRightIsDown = true;
                if (!this.sliding)
                {
                    this.leftButton.gotoAndStop(1);
                    this.leftButton.visible = false;
                    this.rightButton.gotoAndStop(1);
                    this.rightButton.visible = false;
                    this.sliding = true;
                }
                this.lastMouseX = ex;
            }
            if (ex < this.lastMouseX - 20)
            {
                Char.CharArray[0].fakeRightIsDown = false;
                Char.CharArray[0].fakeLeftIsDown = true;
                if (!this.sliding)
                {
                    this.leftButton.gotoAndStop(1);
                    this.leftButton.visible = false;
                    this.rightButton.gotoAndStop(1);
                    this.rightButton.visible = false;
                    this.sliding = true;
                }
                this.lastMouseX = ex;
            }
            if (!this.sliding)
            {
                this.checkMoveButtons(ex, ey);
            }
        }
    }
    
    private function checkMoveButtons(ex : Float, ey : Float) : Dynamic
    {
        Char.CharArray[0].fakeLeftIsDown = false;
        Char.CharArray[0].fakeRightIsDown = false;
        if (usingGamepad)
        {
            Char.CharArray[0].usingGamepad = usingGamepad = false;
            this.buttonsVisible(true);
            Main.switchTouchscreen(true);
        }
        if (ex < 0)
        {
            Char.CharArray[0].fakeLeftIsDown = true;
        }
        else
        {
            Char.CharArray[0].fakeRightIsDown = true;
        }
        if (Char.CharArray[0].fakeLeftIsDown)
        {
            this.leftButton.gotoAndStop(2);
        }
        else
        {
            this.leftButton.gotoAndStop(1);
        }
        if (Char.CharArray[0].fakeRightIsDown)
        {
            this.rightButton.gotoAndStop(2);
        }
        else
        {
            this.rightButton.gotoAndStop(1);
        }
    }
    
    private function buttonsButtonPause(event : Event) : Dynamic
    {
        if ((event.localY - y) / Main.overRatio < 80)
        {
            this.buttonsVisible(false);
            Main.PauseGame(true, 0);
        }
    }
    
    public function buttonsButtonStart(ex : Float, ey : Float) : Void
    {
        if (ey < 80)
        {
            this.buttonsVisible(false);
            Main.PauseGame(true, 0);
        }
        else
        {
            this.checkButtonsButtons(ex, ey, true);
        }
    }
    
    public function buttonsButtonMove(ex : Float, ey : Float) : Dynamic
    {
        this.checkButtonsButtons(ex, ey);
    }
    
    public function buttonsButtonEnd(ex : Float, ey : Float) : Dynamic
    {
        Char.CharArray[0].fakeJumpIsDown = false;
        Char.CharArray[0].fakeDownIsDown = false;
        Char.CharArray[0].fakeAttackIsDown = false;
        Char.CharArray[0].fakeSpecial2IsDown = false;
        Char.CharArray[0].fakeSpecialIsDown = false;
        this.specialDown = false;
        this.specialDown2 = false;
        this.specialDownRL = 0;
        this.jumpButton.gotoAndStop(1);
        this.downButton.gotoAndStop(1);
        this.attackButton.gotoAndStop(1);
        this.specialButton.gotoAndStop(1);
    }
    
    private function checkButtonsButtons(ex : Float, ey : Float, start : Bool = false) : Dynamic
    {
        Char.CharArray[0].fakeJumpIsDown = false;
        Char.CharArray[0].fakeDownIsDown = false;
        Char.CharArray[0].fakeAttackIsDown = false;
        Char.CharArray[0].fakeSpecial2IsDown = false;
        Char.CharArray[0].fakeSpecialIsDown = false;
        if (usingGamepad)
        {
            Char.CharArray[0].usingGamepad = usingGamepad = false;
            this.buttonsVisible(true);
            Main.switchTouchscreen(true);
        }
        if (start)
        {
            this.specialDownX = ex;
        }
        else
        {
            this.specialDownRL = ex - this.specialDownX;
        }
        if (!this.specialDown)
        {
            if (ex > 0)
            {
                if (ey < this.jumpduckSplit + 5)
                {
                    Char.CharArray[0].fakeJumpIsDown = true;
                }
                else
                {
                    Char.CharArray[0].fakeDownIsDown = true;
                }
            }
            else if (ex < -this.inkReach)
            {
                if (start)
                {
                    this.specialDown = true;
                    this.specialDownN = 0;
                }
                this.specialDownUD = ey - this.jumpduckSplit;
            }
            else
            {
                Char.CharArray[0].fakeAttackIsDown = true;
                if (Math.abs(ey - this.jumpduckSplit) > this.udReach)
                {
                    Char.CharArray[0].attackUD = ey - this.jumpduckSplit;
                }
                else
                {
                    Char.CharArray[0].attackUD = 0;
                }
            }
        }
        HUD.checkSpecial();
        if (Char.CharArray[0].fakeDownIsDown)
        {
            this.downButton.gotoAndStop(2);
        }
        else
        {
            this.downButton.gotoAndStop(1);
        }
        if (Char.CharArray[0].fakeAttackIsDown)
        {
            if (Char.CharArray[0].attackUD < 0)
            {
                this.attackButton.gotoAndStop(3);
            }
            else if (Char.CharArray[0].attackUD > 0)
            {
                this.attackButton.gotoAndStop(4);
            }
            else
            {
                this.attackButton.gotoAndStop(2);
            }
        }
        else
        {
            this.attackButton.gotoAndStop(1);
        }
        if (this.specialDown)
        {
            this.specialButton.gotoAndStop(2);
        }
        else
        {
            this.specialButton.gotoAndStop(1);
        }
    }
    
    private function shiftAllButtons(ey : Dynamic) : Dynamic
    {
        if (Math.abs(ey - y - this.rightButton.y) > 20)
        {
            this.rightButton.y = ey - y;
            if (this.rightButton.y - Main.relativeStageY > 325)
            {
                this.rightButton.y = Main.relativeStageY + 325;
            }
            if (this.rightButton.y - Main.relativeStageY < -325)
            {
                this.rightButton.y = Main.relativeStageY - 325;
            }
            this.leftButton.y = this.rightButton.y;
            this.attackButton.y = (this.rightButton.y - Main.relativeStageY) * 0.8633980881899477 + Main.relativeStageY;
            this.jumpButton.y = this.attackButton.y - 35;
            this.downButton.y = this.attackButton.y + 35;
            this.specialButton.y = this.attackButton.y;
            this.jumpduckSplit = this.attackButton.y;
            this.doorButton.y = this.attackButton.y + 15;
        }
    }
    
    private function toggleBonusClick(event : MouseEvent) : Dynamic
    {
        this.toggleBonus = !this.toggleBonus;
        if (this.toggleBonus)
        {
            event.target.parent.gotoAndStop(2);
        }
        else
        {
            event.target.parent.gotoAndStop(1);
        }
    }
    
    private function levelClicked(event : MouseEvent) : Void
    {
        stage.focus = stage;
        if (event.target.parent.ID == "language")
        {
            if (myLanguageSelector == null)
            {
                myLanguageSelector = new LanguageSelector();
                myLanguageSelector.x = Main.relativeStageX;
                myLanguageSelector.y = Main.relativeStageY;
                addChild(myLanguageSelector);
            }
            else
            {
                removeLanguageSelector();
            }
            return;
        }
        if (myLanguageSelector != null)
        {
            removeLanguageSelector();
        }
        var n : Int = numChildren;
        for (i in 0...n)
        {
            if (Type.getClassName(getChildAt(i)) == "flash.display::MovieClip" && getChildAt(i).name.substr(0, 2) == "__")
            {
                getChildAt(i).button.removeEventListener(MouseEvent.CLICK, this.levelClicked);
            }
        }
        if (event.target.parent.dir == "World 1")
        {
            Main.worldPrefix = "_W1R";
        }
        else
        {
            Main.worldPrefix = "_W4A";
        }
        var load : String = event.target.parent.ID;
        if (load == "reset")
        {
            Main.fillUndefined(true);
            load = "Menus0-a";
        }
        else if (load.substr(0, 5) != "Villa")
        {
            if (!(load == "Level0-a" || load == "Level0-d" || load == "Level0-h" || load == "Level1-h" || load == "Level1-k" || load == "Level2-j" || load == "Level3-a" || load == "Level3-i" || load == "Level3-j" || load == "Level4-h" || load == "Level5-a"))
            {
                if (cast(this.toggleBonus, Bool) && load.indexOf("-") > -1)
                {
                    load = "Bonus" + load.substr(5, load.length - 5);
                }
            }
        }
        Main.saveDebug(load, event.target.parent.door, event.target.parent.dir);
        Main.debugGivePen(load, event.target.parent.dir);
        Main.stageRoot.startLoad(load, event.target.parent.dir);
        Sounds.fadeOutMusic(Sounds.getMusic(load));
        if (event.target.parent.door != null)
        {
            Main.DoorIt = event.target.parent.door;
        }
        Main.stageRoot.onlyMove = load == "Menus0-a" && Main.DoorIt == 1;
        rootHUD.setOnlyMove(load == "Menus0-a" && Main.DoorIt == 1);
        rootHUD.HUD.setupTouchScreen();
        Main.startControls();
        if (!isTouchScreen)
        {
            gotoAndStop("1Player");
            this.fixBanner();
        }
    }
    
    public function setupTouchScreen() : Void
    {
        if (this.deviceID != "iPad")
        {
            gotoAndStop("touchScreen");
            this.inkReach = 140;
            this.udReach = 50;
        }
        else
        {
            gotoAndStop("touchScreen43");
            this.inkReach = 80;
            this.udReach = 40;
            if (this.shouldShowHold)
            {
                this.showHoldMe = new HoldMe();
                this.showHoldMe.x = Main.relativeStageX;
                this.showHoldMe.y = Main.relativeStageY;
                addChild(this.showHoldMe);
            }
        }
        this.keySwitch.stop();
        mouseEnabled = false;
        mouseChildren = false;
        this.leftButton.stop();
        this.rightButton.stop();
        this.jumpButton.stop();
        this.downButton.stop();
        this.attackButton.stop();
        this.specialButton.stop();
        this.doorButton.stop();
        this.doorButton.alpha = 0;
        this.jumpduckSplit = (this.jumpButton.y + this.downButton.y) * 0.5;
        if (Char.CharArray[0].usingGamepad)
        {
            usingGamepad = true;
            this.buttonsVisible(false);
            Main.switchTouchscreen(false);
        }
        else if (this.onlyMove)
        {
            this.buttonsVisible(false);
            Main.switchTouchscreen(false);
            alpha = 0;
        }
        else
        {
            Main.switchTouchscreen(true);
        }
    }
    
    public function fixBanner() : Void
    {
        this.keySwitch.stop();
        this.Kong.visible = this.keySwitch.visible = false;
    }
    
    public function shoutTheBox(shout : Dynamic) : Void
    {
        var classType : Class<Dynamic>;
        var temp : Int = Lambda.indexOf(["goForCat", "Level0-b", "continuePen", "inkboarding", "startPlains", "RUN", "Level1-k", "Villa0-a", "Villa0-b", "goUpgrade", "findSource", "findSource2", "findPirates", "tutOutlines", "Level2-a", "tutSpinners", "rescueCrew", "goZip", "reallyGoZip", "reallyGoZipTouch", "reallyGoZipPad", "Level3-b", "Level4-a"], shout);
        if (temp == -1)
        {
            return;
        }
        if (this.nowShouting != "nothing" && shout == this.nowShouting)
        {
            if (this.myShoutBox.state == 2)
            {
                this.myShoutBox.b = 10;
            }
            return;
        }
        if (this.myShoutBox != null)
        {
            return;
        }
        trace("---- " + shout + "-----");
        classType = Type.getClass(Type.resolveClass("shoutBox" + Main.localSettings.language));
        this.myShoutBox = Type.createInstance(classType, []);
        addChild(this.myShoutBox);
        this.myShoutBox.x = 500;
        this.myShoutBox.y = -70;
        this.myShoutBox.b = 10;
        this.myShoutBox.state = 0;
        this.myShoutBox.speed = [0.02, 0.03, 0.08, 0.03, 0.03, 0.1, 0.04, 0.04, 0.04, 0.04, 0.03, 0.03, 0.05, 0.02, 0.03, 0.02, 0.03, 0.02, 0.02, 0.02, 0.02, 0.03, 0.03][temp];
        this.myShoutBox.stay = 60;
        elements.push(this.myShoutBox);
        this.myShoutBox.gotoAndStop(shout);
        this.nowShouting = shout;
        this.myShoutBox.elementEnterFrame = function() : Dynamic
                {
                    if (this.state == 0)
                    {
                        if (this.b > 0)
                        {
                            --this.b;
                        }
                        else
                        {
                            this.b = 0;
                            this.state = 1;
                        }
                    }
                    else if (this.state == 1)
                    {
                        this.b += this.speed;
                        if (this.b > 1)
                        {
                            this.b = 1;
                        }
                        myShoutBox.y = -70 + 130 * sinCurve(this.b);
                        if (this.b == 1)
                        {
                            this.b = this.stay;
                            this.state = 2;
                        }
                    }
                    else if (this.state == 2)
                    {
                        if (this.b > 0)
                        {
                            --this.b;
                        }
                        else
                        {
                            this.b = 1;
                            this.state = 3;
                        }
                    }
                    else if (this.state == 3)
                    {
                        this.b -= this.speed * 2;
                        if (this.b < 0)
                        {
                            this.b = 0;
                        }
                        myShoutBox.y = -70 + 130 * sinCurve(this.b);
                        if (this.b == 0)
                        {
                            clearSplashScreens();
                        }
                    }
                };
    }
    
    private function sinCurve(e : Float) : Float
    {
        return Math.sin(e * 1.57);
    }
    
    public function setupBars(i : Int) : Dynamic
    {
        if (Main.LevelStatus == "Smash")
        {
            Reflect.setField(HUD, Std.string("counterSmash" + i), i).smoke.text;
            Reflect.setField(HUD, Std.string("counterSmash" + i), i).originX;
            Reflect.setField(HUD, Std.string("counterSmash" + i), i).originY;
            Reflect.setField(HUD, Std.string("counterLives" + i), i).smoke.text;
        }
        else
        {
            if (this.barBitmapDatas.length <= i)
            {
                this.barBitmapDatas[i] = new BitmapData(600, 28, false, Main.pantsToHex(Char.CharArray[i].pantsN));
                this.barBitmaps[i] = new Bitmap(this.barBitmapDatas[i]);
            }
            Reflect.field(HUD, Std.string("HealthBar" + i)).addChild(this.barBitmaps[i]);
            Reflect.field(HUD, Std.string("HealthBar" + i)).addChild(Reflect.field(HUD, Std.string("HealthBar" + i)).outline);
            this.barBitmaps[i].x = Reflect.field(HUD, Std.string("HealthBar" + i)).bar.x;
            this.barBitmaps[i].y = Reflect.field(HUD, Std.string("HealthBar" + i)).bar.y;
            this.barBitmaps[i].scaleX = this.barBitmaps[i].scaleY = 0.5;
            this.barBitmaps[i].mask = Reflect.field(HUD, Std.string("HealthBar" + i)).bar;
            if (Char.CharArray[i].lives > -1)
            {
                Reflect.setField(HUD, Std.string("counterLives" + i), i).smoke.text;
            }
            if (Char.CharArray[i].patternN > 0)
            {
                Char.CharArray[i].textureOnBar(Char.CharArray[i].patternN);
            }
            Reflect.setField(HUD, Std.string("InkBar" + i), i).originX;
            Reflect.setField(HUD, Std.string("InkBar" + i), i).originY;
            HUD.counterSquiggles.smoke.text = Char.Squiggles;
            if (Char.hasShoot)
            {
                Reflect.setField(HUD, Std.string("InkBar" + i), i).visible;
                Reflect.setField(HUD, Std.string("InkBar" + i), i).bar.scaleX;
                if (HUD.specialButton != null)
                {
                    HUD.specialButton.visible = HUD.attackButton.visible;
                }
            }
            else
            {
                Reflect.setField(HUD, Std.string("InkBar" + i), i).visible;
                if (HUD.specialButton != null)
                {
                    HUD.specialButton.visible = false;
                }
            }
        }
        this.arrangeHUD(i, Char.CharArray[i].health, Char.CharArray[i].healthMax);
        this.iconBitmapDatas[i] = new BitmapData(50, 45, true, 0);
        this.iconBitmaps[i] = new Bitmap(this.iconBitmapDatas[i]);
        this.iconBitmaps[i].x = this.iconBitmaps[i].y = -10;
        this.iconBitmaps[i].scaleX = this.iconBitmaps[i].scaleY = 0.5;
        this.iconBitmaps[i].smoothing = true;
        Reflect.field(HUD, Std.string("counterLives" + i)).addChild(this.iconBitmaps[i]);
    }
    
    private function arrangeHUD(i : Int, health : Int, healthMax : Int) : Void
    {
        if (Main.LevelStatus != "Smash")
        {
            Reflect.setField(HUD, Std.string("HealthBar" + i), i).outline.scaleX;
            if (health > -1)
            {
                Reflect.setField(HUD, Std.string("HealthBar" + i), i).bar.scaleX;
            }
            if (i == 0 || i == 2)
            {
                Reflect.setField(HUD, Std.string("HealthBar" + i), i).x;
            }
            else
            {
                Reflect.setField(HUD, Std.string("HealthBar" + i), i).x;
            }
            if (i == 0 || i == 1)
            {
                Reflect.setField(HUD, Std.string("HealthBar" + i), i).y;
            }
            else
            {
                Reflect.setField(HUD, Std.string("HealthBar" + i), i).y;
            }
            Reflect.setField(HUD, Std.string("HealthBar" + i), i).originX;
            Reflect.setField(HUD, Std.string("HealthBar" + i), i).originY;
            if (Char.CharN == 1)
            {
                this.counterSquiggles.x = 38.25;
                this.counterSquiggles.y = 33.65;
            }
            else
            {
                this.counterSquiggles.x = 400;
                this.counterSquiggles.y = 17.65;
            }
            HUD.counterSquiggles.originX = HUD.counterSquiggles.x;
            HUD.counterSquiggles.originY = HUD.counterSquiggles.y;
            if (Char.CharN == 1 && Main.LevelStatus != "Smash")
            {
                Reflect.setField(HUD, Std.string("counterLives" + i), i).x;
                Reflect.setField(HUD, Std.string("counterLives" + i), i).y;
            }
            else
            {
                Reflect.setField(HUD, Std.string("counterLives" + i), i).x;
                Reflect.setField(HUD, Std.string("counterLives" + i), i).y;
            }
        }
        Reflect.setField(HUD, Std.string("counterLives" + i), i).originX;
        Reflect.setField(HUD, Std.string("counterLives" + i), i).originY;
    }
    
    public function showBars() : Void
    {
        for (i in 0...this.barBitmaps.length)
        {
            Reflect.setField(HUD, Std.string("InkBar" + i), i).visible;
        }
    }
    
    private function clearBars() : Void
    {
        for (i in 0...this.barBitmaps.length)
        {
            this.barBitmaps[i].parent.removeChild(this.barBitmaps[i]);
            this.barBitmapDatas[i].dispose();
        }
        this.barBitmaps = new Array<Bitmap>();
        this.barBitmapDatas = new Array<BitmapData>();
    }
    
    public function spawnBossHealth() : Void
    {
        this.myBossHealth = new FinalBossHealth();
        this.myBossHealth.x = Main.relativeStageX;
        this.myBossHealth.y = Main.relativeStageY * 1.7;
        HUD.addChild(this.myBossHealth);
        this.myBossHealth.alpha = 0;
    }
    
    public function removeBossHealth() : Void
    {
        if (this.myBossHealth != null)
        {
            this.myBossHealth.parent.removeChild(this.myBossHealth);
            this.myBossHealth = null;
        }
    }
    
    public function updateBossHealth(e : Float) : Void
    {
        this.myBossHealth.bar.scaleX = e * 2;
    }
    
    public function showDoor(show : Dynamic) : Dynamic
    {
        if (show != null)
        {
            if (!this.doorButton.visible)
            {
                this.doorButton.visible = true;
            }
            if (this.doorButton.alpha < 0.8)
            {
                this.doorButton.alpha += 0.2;
            }
            if (this.doorButton.alpha > 0.8)
            {
                this.doorButton.alpha = 0.8;
            }
        }
        else if (this.doorButton.alpha > 0)
        {
            this.doorButton.alpha -= 0.1;
        }
        else
        {
            this.doorButton.gotoAndStop(1);
            this.doorButton.alpha = 0;
            this.doorButton.visible = false;
        }
    }
    
    public function showAttack(show : Dynamic) : Dynamic
    {
        if (show != null)
        {
            if (this.attackButton.alpha < 1)
            {
                this.attackButton.alpha += 0.2;
            }
            else
            {
                this.attackButton.alpha = 1;
            }
            if (this.specialButton.alpha < 1)
            {
                this.specialButton.alpha += 0.2;
            }
            else
            {
                this.specialButton.alpha = 1;
            }
        }
        else
        {
            if (this.attackButton.alpha > 0.4)
            {
                this.attackButton.alpha -= 0.1;
            }
            else
            {
                this.attackButton.alpha = 0.4;
            }
            if (this.specialButton.alpha > 0.4)
            {
                this.specialButton.alpha -= 0.1;
            }
            else
            {
                this.specialButton.alpha = 0.4;
            }
        }
    }
    
    public function showInkboard() : Dynamic
    {
        if (Char.CharArray[0].fakeJumpIsDown)
        {
            if (Char.CharArray[0].canStatus == "inkBoard")
            {
                this.jumpButton.gotoAndStop(4);
            }
            else
            {
                this.jumpButton.gotoAndStop(2);
            }
        }
        else if (Char.CharArray[0].canStatus == "inkBoard")
        {
            this.jumpButton.gotoAndStop(3);
        }
        else
        {
            this.jumpButton.gotoAndStop(1);
        }
    }
    
    public function checkSpecial(tick : Bool = false) : Void
    {
        if (Math.abs(this.specialDownRL) > 20)
        {
            Char.CharArray[0].attackRL = this.specialDownRL;
            Char.CharArray[0].fakeSpecial2IsDown = true;
            this.specialDown = true;
        }
        else if (this.specialDown)
        {
            if (tick)
            {
                ++this.specialDownN;
            }
            if (this.specialDownN > 5)
            {
                Char.CharArray[0].fakeSpecialIsDown = true;
                Char.CharArray[0].attackUD = this.specialDownUD;
            }
        }
    }
    
    public function switchInkboard(inkboard : Dynamic) : Dynamic
    {
        if (isTouchScreen && !usingGamepad)
        {
            if (inkboard != null)
            {
                this.leftButton.visible = false;
                this.rightButton.visible = false;
            }
            else if (!this.sliding)
            {
                this.leftButton.visible = true;
                this.rightButton.visible = true;
            }
            this.inkboarding = inkboard;
        }
    }
    
    public function popOutLogic(ex : Dynamic) : Dynamic
    {
        if (Main.canPopOut && popoutMenu.status != "wait")
        {
            if (ex > 800 - 300 && ex < 800)
            {
                popoutN = 60;
                if (popoutMenu.status != "out")
                {
                    popoutMenuMenu("out");
                }
            }
            else
            {
                popoutN = 10;
                if (popoutMenu.alpha < 1)
                {
                    if (popoutMenu.status != "fadein")
                    {
                        popoutMenuMenu("fadein");
                    }
                }
                else if (popoutMenu.status != "in")
                {
                    popoutMenuMenu("in");
                }
            }
        }
    }
    
    @:allow()
    private function __setProp___id0__HUD_buttons_9() : Dynamic
    {
        if (this.__setPropDict[this.__id0_] == null || as3hx.Compat.parseInt(this.__setPropDict[this.__id0_]) != 10)
        {
            this.__setPropDict[this.__id0_] = 10;
            try
            {
                this.__id0_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id0_.dir = "World 4";
            this.__id0_.ID = "Level0-a";
            this.__id0_.door = -1;
            try
            {
                this.__id0_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id0__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id0_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id0_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id0_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id0_]) <= 20)))
        {
            this.__setPropDict[this.__id0_] = curFrame;
            try
            {
                this.__id0_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id0_.dir = "World 4";
            this.__id0_.ID = "Tutor2-a";
            this.__id0_.door = -1;
            try
            {
                this.__id0_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id1__HUD_buttons_9() : Dynamic
    {
        if (this.__setPropDict[this.__id1_] == null || as3hx.Compat.parseInt(this.__setPropDict[this.__id1_]) != 10)
        {
            this.__setPropDict[this.__id1_] = 10;
            try
            {
                this.__id1_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id1_.dir = "World 4";
            this.__id1_.ID = "Level0-b";
            this.__id1_.door = -1;
            try
            {
                this.__id1_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id1__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id1_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id1_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id1_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id1_]) <= 20)))
        {
            this.__setPropDict[this.__id1_] = curFrame;
            try
            {
                this.__id1_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id1_.dir = "World 4";
            this.__id1_.ID = "Tutor1";
            this.__id1_.door = -1;
            try
            {
                this.__id1_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id2__HUD_buttons_9() : Dynamic
    {
        if (this.__setPropDict[this.__id2_] == null || as3hx.Compat.parseInt(this.__setPropDict[this.__id2_]) != 10)
        {
            this.__setPropDict[this.__id2_] = 10;
            try
            {
                this.__id2_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id2_.dir = "World 4";
            this.__id2_.ID = "Level0-c";
            this.__id2_.door = -1;
            try
            {
                this.__id2_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id2__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id2_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id2_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id2_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id2_]) <= 20)))
        {
            this.__setPropDict[this.__id2_] = curFrame;
            try
            {
                this.__id2_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id2_.dir = "World 4";
            this.__id2_.ID = "Trans1";
            this.__id2_.door = -1;
            try
            {
                this.__id2_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id3__HUD_buttons_9() : Dynamic
    {
        if (this.__setPropDict[this.__id3_] == null || as3hx.Compat.parseInt(this.__setPropDict[this.__id3_]) != 10)
        {
            this.__setPropDict[this.__id3_] = 10;
            try
            {
                this.__id3_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id3_.dir = "World 4";
            this.__id3_.ID = "Level0-d";
            this.__id3_.door = -1;
            try
            {
                this.__id3_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id3__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id3_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id3_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id3_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id3_]) <= 20)))
        {
            this.__setPropDict[this.__id3_] = curFrame;
            try
            {
                this.__id3_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id3_.dir = "World 4";
            this.__id3_.ID = "Level1";
            this.__id3_.door = -1;
            try
            {
                this.__id3_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id4__HUD_buttons_9() : Dynamic
    {
        if (this.__setPropDict[this.__id4_] == null || as3hx.Compat.parseInt(this.__setPropDict[this.__id4_]) != 10)
        {
            this.__setPropDict[this.__id4_] = 10;
            try
            {
                this.__id4_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id4_.dir = "World 4";
            this.__id4_.ID = "Level0-e";
            this.__id4_.door = -1;
            try
            {
                this.__id4_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id4__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id4_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id4_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id4_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id4_]) <= 20)))
        {
            this.__setPropDict[this.__id4_] = curFrame;
            try
            {
                this.__id4_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id4_.dir = "World 4";
            this.__id4_.ID = "Arena5";
            this.__id4_.door = -1;
            try
            {
                this.__id4_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id5__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id5_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id5_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id5_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id5_]) <= 20)))
        {
            this.__setPropDict[this.__id5_] = curFrame;
            try
            {
                this.__id5_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id5_.dir = "World 4";
            this.__id5_.ID = "Tests1";
            this.__id5_.door = -1;
            try
            {
                this.__id5_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id6__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id6_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id6_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id6_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id6_]) <= 20)))
        {
            this.__setPropDict[this.__id6_] = curFrame;
            try
            {
                this.__id6_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id6_.dir = "World 4";
            this.__id6_.ID = "Tests4";
            this.__id6_.door = -1;
            try
            {
                this.__id6_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id7__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id7_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id7_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id7_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id7_]) <= 20)))
        {
            this.__setPropDict[this.__id7_] = curFrame;
            try
            {
                this.__id7_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id7_.dir = "World 4";
            this.__id7_.ID = "Tests2";
            this.__id7_.door = -1;
            try
            {
                this.__id7_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id8__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id8_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id8_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id8_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id8_]) <= 20)))
        {
            this.__setPropDict[this.__id8_] = curFrame;
            try
            {
                this.__id8_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id8_.dir = "World 4";
            this.__id8_.ID = "Tests3";
            this.__id8_.door = -1;
            try
            {
                this.__id8_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id9__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id9_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id9_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id9_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id9_]) <= 20)))
        {
            this.__setPropDict[this.__id9_] = curFrame;
            try
            {
                this.__id9_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id9_.dir = "World 4";
            this.__id9_.ID = "Arena0";
            this.__id9_.door = -1;
            try
            {
                this.__id9_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id10__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id10_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id10_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id10_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id10_]) <= 20)))
        {
            this.__setPropDict[this.__id10_] = curFrame;
            try
            {
                this.__id10_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id10_.dir = "World 4";
            this.__id10_.ID = "Level0-a";
            this.__id10_.door = -1;
            try
            {
                this.__id10_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id11__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id11_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id11_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id11_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id11_]) <= 20)))
        {
            this.__setPropDict[this.__id11_] = curFrame;
            try
            {
                this.__id11_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id11_.dir = "World 4";
            this.__id11_.ID = "Level0-a";
            this.__id11_.door = -1;
            try
            {
                this.__id11_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id12__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id12_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id12_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id12_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id12_]) <= 20)))
        {
            this.__setPropDict[this.__id12_] = curFrame;
            try
            {
                this.__id12_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id12_.dir = "World 4";
            this.__id12_.ID = "Tests5";
            this.__id12_.door = -1;
            try
            {
                this.__id12_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id13__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id13_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id13_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id13_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id13_]) <= 20)))
        {
            this.__setPropDict[this.__id13_] = curFrame;
            try
            {
                this.__id13_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id13_.dir = "World 4";
            this.__id13_.ID = "Level0-b";
            this.__id13_.door = -1;
            try
            {
                this.__id13_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id14__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id14_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id14_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id14_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id14_]) <= 20)))
        {
            this.__setPropDict[this.__id14_] = curFrame;
            try
            {
                this.__id14_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id14_.dir = "World 4";
            this.__id14_.ID = "Level0-c";
            this.__id14_.door = -1;
            try
            {
                this.__id14_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id15__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id15_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id15_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id15_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id15_]) <= 20)))
        {
            this.__setPropDict[this.__id15_] = curFrame;
            try
            {
                this.__id15_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id15_.dir = "World 4";
            this.__id15_.ID = "Level0-d";
            this.__id15_.door = -1;
            try
            {
                this.__id15_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id16__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id16_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id16_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id16_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id16_]) <= 20)))
        {
            this.__setPropDict[this.__id16_] = curFrame;
            try
            {
                this.__id16_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id16_.dir = "World 4";
            this.__id16_.ID = "Level0-e";
            this.__id16_.door = -1;
            try
            {
                this.__id16_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id17__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id17_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id17_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id17_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id17_]) <= 20)))
        {
            this.__setPropDict[this.__id17_] = curFrame;
            try
            {
                this.__id17_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id17_.dir = "World 4";
            this.__id17_.ID = "Level0-f";
            this.__id17_.door = -1;
            try
            {
                this.__id17_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id18__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id18_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id18_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id18_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id18_]) <= 20)))
        {
            this.__setPropDict[this.__id18_] = curFrame;
            try
            {
                this.__id18_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id18_.dir = "World 4";
            this.__id18_.ID = "Level0-g";
            this.__id18_.door = -1;
            try
            {
                this.__id18_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id19__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id19_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id19_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id19_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id19_]) <= 20)))
        {
            this.__setPropDict[this.__id19_] = curFrame;
            try
            {
                this.__id19_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id19_.dir = "World 4";
            this.__id19_.ID = "Level0-h";
            this.__id19_.door = -1;
            try
            {
                this.__id19_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id20__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id20_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id20_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id20_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id20_]) <= 20)))
        {
            this.__setPropDict[this.__id20_] = curFrame;
            try
            {
                this.__id20_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id20_.dir = "World 4";
            this.__id20_.ID = "Level0-i";
            this.__id20_.door = -1;
            try
            {
                this.__id20_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id21__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id21_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id21_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id21_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id21_]) <= 20)))
        {
            this.__setPropDict[this.__id21_] = curFrame;
            try
            {
                this.__id21_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id21_.dir = "World 4";
            this.__id21_.ID = "Level0-j";
            this.__id21_.door = -1;
            try
            {
                this.__id21_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id22__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id22_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id22_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id22_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id22_]) <= 20)))
        {
            this.__setPropDict[this.__id22_] = curFrame;
            try
            {
                this.__id22_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id22_.dir = "World 4";
            this.__id22_.ID = "Level1-a";
            this.__id22_.door = -1;
            try
            {
                this.__id22_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id23__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id23_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id23_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id23_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id23_]) <= 20)))
        {
            this.__setPropDict[this.__id23_] = curFrame;
            try
            {
                this.__id23_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id23_.dir = "World 4";
            this.__id23_.ID = "Level1-b";
            this.__id23_.door = -1;
            try
            {
                this.__id23_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id24__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id24_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id24_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id24_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id24_]) <= 20)))
        {
            this.__setPropDict[this.__id24_] = curFrame;
            try
            {
                this.__id24_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id24_.dir = "World 4";
            this.__id24_.ID = "Level1-c";
            this.__id24_.door = -1;
            try
            {
                this.__id24_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id25__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id25_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id25_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id25_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id25_]) <= 20)))
        {
            this.__setPropDict[this.__id25_] = curFrame;
            try
            {
                this.__id25_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id25_.dir = "World 4";
            this.__id25_.ID = "Level1-d";
            this.__id25_.door = -1;
            try
            {
                this.__id25_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id26__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id26_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id26_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id26_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id26_]) <= 20)))
        {
            this.__setPropDict[this.__id26_] = curFrame;
            try
            {
                this.__id26_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id26_.dir = "World 4";
            this.__id26_.ID = "Level1-e";
            this.__id26_.door = -1;
            try
            {
                this.__id26_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id27__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id27_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id27_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id27_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id27_]) <= 20)))
        {
            this.__setPropDict[this.__id27_] = curFrame;
            try
            {
                this.__id27_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id27_.dir = "World 4";
            this.__id27_.ID = "Level1-f";
            this.__id27_.door = -1;
            try
            {
                this.__id27_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id28__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id28_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id28_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id28_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id28_]) <= 20)))
        {
            this.__setPropDict[this.__id28_] = curFrame;
            try
            {
                this.__id28_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id28_.dir = "World 4";
            this.__id28_.ID = "Level1-g";
            this.__id28_.door = -1;
            try
            {
                this.__id28_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id29__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id29_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id29_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id29_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id29_]) <= 20)))
        {
            this.__setPropDict[this.__id29_] = curFrame;
            try
            {
                this.__id29_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id29_.dir = "World 4";
            this.__id29_.ID = "Level1-h";
            this.__id29_.door = -1;
            try
            {
                this.__id29_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id30__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id30_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id30_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id30_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id30_]) <= 20)))
        {
            this.__setPropDict[this.__id30_] = curFrame;
            try
            {
                this.__id30_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id30_.dir = "World 4";
            this.__id30_.ID = "Level1-i";
            this.__id30_.door = -1;
            try
            {
                this.__id30_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id31__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id31_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id31_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id31_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id31_]) <= 20)))
        {
            this.__setPropDict[this.__id31_] = curFrame;
            try
            {
                this.__id31_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id31_.dir = "World 4";
            this.__id31_.ID = "Level1-j";
            this.__id31_.door = -1;
            try
            {
                this.__id31_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id32__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id32_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id32_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id32_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id32_]) <= 20)))
        {
            this.__setPropDict[this.__id32_] = curFrame;
            try
            {
                this.__id32_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id32_.dir = "World 4";
            this.__id32_.ID = "Level1-k";
            this.__id32_.door = -1;
            try
            {
                this.__id32_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id33__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id33_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id33_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id33_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id33_]) <= 20)))
        {
            this.__setPropDict[this.__id33_] = curFrame;
            try
            {
                this.__id33_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id33_.dir = "World 4";
            this.__id33_.ID = "Villa0-a";
            this.__id33_.door = -1;
            try
            {
                this.__id33_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id34__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id34_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id34_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id34_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id34_]) <= 20)))
        {
            this.__setPropDict[this.__id34_] = curFrame;
            try
            {
                this.__id34_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id34_.dir = "World 4";
            this.__id34_.ID = "Villa0-b";
            this.__id34_.door = -1;
            try
            {
                this.__id34_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id35__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id35_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id35_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id35_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id35_]) <= 20)))
        {
            this.__setPropDict[this.__id35_] = curFrame;
            try
            {
                this.__id35_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id35_.dir = "World 4";
            this.__id35_.ID = "Villa0-c";
            this.__id35_.door = -1;
            try
            {
                this.__id35_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id36__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id36_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id36_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id36_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id36_]) <= 20)))
        {
            this.__setPropDict[this.__id36_] = curFrame;
            try
            {
                this.__id36_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id36_.dir = "World 4";
            this.__id36_.ID = "Villa0-d";
            this.__id36_.door = -1;
            try
            {
                this.__id36_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id37__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id37_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id37_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id37_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id37_]) <= 20)))
        {
            this.__setPropDict[this.__id37_] = curFrame;
            try
            {
                this.__id37_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id37_.dir = "World 4";
            this.__id37_.ID = "Villa0-e";
            this.__id37_.door = -1;
            try
            {
                this.__id37_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id38__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id38_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id38_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id38_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id38_]) <= 20)))
        {
            this.__setPropDict[this.__id38_] = curFrame;
            try
            {
                this.__id38_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id38_.dir = "World 4";
            this.__id38_.ID = "Villa0-f";
            this.__id38_.door = -1;
            try
            {
                this.__id38_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id39__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id39_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id39_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id39_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id39_]) <= 20)))
        {
            this.__setPropDict[this.__id39_] = curFrame;
            try
            {
                this.__id39_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id39_.dir = "World 4";
            this.__id39_.ID = "Level2-a";
            this.__id39_.door = -1;
            try
            {
                this.__id39_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id40__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id40_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id40_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id40_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id40_]) <= 20)))
        {
            this.__setPropDict[this.__id40_] = curFrame;
            try
            {
                this.__id40_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id40_.dir = "World 4";
            this.__id40_.ID = "Level2-b";
            this.__id40_.door = -1;
            try
            {
                this.__id40_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id41__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id41_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id41_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id41_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id41_]) <= 20)))
        {
            this.__setPropDict[this.__id41_] = curFrame;
            try
            {
                this.__id41_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id41_.dir = "World 4";
            this.__id41_.ID = "Level2-c";
            this.__id41_.door = -1;
            try
            {
                this.__id41_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id42__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id42_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id42_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id42_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id42_]) <= 20)))
        {
            this.__setPropDict[this.__id42_] = curFrame;
            try
            {
                this.__id42_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id42_.dir = "World 4";
            this.__id42_.ID = "Level2-d";
            this.__id42_.door = -1;
            try
            {
                this.__id42_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id43__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id43_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id43_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id43_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id43_]) <= 20)))
        {
            this.__setPropDict[this.__id43_] = curFrame;
            try
            {
                this.__id43_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id43_.dir = "World 4";
            this.__id43_.ID = "Level2-e";
            this.__id43_.door = -1;
            try
            {
                this.__id43_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id44__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id44_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id44_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id44_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id44_]) <= 20)))
        {
            this.__setPropDict[this.__id44_] = curFrame;
            try
            {
                this.__id44_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id44_.dir = "World 4";
            this.__id44_.ID = "Level2-f";
            this.__id44_.door = -1;
            try
            {
                this.__id44_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id45__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id45_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id45_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id45_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id45_]) <= 20)))
        {
            this.__setPropDict[this.__id45_] = curFrame;
            try
            {
                this.__id45_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id45_.dir = "World 4";
            this.__id45_.ID = "Level2-g";
            this.__id45_.door = -1;
            try
            {
                this.__id45_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id46__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id46_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id46_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id46_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id46_]) <= 20)))
        {
            this.__setPropDict[this.__id46_] = curFrame;
            try
            {
                this.__id46_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id46_.dir = "World 4";
            this.__id46_.ID = "Level2-h";
            this.__id46_.door = -1;
            try
            {
                this.__id46_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id47__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id47_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id47_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id47_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id47_]) <= 20)))
        {
            this.__setPropDict[this.__id47_] = curFrame;
            try
            {
                this.__id47_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id47_.dir = "World 4";
            this.__id47_.ID = "Level2-i";
            this.__id47_.door = -1;
            try
            {
                this.__id47_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id48__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id48_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id48_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id48_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id48_]) <= 20)))
        {
            this.__setPropDict[this.__id48_] = curFrame;
            try
            {
                this.__id48_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id48_.dir = "World 4";
            this.__id48_.ID = "Level2-j";
            this.__id48_.door = -1;
            try
            {
                this.__id48_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id49__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id49_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id49_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id49_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id49_]) <= 20)))
        {
            this.__setPropDict[this.__id49_] = curFrame;
            try
            {
                this.__id49_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id49_.dir = "World 4";
            this.__id49_.ID = "Tests0";
            this.__id49_.door = -1;
            try
            {
                this.__id49_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id50__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id50_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id50_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id50_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id50_]) <= 20)))
        {
            this.__setPropDict[this.__id50_] = curFrame;
            try
            {
                this.__id50_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id50_.dir = "World 4";
            this.__id50_.ID = "Tests4";
            this.__id50_.door = -1;
            try
            {
                this.__id50_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id51__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id51_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id51_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id51_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id51_]) <= 20)))
        {
            this.__setPropDict[this.__id51_] = curFrame;
            try
            {
                this.__id51_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id51_.dir = "World 4";
            this.__id51_.ID = "Level3-a";
            this.__id51_.door = 0;
            try
            {
                this.__id51_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id52__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id52_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id52_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id52_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id52_]) <= 20)))
        {
            this.__setPropDict[this.__id52_] = curFrame;
            try
            {
                this.__id52_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id52_.dir = "World 4";
            this.__id52_.ID = "Level3-b";
            this.__id52_.door = -1;
            try
            {
                this.__id52_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id53__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id53_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id53_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id53_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id53_]) <= 20)))
        {
            this.__setPropDict[this.__id53_] = curFrame;
            try
            {
                this.__id53_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id53_.dir = "World 4";
            this.__id53_.ID = "Level3-c";
            this.__id53_.door = -1;
            try
            {
                this.__id53_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id54__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id54_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id54_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id54_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id54_]) <= 20)))
        {
            this.__setPropDict[this.__id54_] = curFrame;
            try
            {
                this.__id54_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id54_.dir = "World 4";
            this.__id54_.ID = "Level3-d";
            this.__id54_.door = -1;
            try
            {
                this.__id54_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id55__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id55_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id55_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id55_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id55_]) <= 20)))
        {
            this.__setPropDict[this.__id55_] = curFrame;
            try
            {
                this.__id55_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id55_.dir = "World 4";
            this.__id55_.ID = "Level3-e";
            this.__id55_.door = -1;
            try
            {
                this.__id55_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id56__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id56_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id56_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id56_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id56_]) <= 20)))
        {
            this.__setPropDict[this.__id56_] = curFrame;
            try
            {
                this.__id56_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id56_.dir = "World 4";
            this.__id56_.ID = "Level3-f";
            this.__id56_.door = -1;
            try
            {
                this.__id56_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id57__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id57_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id57_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id57_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id57_]) <= 20)))
        {
            this.__setPropDict[this.__id57_] = curFrame;
            try
            {
                this.__id57_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id57_.dir = "World 4";
            this.__id57_.ID = "Level3-g";
            this.__id57_.door = -1;
            try
            {
                this.__id57_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id58__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id58_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id58_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id58_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id58_]) <= 20)))
        {
            this.__setPropDict[this.__id58_] = curFrame;
            try
            {
                this.__id58_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id58_.dir = "World 4";
            this.__id58_.ID = "Level3-h";
            this.__id58_.door = -1;
            try
            {
                this.__id58_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id59__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id59_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id59_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id59_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id59_]) <= 20)))
        {
            this.__setPropDict[this.__id59_] = curFrame;
            try
            {
                this.__id59_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id59_.dir = "World 4";
            this.__id59_.ID = "Level3-i";
            this.__id59_.door = -1;
            try
            {
                this.__id59_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id60__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id60_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id60_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id60_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id60_]) <= 20)))
        {
            this.__setPropDict[this.__id60_] = curFrame;
            try
            {
                this.__id60_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id60_.dir = "World 4";
            this.__id60_.ID = "Level3-j";
            this.__id60_.door = -1;
            try
            {
                this.__id60_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id61__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id61_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id61_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id61_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id61_]) <= 20)))
        {
            this.__setPropDict[this.__id61_] = curFrame;
            try
            {
                this.__id61_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id61_.dir = "World 4";
            this.__id61_.ID = "Level4-a";
            this.__id61_.door = -1;
            try
            {
                this.__id61_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id62__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id62_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id62_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id62_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id62_]) <= 20)))
        {
            this.__setPropDict[this.__id62_] = curFrame;
            try
            {
                this.__id62_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id62_.dir = "World 4";
            this.__id62_.ID = "Level4-b";
            this.__id62_.door = -1;
            try
            {
                this.__id62_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id63__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id63_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id63_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id63_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id63_]) <= 20)))
        {
            this.__setPropDict[this.__id63_] = curFrame;
            try
            {
                this.__id63_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id63_.dir = "World 4";
            this.__id63_.ID = "Level4-c";
            this.__id63_.door = -1;
            try
            {
                this.__id63_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id64__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id64_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id64_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id64_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id64_]) <= 20)))
        {
            this.__setPropDict[this.__id64_] = curFrame;
            try
            {
                this.__id64_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id64_.dir = "World 4";
            this.__id64_.ID = "Level4-d";
            this.__id64_.door = -1;
            try
            {
                this.__id64_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id65__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id65_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id65_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id65_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id65_]) <= 20)))
        {
            this.__setPropDict[this.__id65_] = curFrame;
            try
            {
                this.__id65_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id65_.dir = "World 4";
            this.__id65_.ID = "Level4-e";
            this.__id65_.door = -1;
            try
            {
                this.__id65_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id66__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id66_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id66_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id66_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id66_]) <= 20)))
        {
            this.__setPropDict[this.__id66_] = curFrame;
            try
            {
                this.__id66_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id66_.dir = "World 4";
            this.__id66_.ID = "Level4-f";
            this.__id66_.door = -1;
            try
            {
                this.__id66_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id67__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id67_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id67_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id67_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id67_]) <= 20)))
        {
            this.__setPropDict[this.__id67_] = curFrame;
            try
            {
                this.__id67_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id67_.dir = "World 4";
            this.__id67_.ID = "Level4-g";
            this.__id67_.door = -1;
            try
            {
                this.__id67_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id68__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id68_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id68_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id68_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id68_]) <= 20)))
        {
            this.__setPropDict[this.__id68_] = curFrame;
            try
            {
                this.__id68_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id68_.dir = "World 4";
            this.__id68_.ID = "Level4-h";
            this.__id68_.door = -1;
            try
            {
                this.__id68_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id69__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id69_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id69_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id69_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id69_]) <= 20)))
        {
            this.__setPropDict[this.__id69_] = curFrame;
            try
            {
                this.__id69_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id69_.dir = "World 4";
            this.__id69_.ID = "Level5-a";
            this.__id69_.door = -1;
            try
            {
                this.__id69_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id70__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id70_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id70_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id70_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id70_]) <= 20)))
        {
            this.__setPropDict[this.__id70_] = curFrame;
            try
            {
                this.__id70_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id70_.dir = "World 4";
            this.__id70_.ID = "Menus0-a";
            this.__id70_.door = 1;
            try
            {
                this.__id70_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id71__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id71_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id71_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id71_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id71_]) <= 20)))
        {
            this.__setPropDict[this.__id71_] = curFrame;
            try
            {
                this.__id71_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id71_.dir = "World 4";
            this.__id71_.ID = "reset";
            this.__id71_.door = 1;
            try
            {
                this.__id71_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id72__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id72_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id72_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id72_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id72_]) <= 20)))
        {
            this.__setPropDict[this.__id72_] = curFrame;
            try
            {
                this.__id72_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id72_.dir = "World 4";
            this.__id72_.ID = "language";
            this.__id72_.door = -1;
            try
            {
                this.__id72_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id73__HUD_buttons_10(curFrame : Int) : Dynamic
    {
        if (this.__id73_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id73_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id73_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id73_]) <= 20)))
        {
            this.__setPropDict[this.__id73_] = curFrame;
            try
            {
                this.__id73_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id73_.dir = "World 4";
            this.__id73_.ID = "Menus0-b";
            this.__id73_.door = -1;
            try
            {
                this.__id73_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp___id74__HUD_text_10(curFrame : Int) : Dynamic
    {
        if (this.__id74_ != null && curFrame >= 11 && curFrame <= 20 && (this.__setPropDict[this.__id74_] == null || !(as3hx.Compat.parseInt(this.__setPropDict[this.__id74_]) >= 11 && as3hx.Compat.parseInt(this.__setPropDict[this.__id74_]) <= 20)))
        {
            this.__setPropDict[this.__id74_] = curFrame;
            try
            {
                this.__id74_["componentInspectorSetting"] = true;
            }
            catch (e : Error)
            {
            }
            this.__id74_.dir = "World 4";
            this.__id74_.ID = "Tutor1";
            this.__id74_.door = -1;
            try
            {
                this.__id74_["componentInspectorSetting"] = false;
            }
            catch (e : Error)
            {
            }
        }
    }
    
    @:allow()
    private function __setProp_handler(e : Dynamic) : Dynamic
    {
        var curFrame : Int = currentFrame;
        if (this.__lastFrameProp == curFrame)
        {
            return;
        }
        this.__lastFrameProp = curFrame;
        this.__setProp___id0__HUD_buttons_10(curFrame);
        this.__setProp___id1__HUD_buttons_10(curFrame);
        this.__setProp___id2__HUD_buttons_10(curFrame);
        this.__setProp___id3__HUD_buttons_10(curFrame);
        this.__setProp___id4__HUD_buttons_10(curFrame);
        this.__setProp___id5__HUD_buttons_10(curFrame);
        this.__setProp___id6__HUD_buttons_10(curFrame);
        this.__setProp___id7__HUD_buttons_10(curFrame);
        this.__setProp___id8__HUD_buttons_10(curFrame);
        this.__setProp___id9__HUD_buttons_10(curFrame);
        this.__setProp___id10__HUD_buttons_10(curFrame);
        this.__setProp___id11__HUD_buttons_10(curFrame);
        this.__setProp___id12__HUD_buttons_10(curFrame);
        this.__setProp___id13__HUD_buttons_10(curFrame);
        this.__setProp___id14__HUD_buttons_10(curFrame);
        this.__setProp___id15__HUD_buttons_10(curFrame);
        this.__setProp___id16__HUD_buttons_10(curFrame);
        this.__setProp___id17__HUD_buttons_10(curFrame);
        this.__setProp___id18__HUD_buttons_10(curFrame);
        this.__setProp___id19__HUD_buttons_10(curFrame);
        this.__setProp___id20__HUD_buttons_10(curFrame);
        this.__setProp___id21__HUD_buttons_10(curFrame);
        this.__setProp___id22__HUD_buttons_10(curFrame);
        this.__setProp___id23__HUD_buttons_10(curFrame);
        this.__setProp___id24__HUD_buttons_10(curFrame);
        this.__setProp___id25__HUD_buttons_10(curFrame);
        this.__setProp___id26__HUD_buttons_10(curFrame);
        this.__setProp___id27__HUD_buttons_10(curFrame);
        this.__setProp___id28__HUD_buttons_10(curFrame);
        this.__setProp___id29__HUD_buttons_10(curFrame);
        this.__setProp___id30__HUD_buttons_10(curFrame);
        this.__setProp___id31__HUD_buttons_10(curFrame);
        this.__setProp___id32__HUD_buttons_10(curFrame);
        this.__setProp___id33__HUD_buttons_10(curFrame);
        this.__setProp___id34__HUD_buttons_10(curFrame);
        this.__setProp___id35__HUD_buttons_10(curFrame);
        this.__setProp___id36__HUD_buttons_10(curFrame);
        this.__setProp___id37__HUD_buttons_10(curFrame);
        this.__setProp___id38__HUD_buttons_10(curFrame);
        this.__setProp___id39__HUD_buttons_10(curFrame);
        this.__setProp___id40__HUD_buttons_10(curFrame);
        this.__setProp___id41__HUD_buttons_10(curFrame);
        this.__setProp___id42__HUD_buttons_10(curFrame);
        this.__setProp___id43__HUD_buttons_10(curFrame);
        this.__setProp___id44__HUD_buttons_10(curFrame);
        this.__setProp___id45__HUD_buttons_10(curFrame);
        this.__setProp___id46__HUD_buttons_10(curFrame);
        this.__setProp___id47__HUD_buttons_10(curFrame);
        this.__setProp___id48__HUD_buttons_10(curFrame);
        this.__setProp___id49__HUD_buttons_10(curFrame);
        this.__setProp___id50__HUD_buttons_10(curFrame);
        this.__setProp___id51__HUD_buttons_10(curFrame);
        this.__setProp___id52__HUD_buttons_10(curFrame);
        this.__setProp___id53__HUD_buttons_10(curFrame);
        this.__setProp___id54__HUD_buttons_10(curFrame);
        this.__setProp___id55__HUD_buttons_10(curFrame);
        this.__setProp___id56__HUD_buttons_10(curFrame);
        this.__setProp___id57__HUD_buttons_10(curFrame);
        this.__setProp___id58__HUD_buttons_10(curFrame);
        this.__setProp___id59__HUD_buttons_10(curFrame);
        this.__setProp___id60__HUD_buttons_10(curFrame);
        this.__setProp___id61__HUD_buttons_10(curFrame);
        this.__setProp___id62__HUD_buttons_10(curFrame);
        this.__setProp___id63__HUD_buttons_10(curFrame);
        this.__setProp___id64__HUD_buttons_10(curFrame);
        this.__setProp___id65__HUD_buttons_10(curFrame);
        this.__setProp___id66__HUD_buttons_10(curFrame);
        this.__setProp___id67__HUD_buttons_10(curFrame);
        this.__setProp___id68__HUD_buttons_10(curFrame);
        this.__setProp___id69__HUD_buttons_10(curFrame);
        this.__setProp___id70__HUD_buttons_10(curFrame);
        this.__setProp___id71__HUD_buttons_10(curFrame);
        this.__setProp___id72__HUD_buttons_10(curFrame);
        this.__setProp___id73__HUD_buttons_10(curFrame);
        this.__setProp___id74__HUD_text_10(curFrame);
    }
    
    @:allow()
    private function frame10() : Dynamic
    {
        this.__setProp___id4__HUD_buttons_9();
        this.__setProp___id3__HUD_buttons_9();
        this.__setProp___id2__HUD_buttons_9();
        this.__setProp___id1__HUD_buttons_9();
        this.__setProp___id0__HUD_buttons_9();
    }
}


