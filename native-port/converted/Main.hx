import flash.errors.Error;
import com.illumifi.*;
import com.miniclip.*;
import com.miniclip.events.*;
import com.newgrounds.*;
import com.newgrounds.components.*;
import flash.desktop.*;
import flash.display.*;
import flash.events.*;
import flash.external.*;
import flash.filters.*;
import flash.geom.*;
import flash.media.*;
import flash.net.*;
import flash.system.*;
import flash.ui.*;
import flash.utils.*;
import scaleform.gfx.*;
import starling.textures.Texture;

class Main extends Sprite
{
    
    public static var gameInputClass : GameInput;
    
    public static var gamepadRef : GameInputDevice;
    
    public static var changeEventPress : Bool;
    
    public static var changeCached : Bool;
    
    private static var dontCheat : Array<Dynamic>;
    
    public static var kongregate : Dynamic;
    
    @:allow()
    private static var deviceID : String;
    
    @:allow()
    private static var groundN : Int;
    
    @:allow()
    private static var loadedFromURL : Bool;
    
    @:allow()
    private static var b : Int;
    
    public static var showDoorIcon : Bool;
    
    private static var daParameters : Dynamic;
    
    public static var onSite : String;
    
    public static var cleanForBrand : Bool;
    
    public static var mouseIsDown : Bool;
    
    public static var dragDir : Float;
    
    public static var quickResetLevel : Bool;
    
    public static var quickResetObjects : Bool;
    
    private static var preservePlayers : Bool;
    
    private static var justBitmaps : Bool;
    
    public static var refreshLevelNow : Bool;
    
    private static var i : Int;
    
    private static var n : Int;
    
    public static var uberSpacing : Int;
    
    public static var uberRes : Float;
    
    public static var backRes : Float;
    
    public static var foreRes : Float;
    
    private static var waitToCacheN : Int;
    
    public static var FadeClip : Dynamic;
    
    public static var MapClip : MapScreen;
    
    public static var myLoadHUD : Dynamic;
    
    public static var stageRoot : Main;
    
    public static var Overlord : Dynamic;
    
    public static var CoinN : Int;
    
    public static var inkSplatEffect : MovieClip;
    
    private static var interactPlacers : MovieClip;
    
    private static var baddiePlacers : MovieClip;
    
    public static var member : String;
    
    public static var memberDisplay : String;
    
    public static var statsObjectID : String;
    
    public static var scoresObjectID : String;
    
    public static var settingsObjectID : String;
    
    public static var extrasObjectID : String;
    
    private static var analyticsObjectId : String;
    
    private static var keysObjectId : String;
    
    public static var bugger : Dynamic;
    
    public static var myPauseMenu : PauseMenu;
    
    public static var myTutorialPopup : TutorialPopup;
    
    public static var isScaleForm : Bool;
    
    public static var isTouchScreen : Bool;
    
    public static var isStarling : Bool;
    
    private static var userHasKey : Bool;
    
    public static var shared : SharedObject;
    
    public static var kiziLogo : Dynamic;
    
    private static var isOnline : Bool;
    
    private static var saveFile : SaveFile;
    
    private static var ng_medalPopup : MedalPopup;
    
    private static var netMaster : Bool;
    
    public static var clickTimer : Float;
    
    public static var ground : MovieClip;
    
    public static var walls : MovieClip;
    
    public static var platforms : MovieClip;
    
    public static var levelContainer : MovieClip;
    
    public static var AllEverything : MovieClip;
    
    public static var levelClasses : Dynamic;
    
    public static var staticBackground : Sprite;
    
    public static var volcanoBackground : Sprite;
    
    public static var boxBackground : Sprite;
    
    public static var cardboardBack : Sprite;
    
    public static var cameraShift : Bool;
    
    public static var cameraShiftZ : Float;
    
    public static var charScrollX : Float;
    
    public static var charScrollY : Float;
    
    public static var charScrollZ : Float;
    
    public static var lockShift : Bool;
    
    public static var lockShiftZ : Float;
    
    private static var wasCameraX : Int;
    
    private static var wasCameraY : Int;
    
    private static var scrollOtherObject : Collision;
    
    public static var lockShiftMaxZ : Float;
    
    public static var maxScale : Float;
    
    public static var vOffset : Int;
    
    public static var stageX : Float;
    
    public static var stageY : Float;
    
    public static var originalStageX : Int;
    
    public static var originalStageY : Int;
    
    public static var realStageX : Int;
    
    public static var realStageY : Int;
    
    public static var relativeStageX : Int;
    
    public static var relativeStageY : Int;
    
    public static var interactContainer : MovieClip;
    
    public static var UberForeground : MovieClip;
    
    public static var hasUberForeground : Bool;
    
    @:allow()
    private static var test1 : MovieClip;
    
    @:allow()
    private static var test2 : MovieClip;
    
    @:allow()
    private static var AllLevelObjects : Array<Dynamic>;
    
    @:allow()
    private static var AllBoxObjects : Array<Dynamic>;
    
    public static var gamepadObject : Dynamic = { };
    
    public static var framin : Float = 1;
    
    public static var allTheFrames : Float = 0;
    
    @:allow()
    private static var debug : Bool = true;
    
    public static var bitRes : Float = 1;
    
    public static var objRes : Float = 0.7;
    
    @:allow()
    private static var debugKey : Bool = false;
    
    @:allow()
    private static var canPopOut : Bool = false;
    
    @:allow()
    private static var external : Bool = true;
    
    @:allow()
    private static var debugN : Int = 0;
    
    @:allow()
    private static var LoadIt : String = "Menus0-a";
    
    @:allow()
    private static var DoorIt : Int = 1;
    
    @:allow()
    private static var DirIt : String = "World 4";
    
    @:allow()
    private static var gameMode : String = "level";
    
    @:allow()
    private static var LevelLoaded : String = "nothing";
    
    @:allow()
    private static var DoorLoaded : Int = -1;
    
    @:allow()
    private static var LastFullLevel : String = "nothing";
    
    @:allow()
    private static var numPlayers : Int = 1;
    
    public static var crossLevelStatus : String = "nothing";
    
    public static var LevelStatus : String = "nothing";
    
    public static var StatusName : String = "nothing";
    
    public static var transLevelOffsetX : Float = 0;
    
    public static var transLevelOffsetY : Float = 0;
    
    public static var whereAt : String = "";
    
    public static var backgroundsN : Int = 0;
    
    public static var backgroundZs : Array<Dynamic> = [];
    
    public static var AllBitmaps : Array<Dynamic> = [];
    
    public static var AllLoaders : Array<Dynamic> = [];
    
    private static var cacheBackgroundN : Int = -1;
    
    public static var boxception : Array<Dynamic> = [];
    
    public static var tempFollow : Array<Dynamic> = [];
    
    public static var tempFollowB : Array<Dynamic> = [];
    
    public static var tempFollowR : Array<Dynamic> = [];
    
    public static var groundsArray : Array<Dynamic> = [];
    
    public static var platformsArray : Array<Dynamic> = [];
    
    public static var wallsArray : Array<Dynamic> = [];
    
    public static var availableBaddies : Array<Dynamic> = [];
    
    public static var availableInteracts : Array<Dynamic> = [];
    
    public static var localScores : Dynamic = {};
    
    public static var localSettings : Dynamic = {};
    
    public static var tempSettings : Dynamic = {};
    
    public static var localScoreTables : Dynamic = {};
    
    private static var comboHS : Array<Dynamic> = new Array<Dynamic>();
    
    public static var baddiesSession : Int = 0;
    
    public static var squigglesSession : Int = 0;
    
    public static var rockonsSession : Int = 0;
    
    public static var levelStates : Dynamic = {
            bowlingBalled : false,
            secondBox : false
        };
    
    public static var pauseStatus : String = "nothing";
    
    public static var keyToBuy : String = "nothing";
    
    private static var keyMessage : String = ["key", "buykey"][Math.floor(Math.random() * 2)];
    
    public static var overRatio : Float = 1;
    
    public static var bitmapTotal : Int = 0;
    
    public static var world4Progress : Dynamic = { };
    
    public static var PantsPallet : Dynamic = [[100, 60, 0], [0, 75, 0], [100, 20, 20], [0, 30, 100], [50, 30, 100], [100, 100, 0], [0, 80, 80], [60, 100, 0], [100, 0, 100], [65, 35, 0], [100, 100, 100], [15, 15, 15], [10, 10, 20]];
    
    public static var ChallengeList : Dynamic = ["Bonus0-b", "Bonus0-c", "Bonus0-e", "Bonus0-f", "Bonus0-g", "Bonus0-i", "Bonus0-j", "Bonus1-a", "Bonus1-b", "Bonus1-c", "Bonus1-d", "Bonus1-e", "Bonus1-f", "Bonus1-g", "Bonus1-i", "Bonus1-j", "Bonus2-a", "Bonus2-b", "Bonus2-c", "Bonus2-d", "Bonus2-e", "Bonus2-f", "Bonus2-g", "Bonus2-h", "Bonus2-i", "Bonus3-b", "Bonus3-c", "Bonus3-d", "Bonus3-e", "Bonus3-f", "Bonus3-g", "Bonus3-h", "Bonus4-a", "Bonus4-b", "Bonus4-c", "Bonus4-d", "Bonus4-e", "Bonus4-f", "Bonus4-g", "Bonus5-a"];
    
    public static var RewardList : Dynamic = ["Hat-1", "Pants-1", "Hat-2", "Pants-2", "Pattern-1", "Pattern-2", "Hat-3", "Hat-4", "Pants-3", "Pants-4", "Pattern-3", "Hat-5", "Pants-5", "Pattern-4", "Hat-6", "Pants-6", "Pants-7", "Hat-7", "Hat-8", "Pattern-5", "Pattern-6", "Hat-9", "Pattern-7", "Hat-10", "Pattern-8", "Pattern-9", "Pattern-10", "Hat-11", "Pattern-11", "Pattern-12", "Hat-12", "Pattern-13", "Pants-8", "Pattern-14", "Hat-13", "Pattern-15", "Pattern-16", "Hat-14", "Pattern-17", "nothing"];
    
    public static var Level0Rewards : Dynamic = ["Bonus0-b", "Bonus0-c", "Bonus0-e", "Bonus0-f", "Bonus0-g", "Bonus0-i", "Bonus0-j"];
    
    public static var Level1Rewards : Dynamic = ["Bonus1-a", "Bonus1-b", "Bonus1-c", "Bonus1-d", "Bonus1-e", "Bonus1-f", "Bonus1-g", "Bonus1-i", "Bonus1-j"];
    
    public static var Villa0Rewards : Dynamic = [];
    
    public static var Level2Rewards : Dynamic = ["Bonus2-a", "Bonus2-b", "Bonus2-c", "Bonus2-d", "Bonus2-e", "Bonus2-f", "Bonus2-g", "Bonus2-h", "Bonus2-i"];
    
    public static var Level3Rewards : Dynamic = ["Bonus3-b", "Bonus3-c", "Bonus3-d", "Bonus3-e", "Bonus3-f", "Bonus3-g", "Bonus3-h"];
    
    public static var Level4Rewards : Dynamic = ["Bonus4-a", "Bonus4-b", "Bonus4-c", "Bonus4-d", "Bonus4-e", "Bonus4-f", "Bonus4-g"];
    
    public static var Level5Rewards : Dynamic = [];
    
    private static var firstChallenge : Bool = false;
    
    public static var cameraX : Float = 0;
    
    public static var cameraY : Float = 0;
    
    private static var cameraTemp : Float = 0;
    
    private static var cameraStage : Int = 0;
    
    private static var tempCameraX : Float = 0;
    
    private static var tempCameraY : Float = 0;
    
    private static var tempCameraZ : Float = 0;
    
    public static var cameraShiftX : Int = -10000;
    
    public static var cameraShiftY : Int = -10000;
    
    public static var toCameraShiftRatio : Float = 1;
    
    public static var cameraShiftRatio : Float = 1;
    
    public static var boundsShiftDistX : Int = 0;
    
    public static var boundsShiftDistY : Int = 0;
    
    public static var boundsShiftX : Int = 0;
    
    public static var boundsShiftY : Int = 0;
    
    public static var boundsShiftZ : Int = 0;
    
    public static var lockShiftX : Int = -20000;
    
    public static var lockShiftY : Int = -20000;
    
    public static var lockShiftRatio : Float = 0;
    
    public static var rootX : Float = 0;
    
    public static var rootY : Float = 0;
    
    public static var rootZ : Float = 0;
    
    public static var rootRatios : Array<Dynamic> = [];
    
    public static var stageRatios : Array<Dynamic> = [];
    
    public static var MinX : Float = 0;
    
    public static var MaxX : Float = 0;
    
    public static var MinY : Float = 0;
    
    public static var MaxY : Float = 0;
    
    public static var lockShiftMinX : Float = 0;
    
    public static var lockShiftMaxX : Float = 0;
    
    public static var lockShiftMinY : Float = 0;
    
    public static var lockShiftMaxY : Float = 0;
    
    public static var originalMinX : Int = 0;
    
    public static var originalMaxX : Int = 0;
    
    public static var originalMinY : Int = 0;
    
    public static var originalMaxY : Int = 0;
    
    public static var preferScrollX : Int = 0;
    
    public static var preferScrollY : Int = 0;
    
    public static var cameraZ : Float = 0;
    
    public static var cameraFocalLength : Int = 100;
    
    public static var levelScale : Float = 1;
    
    public static var zOffset : Int = 0;
    
    public static var allCameraZs : Array<Dynamic> = [];
    
    public static var stageXs : Array<Dynamic> = new Array<Dynamic>();
    
    public static var stageYs : Array<Dynamic> = new Array<Dynamic>();
    
    public static var fauxContainer : MovieClip = new MovieClip();
    
    public static var cameraX1 : Float = 100000;
    
    public static var cameraY1 : Float = 100000;
    
    public static var cameraX2 : Float = -100000;
    
    public static var cameraY2 : Float = -100000;
    
    public static var worldPrefix : String = "_W1R";
    
    public var gamepadArray : Array<Dynamic>;
    
    private var simpleFrames : Int = 0;
    
    private var waitASec : Int;
    
    private var testNum : Float = 0;
    
    private var SpaceIsDown : Bool;
    
    private var useNodes : Bool;
    
    private var useGamepads : Bool;
    
    private var scrollEngine : Dynamic;
    
    private var levelTimer : Dynamic;
    
    public var frameCounter : Float;
    
    private var ChallengeRules : Dynamic;
    
    private var adStatus : String = "nothing";
    
    private var splashLogo : MovieClip;
    
    private var BGConnect : LocalConnection;
    
    private var myNetwork : Network;
    
    private var oTimer : Int = 0;
    
    private var oMouseX : Float;
    
    public var tick : Bool = true;
    
    private var ticktockslow : Int;
    
    private var slowMo : Bool;
    
    private var superOffset : Int = 0;
    
    public var fadingMusic : Bool;
    
    private var hideMouseN : Int = 0;
    
    private var masterSplit : Int;
    
    private var moveTouchID : Int;
    
    private var buttonsTouchID : Int;
    
    private var moveSplit : Int;
    
    private var buttonSplit : Int;
    
    public var onlyMove : Bool;
    
    private var volcanoDist : Float = 1;
    
    private var volcanoY : Float;
    
    private var blurOffset : Float;
    
    private var blurStrength : Float;
    
    private var isFullscreen : Bool;
    
    public var simpleBackgrounds : Bool = false;
    
    private var toForeground : Bool = false;
    
    public var houseFront : ScrollingObject;
    
    public var houseFrontDoor : ScrollingObject;
    
    private var alphaSort : String = "abcdefghijklmn";
    
    private var startDelay : Timer;
    
    public var bitmapData : BitmapData;
    
    public var foregroundBitmap : Bitmap;
    
    public var backgroundBitmap : Bitmap;
    
    private var cameraRumble : Bool;
    
    private var rumbleSound : Bool;
    
    private var rumbleChannel : SoundChannel;
    
    private var rumbleFade : Float = 0;
    
    private var shakeRL : Float = 0;
    
    private var shakeUD : Float = 0;
    
    private var shakeX : Float = 0;
    
    private var shakeY : Float = 0;
    
    public var tempX : Float = 0;
    
    public var tempY : Float = 0;
    
    public var tempDist : Float = 0;
    
    private var levelLoader : Loader;
    
    private var bitmapLoader : Loader;
    
    public var isWiimote : Bool;
    
    private var mainToWorker : MessageChannel;
    
    private var workerToMain : MessageChannel;
    
    private var controllerWorker : Worker;
    
    private var workerControls : Bool;
    
    public var workerGamepadID : Array<String>;
    
    public var workerGamepadName : Array<String>;
    
    public var workerGamepadBinded : Array<Bool>;
    
    public function new()
    {
        var prop : String = null;
        var workerLoader : URLLoader = null;
        this.gamepadArray = [];
        this.scrollEngine = function() : Dynamic
                {
                };
        this.ChallengeRules = function() : Dynamic
                {
                };
        this.BGConnect = new LocalConnection();
        this.workerGamepadID = new Array<String>();
        this.workerGamepadName = new Array<String>();
        this.workerGamepadBinded = new Array<Bool>();
        super();
        shared = SharedObject.getLocal("SFPA");
        if (Capabilities.os.indexOf("iPad") > -1)
        {
            deviceID = "iPad";
        }
        else if (Capabilities.os.indexOf("iPhone") > -1)
        {
            deviceID = "iPhone";
        }
        else if (Capabilities.os.indexOf("tvOS") > -1)
        {
            deviceID = "AppleTV";
        }
        else if (Capabilities.os.indexOf("Linux") > -1)
        {
            deviceID = "Android";
        }
        else
        {
            deviceID = "PC";
        }
        stageRoot = this;
        Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
        isScaleForm = "Starling" == "Scaleform";
        Char.isTouchScreen = rootHUD.isTouchScreen = isTouchScreen = deviceID != "PC" && deviceID != "AppleTV";
        if (shared.data.controllers == null)
        {
            shared.data.controllers = { };
        }
        if (deviceID != "PC")
        {
            gameInputClass = new GameInput();
            gameInputClass.addEventListener(GameInputEvent.DEVICE_ADDED, this.controllerAdded);
            gameInputClass.addEventListener(GameInputEvent.DEVICE_REMOVED, this.controllerRemoved);
            for (prop in Reflect.fields(gamepadObject))
            {
                this.checkGamepadConfig(Reflect.field(gamepadObject, prop).reference);
            }
        }
        else
        {
            workerLoader = new URLLoader();
            workerLoader.dataFormat = URLLoaderDataFormat.BINARY;
            workerLoader.addEventListener(Event.COMPLETE, this.WorkerLoadComplete);
            workerLoader.load(new URLRequest("gamepad.swf"));
        }
        addEventListener(Event.ADDED_TO_STAGE, this.StartMainOrMiniClip);
    }
    
    public static function parse_CheckScoresLoad(func : Dynamic) : Dynamic
    {
        Parse.Get("Scores" + worldPrefix, null, {
                    gamerId : member
                }, function(resp : Dynamic) : Dynamic
                {
                    rootHUD.HUD.debug.text += "n get scores";
                    if (Reflect.field(Reflect.field(resp, "results"), Std.string(0)) == null)
                    {
                        rootHUD.HUD.debug.text += "undefined scores";
                        trace("don\'t add scores");
                    }
                    else
                    {
                        scoresObjectID = Reflect.field(Reflect.field(resp, "results"), Std.string(0)).objectId;
                        localScores = resp.results[0];
                        trace(haxe.Json.stringify(localScores));
                        rootHUD.HUD.debug.text += "done";
                        rootHUD.HUD.debug.text += haxe.Json.stringify(localScores);
                        trace("loaded all scores");
                    }
                    func();
                }, function(err : Dynamic) : Dynamic
                {
                    trace(err);
                    rootHUD.HUD.debug.text = err;
                    parse_CheckScoresLoad(func);
                });
    }
    
    public static function parse_CheckSettingsLoad(func : Dynamic) : Dynamic
    {
        rootHUD.HUD.debug.text += "\n " + member;
        trace("try settings for " + member);
        Parse.Get("Settings", null, {
                    gamerId : member
                }, function(resp : Dynamic) : Dynamic
                {
                    trace("got settings");
                    rootHUD.HUD.debug.text += "\n get settings";
                    if (Reflect.field(Reflect.field(resp, "results"), Std.string(0)) == null)
                    {
                        rootHUD.HUD.debug.text += "\n undefined settings";
                        trace("created new settings");
                        parse_AddSettingsEntry(func);
                    }
                    else
                    {
                        settingsObjectID = Reflect.field(Reflect.field(resp, "results"), Std.string(0)).objectId;
                        rootHUD.HUD.debug.text += "\n " + settingsObjectID;
                        localSettings = resp.results[0];
                        fillUndefined();
                        Sounds.setVolume(localSettings.sfxVol);
                        Sounds.musicVol = localSettings.musicVol;
                        Sounds.updateMusic(1);
                        trace(haxe.Json.stringify(localSettings));
                        rootHUD.HUD.debug.text += "done";
                        rootHUD.HUD.debug.text += haxe.Json.stringify(localSettings);
                        trace("loaded all settings");
                        func();
                    }
                }, function(err : Dynamic) : Dynamic
                {
                    trace(err);
                    rootHUD.HUD.debug.text = err;
                    parse_CheckSettingsLoad(func);
                });
    }
    
    public static function parse_CheckKeys(output : Dynamic, func : Dynamic) : Dynamic
    {
        Parse.Get("Keys", null, {
                    gamerId : member
                }, function(resp : Dynamic) : Dynamic
                {
                    var keys : Dynamic = null;
                    trace("got keys");
                    if (Reflect.field(Reflect.field(resp, "results"), Std.string(0)) == null)
                    {
                        rootHUD.HUD.debug.text += "\n no key";
                        rootHUD.HUD.keySwitch.gotoAndStop(keyMessage);
                    }
                    else
                    {
                        trace("loaded keys");
                        keys = resp.results[0];
                        rootHUD.HUD.debug.text += "\n" + keys;
                        if (keys.extrafancykey_W1R > 0)
                        {
                            getThatKey("extrafancykey");
                        }
                        else if (keys.goldkey_W1R > 0)
                        {
                            getThatKey("goldkey");
                        }
                        else if (keys.silverkey_W1R > 0)
                        {
                            getThatKey("silverkey");
                        }
                        else if (keys.fancykey_W1R > 0)
                        {
                            getThatKey("fancykey");
                        }
                        else
                        {
                            if (keys.key_W1R <= 0)
                            {
                                rootHUD.HUD.keySwitch.gotoAndStop(keyMessage);
                                rootHUD.HUD.debug.text += "\n no key?";
                                return false;
                            }
                            getThatKey("key");
                        }
                        if (output != null)
                        {
                            rootHUD.spawnPopup("You have a key, thank you!");
                        }
                    }
                    func();
                }, function(err : Dynamic) : Dynamic
                {
                    trace(err);
                    rootHUD.HUD.debug.text = err;
                });
    }
    
    public static function parse_CheckStatsLoad(func : Dynamic) : Dynamic
    {
        trace("get Stats");
        Parse.Get("Stats", {
                    count : 1
                }, {
                    gamerId : member
                }, function(resp : Dynamic) : Dynamic
                {
                    trace("stats");
                    if (Reflect.field(Reflect.field(resp, "results"), Std.string(0)) == null)
                    {
                        trace("create stats entry");
                        rootHUD.HUD.debug.text += "\n New entry for " + memberDisplay + ".";
                        parse_AddStatsEntry(func);
                    }
                    else
                    {
                        trace("loaded all stats");
                        trace(haxe.Json.stringify(Reflect.field(Reflect.field(resp, "results"), Std.string(0))));
                        if (member == "Local")
                        {
                            rootHUD.HUD.debug.text += "local?";
                        }
                        else if (member == "not_logged_in_BG")
                        {
                            rootHUD.HUD.debug.text = "Register or log in to BorneGames.com to track your scores!";
                        }
                        statsObjectID = Reflect.field(Reflect.field(resp, "results"), Std.string(0)).objectId;
                        func();
                    }
                }, function(err : Dynamic) : Dynamic
                {
                    trace("er");
                    rootHUD.HUD.debug.text = err;
                });
    }
    
    public static function parse_AddScoresEntry(func : Dynamic) : Dynamic
    {
        var paramz : Dynamic = {};
        paramz.gamerId = member;
        paramz.maxCombo = 0;
        Parse.Post("Scores" + worldPrefix, paramz, function(resp : Dynamic) : Dynamic
                {
                    trace("scores entry added");
                    rootHUD.HUD.debug.text += "\n new entry!";
                    scoresObjectID = resp.objectId;
                    func();
                }, function(err : Dynamic) : Dynamic
                {
                    parse_AddScoresEntry(func);
                    trace("add score entry error");
                });
    }
    
    public static function parse_AddSettingsEntry(func : Dynamic) : Dynamic
    {
        fillUndefined();
        Parse.Post("Settings", localSettings, function(resp : Dynamic) : Dynamic
                {
                    trace("settings entry added");
                    rootHUD.HUD.debug.text += "\n new entry!";
                    settingsObjectID = resp.objectId;
                    func();
                }, function(err : Dynamic) : Dynamic
                {
                    parse_AddSettingsEntry(func);
                    trace("add settings entry error");
                });
    }
    
    public static function parse_ExtrasDownload(extra : Dynamic) : Dynamic
    {
        if (extrasObjectID == null)
        {
            parse_CheckExtras(extra);
        }
        else
        {
            parse_UpdateExtrasEntry(extra);
        }
    }
    
    public static function parse_CheckExtras(extra : Dynamic) : Dynamic
    {
        Parse.Get("Extras", {
                    count : 1
                }, {
                    gamerId : member
                }, function(resp : Dynamic) : Dynamic
                {
                    if (Reflect.field(Reflect.field(resp, "results"), Std.string(0)) == null)
                    {
                        trace("create Extras entry");
                        parse_AddExtrasEntry(extra);
                    }
                    else
                    {
                        extrasObjectID = Reflect.field(Reflect.field(resp, "results"), Std.string(0)).objectId;
                        parse_UpdateExtrasEntry(extra);
                    }
                }, function(err : Dynamic) : Dynamic
                {
                    trace("er");
                    rootHUD.HUD.debug.text = err;
                });
    }
    
    public static function parse_AddExtrasEntry(extra : Dynamic) : Dynamic
    {
        var paramz : Dynamic = {};
        paramz.gamerId = member;
        Reflect.setField(paramz, Std.string("canDownload" + extra), extra);
        Reflect.setField(paramz, Std.string("downloads" + extra), extra);
        Parse.Post("Extras", paramz, function(resp : Dynamic) : Dynamic
                {
                    trace("Extras entry added");
                    extrasObjectID = resp.objectId;
                    launchURL("http://www.bornegames.com/files/soundtrack.php?user=" + member);
                }, function(err : Dynamic) : Dynamic
                {
                    trace("add settings entry error");
                });
    }
    
    public static function parse_UpdateExtrasEntry(extra : Dynamic) : Dynamic
    {
        var paramz : Dynamic = {};
        paramz.gamerId = member;
        Reflect.setField(paramz, Std.string("canDownload" + extra), extra);
        Reflect.setField(paramz, Std.string("downloads" + extra), extra);
        Parse.Put("Extras", extrasObjectID, paramz, function(resp : Dynamic) : Dynamic
                {
                    rootHUD.HUD.debug.text = "Extras updated!";
                    launchURL("http://www.bornegames.com/files/soundtrack.php?user=" + member);
                }, function(err : Dynamic) : Dynamic
                {
                    rootHUD.HUD.debug.text = "settings error";
                });
    }
    
    private static function parse_saveKey(key : Dynamic, message : Dynamic) : Dynamic
    {
        Parse.Get("Keys", {
                    count : 1
                }, {
                    gamerId : member
                }, function(resp : Dynamic) : Dynamic
                {
                    if (Reflect.field(Reflect.field(resp, "results"), Std.string(0)) == null)
                    {
                        rootHUD.HUD.debug.text += "create Keys entry";
                        parse_AddKeysEntry(key, message);
                    }
                    else
                    {
                        keysObjectId = Reflect.field(Reflect.field(resp, "results"), Std.string(0)).objectId;
                        parse_UpdateKeysEntry(key, message);
                    }
                }, function(err : Dynamic) : Dynamic
                {
                    trace("er");
                    rootHUD.HUD.debug.text = err;
                });
    }
    
    public static function parse_AddKeysEntry(key : Dynamic, message : Dynamic) : Dynamic
    {
        var i : String = null;
        var paramz : Dynamic = {};
        paramz.gamerId = member;
        if (message != "nothing")
        {
            paramz.message = message;
        }
        if (as3hx.Compat.typeof(key) == "string")
        {
            Reflect.setField(paramz, Std.string(key + worldPrefix), worldPrefix);
        }
        else
        {
            for (i in Reflect.fields(key))
            {
                Reflect.setField(paramz, Std.string(i + worldPrefix), worldPrefix);
            }
        }
        Parse.Post("Keys", paramz, function(resp : Dynamic) : Dynamic
                {
                    rootHUD.HUD.debug.text += "Keys entry added";
                }, function(err : Dynamic) : Dynamic
                {
                    trace("add key entry error");
                });
    }
    
    public static function parse_UpdateKeysEntry(key : Dynamic, message : Dynamic) : Dynamic
    {
        var i : String = null;
        var paramz : Dynamic = {};
        paramz.gamerId = member;
        if (message != "nothing")
        {
            paramz.message = message;
        }
        if (as3hx.Compat.typeof(key) == "string")
        {
            Reflect.setField(paramz, Std.string(key + worldPrefix), worldPrefix);
        }
        else
        {
            for (i in Reflect.fields(key))
            {
                Reflect.setField(paramz, Std.string(i + worldPrefix), worldPrefix);
            }
        }
        Parse.Put("Keys", keysObjectId, paramz, function(resp : Dynamic) : Dynamic
                {
                    rootHUD.HUD.debug.text += "Keys updated!";
                }, function(err : Dynamic) : Dynamic
                {
                    rootHUD.HUD.debug.text = "Keys error";
                });
    }
    
    private static function populateLevelArray() : Void
    {
        AllLevelObjects = [];
        framin = 1;
        loadDontCheat();
        addObjectsToArray(0);
        saveDontCheat();
        setupAutos(0);
    }
    
    private static function addObjectsToArray(ID : Dynamic) : Void
    {
        var ePlacers : MovieClip = null;
        var interact : Dynamic = null;
        var bad : Dynamic = null;
        if (ID == 0)
        {
            ePlacers = interactPlacers;
        }
        else
        {
            ePlacers = AllEverything["interact" + ID];
        }
        if (ePlacers != null)
        {
            CoinN = 0;
            n = ePlacers.numChildren;
            for (i in 0...n)
            {
                interact = ePlacers.getChildAt(0);
                if (Lambda.indexOf(availableInteracts, interact.ItIs) > -1)
                {
                    if (stageRoot.simpleBackgrounds)
                    {
                        if (interact.onRail > 1)
                        {
                            interact.onRail = 1;
                        }
                    }
                    if (interact.ItIs == "SquigglePop")
                    {
                        if (dontCheat[CoinN] == null)
                        {
                            dontCheat[CoinN] = false;
                        }
                        interact.ID = CoinN;
                        saveLevelObject(interact, ID);
                        ++CoinN;
                    }
                    else if (interact.ItIs == "Squiggle" || interact.ItIs == "grassPop" || interact.ItIs == "shadowSquiggle")
                    {
                        if (dontCheat[CoinN] == null)
                        {
                            dontCheat[CoinN] = false;
                        }
                        if (dontCheat[CoinN] == null)
                        {
                            interact.ID = CoinN;
                            saveLevelObject(interact, ID);
                        }
                        ++CoinN;
                    }
                    else
                    {
                        saveLevelObject(interact, ID);
                    }
                }
                ePlacers.removeChildAt(0);
            }
            AllEverything.removeChild(ePlacers);
            if (ID == 0)
            {
                interactPlacers = null;
            }
        }
        if (ID == 0)
        {
            ePlacers = baddiePlacers;
        }
        else
        {
            ePlacers = AllEverything["baddies" + ID];
        }
        if (ePlacers != null)
        {
            n = ePlacers.numChildren;
            for (i in 0...n)
            {
                bad = ePlacers.getChildAt(0);
                if (Lambda.indexOf(availableBaddies, bad.ItIs) > -1)
                {
                    if (stageRoot.simpleBackgrounds)
                    {
                        if (bad.onRail > 1)
                        {
                            bad.onRail = 1;
                        }
                    }
                    saveLevelObject(bad, ID);
                }
                ePlacers.removeChildAt(0);
            }
            AllEverything.removeChild(ePlacers);
            if (ID == 0)
            {
                baddiePlacers = null;
            }
        }
        ePlacers = null;
    }
    
    private static function saveLevelObject(placer : Dynamic, id : Dynamic) : Void
    {
        var i : String = null;
        var obj : Dynamic = {
            x : placer.x,
            y : placer.y,
            rotation : placer.rotation,
            scaleX : placer.scaleX,
            scaleY : placer.scaleY
        };
        for (i in Reflect.fields(placer))
        {
            Reflect.setField(obj, i, Reflect.field(placer, i));
        }
        if (id == 0)
        {
            AllLevelObjects.push(obj);
        }
        else
        {
            obj.onRail = id;
            AllBoxObjects.push(obj);
        }
    }
    
    public static function populateLevel(clearAll : Dynamic) : Void
    {
        var classType : Class<Dynamic> = null;
        var i : Int = 0;
        n = AllLevelObjects.length;
        framin = 1;
        CoinN = 0;
        if (clearAll != null)
        {
            aPlat.makePressBlock();
        }
        loadDontCheat();
        if (clearAll != null)
        {
            for (i in 0...n)
            {
                spawnObject(AllLevelObjects[i]);
            }
        }
        else
        {
            for (i in 0...n)
            {
                if (AllLevelObjects[i].ItIs != "aPlat" && AllLevelObjects[i].ItIs != "inkBoard")
                {
                    spawnObject(AllLevelObjects[i]);
                }
            }
            aPlat.resetAllPlats();
        }
        for (i in 0...backgroundsN)
        {
            Backgrounds.backgroundsArray[i].addChild(Backgrounds.backgroundsArray[i].container);
        }
        StarlingDecals.staticOnDeckArray.sortOn("ex", Array.NUMERIC);
        aWall.pairBlocks();
        setupUberForegrounds();
        textBubbles.addTextBubble();
        setUseNodes(progressNode.arrangeNodes());
        if (clearAll != null)
        {
            aPlat.forgetPressBlock();
        }
    }
    
    private static function populateBox(ID : Dynamic) : Void
    {
        loadDontCheatBox(ID);
        AllBoxObjects = [];
        addObjectsToArray(ID);
        saveDontCheatBox(ID);
        Backgrounds.backgroundsArray[ID].addChild(Backgrounds.backgroundsArray[ID].container);
        n = AllBoxObjects.length;
        framin = 1;
        for (i in 0...n)
        {
            spawnObject(AllBoxObjects[i]);
        }
    }
    
    private static function spawnObject(e : Dynamic) : Dynamic
    {
        if (e.ItIs == "aPlat" || e.ItIs == "aWall" || e.ItIs == "aGround")
        {
            classType = Type.getClass(Type.resolveClass(e.ItIs));
            new ClassType(e);
        }
        else if (Lambda.indexOf(availableBaddies, e.ItIs) > -1 || Lambda.indexOf(availableInteracts, e.ItIs) > -1)
        {
            if (e.ItIs == "WarpBox" || e.ItIs == "TriggerBox" || e.ItIs == "SwitchBox" || e.ItIs == "KillaBox")
            {
                new WarpBox(e);
            }
            else if (e.ItIs == "doodleGrass" || e.ItIs == "spikeDecal" || e.ItIs == "spikeBarDecal" || e.ItIs == "inkBubbleDecal")
            {
                classType = Type.getClass(Type.resolveClass(e.ItIs + "Starling"));
                new ClassType(e);
            }
            else if (e.ItIs == "SquigglePop" || e.ItIs == "fadeInHelp" || e.ItIs == "inkSpout" || e.ItIs == "aScratch")
            {
                StarlingInteract.InteractPopulate(e);
            }
            else if (e.ItIs == "inkPipe")
            {
                StarlingInteract.InkPipePopulate(e);
            }
            else if (e.ItIs == "Squiggle" || e.ItIs == "shadowSquiggle" || e.ItIs == "grassPop")
            {
                if (dontCheat[e.ID] == null)
                {
                    StarlingInteract.InteractPopulate(e);
                }
            }
            else if (e.ItIs == "justALoop")
            {
                classType = Type.getClass(Type.resolveClass(e.which));
                setupLoop(new ClassType(), e);
            }
            else if (e.ItIs == "justALoopStarling")
            {
                if (e.onRail > 3)
                {
                    StarlingTemporary.Spawn("Blur" + e.which, e.x, e.y, e.rotation * (Math.PI / 180), e.scaleX, e.onRail, true);
                }
                else
                {
                    StarlingTemporary.Spawn(e.which, e.x, e.y, e.rotation * (Math.PI / 180), e.scaleX, e.onRail, true);
                }
            }
            else if (e.ItIs == "WalkingWorker")
            {
                classType = Type.getClass(Type.resolveClass(e.ItIs));
                new ClassType(e.x, e.y, e.scaleX, e.onRail);
            }
            else
            {
                classType = Type.getClass(Type.resolveClass(e.ItIs));
                new ClassType(e);
            }
        }
    }
    
    private static function saveBoxObject(placer : Dynamic) : Dynamic
    {
        var i : String = null;
        var obj : Dynamic = {
            x : placer.x,
            y : placer.y,
            rotation : placer.rotation,
            scaleX : placer.scaleX,
            scaleY : placer.scaleY
        };
        for (i in Reflect.fields(placer))
        {
            Reflect.setField(obj, i, Reflect.field(placer, i));
        }
        AllBoxObjects.push(obj);
    }
    
    private static function setupAutos(id : Dynamic) : Dynamic
    {
        if (AllEverything.aPlats != null)
        {
            n = AllEverything.aPlats.numChildren;
            for (i in 0...n)
            {
                saveLevelObject(AllEverything.aPlats.getChildAt(0), id);
                AllEverything.aPlats.removeChildAt(0);
            }
            AllEverything.removeChild(AllEverything.getChildByName("aPlats"));
        }
    }
    
    private static function setupLoop(c : Dynamic, e : Dynamic) : Dynamic
    {
        c.x = e.x;
        c.y = e.y;
        c.scaleX = e.scaleY;
        c.scaleY = e.scaleY;
        if (e.scaleX != null && e.scaleX != 0)
        {
            c.scaleX *= e.scaleX;
        }
        c.ItIs = e.which;
        c.loopRand = e.rand;
        Backgrounds.backgroundsArray[e.onRail].addChild(c);
    }
    
    private static function loadDontCheat() : Array<Dynamic>
    {
        dontCheat = StarlingInteract.dontCheat[LoadIt];
        if (dontCheat == null)
        {
            dontCheat = [];
        }
    }
    
    private static function loadDontCheatBox(ID : Dynamic) : Array<Dynamic>
    {
        dontCheat = StarlingInteract.dontCheat[LoadIt + "_" + ID];
        if (dontCheat == null)
        {
            dontCheat = [];
        }
    }
    
    private static function saveDontCheat() : Array<Dynamic>
    {
        StarlingInteract.dontCheat[LoadIt] = dontCheat;
        dontCheat = null;
    }
    
    private static function saveDontCheatBox(ID : Dynamic) : Array<Dynamic>
    {
        StarlingInteract.dontCheat[LoadIt + "_" + ID] = dontCheat;
        if (dontCheat == null)
        {
            dontCheat = [];
        }
    }
    
    public static function getBlurOffset(rail : Int) : Float
    {
        return cameraFocalLength / (cameraFocalLength + backgroundZs[rail]);
    }
    
    private static function backgroundZAdd(start : Dynamic, interval : Dynamic, times : Dynamic) : Void
    {
        var i : Int = start;
        while (i < start + times * interval)
        {
            backgroundZs.push(i);
            i += interval;
        }
    }
    
    private static function setupCamera() : Dynamic
    {
        MinX = originalMinX;
        MaxX = originalMaxX;
        MinY = originalMinY;
        MaxY = originalMaxY;
        cameraStage = cameraTemp = 0;
        if (gameMode == "showAll")
        {
            if ((MaxX - MinX) / (relativeStageX * 2) < (MaxY - MinY) / (relativeStageY * 2))
            {
                cameraZ = -((MaxX - MinX) / (relativeStageX * 2) * cameraFocalLength - cameraFocalLength);
            }
            else
            {
                cameraZ = -((MaxY - MinY) / (relativeStageY * 2) * cameraFocalLength - cameraFocalLength);
            }
        }
        else
        {
            setMaxZ();
        }
        rootHUD.setOnlyMove(LoadIt == "Menus0-a" && DoorIt == 1);
        tick = true;
        if (cameraZ < MaxZ)
        {
            cameraZ = MaxZ;
        }
    }
    
    public static function setMaxZ() : Void
    {
        if ((MaxX - MinX) / (relativeStageX * 2) < (MaxY - MinY) / (relativeStageY * 2))
        {
            MaxZ = -((MaxX - MinX) / (relativeStageX * 2) * cameraFocalLength - cameraFocalLength);
        }
        else
        {
            MaxZ = -((MaxY - MinY) / (relativeStageY * 2) * cameraFocalLength - cameraFocalLength);
        }
        MaxZ += backgroundZs[0];
        MaxZ -= zOffset;
        if (MaxZ > 0)
        {
            cameraZ = MaxZ;
        }
    }
    
    public static function setScroll() : Dynamic
    {
        var ex : Float = Math.NaN;
        var ey : Float = Math.NaN;
        var ez : Float = Math.NaN;
        toCameraShiftRatio = cameraShiftRatio = 1;
        lockShiftRatio = 0;
        cameraShift = lockShift = false;
        boundsShiftX = boundsShiftY = boundsShiftDistX = boundsShiftDistY = 0;
        cameraShiftX = -10000;
        Char.scrollChars(cameraX, cameraY, cameraZ + zOffset, 0, 0);
        for (i in 0...Char.ActiveCharArray.length)
        {
            rootRatios[0] = cameraFocalLength / (cameraFocalLength + Char.ActiveCharArray[i].cameraZ - (cameraZ + zOffset)) * overRatio;
            Char.ActiveCharArray[i].resetCamera();
        }
        if (lockShift)
        {
            lockShiftRatio = 1;
        }
        cameraShiftRatio = toCameraShiftRatio;
        if (boundsShiftDistX != 0 || boundsShiftDistY != 0)
        {
            setShiftBounds();
        }
        if (gameMode == "showAll")
        {
            stageRoot.scrollEngine = function() : Dynamic
                    {
                    };
            cameraX = (MaxX + MinX) * 0.5;
            cameraY = (MaxY + MinY) * 0.5;
        }
        else
        {
            ez = -Math.abs(Char.ActiveCharArray[0].moveRL * 2) + Char.ActiveCharArray[0].zOffset;
            if (cameraShiftRatio < 1)
            {
                if (!cameraShift)
                {
                    cameraShiftRatio += 0.01;
                }
                if (cameraShiftRatio > 1)
                {
                    cameraShiftRatio = 1;
                }
                ex = cameraShiftX + (Char.ActiveCharArray[0].cameraX - cameraShiftX) * cameraShiftRatio;
                ey = cameraShiftY + (Char.ActiveCharArray[0].cameraY - cameraShiftY) * cameraShiftRatio;
                charScrollZ = cameraShiftZ + -cameraShiftZ * cameraShiftRatio;
            }
            else
            {
                ex = Char.ActiveCharArray[0].cameraX;
                ey = Char.ActiveCharArray[0].cameraY;
                charScrollZ = Char.ActiveCharArray[0].zOffset;
                if (cameraShiftX > -10000)
                {
                    cameraShiftX = -10000;
                }
            }
            if (charScrollZ < MaxZ)
            {
                charScrollZ = MaxZ;
            }
            quickStages(charScrollZ);
            if (shiftBounds(ex, ey))
            {
                ex = Char.ActiveCharArray[0].cameraX;
                ey = Char.ActiveCharArray[0].cameraY;
            }
            if (ex - stageX < MinX)
            {
                ex = MinX + stageX;
            }
            if (ex + stageX > MaxX)
            {
                ex = MaxX - stageX;
            }
            if (ey - stageY < MinY)
            {
                ey = MinY + stageY;
            }
            if (ey + stageY > MaxY)
            {
                ey = MaxY - stageY;
            }
            if (MaxX - MinX < stageX * 2 || MaxY - MinY < stageY * 2)
            {
                if ((MaxX - MinX) / (stageX * 2) < (MaxY - MinY) / (stageY * 2))
                {
                    ex = (MinX + MaxX) * 0.5;
                }
                else
                {
                    ey = (MinY + MaxY) * 0.5;
                }
            }
            charScrollX = ex;
            charScrollY = ey;
            stageRoot.focusScroll(charScrollX, charScrollY, charScrollZ);
            stageRoot.scrollEverything();
            collision.sendVars(cameraX, cameraY, stageXs, stageYs);
            if (false && LoadIt.substr(0, 5) == "Lockd" && !hasKey())
            {
                MaxZ = 1;
                stageRoot.scrollEngine = function() : Dynamic
                        {
                        };
                cameraY -= 30;
            }
            else if (LoadIt == "Level3" && DirIt == "World 4")
            {
                cameraX = Char.ActiveCharArray[0].x;
                cameraY += 20;
                cameraZ -= 500;
                cameraTemp = 0;
                stageRoot.scrollEngine = stageRoot.introScroll;
            }
            else if (LoadIt == "Menus0-a" && DoorIt == 1)
            {
                toCameraShiftRatio = cameraShiftRatio = 0;
                stageRoot.scrollEngine = stageRoot.nullScroll;
                cameraX = 233;
                cameraY = -118;
                cameraZ = 85;
                setNullScroll();
            }
            else
            {
                stageRoot.scrollEngine = stageRoot.scrollChars;
                stageRoot.scrollChars();
            }
        }
        stageRoot.scrollEverything();
    }
    
    public static function refreshCamera() : Void
    {
        cameraShift = lockShift = false;
    }
    
    public static function switchScroll(scroll : String) : Void
    {
        stageRoot.scrollEngine = Reflect.field(stageRoot, scroll);
    }
    
    public static function justSetShifts(ex : Int, ey : Int, ez : Int) : Void
    {
        cameraShiftX = ex;
        cameraShiftY = as3hx.Compat.parseInt(ey - stageRoot.superOffset);
        cameraShiftZ = ez - zOffset;
        charScrollX = cameraX;
        charScrollY = cameraY - stageRoot.superOffset;
        charScrollZ = cameraZ;
    }
    
    public static function setNullScroll() : Void
    {
        charScrollX = cameraX;
        charScrollY = cameraY - stageRoot.superOffset;
        charScrollZ = cameraZ;
    }
    
    public static function setTempCameras() : Void
    {
        tempCameraX = charScrollX;
        tempCameraY = charScrollY;
        tempCameraZ = charScrollZ + (zOffset + 10);
    }
    
    private static function quickStages(Z : Float) : Void
    {
        rootRatios[0] = cameraFocalLength / (cameraFocalLength - (Z - backgroundZs[0] + zOffset)) * overRatio;
        stageX = originalStageX / rootRatios[0];
        stageY = originalStageY / rootRatios[0];
        if (stageX < 10)
        {
            stageX = 10;
        }
        if (stageY < 10)
        {
            stageY = 10;
        }
        stageXs[0] = stageX;
        stageYs[0] = stageY;
    }
    
    private static function quickStageX(Z : Float) : Float
    {
        return originalStageX / (cameraFocalLength / (cameraFocalLength - (Z - backgroundZs[0] + zOffset)) * overRatio);
    }
    
    private static function quickStageY(Z : Float) : Float
    {
        return originalStageY / (cameraFocalLength / (cameraFocalLength - (Z - backgroundZs[0] + zOffset)) * overRatio);
    }
    
    private static function cosCurve(ex : Float) : Float
    {
        return (-Math.cos(ex * 3.14) + 1) * 0.5;
    }
    
    public static function setScrollOther(e : Collision, ez : Float = 0) : Dynamic
    {
        scrollOtherObject = e;
        stageRoot.scrollEngine = stageRoot.scrollOther;
        lockShiftZ = ez;
    }
    
    public static function setScrollAfterRace(e : Collision, ez : Float = 0) : Dynamic
    {
        scrollOtherObject = e;
        stageRoot.scrollEngine = stageRoot.scrollAfterRace;
        lockShiftZ = ez;
    }
    
    public static function lockShiftBack() : Void
    {
        WarpBox.clearShiftID();
        if (lockShiftRatio > 0.1)
        {
            return;
        }
        lockShiftRatio = 1;
        lockShiftX = as3hx.Compat.parseInt(charScrollX);
        lockShiftY = as3hx.Compat.parseInt(charScrollY);
        lockShiftZ = charScrollZ;
        charScrollX = Char.ActiveCharArray[0].cameraX;
        charScrollY = Char.ActiveCharArray[0].cameraY;
        charScrollZ = Char.ActiveCharArray[0].zOffset;
        if (charScrollX - stageX < MinX)
        {
            charScrollX = MinX + stageX;
        }
        if (charScrollX + stageX > MaxX)
        {
            charScrollX = MaxX - stageX;
        }
        if (charScrollY - stageY < MinY)
        {
            charScrollY = MinY + stageY;
        }
        if (charScrollY + stageY > MaxY)
        {
            charScrollY = MaxY - stageY;
        }
    }
    
    public static function startShiftBounds(dirX : Dynamic, dirY : Dynamic, distX : Dynamic, distY : Dynamic) : Void
    {
        if (boundsShiftX == 0)
        {
            if (dirX > 0)
            {
                if (cameraX + stageX < MaxX)
                {
                    if (cameraX + stageX < originalMaxX + distX)
                    {
                        MaxX = originalMaxX + distX;
                    }
                    else
                    {
                        MaxX = cameraX + stageX;
                    }
                }
            }
            else if (dirX < 0)
            {
                if (cameraX - stageX > MinX)
                {
                    if (cameraX - stageX > originalMinX + distX)
                    {
                        MinX = originalMinX + distX;
                    }
                    else
                    {
                        MinX = cameraX - stageX;
                    }
                }
            }
        }
        if (boundsShiftY == 0)
        {
            if (dirY > 0)
            {
                if (cameraY + stageY < MaxY)
                {
                    if (cameraY + stageY < originalMaxY + distY)
                    {
                        MaxY = originalMaxY + distY;
                    }
                    else
                    {
                        MaxY = cameraY + stageY;
                    }
                }
            }
            else if (dirY < 0)
            {
                if (cameraY - stageY > MinY)
                {
                    if (cameraY - stageY > originalMinY + distY)
                    {
                        MinY = originalMinY + distY;
                    }
                    else
                    {
                        MinY = cameraY - stageY;
                    }
                }
            }
        }
        if (dirX != 0)
        {
            boundsShiftDistX = distX;
            boundsShiftX = dirX;
        }
        if (dirY != 0)
        {
            boundsShiftDistY = distY;
            boundsShiftY = dirY;
        }
    }
    
    public static function shiftBounds(ex : Dynamic, ey : Dynamic) : Bool
    {
        if (boundsShiftX < 0)
        {
            if (MaxX != originalMaxX)
            {
                MaxX = originalMaxX;
            }
            if (boundsShiftDistX == 0 && MinX - originalMinX > 0)
            {
                if (ex - stageX < MinX)
                {
                    Char.ActiveCharArray[0].reCalCamera(Char.ActiveCharArray[0].cameraX = MinX + stageX, ey);
                    boundsShiftX = 0;
                    MinX = originalMinX;
                    setMaxZ();
                    return true;
                }
                boundsShiftX = 0;
                MinX = originalMinX;
            }
            else
            {
                MinX += limitVar((originalMinX + boundsShiftDistX - MinX) * 0.1, 20) * framin;
                setMaxZ();
            }
        }
        if (boundsShiftX > 0)
        {
            if (MinX != originalMinX)
            {
                MinX = originalMinX;
            }
            if (boundsShiftDistX == 0 && MaxX - originalMaxX < 0)
            {
                if (ex + stageX > MaxX)
                {
                    Char.ActiveCharArray[0].reCalCamera(Char.ActiveCharArray[0].cameraX = MaxX - stageX, ey);
                    boundsShiftX = 0;
                    MaxX = originalMaxX;
                    setMaxZ();
                    return true;
                }
                boundsShiftX = 0;
                MaxX = originalMaxX;
            }
            else
            {
                MaxX += limitVar((originalMaxX + boundsShiftDistX - MaxX) * 0.1, 20) * framin;
                setMaxZ();
            }
        }
        if (boundsShiftY < 0)
        {
            if (MaxY != originalMaxY)
            {
                MaxY = originalMaxY;
            }
            if (boundsShiftDistY == 0 && MinY - originalMinY > 0)
            {
                if (ey - stageY < MinY)
                {
                    Char.ActiveCharArray[0].reCalCamera(ex, Char.ActiveCharArray[0].cameraY = MinY + stageY);
                    boundsShiftY = 0;
                    MinY = originalMinY;
                    setMaxZ();
                    return true;
                }
                boundsShiftY = 0;
                MinY = originalMinY;
            }
            else
            {
                MinY += limitVar((originalMinY + boundsShiftDistY - MinY) * 0.1, 20) * framin;
                setMaxZ();
            }
        }
        if (boundsShiftY > 0)
        {
            if (MinY != originalMinY)
            {
                MinY = originalMinY;
            }
            if (boundsShiftDistY == 0 && MaxY - originalMaxY < 0)
            {
                if (ey + stageY > MaxY)
                {
                    Char.ActiveCharArray[0].reCalCamera(ex, Char.ActiveCharArray[0].cameraY = MaxY - stageY);
                    boundsShiftY = 0;
                    MaxY = originalMaxY;
                    setMaxZ();
                    return true;
                }
                boundsShiftY = 0;
                MaxY = originalMaxY;
            }
            else
            {
                MaxY += limitVar((originalMaxY + boundsShiftDistY - MaxY) * 0.1, 20) * framin;
                setMaxZ();
            }
        }
        if (Math.abs(MinX - originalMinX) < 2)
        {
            MinX = originalMinX;
        }
        if (Math.abs(MaxX - originalMaxX) < 2)
        {
            MaxX = originalMaxX;
        }
        if (Math.abs(MinY - originalMinY) < 2)
        {
            MinY = originalMinY;
        }
        if (Math.abs(MaxY - originalMaxY) < 2)
        {
            MaxY = originalMaxY;
        }
        if (boundsShiftDistX == 0)
        {
            if (MaxX == originalMaxX && MinX == originalMinX)
            {
                boundsShiftX = 0;
            }
        }
        if (boundsShiftDistY == 0)
        {
            if (MaxY == originalMaxY && MinY == originalMinY)
            {
                boundsShiftY = 0;
            }
        }
        boundsShiftDistX = boundsShiftDistY = boundsShiftZ = 0;
        return false;
    }
    
    private static function setShiftBounds() : Dynamic
    {
        if (boundsShiftX > 0)
        {
            MaxX = originalMaxX + boundsShiftDistX;
        }
        else if (boundsShiftX < 0)
        {
            MinX = originalMinX + boundsShiftDistX;
        }
        if (boundsShiftY > 0)
        {
            MaxY = originalMaxY + boundsShiftDistY;
        }
        else if (boundsShiftY < 0)
        {
            MinY = originalMinY + boundsShiftDistY;
        }
    }
    
    public static function shakeScreen(power : Float, angle : Float = 0, rumble : Bool = false, sound : Bool = false) : Dynamic
    {
        if (Math.abs(power) >= Math.abs(stageRoot.shakeRL))
        {
            if (rumble)
            {
                stageRoot.shakeRL = power;
                stageRoot.cameraRumble = true;
            }
            else
            {
                stageRoot.shakeRL = -Math.sin(angle) * power * 5;
                stageRoot.shakeUD = Math.cos(angle) * power * 5;
                stageRoot.cameraRumble = false;
            }
        }
        if (sound)
        {
            if (stageRoot.rumbleSound)
            {
                if (stageRoot.rumbleFade < 3)
                {
                    stageRoot.rumbleFade += 0.15;
                }
            }
            else
            {
                stageRoot.rumbleFade = 0.5;
                stageRoot.rumbleChannel = Sounds.playSoundContinuous("LowRumble", cameraX, 0, 0);
                stageRoot.rumbleSound = true;
            }
        }
    }
    
    public static function checkPitY(ey : Int, rail : Int, ratio : Float = 0) : Bool
    {
        if (ratio == 0)
        {
            return ey - 400 * rootRatios[rail] > MaxY - stageY + stageYs[rail];
        }
        return ey > MaxY - stageY + stageYs[rail] + 400;
    }
    
    public static function isOnStage(ex : Int, ey : Int, rail : Int) : Bool
    {
        return Math.abs(ex - cameraX) < stageXs[rail] && Math.abs(ey - cameraY) < stageYs[rail];
    }
    
    public static function getRewardType(level : String) : String
    {
        var temp : String = null;
        if (RewardList.length > ChallengeList.indexOf(level))
        {
            temp = Reflect.field(RewardList, Std.string(ChallengeList.indexOf(level)));
            return temp.substr(0, temp.indexOf("-"));
        }
        return "nothing";
    }
    
    public static function getRewardNumber(level : String) : Int
    {
        var temp : String = null;
        var n : Int = 0;
        if (RewardList.length > ChallengeList.indexOf(level))
        {
            temp = Reflect.field(RewardList, Std.string(ChallengeList.indexOf(level)));
            n = as3hx.Compat.parseInt(temp.indexOf("-") + 1);
            return temp.substr(n, temp.length - n);
        }
        return 0;
    }
    
    public static function hasReward(level : String) : Bool
    {
        var hasString : String = null;
        var pickupType : String = getRewardType(level);
        var pickupNum : Int = getRewardNumber(level);
        if (pickupType == "Hat")
        {
            hasString = "hasHatsString";
        }
        else if (pickupType == "Pants")
        {
            hasString = "hasPantsString";
        }
        else if (pickupType == "Pattern")
        {
            hasString = "hasPatternsString";
        }
        if (pickupType == "nothing")
        {
            return false;
        }
        return Main.localSettings[hasString].substr(pickupNum - 1, 1) == "y";
    }
    
    public static function challengeAchievements() : Void
    {
        if (!firstChallenge)
        {
            firstChallenge = true;
            Achievements.unlock("First_Challenge");
        }
        Achievements.SendScore("challengesTotal", 1);
        var has : Int = 0;
        var array : Array<Dynamic> = Main["Level" + LevelLoaded.substr(5, 1) + "Rewards"];
        var i : Int = 0;
        var l : Int = array.length;
        while (i < l)
        {
            if (hasReward(array[i]))
            {
                has++;
            }
            i++;
        }
        if (LevelLoaded.substr(5, 1) == "0")
        {
            Achievements.SendScore("challengesBasement", has);
            if (has == array.length)
            {
                Achievements.unlock("Basement_Complete");
            }
        }
        if (LevelLoaded.substr(5, 1) == "1")
        {
            Achievements.SendScore("challengesSquiggleville", has);
            if (has == array.length)
            {
                Achievements.unlock("Squiggleville_Complete");
            }
        }
        if (LevelLoaded.substr(5, 1) == "2")
        {
            Achievements.SendScore("challengesPirate", has);
            if (has == array.length)
            {
                Achievements.unlock("Pirate_Valley_Complete");
            }
        }
        if (LevelLoaded.substr(5, 1) == "3")
        {
            Achievements.SendScore("challengeApproach", has);
            if (has == array.length)
            {
                Achievements.unlock("Approach_Complete");
            }
        }
        if (LevelLoaded.substr(5, 1) == "4")
        {
            Achievements.SendScore("challengesVolcano", has);
            if (has == array.length)
            {
                Achievements.unlock("Volcano_Complete");
            }
        }
    }
    
    public static function randNum(e : Dynamic) : Dynamic
    {
        return Math.floor(Math.random() * e);
    }
    
    private static function ng_CheckFilesLoad() : Dynamic
    {
        var query : SaveQuery = API.createSaveQuery("Settings");
        query.addCondition(SaveQuery.AUTHOR_ID, SaveQuery.OPERATOR_EQUAL, API.userId);
        query.addEventListener(APIEvent.QUERY_COMPLETE, ngQueryComplete);
        query.execute();
    }
    
    private static function ngQueryComplete(event : APIEvent) : Dynamic
    {
        rootHUD.HUD.keySwitch.gotoAndStop(2);
        if (event.data.files.length == 0)
        {
            trace("no file");
            saveFile = API.createSaveFile("Settings");
            saveFile.name = "saveFile";
            saveFile.data = {
                        settings : { },
                        scores : { }
                    };
            fillUndefined();
            pauseStatus = "Ready";
        }
        else
        {
            trace("load ng file");
            saveFile = event.data.files[0];
            saveFile.load();
            saveFile.addEventListener(APIEvent.FILE_LOADED, ngOnLoaded);
        }
    }
    
    private static function ngOnSaved(e : APIEvent) : Dynamic
    {
        saveFile.removeEventListener(APIEvent.FILE_SAVED, ngOnSaved);
        if (e.success)
        {
            trace("ng settings saved");
        }
        else
        {
            trace(e.error);
        }
    }
    
    private static function ngOnLoaded(e : APIEvent) : Dynamic
    {
        saveFile.removeEventListener(APIEvent.FILE_LOADED, ngOnLoaded);
        if (e.success)
        {
            localSettings = saveFile.data.settings;
            fillUndefined();
            if (saveFile.data.scores == null)
            {
                localScores = [];
            }
            else
            {
                localScores = saveFile.data.scores;
            }
            Sounds.setVolume(localSettings.sfxVol);
            Sounds.musicVol = localSettings.musicVol;
            Sounds.updateMusic(1);
            trace(haxe.Json.stringify(localSettings));
            trace("loaded ng settings");
            pauseStatus = "Ready";
        }
        else
        {
            trace(e.error);
        }
    }
    
    private static function sendAnalytics(what : Dynamic) : Dynamic
    {
        var paramz : Dynamic = null;
        if (analyticsObjectId != null)
        {
            paramz = {};
            Reflect.setField(paramz, Std.string(what), {
                __op : "Increment",
                amount : 1
            });
            Parse.Put("Analytics", analyticsObjectId, paramz, function(resp : Dynamic) : Dynamic
                    {
                        trace("analytic " + what);
                    }, function(err : Dynamic) : Dynamic
                    {
                    });
        }
    }
    
    public static function displayCombo(combo : Dynamic) : Dynamic
    {
        var i : Int = 0;
        if (localScores.maxCombo > combo)
        {
            rootHUD.HUD.debug.text = "High Score: " + localScores.maxCombo + "\n ";
        }
        else
        {
            rootHUD.HUD.debug.text = "High Score: " + combo + "\n ";
        }
        var n : Dynamic = as3hx.Compat.parseInt(comboHS.length);
        for (i in Reflect.fields(comboHS))
        {
            if (combo <= comboHS[i][1])
            {
                if (comboHS[i][0] != member)
                {
                    rootHUD.HUD.debug.text += "\n " + comboHS[i][0].slice(0, comboHS[i][0].length - 3) + " : " + comboHS[i][1];
                    n = i;
                    break;
                }
            }
        }
        rootHUD.HUD.debug.text += "\n " + memberDisplay + " : " + combo;
        while (n > 0)
        {
            if (comboHS[n - 1][0] != member)
            {
                rootHUD.HUD.debug.text += "\n " + comboHS[n - 1][0].slice(0, comboHS[n - 1][0].length - 3) + " : " + comboHS[n - 1][1];
                break;
            }
            n--;
        }
    }
    
    public static function updateCombo(e : Int) : Dynamic
    {
        if (e > 1)
        {
            Achievements.SendScore("maxCombo", e);
            if (e > localScores.maxCombo || localScores.maxCombo == null)
            {
                updateScore("maxCombo", e, function() : Dynamic
                        {
                        });
            }
        }
    }
    
    private static function updateTime(e : Dynamic, func : Dynamic) : Dynamic
    {
        kongStats(LevelLoaded + "_" + StatusName, e);
        if (e > 0 && e < Reflect.field(localScores, Std.string(LevelLoaded + "_" + StatusName)) || Reflect.field(localScores, Std.string(LevelLoaded + "_" + StatusName)) == 0 || Reflect.field(localScores, Std.string(LevelLoaded + "_" + StatusName)) == null)
        {
            rootHUD.HUD.debug.text = "Best Time: " + e;
            if (!isOnline)
            {
                rootHUD.spawnPopup("Register to submit a score!");
            }
            updateScore(LevelLoaded + "_" + StatusName, e, func);
        }
        else
        {
            func();
        }
    }
    
    private static function updateScore(score : Dynamic, e : Dynamic, func : Dynamic) : Dynamic
    {
        var paramz : Dynamic = null;
        Reflect.setField(localScores, Std.string(score), e);
        if (isOnline)
        {
            if (scoresObjectID == null)
            {
                parse_AddScoresEntry(function() : Dynamic
                        {
                            updateScore(score, e, func);
                        });
            }
            else
            {
                paramz = {};
                paramz.gamerId = member;
                Reflect.setField(paramz, Std.string(score), e);
                Parse.Put("Scores" + worldPrefix, scoresObjectID, paramz, function(resp : Dynamic) : Dynamic
                        {
                            trace(score + " updated");
                            func();
                        }, function(err : Dynamic) : Dynamic
                        {
                            rootHUD.HUD.debug.text = "score error";
                        });
            }
        }
        else
        {
            shared.data.scores = localScores;
            func();
        }
    }
    
    public static function parse_track(track : Dynamic, inc : Dynamic) : Dynamic
    {
        var paramz : Dynamic = null;
        if (statsObjectID != null)
        {
            paramz = {};
            paramz.gamerId = member;
            Reflect.setField(paramz, Std.string(track), {
                __op : "Increment",
                amount : inc
            });
            Parse.Put("Stats", statsObjectID, paramz, function(resp : Dynamic) : Dynamic
                    {
                        trace("stat " + track + ", " + inc);
                    }, function(err : Dynamic) : Dynamic
                    {
                        rootHUD.HUD.debug.text += "\n" + track;
                    });
        }
    }
    
    public static function parse_saveSettings() : Dynamic
    {
        if (isOnline)
        {
            if (onSite == "Newgrounds" && false)
            {
                saveFile.data.settings = localSettings;
                saveFile.addEventListener(APIEvent.FILE_SAVED, ngOnSaved);
                saveFile.save();
            }
            else
            {
                Parse.Put("Settings", settingsObjectID, localSettings, function(resp : Dynamic) : Dynamic
                        {
                            trace("settings updated!");
                        }, function(err : Dynamic) : Dynamic
                        {
                            rootHUD.HUD.debug.text = "settings error";
                        });
            }
        }
        else
        {
            trace("save settings local");
            shared.data.world4Progress = world4Progress;
            shared.data.settings = localSettings;
            try
            {
                if (!isScaleForm)
                {
                    shared.flush();
                }
            }
            catch (err : Error)
            {
                trace("*** local save fail");
            }
        }
    }
    
    public static function saveProgress(e : Dynamic, n : Dynamic) : Dynamic
    {
        Reflect.setField(world4Progress, Std.string(e), n);
        trace("save " + e + " " + n);
        parse_saveSettings();
    }
    
    public static function fillUndefined(reset : Bool = false) : Dynamic
    {
        if (localSettings == null || reset)
        {
            localSettings = { };
        }
        if (localSettings.gamerId == null)
        {
            localSettings.gamerId = member;
        }
        if (localSettings.W1RProgress == null)
        {
            localSettings.W1RProgress = 0;
        }
        if (localSettings.W1RContProg == null)
        {
            localSettings.W1RContProg = 0;
        }
        if (localSettings.squiggles == null)
        {
            localSettings.squiggles = 0;
        }
        if (localSettings.lives == null)
        {
            localSettings.lives = 3;
        }
        if (localSettings.pantsN == null)
        {
            localSettings.pantsN = 0;
        }
        if (localSettings.hatN == null)
        {
            localSettings.hatN = 0;
        }
        if (localSettings.patternN == null)
        {
            localSettings.patternN = 0;
        }
        if (localSettings.colorN == null)
        {
            localSettings.colorN = 0;
        }
        if (localSettings.sfxVol == null)
        {
            localSettings.sfxVol = 1;
        }
        if (localSettings.musicVol == null)
        {
            localSettings.musicVol = 1;
        }
        if (localSettings.language == null)
        {
            localSettings.language = "English";
        }
        if (localSettings.fullscreen == null)
        {
            localSettings.fullscreen = true;
        }
        if (localSettings.hasPantsString == null)
        {
            localSettings.hasPantsString = "";
        }
        if (localSettings.hasHatsString == null)
        {
            localSettings.hasHatsString = "";
        }
        if (localSettings.hasPatternsString == null)
        {
            localSettings.hasPatternsString = "";
        }
        if (localSettings.hasPen == null)
        {
            localSettings.hasPen = false;
        }
        if (localSettings.hasShoot == null)
        {
            localSettings.hasShoot = false;
        }
        if (localSettings.hasZip == null)
        {
            localSettings.hasZip = false;
        }
        if (world4Progress == null || reset)
        {
            world4Progress = {
                        cutieLeftWindow : false,
                        cutieIsGone : false,
                        cutieHasHeyLady : false,
                        catIsDown : false,
                        volcanoBlown : false,
                        talkToIceCream : false,
                        talkToAssist : false,
                        iceCreamShop : false,
                        defeatBoss1 : false,
                        defeatBigBad1 : false,
                        talkToMayor0 : false,
                        talkToCapt0 : false,
                        bentPipe0 : false,
                        bentPipe1 : false,
                        bentPipe2 : false,
                        bentPipe3 : false,
                        peekBoss2 : false,
                        messageOutline : true,
                        messageSpinner : true,
                        messageUpgrade : true,
                        messageUpgradeAgain : true,
                        healthLevel : 0,
                        powerLevel : 0,
                        threeLevel : 0,
                        fourLevel : 0,
                        fiveLevel : 0,
                        sixLevel : 0,
                        canBuzzSaw : false,
                        canPokeDown : false,
                        canRising : false,
                        freePirateShip : false,
                        canMapAround : false,
                        volcanoUnlocked : false,
                        centerUnlocked : false,
                        gotPushed : false,
                        realUnlocked : false,
                        beatGame : false
                    };
            parse_saveSettings();
        }
        if (localSettings.updatedNumber == null)
        {
            localSettings.updatedNumber = 1;
            world4Progress.freePirateShip = world4Progress.canMapAround;
            world4Progress.defeatBoss2 = world4Progress.volcanoUnlocked;
        }
        if (localSettings.hasPen)
        {
            Char.givePens();
        }
        else
        {
            Char.takePens();
        }
        if (localSettings.lives < 0)
        {
            localSettings.lives = 3;
        }
        Char.hasShoot = localSettings.hasShoot;
        Char.hasZip = localSettings.hasZip;
        if (reset)
        {
            Char.CharArray[0].doChangeHat(0);
            Char.CharArray[0].doChangePants(0);
            Char.CharArray[0].doChangePattern(0);
        }
        if (stageRoot.stage.loaderInfo.url.indexOf(".com") == -1)
        {
            if (deviceID == "PC" && cast(localSettings.fullscreen, Bool))
            {
                goFullscreen();
            }
        }
    }
    
    private static function resetWorld() : Void
    {
        world4Progress.cutieLeftWindow = false;
        world4Progress.cutieIsGone = false;
        world4Progress.cutieHasHeyLady = false;
        world4Progress.catIsDown = false;
        world4Progress.volcanoBlown = false;
        world4Progress.talkToIceCream = false;
        world4Progress.talkToAssist = false;
        world4Progress.iceCreamShop = false;
        world4Progress.defeatBoss1 = false;
        world4Progress.defeatBigBad1 = false;
        world4Progress.talkToMayor0 = false;
        world4Progress.talkToCapt0 = false;
        world4Progress.bentPipe0 = false;
        world4Progress.bentPipe1 = false;
        world4Progress.bentPipe2 = false;
        world4Progress.peekBoss2 = false;
        world4Progress.peekBoss3 = false;
        world4Progress.freePirateShip = false;
        world4Progress.defeatBoss2 = false;
        world4Progress.gotPushed = false;
    }
    
    public static function hasKey() : Dynamic
    {
        return userHasKey || localSettings.role == "beta" || debug;
    }
    
    public static function hasFull() : Dynamic
    {
        return true;
    }
    
    public static function netConfig(p : Int) : Void
    {
        netPlayer = p;
        StarlingBackgrounds.startStarling(stageRoot.stage);
    }
    
    public static function saveDebug(load : Dynamic, door : Dynamic, dir : Dynamic) : Void
    {
        shared.data.debug.loadit = load;
        if (door > -1)
        {
            shared.data.debug.doorit = door;
        }
        shared.data.debug.dirit = dir;
        trace("-- save " + load + " " + door + " " + dir);
        shared.flush();
    }
    
    public static function quickEditSaveString(str : Dynamic, e : Dynamic) : Dynamic
    {
        var temp : String = null;
        while (Reflect.field(localSettings, Std.string("has" + str + "String")).substr(e, 1) == "")
        {
            Reflect.field(localSettings, Std.string("has" + str + "String")) += "n";
        }
        if (Reflect.field(localSettings, Std.string("has" + str + "String")).substr(e, 1) == "n")
        {
            temp = "";
            temp += Reflect.field(localSettings, Std.string("has" + str + "String")).substr(0, e);
            temp += "y";
            temp += Reflect.field(localSettings, Std.string("has" + str + "String")).substr(e + 1);
            Reflect.setField(localSettings, Std.string("has" + str + "String"), str);
        }
    }
    
    public static function getReturnLevel() : String
    {
        if (DirIt == "World 1")
        {
            return LastFullLevel;
        }
        return "Level" + Main.LevelLoaded.substr(5, Main.LevelLoaded.length - 5);
    }
    
    public static function shouldHideHUD(load : String) : Dynamic
    {
        return load.substr(0, 5) == "Menus" || load.substr(0, 5) == "Races" || load == "Villa0-a" || load == "Lockd0";
    }
    
    public static function GameOver() : Void
    {
        numPlayers = 1;
        if (DirIt == "World 1")
        {
            FadeItOut("Villa0-b", 3);
        }
        else if (LevelLoaded.substr(0, 5) == "Villa")
        {
            FadeItOut("Villa0-b", 0);
        }
        else if (LevelLoaded.substr(5, 1) == "0")
        {
            FadeItOut("Level0-a", 2);
        }
        else if (LevelLoaded.substr(5, 1) == "1")
        {
            FadeItOut("Level1-a", 2);
        }
        else if (LevelLoaded.substr(5, 1) == "2")
        {
            FadeItOut("Level2-a", 0);
        }
        else if (LevelLoaded.substr(5, 1) == "3")
        {
            FadeItOut("Level3-b", 2);
        }
        else if (LevelLoaded.substr(5, 1) == "4")
        {
            FadeItOut("Level4-a", 0);
        }
        else if (LevelLoaded.substr(5, 1) == "5")
        {
            FadeItOut("Level4-g", 2);
        }
        else
        {
            FadeItOut("Villa0-b", 0);
        }
        LoadIt = LevelLoaded = "respawn";
    }
    
    public static function launchURL(url : Dynamic) : Dynamic
    {
        flash.Lib.getURL(new URLRequest(url));
    }
    
    private static function setupUberForegrounds() : Dynamic
    {
        if (DirIt == "World 1")
        {
            if (LoadIt == "Level3")
            {
                Overlord = new Level3Overlord();
                Backgrounds.backgroundsArray[0].addChild(Overlord);
                Overlord.x = -1625.35 - 334.65;
                if (LevelStatus == "Birds")
                {
                    Overlord.gotoAndStop(60);
                }
            }
            else if (LoadIt == "Level6")
            {
                Overlord = new Level6Overlord();
                Backgrounds.backgroundsArray[0].addChild(Overlord);
            }
        }
        else if (DirIt == "World 4")
        {
            if (LoadIt == "Arena5")
            {
                Overlord = new Arena5Overlord();
                Backgrounds.backgroundsArray[0].addChild(Overlord);
            }
        }
    }
    
    private static function setupCharIcons() : Dynamic
    {
        var i : Int = 0;
        if (LevelStatus == "Smash")
        {
            rootHUD.HUD.gotoAndStop(1);
            rootHUD.HUD.gotoAndStop("Smash" + numPlayers);
            while (i < numPlayers)
            {
                rootHUD.HUD["counterSmash" + i].anchorX = rootHUD.HUD["counterSmash" + i].x;
                rootHUD.HUD["counterSmash" + i].anchorY = rootHUD.HUD["counterSmash" + i].y;
                i++;
            }
            for (i in 0...numPlayers)
            {
                Char.CharArray[i].isSmash = true;
                rootHUD.HUD.setupBars(i);
                Char.CharArray[i].drawPantsIcon();
            }
        }
        else
        {
            if (onSite == "Kizi")
            {
                rootHUD.HUD.gotoAndStop("Kizi");
                if (kiziLogo == null)
                {
                    loadKiziLogo();
                }
            }
            else if (onSite == "MiniClip")
            {
                rootHUD.HUD.gotoAndStop("MiniClip");
                rootHUD.HUD.MGorMC.gotoAndStop(1);
                if (Sounds.musicVol == 0 && Sounds.sfxVol == 0)
                {
                    rootHUD.HUD.muteButton.gotoAndStop(2);
                }
                else
                {
                    rootHUD.HUD.muteButton.gotoAndStop(1);
                }
                logo0 = new AdvertContainer(AdvertContainer.ID_0, 160, 90);
                logo0.x = 10;
                logo0.y = 10;
                rootHUD.HUD.addChild(logo0);
            }
            else if (onSite == "AddictingGames")
            {
                rootHUD.HUD.gotoAndStop("AG");
            }
            else if (isTouchScreen)
            {
                stageRoot.onlyMove = LoadIt == "Menus0-a" && DoorIt == 1;
                rootHUD.setOnlyMove(stageRoot.onlyMove);
                rootHUD.HUD.setupTouchScreen();
                if (numPlayers > 1)
                {
                    rootHUD.HUD.gotoAndStop(rootHUD.HUD.currentFrame + 3);
                }
            }
            else
            {
                rootHUD.HUD.gotoAndStop(numPlayers + "Player");
                rootHUD.HUD.fixBanner();
                if (cast(shouldHideHUD(LevelLoaded), Bool) || LevelStatus != "Normal")
                {
                    stageRoot.hideAllHUD(false);
                }
            }
            for (i in 0...numPlayers)
            {
                Char.CharArray[i].isSmash = false;
                rootHUD.HUD.setupBars(i);
                Char.CharArray[i].drawPantsIcon();
            }
        }
    }
    
    public static function debugGivePen(load : Dynamic, dir : Dynamic) : Void
    {
        if (dir != "World 1")
        {
            if (as3hx.Compat.parseFloat(load.substr(5, 1)) > 0 || load.substr(0, 5) == "Villa" || load.substr(0, 5) == "Tests" || load == "Level0-i" || load == "Level0-j" || load == "Arena1")
            {
                Char.givePens();
            }
            if (load == "Villa0-e" && DoorIt == 1)
            {
                Char.hasShoot = true;
            }
            else if (as3hx.Compat.parseFloat(load.substr(5, 1)) > 1 || load == "Arena1")
            {
                Char.hasShoot = true;
            }
            if (load != "Level3-a" && as3hx.Compat.parseFloat(load.substr(5, 1)) > 2 || load == "Arena1")
            {
                Char.hasZip = true;
            }
        }
    }
    
    public static function parse_AddStatsEntry(func : Dynamic) : Dynamic
    {
        var paramz : Dynamic = {};
        paramz.gamerId = member;
        paramz.plays = 1;
        Reflect.setField(paramz, Std.string(LevelLoaded + "_Plays"), "_Plays");
        Parse.Post("Stats", paramz, function(resp : Dynamic) : Dynamic
                {
                    statsObjectID = resp.objectId;
                    parse_track(LoadIt + "_Plays", 1);
                    func();
                }, function(err : Dynamic) : Dynamic
                {
                    rootHUD.HUD.debug.text = "make new error";
                });
    }
    
    public static function parse_orderAScore(score : Dynamic, high : Dynamic, lmt : Dynamic, func : Dynamic) : Dynamic
    {
        var where : Dynamic;
        var paramz : Dynamic = {};
        if (high != null)
        {
            paramz.order = "-" + score;
        }
        else
        {
            paramz.order = score;
        }
        paramz.keys = "gamerId," + score;
        paramz.limit = lmt;
        where = {};
        Reflect.setField(where, Std.string(score), {
            $exists : true,
            $ne : 0
        });
        Parse.Get("Scores" + worldPrefix, paramz, where, function(resp : Dynamic) : Dynamic
                {
                    var i : Int = 0;
                    var scores : Array<Dynamic> = new Array<Dynamic>();
                    for (i in Reflect.fields(Reflect.field(resp, "results")))
                    {
                        scores.push([Reflect.field(Reflect.field(resp, "results"), Std.string(i)).gamerId, Reflect.field(Reflect.field(Reflect.field(resp, "results"), Std.string(i)), Std.string(score))]);
                    }
                    func(scores);
                }, function(err : Dynamic) : Dynamic
                {
                    trace(err);
                    rootHUD.HUD.debug.text = err;
                });
    }
    
    public static function ScoresTable(whatClass : Dynamic, score : Dynamic, high : Dynamic, lmt : Dynamic, func : Dynamic) : Dynamic
    {
        var tempText : String = null;
        tempText = "";
        parse_orderAScore(score, high, lmt, function(e : Dynamic) : Dynamic
                {
                    var col : Int = 0;
                    var o : Int = 0;
                    var i : Int = 0;
                    var n : Int = 0;
                    var score : String = null;
                    var col0 : Int = Math.floor(e.length / 3);
                    var col1 : Int = col0;
                    var col2 : Int = col0;
                    var rem : Float = e.length / 3 - Math.floor(e.length / 3);
                    if (e.length > 20)
                    {
                        col = 3;
                    }
                    else if (e.length > 10)
                    {
                        col = 2;
                    }
                    else
                    {
                        col = 1;
                    }
                    if (rem + 0.001 > 1 / 3)
                    {
                        col0++;
                    }
                    if (rem + 0.001 > 2 / 3)
                    {
                        col1++;
                    }
                    for (o in Reflect.fields(e))
                    {
                        i = Math.floor(o / 3);
                        if (o / 3 - Math.floor(o / 3) + 0.001 > 1 / 3)
                        {
                            i += col0;
                        }
                        if (o / 3 - Math.floor(o / 3) + 0.001 > 2 / 3)
                        {
                            i += col1;
                        }
                        if (o > 0)
                        {
                            if (o / 3 == i)
                            {
                                tempText += "<br/>";
                            }
                            else
                            {
                                tempText += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                            }
                        }
                        tempText += Reflect.field(Reflect.field(e, Std.string(i)), Std.string(0)).slice(0, Reflect.field(Reflect.field(e, Std.string(i)), Std.string(0)).length - 3);
                        for (n in Reflect.field(Reflect.field(e, Std.string(i)), Std.string(0)).length - 3...20)
                        {
                            tempText += ".";
                        }
                        for (n in as3hx.Compat.parseInt(Std.string(Reflect.field(Reflect.field(e, Std.string(i)), Std.string(1))).length)...10)
                        {
                            tempText += ".";
                        }
                        score = Std.string(Math.round(Reflect.field(Reflect.field(e, Std.string(i)), Std.string(1)) * 100) / 100);
                        if (score.indexOf(".") == -1)
                        {
                            score += ".00";
                        }
                        else if (score.length - score.indexOf(".") < 3)
                        {
                            score += "0";
                        }
                        tempText += score;
                    }
                    if (rem > 0)
                    {
                        tempText += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                        if (rem < 0.44)
                        {
                            tempText += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                        }
                    }
                    func(tempText);
                });
    }
    
    public static function addPuppet(peer : String) : Void
    {
        if (Char.CharN > 0 && !Char.getPuppet(Char.CharN - 1))
        {
            stageRoot.addChar(0, true);
            setupCharIcons();
            startControls();
        }
        Char.netMaster = netMaster = true;
    }
    
    @:allow()
    private static function getColorTransform(e : Dynamic) : Dynamic
    {
        var cT : Dynamic = new ColorTransform();
        if (e != -1)
        {
            cT.redOffset = Math.round(-(255 - Reflect.field(Reflect.field(PantsPallet, Std.string(e)), Std.string(0)) * 2.55));
            cT.greenOffset = Math.round(-(255 - Reflect.field(Reflect.field(PantsPallet, Std.string(e)), Std.string(1)) * 2.55));
            cT.blueOffset = Math.round(-(255 - Reflect.field(Reflect.field(PantsPallet, Std.string(e)), Std.string(2)) * 2.55));
        }
        return cT;
    }
    
    public static function pantsToHex(e : Dynamic) : Dynamic
    {
        var r : Int = 0;
        var g : Int = 0;
        var b : Int = 0;
        var rs : String = null;
        var gs : String = null;
        var bs : String = null;
        if (e == -1)
        {
            return "0xFFFFFF";
        }
        r = Math.round(Reflect.field(Reflect.field(PantsPallet, Std.string(e)), Std.string(0)) * 2.55);
        g = Math.round(Reflect.field(Reflect.field(PantsPallet, Std.string(e)), Std.string(1)) * 2.55);
        b = Math.round(Reflect.field(Reflect.field(PantsPallet, Std.string(e)), Std.string(2)) * 2.55);
        if (r == 0)
        {
            rs = "00";
        }
        else
        {
            rs = Std.string(r);
        }
        if (g == 0)
        {
            gs = "00";
        }
        else
        {
            gs = Std.string(g);
        }
        if (b == 0)
        {
            bs = "00";
        }
        else
        {
            bs = Std.string(b);
        }
        return "0x" + rs + gs + bs;
    }
    
    @:allow()
    private static function getTint(r : Dynamic, g : Dynamic, b : Dynamic) : Dynamic
    {
        var cT : ColorTransform = new ColorTransform();
        cT.redOffset = r * 255;
        cT.greenOffset = g * 255;
        cT.blueOffset = b * 255;
        return cT;
    }
    
    public static function leaveArcade() : Void
    {
        Char.CharArray[0].inkReserve = Char.CharArray[0].inkMax;
        LoadIt = "Villa0-b";
        DoorIt = 1;
        DirIt = "World 4";
        numPlayers = 1;
        Sounds.fadeOutMusic(Sounds.getMusic(LoadIt, 1));
    }
    
    public static function goFullscreen(sound : Bool = false) : Dynamic
    {
        var viewPortRectangle : Rectangle = new Rectangle();
        if (stageRoot.stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE)
        {
            stageRoot.stage.displayState = StageDisplayState.NORMAL;
            localSettings.fullscreen = stageRoot.isFullscreen = false;
            if (sound)
            {
                Sounds.playSoundSimple("UnPause");
            }
        }
        else
        {
            localSettings.fullscreen = stageRoot.isFullscreen = true;
            stageRoot.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            if (sound)
            {
                Sounds.playSoundSimple("Pause");
            }
        }
        stageRoot.stage.focus = stageRoot.stage;
    }
    
    private static function changeRes(ex : Dynamic, ey : Dynamic) : Dynamic
    {
        rootHUD.HUD.scaleX = ex / 800;
        rootHUD.HUD.scaleY = ey / 500;
        bitRes = 1.2;
        StarlingBackgrounds.bitRes = bitRes;
        if (PauseMenu.pausemenu != null)
        {
            PauseMenu.pausemenu.scaleX = rootHUD.HUD.scaleX;
            PauseMenu.pausemenu.scaleY = rootHUD.HUD.scaleY;
        }
        if (FadeClip != null)
        {
            FadeClip.x = Math.round(ex) * 0.5;
            FadeClip.y = Math.round(ey) * 0.5;
            FadeClip.scaleX = rootHUD.HUD.scaleX;
            FadeClip.scaleY = rootHUD.HUD.scaleY;
        }
        rootHUD.HUD.overRatio = Char.overRatio = overRatio = ey / (relativeStageY * 2);
        relativeStageX = as3hx.Compat.parseInt(relativeStageY * (ex / ey));
        Char.realStageX = StarlingBackgrounds.realStageX = stageX = originalStageX = realStageX = as3hx.Compat.parseInt(Math.round(ex) * 0.5);
        Char.realStageY = StarlingBackgrounds.realStageY = stageY = originalStageY = realStageY = as3hx.Compat.parseInt(Math.round(ey) * 0.5);
        ng_medalPopup.x = Math.round(ex) - 250;
        setMaxZ();
        StarlingBackgrounds.resizeStaticBack(originalStageX / 400, originalStageY / 250);
        StarlingBackgrounds.resizeVolcano(originalStageX / 400, originalStageY / 250);
        if (LevelLoaded == "MapScreen")
        {
            MapClip.x = realStageX;
            MapClip.y = realStageY;
            MapClip.scaleX = MapClip.scaleY = overRatio;
        }
        if (Char.CharArray.length > 0)
        {
            StarlingBackgrounds.setBlur(Char.CharArray[0].onRail, true);
        }
        WarpBox.resetCameras();
        if (gameMode == "vase")
        {
            cameraX = tempCameraX;
            cameraY = tempCameraY;
            stageRoot.scrollEverything();
            cameraX = cameraY = 0;
            Char.CharArray[0].parent.x = realStageX;
            Char.CharArray[0].parent.y = realStageY - 60;
            Char.CharArray[0].ratio = cameraFocalLength / (cameraFocalLength + 33.33 + (backgroundsN - backgroundsN) * 10);
            rootRatios[backgroundsN] = Char.CharArray[0].ratio * overRatio;
            stageXs[backgroundsN] = originalStageX;
            stageYs[backgroundsN] = originalStageY;
            Char.CharArray[0].parent.scaleX = Char.CharArray[0].parent.scaleY = rootRatios[backgroundsN];
            Backgrounds.backgroundsArray[backgroundsN].x = realStageX;
            Backgrounds.backgroundsArray[backgroundsN].y = realStageY - 60;
            Backgrounds.backgroundsArray[backgroundsN].scaleX = Backgrounds.backgroundsArray[backgroundsN].scaleY = rootRatios[backgroundsN];
            StarlingBackgrounds.BackgroundObjArray[backgroundsN].x = StarlingBackgrounds.BackgroundArray[backgroundsN].x = realStageX;
            StarlingBackgrounds.BackgroundObjArray[backgroundsN].y = StarlingBackgrounds.BackgroundArray[backgroundsN].y = realStageY - 60;
            StarlingBackgrounds.BackgroundObjArray[backgroundsN].scaleX = StarlingBackgrounds.BackgroundArray[backgroundsN].scaleX = rootRatios[backgroundsN];
            StarlingBackgrounds.BackgroundObjArray[backgroundsN].scaleY = StarlingBackgrounds.BackgroundArray[backgroundsN].scaleY = rootRatios[backgroundsN];
        }
        else
        {
            stageRoot.scrollEverything();
        }
    }
    
    private static function pauseTouchscreen(canUnpause : Bool) : Void
    {
        if (isTouchScreen)
        {
            if (rootHUD.HUD.isReallyMobile)
            {
                stageRoot.stage.addEventListener(TouchEvent.TOUCH_BEGIN, stageRoot.clickPauseMenu);
                stageRoot.stage.addEventListener(TouchEvent.TOUCH_END, stageRoot.mouseUp);
            }
            else
            {
                stageRoot.stage.addEventListener(MouseEvent.MOUSE_DOWN, stageRoot.clickPauseMenu);
            }
        }
        else if (canUnpause)
        {
            stageRoot.stage.addEventListener(KeyboardEvent.KEY_DOWN, stageRoot.getKeysUnPause);
            stageRoot.stage.addEventListener(KeyboardEvent.KEY_UP, stageRoot.getKeysUp);
        }
        else
        {
            stageRoot.stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageRoot.mouseDown);
        }
    }
    
    private static function unpauseTouchscreen() : Void
    {
        if (isTouchScreen)
        {
            if (rootHUD.HUD.isReallyMobile)
            {
                stageRoot.stage.removeEventListener(TouchEvent.TOUCH_BEGIN, stageRoot.clickPauseMenu);
                stageRoot.stage.removeEventListener(TouchEvent.TOUCH_END, stageRoot.mouseUp);
            }
            else
            {
                stageRoot.stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageRoot.clickPauseMenu);
            }
        }
        else
        {
            stageRoot.stage.removeEventListener(KeyboardEvent.KEY_DOWN, stageRoot.getKeysUnPause);
            stageRoot.stage.removeEventListener(KeyboardEvent.KEY_UP, stageRoot.getKeysUp);
        }
    }
    
    public static function setArcadeControls() : Void
    {
        if (isTouchScreen)
        {
            killControls();
            if (rootHUD.HUD.isReallyMobile)
            {
                stageRoot.stage.addEventListener(TouchEvent.TOUCH_END, stageRoot.touchArcade);
            }
            else
            {
                stageRoot.stage.addEventListener(MouseEvent.MOUSE_UP, stageRoot.touchArcade);
            }
        }
    }
    
    public static function removeArcadeControls() : Void
    {
        if (isTouchScreen)
        {
            startControls();
            if (rootHUD.HUD.isReallyMobile)
            {
                stageRoot.stage.removeEventListener(TouchEvent.TOUCH_END, stageRoot.touchArcade);
            }
            else
            {
                stageRoot.stage.removeEventListener(MouseEvent.MOUSE_UP, stageRoot.touchArcade);
            }
        }
    }
    
    @:allow()
    private static function PauseGame(canUnpause : Bool, char : Int) : Void
    {
        if (Char.CharArray[char].health <= 0)
        {
            return;
        }
        Sounds.playSoundSimple("Pause");
        Char.pauseCurrentLoop();
        Sounds.pauseSuperLoop();
        System.gc();
        pauseStatus = "Menu";
        PauseMenu.showPause(char);
        stageRoot.removeEventListener(Event.ENTER_FRAME, stageRoot.MainEnterFrame60);
        stageRoot.addEventListener(Event.ENTER_FRAME, stageRoot.PauseEnterFrame);
        Sounds.pauseMusic();
        killControls();
        pauseTouchscreen(canUnpause);
    }
    
    @:allow()
    private static function unPauseGame() : Dynamic
    {
        Sounds.playSoundSimple("UnPause");
        PauseMenu.pausemenu.settings();
        Sounds.unPauseSuperLoop();
        sendSessions();
        pauseStatus = "nothing";
        PauseMenu.destroy();
        stageRoot.removeEventListener(Event.ENTER_FRAME, stageRoot.PauseEnterFrame);
        stageRoot.addEventListener(Event.ENTER_FRAME, stageRoot.MainEnterFrame60);
        unpauseTouchscreen();
        if (LoadIt != "LevelSelect" && LoadIt != "MapScreen")
        {
            Sounds.resumeMusic();
            if (stageRoot.fadingMusic)
            {
                Sounds.musicEnterFrame();
            }
            startControls();
        }
    }
    
    public static function TutorialGame(pause : Bool, frame : Int = 1) : Void
    {
        Char.pauseCurrentLoop();
        if (pauseStatus == "Menu")
        {
            stageRoot.removeEventListener(Event.ENTER_FRAME, stageRoot.PauseEnterFrame);
        }
        else
        {
            if (Char.CharArray[0].JumpIsDown())
            {
                stageRoot.SpaceIsDown = true;
            }
            stageRoot.removeEventListener(Event.ENTER_FRAME, stageRoot.MainEnterFrame60);
            Sounds.pauseMusic();
            killControls();
            pauseTouchscreen(true);
        }
        stageRoot.addEventListener(Event.ENTER_FRAME, stageRoot.TutorialEnterFrame);
        pauseStatus = "tutorial";
        myTutorialPopup = new TutorialPopup(realStageX, realStageY, overRatio, frame);
        stageRoot.addChild(myTutorialPopup);
    }
    
    @:allow()
    private static function KeyGame() : Dynamic
    {
        pauseStatus = "Key";
        if (stageRoot.stage.loaderInfo.url.indexOf("kongregate.com") > -1)
        {
            stageRoot.addChild(new KeyMenu());
        }
        else
        {
            stageRoot.addChild(new KeyMenuBG());
        }
        stageRoot.removeEventListener(Event.ENTER_FRAME, stageRoot.MainEnterFrame60);
        stageRoot.addEventListener(Event.ENTER_FRAME, stageRoot.PauseEnterFrame);
        stageRoot.stage.addEventListener(KeyboardEvent.KEY_DOWN, stageRoot.getKeysUnPause);
        sendAnalytics("clicked_" + keyMessage);
        if (Sounds.musicVol > 0)
        {
            Sounds.pausedBackgroundPosition = Sounds.BackgroundChannel.position;
            Sounds.BackgroundChannel.stop();
        }
        killControls();
        stageRoot.stage.addEventListener(KeyboardEvent.KEY_UP, stageRoot.getKeysUp);
    }
    
    @:allow()
    private static function unKeyGame() : Dynamic
    {
        pauseStatus = "nothing";
        KeyMenu.destroy();
        stageRoot.removeEventListener(Event.ENTER_FRAME, stageRoot.PauseEnterFrame);
        stageRoot.addEventListener(Event.ENTER_FRAME, stageRoot.MainEnterFrame60);
        stageRoot.stage.removeEventListener(KeyboardEvent.KEY_DOWN, stageRoot.getKeysUnPause);
        if (Sounds.musicVol > 0)
        {
            Sounds.BackgroundChannel = Sounds.BackgroundMusic.play(0, 1000);
            Sounds.BackgroundChannel.soundTransform = new SoundTransform(Sounds.musicVol);
        }
        startControls();
    }
    
    @:allow()
    private static function startControls(start : Bool = false) : Dynamic
    {
        if (isTouchScreen)
        {
            stageRoot.startTouchControls();
        }
        else
        {
            stageRoot.stage.addEventListener(KeyboardEvent.KEY_DOWN, stageRoot.getKeysDown);
            stageRoot.stage.addEventListener(KeyboardEvent.KEY_UP, stageRoot.getKeysUp);
        }
    }
    
    @:allow()
    private static function killControls(full : Bool = false) : Dynamic
    {
        if (isTouchScreen)
        {
            stageRoot.killTouchControls();
        }
        else
        {
            stageRoot.stage.removeEventListener(KeyboardEvent.KEY_DOWN, stageRoot.getKeysDown);
            stageRoot.stage.removeEventListener(KeyboardEvent.KEY_UP, stageRoot.getKeysUp);
        }
        for (i in 0...Char.CharArray.length)
        {
            Char.CharArray[i].resetAllControls();
        }
    }
    
    public static function switchTouchscreen(e : Bool) : Void
    {
        if (e && deviceID == "iPhone")
        {
            stageRoot.superOffset = 30;
        }
        else
        {
            stageRoot.superOffset = 0;
        }
    }
    
    private static function clearAllOnRail(rail : Dynamic) : Dynamic
    {
        Baddies.clearAllBaddiesOnRail(rail);
        InteractObjects.clearAllInteracts();
        staticInteractObjects.clearAllInteractsOnRail(rail);
    }
    
    public static function FadeItOut(load : String, door : Int = 0) : Dynamic
    {
        boundsShiftX = boundsShiftY = 0;
        FadeClip = new FadeOut(load, door);
        stageRoot.addChild(FadeClip);
        Sounds.fadeOutMusic(Sounds.getMusic(load, door));
    }
    
    public static function FadeItOutWhite(load : String, door : Int = 0) : Dynamic
    {
        boundsShiftX = boundsShiftY = 0;
        FadeClip = new FadeOutWhite(load, door);
        stageRoot.addChild(FadeClip);
        Sounds.fadeOutMusic(Sounds.getMusic(load, door));
    }
    
    public static function FadeItBlack(load : Dynamic, door : Dynamic) : Dynamic
    {
        LoadIt = load;
        DoorIt = door;
    }
    
    public static function enterVase(char : Dynamic, box : Dynamic) : Dynamic
    {
        var cardBack : MovieClip = null;
        var i : Int = 0;
        gameMode = "vase";
        if (char.onRail < backgroundsN)
        {
            char.onRail = backgroundsN;
            boxception = [];
        }
        else
        {
            ++char.onRail;
        }
        boxception.push(box);
        stageRoot.scrollEngine = stageRoot.scrollInVase;
        rootRatios[backgroundsN] = 0.75 * overRatio;
        stageXs[char.onRail] = originalStageX;
        stageYs[char.onRail] = originalStageY;
        tempCameraX = cameraX;
        tempCameraY = cameraY - stageRoot.superOffset;
        cameraX = cameraY = 0;
        var platformsClass : Class<Dynamic> = Type.getClass(Type.resolveClass("boxPlatforms" + Std.string(box.superID)));
        var boxPlatforms : Sprite = Type.createInstance(platformsClass, []);
        AllEverything.addChild(boxPlatforms);
        AllEverything["platforms" + char.onRail] = boxPlatforms;
        AllEverything.addChild(boxPlatforms);
        var wallsClass : Class<Dynamic> = Type.getClass(Type.resolveClass("boxWalls" + Std.string(box.superID)));
        var boxWalls : Sprite = Type.createInstance(wallsClass, []);
        AllEverything.addChild(boxWalls);
        AllEverything["walls" + char.onRail] = boxWalls;
        var groundClass : Class<Dynamic> = Type.getClass(levelClasses.getDefinition("boxGround" + Std.string(box.superID)));
        var boxGround : Sprite = Type.createInstance(groundClass, []);
        AllEverything.addChild(boxGround);
        AllEverything["ground" + char.onRail] = boxGround;
        var interactClass : Class<Dynamic> = Type.getClass(Type.resolveClass("boxInteract" + Std.string(box.superID)));
        var boxInteract : Sprite = Type.createInstance(interactClass, []);
        AllEverything.addChild(boxInteract);
        AllEverything["interact" + char.onRail] = boxInteract;
        var baddiesClass : Class<Dynamic> = Type.getClass(Type.resolveClass("boxBaddies" + Std.string(box.superID)));
        var boxBaddies : Sprite = Type.createInstance(baddiesClass, []);
        AllEverything.addChild(boxBaddies);
        AllEverything["baddies" + char.onRail] = boxBaddies;
        char.inVase = box;
        char.parent.x = realStageX;
        char.parent.y = realStageY - 60;
        char.ratio = cameraFocalLength / (cameraFocalLength + 33.33 + (char.onRail - backgroundsN) * 10);
        char.parent.scaleX = char.parent.scaleY = rootRatios[backgroundsN];
        char.x = 0;
        char.lastY = char.y = -(relativeStageY + 80);
        char.fakeRL = char.moveRL = 0;
        char.hitPause = 15;
        char.Jumper = -20;
        char.scaleX = 1;
        char.platforms = AllEverything["platforms" + char.onRail];
        char.walls = AllEverything["walls" + char.onRail];
        char.ground = AllEverything["ground" + char.onRail];
        char.gotoBuffer = "Jump";
        b = 5;
        var back : Backgrounds = new Backgrounds(false);
        stageRoot.addChild(back);
        StarlingBackgrounds.addBackground(char.onRail);
        back.scaleX = back.scaleY = rootRatios[backgroundsN];
        back.alpha = 0;
        back.x = char.parent.x;
        back.y = char.parent.y;
        StarlingBackgrounds.BackgroundObjArray[char.onRail].x = StarlingBackgrounds.BackgroundArray[char.onRail].x = char.parent.x;
        StarlingBackgrounds.BackgroundObjArray[char.onRail].y = StarlingBackgrounds.BackgroundArray[char.onRail].y = char.parent.y;
        StarlingBackgrounds.BackgroundObjArray[char.onRail].scaleX = StarlingBackgrounds.BackgroundArray[char.onRail].scaleX = rootRatios[backgroundsN];
        StarlingBackgrounds.BackgroundObjArray[char.onRail].scaleY = StarlingBackgrounds.BackgroundArray[char.onRail].scaleY = rootRatios[backgroundsN];
        StarlingBackgrounds.BackgroundObjArray[char.onRail].alpha = StarlingBackgrounds.BackgroundArray[char.onRail].alpha = 0;
        var cardbackClass : Class<Dynamic> = Type.getClass(Type.resolveClass("cardboardBackground" + localSettings.language));
        cardBack = Type.createInstance(cardbackClass, []);
        cardBack.gotoAndStop(box.superID + 1);
        var bitmapData : BitmapData = new BitmapData((realStageX * 2 + 20) / back.scaleX, (realStageY * 2 + 150) / back.scaleY, true, 0);
        bitmapData.draw(cardBack, new Matrix(1, 0, 0, 1, (realStageX + 10) / back.scaleX, (realStageY + 10) / back.scaleY));
        StarlingBackgrounds.addBitmap(bitmapData, StarlingBackgrounds.BackgroundArray[char.onRail], -(realStageX + 10) / back.scaleX, -(realStageY + 10) / back.scaleY, 1);
        bitmapData.dispose();
        stageRoot.addChild(char.parent);
        populateBox(char.onRail);
        stageRoot.addChild(rootHUD.HUD);
        if (box.superID == 0)
        {
            rootHUD.spawnUpgradePanel();
        }
        for (i in Reflect.fields(staticInteractObjects.InteractArray))
        {
            if (staticInteractObjects.InteractArray[i].ItIs == "Door")
            {
                if (staticInteractObjects.InteractArray[i].onRail == char.onRail && staticInteractObjects.InteractArray[i].ID == 0)
                {
                    char.lastX = char.x = staticInteractObjects.InteractArray[i].x - char.ID * 60 + (Char.CharN - 1) * 30;
                }
            }
        }
        for (i in 0...Char.ActiveCharArray.length)
        {
            Char.ActiveCharArray[i].AllInBox(char);
        }
    }
    
    public static function exitVase(char : Dynamic) : Dynamic
    {
        gameMode = "outVase";
        if (AllEverything["ground" + char.onRail].parent == null)
        {
            ;
        }
        else
        {
            AllEverything["ground" + char.onRail].parent.removeChild(AllEverything["ground" + char.onRail]);
        }
        if (AllEverything["walls" + char.onRail].parent == null)
        {
            ;
        }
        else
        {
            AllEverything["walls" + char.onRail].parent.removeChild(AllEverything["walls" + char.onRail]);
        }
        if (AllEverything["platforms" + char.onRail].parent == null)
        {
            ;
        }
        else
        {
            AllEverything["platforms" + char.onRail].parent.removeChild(AllEverything["platforms" + char.onRail]);
        }
        for (i in 0...Char.ActiveCharArray.length)
        {
            if (Char.ActiveCharArray[i].onRail == backgroundsN)
            {
                Char.ActiveCharArray[i].onRail = 0;
            }
            else
            {
                --Char.ActiveCharArray[i].onRail;
            }
            Char.ActiveCharArray[i].Status = "enterBox";
            Char.ActiveCharArray[i].ground = Main.AllEverything["ground" + char.onRail];
            Char.ActiveCharArray[i].platforms = Main.AllEverything["platforms" + char.onRail];
            Char.ActiveCharArray[i].walls = Main.AllEverything["walls" + char.onRail];
            Char.ActiveCharArray[i].x = boxception[boxception.length - 1].x;
            Char.ActiveCharArray[i].y = boxception[boxception.length - 1].y;
        }
        cameraX = tempCameraX;
        cameraY = tempCameraY;
        rootHUD.removeUpgradePanel();
        InteractObjects.clearIceCream();
        b = 2;
        stageRoot.scrollEngine = stageRoot.scrollOutVase;
        char.parent.visible = false;
    }
    
    public static function getOutOfBox() : Void
    {
        for (i in 0...Char.ActiveCharArray.length)
        {
            if (Char.ActiveCharArray[i].onRail < backgroundsN)
            {
                Char.ActiveCharArray[i].parent.x = originalStageX - rootX * Char.ActiveCharArray[i].ratio * overRatio;
                Char.ActiveCharArray[i].parent.y = originalStageY - rootY * Char.ActiveCharArray[i].ratio * overRatio;
                Char.ActiveCharArray[i].parent.scaleX = Char.ActiveCharArray[i].parent.scaleY = Char.ActiveCharArray[i].ratio * overRatio;
            }
            else
            {
                Char.ActiveCharArray[i].parent.scaleX = Char.ActiveCharArray[i].parent.scaleY = cameraFocalLength / (cameraFocalLength + 33.33 + (Char.ActiveCharArray[i].onRail - backgroundsN) * 10);
            }
            Char.ActiveCharArray[i].parent.visible = true;
        }
        clearAllOnRail(Backgrounds.backgroundsArray.length - 1);
        Backgrounds.flushOne(Backgrounds.backgroundsArray.length - 1);
        Backgrounds.backgroundsArray.pop();
        StarlingBackgrounds.removeOneBackground(StarlingBackgrounds.BackgroundArray.length - 1);
    }
    
    public static function cutieRunEnd() : Void
    {
        boundsShiftX = 1;
        MaxX = originalMaxX;
        lockShift = false;
        Char.CharArray[0].Still = false;
        Char.CharArray[0].x = 82;
    }
    
    public static function setUseNodes(e : Bool) : Void
    {
        Char.useNodes = stageRoot.useNodes = e;
    }
    
    public static function gotCatDown() : Dynamic
    {
    }
    
    @:allow()
    private static function popBetween(char : Dynamic, bad : Dynamic, scale : Float = 1) : Dynamic
    {
        StarlingEffect.Spawn("popEffect", (char.x + bad.x) / 2, (char.y + bad.y) / 2, Math.random() * 3, scale, 0, 0, char.onRail);
    }
    
    public static function easeInOut(t : Dynamic, b : Dynamic, c : Dynamic, d : Dynamic) : Dynamic
    {
        t /= d;
        return c * t * t + b;
    }
    
    public static function limitVar(e : Float, limit : Float) : Float
    {
        if (Math.abs(e) > limit)
        {
            return limit * e / Math.abs(e);
        }
        return e;
    }
    
    public static function makeOne(e : Dynamic) : Int
    {
        if (e == 0)
        {
            return 0;
        }
        return as3hx.Compat.parseInt(e / Math.abs(e));
    }
    
    public static function buyAKey(key : Dynamic) : Dynamic
    {
        if (onSite == "Kongregate")
        {
            if (daParameters.kongregate_api_path == null)
            {
                launchURL("http://www.kongregate.com?haref=fpa_remix&src=spon&cm=fpa_remix");
            }
            else if (memberDisplay == "Guest")
            {
                kongregate.services.showRegistrationBox();
            }
            else
            {
                keyToBuy = key;
                kongregate.mtx.purchaseItems([key], onPurchaseResult);
            }
        }
        else if (onSite == "BorneGames")
        {
            if (member != "Local")
            {
                if (member == "not_logged_in_BG")
                {
                    launchURL("http://www.bornegames.com/blog/wp-login.php?action=register");
                }
                else
                {
                    ExternalInterface.call("openURL", "http://bornegames.com/paypal/purchaseKey.php?user=" + member + "&key=" + key);
                }
            }
        }
        else
        {
            launchURL("http://www.kongregate.com/games/DrNeroCF/fpa-world-1-remix");
        }
    }
    
    private static function getThatKey(e : Dynamic) : Dynamic
    {
        rootHUD.HUD.debug.text += "\n " + e;
        var userHadKey : Bool = cast(userHasKey, Bool);
        if (e == "key")
        {
            rootHUD.HUD.keySwitch.gotoAndStop(5);
            userHasKey = true;
            if (rootHUD.HUD.keySwitch.key.currentFrame == 1)
            {
                rootHUD.HUD.keySwitch.key.gotoAndStop(1);
            }
        }
        else if (e == "fancykey")
        {
            rootHUD.HUD.keySwitch.gotoAndStop(5);
            userHasKey = true;
            if (rootHUD.HUD.keySwitch.key.currentFrame < 2)
            {
                rootHUD.HUD.keySwitch.key.gotoAndStop(2);
            }
        }
        else if (e == "silverkey")
        {
            rootHUD.HUD.keySwitch.gotoAndStop(5);
            userHasKey = true;
            if (rootHUD.HUD.keySwitch.key.currentFrame < 3)
            {
                rootHUD.HUD.keySwitch.key.gotoAndStop(3);
            }
        }
        else if (e == "goldkey")
        {
            rootHUD.HUD.keySwitch.gotoAndStop(5);
            userHasKey = true;
            if (rootHUD.HUD.keySwitch.key.currentFrame < 4)
            {
                rootHUD.HUD.keySwitch.key.gotoAndStop(4);
            }
        }
        else if (e == "platinumkey")
        {
            rootHUD.HUD.keySwitch.gotoAndStop(5);
            userHasKey = true;
            if (rootHUD.HUD.keySwitch.key.currentFrame < 5)
            {
                rootHUD.HUD.keySwitch.key.gotoAndStop(5);
            }
        }
        else if (e == "extrafancykey")
        {
            rootHUD.HUD.keySwitch.gotoAndStop(5);
            userHasKey = true;
            rootHUD.HUD.keySwitch.key.gotoAndStop(6);
        }
        else
        {
            rootHUD.HUD.keySwitch.gotoAndStop(keyMessage);
        }
        if (!userHadKey && cast(userHasKey, Bool))
        {
            if (LevelLoaded.substr(0, 5) == "Lockd")
            {
                stageRoot.refreshLevel();
                quickResetLevel = true;
            }
        }
    }
    
    public static function onPurchaseResult(result : Dynamic) : Dynamic
    {
        rootHUD.HUD.debug.text += "\n Purchase success:" + result.success;
        unKeyGame();
        if (result.success)
        {
            rootHUD.spawnPopup("You have a key, thank you!");
            parse_saveKey(keyToBuy, keyMessage);
            getThatKey(keyToBuy);
            keyMessage = "stay_fancy";
        }
        else
        {
            rootHUD.HUD.keySwitch.gotoAndStop(keyMessage);
        }
        keyToBuy = "nothing";
    }
    
    public static function sendSessions() : Dynamic
    {
        if (baddiesSession > 0)
        {
            kongStats("baddiesStomped", baddiesSession);
            baddiesSession = 0;
        }
        if (squigglesSession > 0)
        {
            kongStats("squigglesGot", squigglesSession);
            squigglesSession = 0;
        }
        if (rockonsSession > 0)
        {
            kongStats("rockons", rockonsSession);
            rockonsSession = 0;
        }
    }
    
    public static function achievement(e : Dynamic) : Void
    {
    }
    
    public static function kongStats(stat : String, e : Int) : Dynamic
    {
    }
    
    private function oldcontrollerAdded(e : GameInputEvent) : Dynamic
    {
        var i : Int = 0;
        trace(e.device.name + " added");
        Reflect.setField(gamepadObject, Std.string(e.device.id), {
            binded : false,
            reference : e.device,
            myChar : null,
            padRange : 0.2,
            hasAnalog : false,
            hasDpad : false,
            controls : [],
            isWiimote : false
        });
        this.checkGamepadConfig(e.device);
        if (Char.CharN > 0)
        {
            if (GameInput.numDevices <= Char.CharN)
            {
                for (i in 0...Char.CharArray.length)
                {
                    if (!Char.CharArray[i].hasGamepad)
                    {
                        Char.CharArray[i].addGamepad(e.device.id);
                        break;
                    }
                }
            }
            else
            {
                if (Char.CharArray[0].gamepadID != e.device.id)
                {
                    Reflect.setField(gamepadObject, Std.string(Char.CharArray[0].gamepadID), false).binded;
                    Reflect.setField(gamepadObject, Std.string(Char.CharArray[0].gamepadID), null).myChar;
                }
                Char.CharArray[0].addGamepad(e.device.id);
            }
        }
    }
    
    private function onGamepadAxisX(e : Event) : Dynamic
    {
        parent.axis.x = 50 + e.target.value * 30;
    }
    
    private function onGamepadAxisY(e : Event) : Dynamic
    {
        parent.axis.y = 150 + e.target.value * 30;
    }
    
    private function onGamepadUpdate(e : Event) : Void
    {
        if (e.target.value == 0)
        {
            parent.showGamepad.gotoAndStop(1);
        }
        else
        {
            parent.showGamepad.gotoAndStop(2);
        }
    }
    
    private function oldcontrollerRemoved(e : GameInputEvent) : Dynamic
    {
        var prop : String = null;
        var propception : String = null;
        trace("A Controller Was Removed");
        for (prop in Reflect.fields(gamepadObject))
        {
            if (!Reflect.field(gamepadObject, prop).reference.enabled)
            {
                if (Reflect.field(gamepadObject, prop).myChar != null)
                {
                    Reflect.field(gamepadObject, prop).myChar.removeGamepad();
                    Reflect.setField(gamepadObject, prop, false).binded;
                    for (propception in Reflect.fields(gamepadObject))
                    {
                        if (prop != propception)
                        {
                            if (!Reflect.field(gamepadObject, propception).binded)
                            {
                                Reflect.field(gamepadObject, prop).myChar.addGamepad(propception);
                            }
                            break;
                        }
                    }
                }
                Reflect.deleteField(gamepadObject, prop);
            }
        }
    }
    
    private function checkGamepadConfig(pad : Dynamic) : Bool
    {
        if (shared.data.controllers[pad.name] != null)
        {
            Reflect.setField(gamepadObject, Std.string(pad.id), shared.data.controllers[pad.name].controls).controls;
            Reflect.setField(gamepadObject, Std.string(pad.id), shared.data.controllers[pad.name].padRange).padRange;
        }
        else if (pad.name.substr(0, 7) == "Wiimote" && false)
        {
            Reflect.setField(gamepadObject, Std.string(pad.id), 0.8).padRange;
            Reflect.setField(gamepadObject, Std.string(pad.id), [0, 1, 7, 6, 8, 9, 15, 16, 12]).controls;
            Reflect.setField(gamepadObject, Std.string(pad.id), true).isWiimote;
        }
        else
        {
            if (pad.name == "Pro Controller")
            {
                Reflect.setField(gamepadObject, Std.string(pad.id), 0.7).padRange;
            }
            else
            {
                Reflect.setField(gamepadObject, Std.string(pad.id), 1).padRange;
            }
            Reflect.setField(gamepadObject, Std.string(pad.id), setupGamepad.getLayout(pad.name)).controls;
        }
        if (Reflect.field(gamepadObject, Std.string(pad.id)).controls.length == 0)
        {
            return false;
        }
        Reflect.setField(gamepadObject, Std.string(pad.id), Reflect.field(gamepadObject, Std.string(pad.id)).controls[0] != null).hasAnalog;
        Reflect.setField(gamepadObject, Std.string(pad.id), Reflect.field(gamepadObject, Std.string(pad.id)).controls[5] != null).hasDpad;
        Reflect.setField(gamepadObject, Std.string(pad.id), true).reference.enabled;
        return true;
    }
    
    private function getBackgroundZs(level : Dynamic, door : Dynamic) : Dynamic
    {
        if (DirIt == "World 1")
        {
            if (level == "Bonus4")
            {
                zOffset = -20;
            }
            else if (level == "Level7")
            {
                zOffset = -10;
            }
            else
            {
                zOffset = 0;
            }
        }
        else if (level == "Menus0-a")
        {
            zOffset = -10;
        }
        else if (deviceID == "iPad")
        {
            zOffset = -20;
        }
        else if (deviceID == "iPhone")
        {
            zOffset = 5;
        }
        else
        {
            zOffset = -20;
        }
        vOffset = 40;
        foreRes = 1;
        this.volcanoY = 0;
        this.blurOffset = 1;
        this.blurStrength = 2;
        Char.forceBitmap = false;
        backRes = 0.5;
        uberSpacing = 0;
        uberRes = 1;
        if (DirIt == "World 1")
        {
            if (level == "Bonus12")
            {
                backgroundZs = [0, 75, 200];
            }
            else if (level == "Trans1W4")
            {
                backgroundZs = [0, 50, 150, 300];
            }
            else if (level == "Lockd4")
            {
                backgroundZs = [0, 40, 120, 300];
            }
            else if (level == "Menus0" || level == "Menus0Clean" || level == "Menus1" || level == "Menus3")
            {
                backgroundZs = [0, 75, 300];
            }
            else if (level == "Lockd3")
            {
                backgroundZs = [0, 150];
            }
            else
            {
                backgroundZs = [0, 100];
            }
            if (level == "Lockd3")
            {
                Char.forceBitmap = true;
            }
        }
        else if (DirIt == "Arcade")
        {
            switch (level)
            {
                case "Arena0":
                    backgroundZs = [0, 300];
                case "Races5":
                    backgroundZs = [0, 60, 200, 600];
                    StarlingBackgrounds.depthOfField = true;
                    StarlingBackgrounds.depthOfFieldCache = false;
                    backRes = 1;
                default:
                    backgroundZs = [0, 100];
            }
        }
        else if (DirIt == "Extra")
        {
            backgroundZs = [0, 50, 150, 300];
            StarlingBackgrounds.depthOfField = false;
            StarlingBackgrounds.depthOfFieldCache = false;
            backRes = 1;
        }
        else if (DirIt == "Custom")
        {
            backgroundZs = AllEverything.backgroundZs;
        }
        else
        {
            if (false && level.substr(5, 1) == "1" && level.substr(0, 5) == "Level")
            {
                backgroundZs = [0, 20, 150, 600];
            }
            else if (level.substr(5, 1) == "3" && level != "Bonus3-h")
            {
                if (level == "Bonus3-c" || level == "Bonus3-d" || level == "Bonus3-f" || level == "Bonus3-g")
                {
                    backgroundZs = [0, 125];
                }
                else if (level == "Bonus3-e")
                {
                    backgroundZs = [0, 60, 125];
                }
                else if (level.substr(0, 5) == "Bonus")
                {
                    backgroundZs = [0, 100, 200, 400];
                }
                else if (level == "Level3-a")
                {
                    backgroundZs = [0, 10, 600, 1500, 2000];
                }
                else if (level == "Level3-h")
                {
                    backgroundZs = [0, 60, 200, 600];
                }
                else if (level == "Level3-j")
                {
                    backgroundZs = [0, 20, 100, 400];
                }
                else
                {
                    backgroundZs = [0, 100, 300, 600];
                }
            }
            else if (level.substr(5, 1) == "4" && level != "Level4-g" && level != "Level4-h")
            {
                if (level.substr(0, 5) == "Bonus")
                {
                    backgroundZs = [0, 125];
                }
                else
                {
                    backgroundZs = [0, 60, 100, 200];
                }
            }
            else
            {
                switch (level)
                {
                    case "Troll1", "Races1":
                        backgroundZs = [0, 150];
                    case "Arena0":
                        backgroundZs = [0, 175];
                    case "Arena1":
                        backgroundZs = [0, 175];
                    case "Tutor1", "Bonus2":
                        backgroundZs = [0, 40, 120, 300];
                    case "Tests3":
                        backgroundZs = [0];
                        zOffset = -30;
                    case "Level1-a", "Level1-c", "Level1-k", "Villa0-c", "Villa0-d":
                        backgroundZs = [0, 50, 200, 600];
                    case "Level1-b":
                        backgroundZs = [0, 10, 50, 300, 600];
                    case "Level1-d":
                        backgroundZs = [0, 75, 400, 1000];
                    case "Level1-e", "Level1-f", "Level1-g", "Level1-h":
                        backgroundZs = [0, 15, 80, 250];
                    case "Level1-i":
                        backgroundZs = [0, 20, 100, 200];
                    case "Level1-j":
                        backgroundZs = [0, 30, 100, 200];
                    case "Level1W4", "Tutor2", "Tutor2-a", "Tests2", "Level1", "Level1-h", "Level3":
                        backgroundZs = [0, 60, 200, 600];
                    case "Level2-j", "Trans1":
                        backgroundZs = [0, 50, 150, 300];
                    case "Level4":
                        backgroundZs = [600, 400, 120, 20];
                    case "Level7":
                        backgroundZs = [0, 50, 150, 300];
                    case "Level8":
                        backgroundZs = [0, 100];
                    case "Dared1":
                        backgroundZs = [0, 50, 150, 300];
                    case "Dared2":
                        backgroundZs = [20, 50, 150, 300];
                    case "Dared3":
                        backgroundZs = [0];
                    case "Level0-a", "Menus0-a":
                        backgroundZs = [0, 10, 500, 1000, 3000];
                    case "Menus1-a":
                        backgroundZs = [0, 10, 500, 1000];
                    case "Level0-b":
                        backgroundZs = [0, 5, 15, 30];
                        backgroundZAdd(50, 30, 5);
                    case "Villa0-a":
                        backgroundZs = [-40, 0, 50, 150, 250, 400];
                    case "Villa0-b":
                        backgroundZs = [0, 10, 50, 300];
                    case "Level2-a":
                        backgroundZs = [0, 20, 35, 150];
                    case "Level2-b":
                        backgroundZs = [0, 20, 100, 400];
                    case "Level2-c", "Villa0-e":
                        backgroundZs = [0, 30, 100, 300];
                    case "Level2-d":
                        backgroundZs = [0, 50, 200, 400];
                    case "Level2-e":
                        backgroundZs = [0, 30, 120, 500];
                    case "Level2-f", "Level2-h":
                        backgroundZs = [0, 100, 300, 600];
                    case "Level2-g":
                        backgroundZs = [0, 50, 200, 400];
                    case "Level2-i", "Level2-j":
                        backgroundZs = [0, 15, 40, 120];
                    case "Level0-c":
                        backgroundZs = [0, 20, 60, 200];
                    case "Level0-i":
                        backgroundZs = [0, 20, 60, 150, 250];
                    case "Level0-d":
                        backgroundZs = [0, 10, 60, 120, 500, 2000, 4000];
                    case "Level0-f", "Level0-g", "Level0-h", "Level0-j":
                        backgroundZs = [0, 20, 60, 120, 200];
                    case "Level0-e":
                        backgroundZs = [0, 10, 40, 100, 150];
                    case "Villa0-f":
                        backgroundZs = [0, 20, 60, 120];
                    case "Level4-g", "Level4-h":
                        backgroundZs = [0, 15, 40, 150];
                    default:
                        backgroundZs = [0, 125];
                }
            }
            if (level.substr(0, 5) == "Bonus")
            {
                zOffset -= 20;
            }
            else if (level == "Level3-j")
            {
                zOffset += 20;
            }
            else if (level == "Level3-k")
            {
                zOffset -= 80;
                vOffset = 0;
            }
            else if (level == "Menus1-a" || level == "Menus0-b")
            {
                zOffset = -500;
            }
            if (level == "Level3-b" || level == "Level3-d" || level == "Level3-e" || level == "Level3-f" || level == "Level3-g" || level == "Level3-h" || level == "Level3-i" || level == "Bonus3-b" || level == "Bonus3-e")
            {
                StarlingBackgrounds.depthOfField = true;
                StarlingBackgrounds.depthOfFieldCache = false;
                backRes = 1;
            }
            else
            {
                StarlingBackgrounds.depthOfField = false;
                StarlingBackgrounds.depthOfFieldCache = true;
                switch (level)
                {
                    case "Menus0-a", "Menus1-a":
                        foreRes = 2;
                        backRes = 0.6;
                        this.volcanoY = 5000;
                    case "Level0-a":
                        uberSpacing = 550;
                        uberRes = 0.05;
                        if (StarlingBackgrounds.constrained)
                        {
                            backRes = 0.3;
                        }
                        else
                        {
                            backRes = 0.5;
                        }
                        Char.forceBitmap = true;
                        this.volcanoY = 5000;
                    case "Villa0-a":
                        uberSpacing = 25;
                        foreRes = uberRes = 0.5;
                        backRes = 1;
                        this.blurOffset = getBlurOffset(2);
                        this.blurStrength = 6;
                    default:
                        backRes = 0.5;
                }
            }
            if (StarlingBackgrounds.constrained)
            {
                foreRes *= 0.6;
            }
            if (level == "Level4-a")
            {
                smokeBack = true;
            }
            else
            {
                smokeBack = false;
            }
            if (level.substr(5, 1) == "0")
            {
                this.volcanoDist = 1;
            }
            else
            {
                this.volcanoDist = (as3hx.Compat.parseFloat(level.substr(5, 1)) - 1) / 2 + 1;
            }
        }
        Backgrounds.backgroundsN = backgroundsN = backgroundZs.length;
        Char.forceAllBitmaps(Char.forceBitmap);
        StarlingInteract.backgroundsN = backgroundsN;
    }
    
    @:allow()
    private function CharCameras() : Dynamic
    {
        var i : Dynamic = 0;
        var hasL : Int = 0;
        var hasR : Int = 0;
        var hasU : Int = 0;
        var hasD : Int = 0;
        var zX1 : Float = Math.NaN;
        var zY1 : Float = Math.NaN;
        var zX2 : Float = Math.NaN;
        var zY2 : Float = Math.NaN;
        var winning : Int = 0;
        if (Char.ActiveCharArray.length == 1 && tempFollow.length == 0)
        {
            this.singleCharCamera();
        }
        else
        {
            hasL = 0;
            hasR = 0;
            hasU = 0;
            hasD = 0;
            cameraX1 = Char.ActiveCharArray[0].x - Char.ActiveCharArray[0].camDistL;
            cameraX2 = Char.ActiveCharArray[0].x + Char.ActiveCharArray[0].camDistR;
            cameraY1 = Char.ActiveCharArray[0].cameraY - Char.ActiveCharArray[0].camDistU;
            cameraY2 = Char.ActiveCharArray[0].cameraY + Char.ActiveCharArray[0].camDistD;
            zX1 = Char.ActiveCharArray[0].cameraZ;
            zY1 = Char.ActiveCharArray[0].cameraZ;
            zX2 = Char.ActiveCharArray[0].cameraZ;
            zY2 = Char.ActiveCharArray[0].cameraZ;
            i = as3hx.Compat.parseInt(Char.ActiveCharArray.length - 1);
            while (i >= 1)
            {
                if (Char.ActiveCharArray[i].x - Char.ActiveCharArray[i].camDistL < cameraX1)
                {
                    cameraX1 = Char.ActiveCharArray[i].x - Char.ActiveCharArray[i].camDistL;
                    zX1 = Char.ActiveCharArray[i].cameraZ;
                    hasL = i;
                }
                if (Char.ActiveCharArray[i].cameraY - Char.ActiveCharArray[i].camDistU < cameraY1)
                {
                    cameraY1 = Char.ActiveCharArray[i].cameraY - Char.ActiveCharArray[i].camDistU;
                    zY1 = Char.ActiveCharArray[i].cameraZ;
                    hasU = i;
                }
                if (Char.ActiveCharArray[i].x + Char.ActiveCharArray[i].camDistR > cameraX2)
                {
                    cameraX2 = Char.ActiveCharArray[i].x + Char.ActiveCharArray[i].camDistR;
                    zX2 = Char.ActiveCharArray[i].cameraZ;
                    hasR = i;
                }
                if (Char.ActiveCharArray[i].cameraY + Char.ActiveCharArray[i].camDistD > cameraY2)
                {
                    cameraY2 = Char.ActiveCharArray[i].cameraY + Char.ActiveCharArray[i].camDistD;
                    zY2 = Char.ActiveCharArray[i].cameraZ;
                    hasD = i;
                }
                i--;
            }
            if (this.useNodes)
            {
                for (i in 0...Char.ActiveCharArray.length)
                {
                    Char.ActiveCharArray[i].myNode = progressNode.findClosest(Char.ActiveCharArray[i].x, Char.ActiveCharArray[i].y, Char.ActiveCharArray[i].myNode);
                }
                winning = Char.findWinner();
                if (winning > -1)
                {
                    preferScrollX = preferScrollY = 0;
                    i = as3hx.Compat.parseInt(Char.ActiveCharArray.length - 1);
                    while (i >= 0)
                    {
                        if (Char.ActiveCharArray[i].cameraMaster)
                        {
                            if (hasL == i)
                            {
                                preferScrollX = -1;
                            }
                            if (hasU == i)
                            {
                                preferScrollY = -1;
                            }
                            if (hasR == i)
                            {
                                preferScrollX = 1;
                            }
                            if (hasD == i)
                            {
                                preferScrollY = 1;
                            }
                        }
                        i--;
                    }
                }
                else
                {
                    preferScrollX = 1;
                    preferScrollY = -1;
                }
            }
            this.multiCharCamera(zX1, zY1, zX2, zX2);
        }
    }
    
    @:allow()
    private function singleCharCamera() : Void
    {
        var ex : Float = Math.NaN;
        var ey : Float = Math.NaN;
        var ez : Float = Math.NaN;
        var tempRatio : Float = Math.NaN;
        if (gameMode != "vase")
        {
            if (cameraShift && cameraShiftRatio != toCameraShiftRatio)
            {
                tempRatio = toCameraShiftRatio - Main.cameraShiftRatio;
                if (Math.abs(tempRatio) > 0.05)
                {
                    tempRatio *= 0.05 / Math.abs(tempRatio) * Main.framin;
                }
                Main.cameraShiftRatio += tempRatio;
            }
            if (cameraShiftRatio < 1)
            {
                if (!cameraShift)
                {
                    cameraShiftRatio += 0.01;
                }
                if (cameraShiftRatio > 1)
                {
                    cameraShiftRatio = 1;
                }
                ex = cameraShiftX + (Char.ActiveCharArray[0].cameraX - cameraShiftX) * cameraShiftRatio;
                ey = cameraShiftY + (Char.ActiveCharArray[0].cameraY - cameraShiftY) * cameraShiftRatio;
                ez = -Math.abs(Char.ActiveCharArray[0].fakeRL * 2) + Char.ActiveCharArray[0].zOffset;
                ez = cameraShiftZ + (ez - cameraShiftZ) * cameraShiftRatio;
                charScrollZ += (ez - charScrollZ) * 0.05 * framin;
            }
            else
            {
                ex = Char.ActiveCharArray[0].cameraX;
                ey = Char.ActiveCharArray[0].cameraY;
                if (cameraShiftX > -10000)
                {
                    cameraShiftX = -10000;
                }
                if (Char.ActiveCharArray[0].toOnRail > 0)
                {
                    ez = Char.ActiveCharArray[0].cameraZ / 10;
                    charScrollZ += (ez - charScrollZ) * 0.01 * framin;
                }
                else
                {
                    ez = -Math.abs(Char.ActiveCharArray[0].fakeRL * 2) + Char.ActiveCharArray[0].zOffset;
                    charScrollZ += (ez - charScrollZ) * 0.02 * framin;
                }
            }
            if (charScrollZ < MaxZ)
            {
                charScrollZ = MaxZ;
            }
            quickStages(charScrollZ);
            if (shiftBounds(ex, ey))
            {
                ex = Char.ActiveCharArray[0].cameraX;
                ey = Char.ActiveCharArray[0].cameraY;
            }
            if (ex - stageX < MinX)
            {
                ex = MinX + stageX;
            }
            if (ex + stageX > MaxX)
            {
                ex = MaxX - stageX;
            }
            if (ey - stageY < MinY)
            {
                ey = MinY + stageY;
            }
            if (ey + stageY > MaxY)
            {
                ey = MaxY - stageY;
            }
            if (MaxX - MinX < stageX * 2 || MaxY - MinY < stageY * 2)
            {
                if ((MaxX - MinX) / (stageX * 2) < (MaxY - MinY) / (stageY * 2))
                {
                    ex = (MinX + MaxX) * 0.5;
                }
                else
                {
                    ey = (MinY + MaxY) * 0.5;
                }
            }
            if (lockShift)
            {
                quickStages(lockShiftZ);
                if (lockShiftX < -18500 && ex - stageX < lockShiftMinX)
                {
                    ex = lockShiftMinX + stageX;
                }
                else if (lockShiftX > 18500 && ex + stageX > lockShiftMaxX)
                {
                    ex = lockShiftMaxX - stageX;
                }
                if (lockShiftY < -18500 && ey - stageY < lockShiftMinY)
                {
                    ey = lockShiftMinY + stageY;
                }
                else if (lockShiftY > 18500 && ey + stageY > lockShiftMaxY)
                {
                    ey = lockShiftMaxY - stageY;
                }
            }
            if (Char.ActiveCharArray[0].ratio > 0.75)
            {
                charScrollX += (ex - charScrollX) * 0.1 * framin * 0.75;
                charScrollY += (ey - charScrollY) * 0.15 * framin * 0.75;
            }
            else
            {
                charScrollX += (ex - charScrollX) * 0.1 * framin * Char.ActiveCharArray[0].ratio;
                charScrollY += (ey - charScrollY) * 0.15 * framin * Char.ActiveCharArray[0].ratio;
            }
        }
    }
    
    @:allow()
    private function multiCharCamera(zX1 : Dynamic, zY1 : Dynamic, zX2 : Dynamic, zY2 : Dynamic) : Dynamic
    {
        var distX : Float = Math.NaN;
        var distY : Float = Math.NaN;
        var ratioX1 : Float = Math.NaN;
        var ratioX2 : Float = Math.NaN;
        var ratioY1 : Float = Math.NaN;
        var ratioY2 : Float = Math.NaN;
        var ratioX : Float = Math.NaN;
        var ratioY : Float = Math.NaN;
        var tempZ : Float = Math.NaN;
        var ex : Int = 0;
        var ey : Int = 0;
        var temp : Float = Math.NaN;
        for (i in 0...tempFollow.length)
        {
            temp = tempFollow[i].x - tempFollow[i].camDistL - cameraX1;
            if (temp < 0)
            {
                cameraX1 += temp * cosCurve(tempFollowR[i]);
            }
            zX1 = 0;
            temp = tempFollow[i].x + tempFollow[i].camDistR - cameraX2;
            if (temp > 0)
            {
                cameraX2 += temp * cosCurve(tempFollowR[i]);
            }
            zX2 = 0;
            temp = tempFollow[i].y - tempFollow[i].camDistU - cameraY1;
            if (temp < 0)
            {
                cameraY1 += temp * cosCurve(tempFollowR[i]);
            }
            zY1 = 0;
            temp = tempFollow[i].y + tempFollow[i].camDistD - cameraY2;
            if (temp > 0)
            {
                cameraY2 += temp * cosCurve(tempFollowR[i]);
            }
            zY2 = 0;
            if (tempFollowB[i] > 0)
            {
                tempFollowB[i] -= framin;
                if (tempFollowR[i] < 1)
                {
                    tempFollowR[i] += 0.02 * framin;
                }
            }
            else if (tempFollowR[i] > 0)
            {
                tempFollowR[i] -= 0.02;
            }
            else
            {
                tempFollow.splice(i, 1);
                tempFollowB.splice(i, 1);
                tempFollowR.splice(i, 1);
            }
        }
        if (cameraX1 < MinX)
        {
            cameraX1 = MinX;
        }
        if (cameraX2 > MaxX)
        {
            cameraX2 = MaxX;
        }
        if (cameraY1 < MinY)
        {
            cameraY1 = MinY;
        }
        if (cameraY2 > MaxY)
        {
            cameraY2 = MaxY;
        }
        distX = Math.abs(cameraX1 - cameraX2);
        distY = Math.abs(cameraY1 - cameraY2);
        ratioX1 = cameraFocalLength / (cameraFocalLength + zX1);
        ratioX2 = cameraFocalLength / (cameraFocalLength + zX2);
        ratioY1 = cameraFocalLength / (cameraFocalLength + zY1);
        ratioY2 = cameraFocalLength / (cameraFocalLength + zY2);
        ratioX = distX / (relativeStageX * 2);
        ratioY = distY / (relativeStageY * 2);
        if (ratioX > ratioY)
        {
            tempZ = -(ratioX * cameraFocalLength - cameraFocalLength);
        }
        else
        {
            tempZ = -(ratioY * cameraFocalLength - cameraFocalLength);
        }
        if (tempZ < MaxZ)
        {
            tempZ = as3hx.Compat.parseFloat(MaxZ);
        }
        else if (tempZ > 0)
        {
            tempZ = 0;
        }
        if (tempZ < -250)
        {
            tempZ = -250;
        }
        if (charScrollZ < tempZ)
        {
            charScrollZ += (tempZ - charScrollZ) * 0.02 * framin;
        }
        else
        {
            charScrollZ += (tempZ - charScrollZ) * 0.1 * framin;
        }
        quickStages(charScrollZ);
        if (cameraX1 > MaxX - stageX * 2)
        {
            cameraX1 = MaxX - stageX * 2;
        }
        if (cameraX2 < MinX + stageX * 2)
        {
            cameraX2 = MinX + stageX * 2;
        }
        if (cameraY1 > MaxY - stageY * 2)
        {
            cameraY1 = MaxY - stageY * 2;
        }
        if (cameraY2 < MinY + stageY * 2)
        {
            cameraY2 = MinY + stageY * 2;
        }
        ex = as3hx.Compat.parseInt((cameraX1 * ratioX1 + cameraX2 * ratioX2) / (ratioX1 + ratioX2));
        ey = as3hx.Compat.parseInt((cameraY1 * ratioY1 + cameraY2 * ratioY2) / (ratioY1 + ratioY2));
        if (shiftBounds(ex, ey))
        {
            ex = Char.ActiveCharArray[0].cameraX;
            ey = Char.ActiveCharArray[0].cameraY;
        }
        Char.pushingScreen = false;
        if (tempZ == MaxZ || tempZ == -250)
        {
            if (preferScrollX < 0 && ex > cameraX1 + stageX)
            {
                Char.pushingScreen = true;
                ex = as3hx.Compat.parseInt(cameraX1 + stageX);
            }
            if (preferScrollX > 0 && ex < cameraX2 - stageX)
            {
                Char.pushingScreen = true;
                ex = as3hx.Compat.parseInt(cameraX2 - stageX);
            }
            if (preferScrollY < 0 && ey > cameraY1 + stageY)
            {
                Char.pushingScreen = true;
                ey = as3hx.Compat.parseInt(cameraY1 + stageY);
            }
            if (preferScrollY > 0 && ey < cameraY2 - stageY)
            {
                Char.pushingScreen = true;
                ey = as3hx.Compat.parseInt(cameraY2 - stageY);
            }
        }
        charScrollX += (ex - charScrollX) * 0.1 * framin;
        charScrollY += (ey - charScrollY) * 0.2 * framin;
    }
    
    private function simpleScroll() : Void
    {
        charScrollX += (cameraShiftX - charScrollX) * 0.05 * framin;
        charScrollY += (cameraShiftY - charScrollY) * 0.05 * framin;
        charScrollZ += (cameraShiftZ - charScrollZ) * 0.05 * framin;
        cameraX = charScrollX;
        cameraY = charScrollY;
        cameraZ = charScrollZ;
    }
    
    private function quickScroll() : Void
    {
        charScrollX += (cameraShiftX - charScrollX) * 0.2 * framin;
        charScrollY += (cameraShiftY - charScrollY) * 0.2 * framin;
        charScrollZ += (cameraShiftZ - charScrollZ) * 0.2 * framin;
        cameraX = charScrollX;
        cameraY = charScrollY;
        cameraZ = charScrollZ;
    }
    
    private function zoomOut() : Void
    {
        if ((cameraShiftZ - (lockShiftZ + 0.1)) * 0.1 > -10)
        {
            cameraShiftZ += (cameraShiftZ - (lockShiftZ + 0.1)) * 0.1 * framin;
        }
        else
        {
            cameraShiftZ -= 10 * framin;
        }
        this.quickScroll();
    }
    
    private function nullScroll() : Void
    {
        cameraX = charScrollX;
        cameraY = charScrollY;
        cameraZ = charScrollZ;
    }
    
    private function peerAndPushScroll() : Void
    {
        if (Char.CharArray[0].y < charScrollY || Char.CharArray[0].Status == "Disabled")
        {
            charScrollX += (2540 + stageX - charScrollX) * 0.05 * framin;
            charScrollY += (-1940 - charScrollY) * 0.05 * framin;
            charScrollZ += (85 - charScrollZ) * 0.05 * framin;
        }
        else
        {
            if (Char.CharArray[0].x > charScrollX)
            {
                charScrollX = Char.CharArray[0].x;
            }
            charScrollY = Char.CharArray[0].y;
        }
        quickStages(charScrollZ);
        cameraX = charScrollX;
        cameraY = charScrollY;
        cameraZ = charScrollZ;
    }
    
    private function scrollChars() : Void
    {
        this.CharCameras();
        this.focusScroll(charScrollX, charScrollY, charScrollZ);
    }
    
    private function introScroll() : Void
    {
        if (cameraZ + 5 * framin < 10)
        {
            if (cameraTemp < 5)
            {
                cameraTemp += framin * 0.05;
            }
            else
            {
                cameraTemp = 5;
            }
            cameraZ += cameraTemp * framin;
        }
        else
        {
            cameraTemp *= Math.pow(9 / 10, framin);
            if (cameraTemp > 0)
            {
                cameraZ += cameraTemp * framin;
            }
        }
    }
    
    private function panOutScroll() : Void
    {
        this.CharCameras();
        if (cameraStage == 0)
        {
            tempCameraX += (-320 - tempCameraX) * 0.1 * framin;
            tempCameraY += (-375 - tempCameraY) * 0.1 * framin;
            tempCameraZ += (80 - tempCameraZ) * 0.1 * framin;
            if (tempCameraZ > 79.8)
            {
                cameraStage = 1;
                Sounds.playOnce("Intro_Zoom");
            }
        }
        else if (cameraStage == 1)
        {
            if (tempCameraZ > -4700)
            {
                if (cameraTemp < 80)
                {
                    cameraTemp += (0.1 + cameraTemp * 0.05) * framin;
                }
            }
            else
            {
                cameraTemp -= cameraTemp * 0.05 * framin;
                if (cameraTemp < 1)
                {
                    cameraStage = 2;
                }
            }
            if (tempCameraZ > -100)
            {
                this.houseFront.alpha = 1 - (tempCameraZ + 100) / 180;
            }
            else
            {
                this.houseFront.alpha = 1;
            }
            tempCameraY += cameraTemp * 1.1 * framin;
            tempCameraZ -= cameraTemp * framin;
        }
        else if (cameraStage == 2)
        {
            if (tempCameraZ < -600)
            {
                if (cameraTemp < 50)
                {
                    cameraTemp += (0.1 + cameraTemp * 0.05) * framin;
                }
            }
            else
            {
                cameraTemp -= cameraTemp * 0.1 * framin;
            }
            tempCameraZ += cameraTemp * framin;
            if (tempCameraZ > -500)
            {
                tempCameraY -= 60 * framin;
                tempCameraZ += (0 - tempCameraZ) * 0.005 * framin;
            }
            if (tempCameraY < 300)
            {
                this.houseFront.alpha = 0;
                this.houseFrontDoor.alpha = 0;
                staticInteractObjects.clearByName("cutieBob");
                StarlingTemporary.justGetWithN(0).visible = false;
                AllEverything.walls0.removeChild(AllEverything.walls0.doorWall);
                this.scrollEngine = this.scrollChars;
                saveProgress("cutieLeftWindow", true);
            }
        }
        cameraX = charScrollX = tempCameraX;
        cameraY = charScrollY = tempCameraY;
        cameraZ = charScrollZ = tempCameraZ - (zOffset + 10);
    }
    
    private function hangOnCatScroll() : Void
    {
        charScrollX += (Char.ActiveCharArray[0].x - charScrollX) * 0.1 * framin;
        charScrollY += (Char.ActiveCharArray[0].y - 60 - charScrollY) * 0.2 * framin;
        charScrollZ += (Char.ActiveCharArray[0].zOffset - charScrollZ) * 0.05 * framin;
        quickStages(charScrollZ);
        this.focusScroll(charScrollX, charScrollY, charScrollZ);
    }
    
    private function EndGameLockScroll() : Void
    {
        lockShift = true;
        lockShiftZ += 0.1 * framin;
        this.focusScroll(charScrollX, charScrollY, charScrollZ);
        if (lockShiftZ < 90 && lockShiftZ + 0.15 * framin > 90)
        {
            boundsShiftX = boundsShiftY = 0;
            FadeClip = new FadeOutTBC("Menus0-a", 0);
            addChild(FadeClip);
        }
    }
    
    private function turtleWarpScroll() : Void
    {
        cameraZ -= 3 * framin;
        Char.scrollChars(0, 0, cameraZ + zOffset, 0, 0);
        if (cameraZ < -400)
        {
            if (FadeClip.currentFrameLabel == "wait")
            {
                FadeClip.nextFrame();
            }
        }
    }
    
    private function zoomInToWarp() : Void
    {
        this.simpleScroll();
    }
    
    private function lockShiftStuff(ex : Float, ey : Float, ez : Float) : Void
    {
        var fade : Float = Math.NaN;
        fade = as3hx.Compat.parseFloat(cosCurve(lockShiftRatio));
        cameraZ = lockShiftZ * fade + ez * (1 - fade);
        quickStages(cameraZ);
        if (Math.abs(lockShiftX) > 17500)
        {
            cameraX = ex;
        }
        else
        {
            cameraX = lockShiftX * fade + ex * (1 - fade);
            if (lockShift)
            {
                boundsShiftX = 0;
            }
        }
        if (Math.abs(lockShiftY) > 17500)
        {
            if (lockShiftX < -18500)
            {
                if (ey - stageY < lockShiftMinY)
                {
                    ey = lockShiftMinY + stageY;
                }
            }
            if (lockShiftX > 18500)
            {
                if (ey + stageY > lockShiftMaxY)
                {
                    ey = lockShiftMaxY - stageY;
                }
            }
            cameraY = ey;
        }
        else
        {
            cameraY = lockShiftY * fade + ey * (1 - fade);
            if (lockShift)
            {
                boundsShiftY = 0;
            }
        }
    }
    
    @:allow()
    private function setMultiCharCamera() : Dynamic
    {
        var distX : Float = Math.NaN;
        var distY : Float = Math.NaN;
        var ratioX : Float = Math.NaN;
        var ratioY : Float = Math.NaN;
        cameraX1 = Char.CharArray[0].cameraX;
        cameraY1 = Char.CharArray[0].cameraY;
        cameraX2 = Char.CharArray[1].cameraX;
        cameraY2 = Char.CharArray[1].cameraY;
        distX = Math.abs(cameraX1 - cameraX2);
        distY = Math.abs(cameraY1 - cameraY2);
        ratioX = distX / (relativeStageX * 2);
        ratioY = distY / (relativeStageY * 2);
        if (ratioX > ratioY)
        {
            cameraZ = -(ratioX * cameraFocalLength - cameraFocalLength);
        }
        else
        {
            cameraZ = -(ratioY * cameraFocalLength - cameraFocalLength);
        }
        charScrollX = (cameraX1 + cameraX2) * 0.5;
        charScrollY = (cameraY1 + cameraY2) * 0.5;
    }
    
    public function customMultiScroll() : Void
    {
        var distX : Float = Math.NaN;
        var distY : Float = Math.NaN;
        var ratioX : Float = Math.NaN;
        var ratioY : Float = Math.NaN;
        var tempZ : Float = Math.NaN;
        var ex : Int = 0;
        var ey : Int = 0;
        cameraX1 = Char.CharArray[0].x + Char.CharArray[0].moveRL * 10;
        cameraY1 = Char.CharArray[0].cameraY;
        if (Baddies.BaddieArray.length > 0)
        {
            cameraX2 = Baddies.BaddieArray[0].x + Baddies.BaddieArray[0].moveRL * 5;
            cameraY2 = Baddies.BaddieArray[0].y;
        }
        distX = Math.abs(cameraX1 - cameraX2);
        distY = Math.abs(cameraY1 - cameraY2);
        ratioX = distX / (relativeStageX * 2 - 200);
        ratioY = distY / (relativeStageY * 2 - 200);
        if (ratioX > ratioY)
        {
            tempZ = -(ratioX * cameraFocalLength - cameraFocalLength);
        }
        else
        {
            tempZ = -(ratioY * cameraFocalLength - cameraFocalLength);
        }
        if (tempZ < MaxZ)
        {
            tempZ = as3hx.Compat.parseFloat(MaxZ);
        }
        else if (tempZ > 40)
        {
            tempZ = 40;
        }
        if (charScrollZ < tempZ)
        {
            charScrollZ += (tempZ - charScrollZ) * 0.02 * framin;
        }
        else
        {
            charScrollZ += (tempZ - charScrollZ) * 0.2 * framin;
        }
        quickStages(charScrollZ);
        ex = as3hx.Compat.parseInt(cameraX1 * 0.5 + cameraX2 * 0.5);
        ey = as3hx.Compat.parseInt(cameraY1 * 0.5 + cameraY2 * 0.5);
        if (ex - stageX < MinX)
        {
            ex = as3hx.Compat.parseInt(MinX + stageX);
        }
        if (ex + stageX > MaxX)
        {
            ex = as3hx.Compat.parseInt(MaxX - stageX);
        }
        if (ey - stageY < MinY)
        {
            ey = as3hx.Compat.parseInt(MinY + stageY);
        }
        if (ey + stageY > MaxY)
        {
            ey = as3hx.Compat.parseInt(MaxY - stageY);
        }
        charScrollX += (ex - charScrollX) * 0.1 * framin;
        charScrollY += (ey - charScrollY) * 0.2 * framin;
        this.focusScroll(charScrollX, charScrollY, charScrollZ);
    }
    
    private function scrollOther() : Dynamic
    {
        var ex : Float = Math.NaN;
        var ey : Float = Math.NaN;
        if (scrollOtherObject.hitPause == 0)
        {
            ex = scrollOtherObject.x + scrollOtherObject.moveRL * 6;
            ey = scrollOtherObject.y + scrollOtherObject.moveUD * 6;
            if (ex - stageX < MinX)
            {
                ex = MinX + stageX;
            }
            if (ex + stageX > MaxX)
            {
                ex = MaxX - stageX;
            }
            if (ey - stageY < MinY)
            {
                ey = MinY + stageY;
            }
            if (ey + stageY > MaxY)
            {
                ey = MaxY - stageY;
            }
            charScrollX += (ex - charScrollX) * 0.4 * framin;
            charScrollY += (ey - charScrollY) * 0.4 * framin;
            charScrollZ += (lockShiftZ - charScrollZ) * 0.1 * framin;
            quickStages(charScrollZ);
            this.focusScroll(charScrollX, charScrollY, charScrollZ);
        }
    }
    
    private function scrollAfterRace() : Dynamic
    {
        var ex : Float = Math.NaN;
        var ey : Float = Math.NaN;
        ex = as3hx.Compat.parseFloat(scrollOtherObject.x);
        ey = scrollOtherObject.y - scrollOtherObject.vOffset;
        if (ex - stageX < MinX)
        {
            ex = MinX + stageX;
        }
        if (ex + stageX > MaxX)
        {
            ex = MaxX - stageX;
        }
        if (ey - stageY < MinY)
        {
            ey = MinY + stageY;
        }
        if (ey + stageY > MaxY)
        {
            ey = MaxY - stageY;
        }
        charScrollX += (ex - charScrollX) * 0.2 * framin;
        charScrollY += (ey - charScrollY) * 0.2 * framin;
        charScrollZ += (lockShiftZ - charScrollZ) * 0.2 * framin;
        quickStages(charScrollZ);
        this.focusScroll(charScrollX, charScrollY, charScrollZ);
    }
    
    private function focusScroll(ex : Float, ey : Float, ez : Float = 0) : Void
    {
        if (lockShift)
        {
            if (lockShiftRatio < 1)
            {
                tempRatio = (1 - lockShiftRatio) * 0.1;
                if (tempRatio > 0.05)
                {
                    tempRatio = 0.05;
                }
                lockShiftRatio += tempRatio * framin;
            }
            else if (lockShiftRatio > 1)
            {
                lockShiftRatio = 1;
            }
        }
        else if (lockShiftRatio > 0)
        {
            tempRatio = -lockShiftRatio * 0.1;
            if (tempRatio < -0.05)
            {
                tempRatio = -0.05;
            }
            else if (tempRatio > -0.002)
            {
                tempRatio = -0.002;
            }
            lockShiftRatio += tempRatio * framin;
            if (lockShiftRatio < 0)
            {
                lockShiftRatio = 0;
                lockShiftX = -20000;
                lockShiftY = -20000;
            }
        }
        if (lockShiftRatio > 0)
        {
            this.lockShiftStuff(ex, ey, ez);
        }
        else
        {
            cameraX = ex;
            cameraY = ey;
            cameraZ = ez;
        }
    }
    
    private function cameraShake() : Dynamic
    {
        if (this.cameraRumble)
        {
            this.shakeX = this.shakeRL * Math.random();
            this.shakeY = this.shakeRL * Math.random();
            this.shakeRL *= -0.8;
        }
        else
        {
            this.shakeRL += -this.shakeX * 0.6;
            this.shakeUD += -this.shakeY * 0.6;
            this.shakeRL *= 0.3;
            this.shakeUD *= 0.3;
            this.shakeX += this.shakeRL;
            this.shakeY += this.shakeUD;
        }
        if (this.rumbleSound)
        {
            Sounds.updateSound(this.rumbleChannel, cameraX, this.rumbleFade, 0);
            this.rumbleFade -= 0.2;
            if (this.rumbleFade < 0)
            {
                this.rumbleFade = 0;
                Sounds.stopSound(this.rumbleChannel);
                this.rumbleSound = false;
            }
        }
    }
    
    private function scrollEverything() : Dynamic
    {
        cameraX += this.shakeX;
        cameraY += this.shakeY + this.superOffset;
        Char.scrollChars(cameraX, cameraY, cameraZ + zOffset, 0, 0);
        for (i in 0...backgroundsN)
        {
            rootRatios[i] = cameraFocalLength / (cameraFocalLength + backgroundZs[i] - (cameraZ + zOffset)) * overRatio;
            StarlingBackgrounds.scrollBackgrounds(i, realStageX - cameraX * rootRatios[i], realStageY - cameraY * rootRatios[i], rootRatios[i]);
            stageXs[i] = originalStageX / rootRatios[i];
            stageYs[i] = originalStageY / rootRatios[i];
            Backgrounds.backgroundsArray[i].x = realStageX - cameraX * rootRatios[i];
            Backgrounds.backgroundsArray[i].y = realStageY - cameraY * rootRatios[i];
            Backgrounds.backgroundsArray[i].scaleX = Backgrounds.backgroundsArray[i].scaleY = rootRatios[i];
        }
        rootX = realStageX - cameraX * rootRatios[0];
        rootY = realStageY - cameraY * rootRatios[0];
        if (hasUberForeground)
        {
            UberForeground.x = rootX;
            UberForeground.y = rootY;
            UberForeground.scaleX = UberForeground.scaleY = rootRatios[0];
        }
        if (cameraZ > -200)
        {
            StarlingBackgrounds.scrollVolcano(-cameraX, -cameraY + this.volcanoY, 0.019529916076312052 * overRatio * this.volcanoDist);
        }
        BackgroundObjects.scrollBackgroundObjects(cameraX, cameraY, cameraZ + zOffset);
        StarlingBackgrounds.scrollBackgroundObjects(cameraX, cameraY, cameraZ + zOffset);
    }
    
    public function scrollInVase() : Dynamic
    {
        if (b > 0)
        {
            --b;
        }
        else if (Backgrounds.backgroundsArray[Char.ActiveCharArray[0].onRail].alpha < 1)
        {
            Backgrounds.backgroundsArray[Char.ActiveCharArray[0].onRail].alpha += 0.1 * framin;
            Backgrounds.backgroundsArray[0].alpha = 1 - Backgrounds.backgroundsArray[Char.ActiveCharArray[0].onRail].alpha;
            this.fadeBackgroundAlphas(Char.ActiveCharArray[0].onRail, Backgrounds.backgroundsArray[Char.ActiveCharArray[0].onRail].alpha);
        }
        this.cameraShake();
    }
    
    public function scrollOutVase() : Dynamic
    {
        var box : StaticInteractObjects = null;
        var i : Int = 0;
        var n : Int = 0;
        if (b == 2)
        {
            if (Backgrounds.backgroundsArray[Backgrounds.backgroundsArray.length - 1].alpha > 0)
            {
                Backgrounds.backgroundsArray[Backgrounds.backgroundsArray.length - 1].alpha -= 0.2 * framin;
                Backgrounds.backgroundsArray[0].alpha = 1 - Backgrounds.backgroundsArray[Backgrounds.backgroundsArray.length - 1].alpha;
                this.fadeBackgroundAlphas(0, Backgrounds.backgroundsArray[0].alpha);
                this.fadeBackgroundAlphas(Backgrounds.backgroundsArray.length - 1, Backgrounds.backgroundsArray[Backgrounds.backgroundsArray.length - 1].alpha);
            }
            else
            {
                --b;
            }
        }
        else if (b == 1)
        {
            getOutOfBox();
            box = boxception.pop();
            for (i in 0...Char.ActiveCharArray.length)
            {
                Char.ActiveCharArray[i].aUD = 26;
                Char.ActiveCharArray[i].exitBox(box, true);
            }
            --b;
        }
        else if (Char.ActiveCharArray[0].onRail < backgroundsN)
        {
            gameMode = "level";
            this.scrollEngine = this.scrollChars;
            for (n in 0...Char.ActiveCharArray.length)
            {
                Char.ActiveCharArray[n].cameraX = charScrollX = cameraX;
                Char.ActiveCharArray[n].cameraY = charScrollY = cameraY;
                Char.ActiveCharArray[n].groundY = Char.ActiveCharArray[n].y;
                Char.ActiveCharArray[n].reCalCamera(cameraX, cameraY);
            }
        }
        else
        {
            gameMode = "vase";
            this.scrollEngine = this.scrollInVase;
        }
    }
    
    private function fadeBackgroundAlphas(n : Dynamic, a : Dynamic) : Void
    {
        StarlingBackgrounds.BackgroundArray[n].alpha = a;
        StarlingBackgrounds.BackgroundObjArray[n].alpha = a;
    }
    
    public function OnResume() : Dynamic
    {
        ExternalInterface.call("resume");
    }
    
    private function onBGConnectStatus(e : Event) : Dynamic
    {
        trace(e.level);
    }
    
    private function StartMainOrMiniClip(e : Dynamic) : Dynamic
    {
        Achievements.startKong();
    }
    
    private function closeStartupAd(e : Event) : Void
    {
        this.adStatus = "closed";
    }
    
    private function AGSplashScreen(e : Event) : Dynamic
    {
        if (this.splashLogo.currentFrame == this.splashLogo.totalFrames)
        {
            removeEventListener(Event.ENTER_FRAME, this.AGSplashScreen);
            this.splashLogo.button.removeEventListener(MouseEvent.MOUSE_DOWN, this.clickAGButton);
            this.splashLogo.parent.removeChild(this.splashLogo);
            this.splashLogo = null;
            this.loadGameBlockClean(e);
        }
        else
        {
            this.splashLogo.gotoAndStop(as3hx.Compat.parseInt((Math.round(haxe.Timer.stamp() * 1000) - this.oTimer) / 33));
        }
    }
    
    private function KongSplashScreen(e : Event) : Dynamic
    {
        framin = (Math.round(haxe.Timer.stamp() * 1000) - this.oTimer) / 42;
        allTheFrames += Math.round(haxe.Timer.stamp() * 1000) - this.oTimer;
        while (allTheFrames >= 42)
        {
            allTheFrames -= 42;
            this.splashLogo.nextFrame();
            if (this.splashLogo.currentFrame < 60)
            {
                Sounds.updateMusic(this.splashLogo.currentFrame / 60);
            }
            if (this.splashLogo.currentFrame == this.splashLogo.totalFrames)
            {
                removeEventListener(Event.ENTER_FRAME, this.KongSplashScreen);
                removeChild(this.splashLogo);
                this.splashLogo = null;
                rootHUD.HUD.debug.text += pauseStatus;
                if (pauseStatus == "Ready")
                {
                    this.loadGameBlock4();
                }
                else
                {
                    addEventListener(Event.ENTER_FRAME, this.waitForParse);
                }
            }
        }
        this.oTimer = Math.round(haxe.Timer.stamp() * 1000);
    }
    
    private function waitForParse(e : Event) : Dynamic
    {
        if (pauseStatus == "Ready")
        {
            removeEventListener(Event.ENTER_FRAME, this.waitForParse);
            this.loadGameBlock4();
        }
    }
    
    public function StartMain(e : Event = null) : Dynamic
    {
        this.setupDevice();
        FadeClip = new FadeIn();
        this.addChild(FadeClip);
        FadeClip.x = 400;
        FadeClip.y = 250;
        if ("Starling" == "Starling")
        {
            StarlingBackgrounds.startStarling(stage);
        }
        else
        {
            this.StartAfterStarling();
        }
    }
    
    public function StartAfterStarling() : Dynamic
    {
        var back : StaticBackgroundClip = null;
        var filter : BlurFilter = null;
        if (Extensions.isScaleform)
        {
            ExternalInterface.call("DisableGC");
        }
        collision.relativeStageY = relativeStageY;
        Char.realStageX = StarlingBackgrounds.realStageX = realStageX;
        Char.realStageY = StarlingBackgrounds.realStageY = realStageY;
        rootHUD.HUD.overRatio = Char.overRatio = overRatio;
        StarlingBackgrounds.onResize();
        back = new StaticBackgroundClip();
        this.bitmapData = new BitmapData(originalStageX * 2 + 90, originalStageX * 2, false, 0);
        this.bitmapData.drawWithQuality(back, new Matrix(overRatio, 0, 0, overRatio, 0, 0), null, null, null, true, StageQuality.BEST);
        filter = new BlurFilter();
        filter.blurX = 5;
        filter.blurY = 5;
        this.bitmapData.applyFilter(this.bitmapData, new Rectangle(0, 0, originalStageX * 2 + 90, originalStageX * 2), new Point(0, 0), filter);
        StarlingBackgrounds.addStaticBack(this.bitmapData);
        back = null;
        this.bitmapData.dispose();
        StarlingBackgrounds.addVolcano();
        StarlingBackgrounds.resizeVolcano(originalStageX / 400, originalStageY / 250);
        ng_medalPopup = new MedalPopup();
        rootHUD.HUD.addChild(ng_medalPopup);
        ng_medalPopup.x = originalStageX * 2 - 250;
        if (!isTouchScreen)
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.mouseUp);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMove);
            stage.addEventListener(Event.RESIZE, this.onFullscreen);
        }
        stage.focus = stage;
        stage.quality = StageQuality.MEDIUM;
        if (this.isFullscreen)
        {
            flash.ui.Mouse.hide();
        }
        if (isScaleForm)
        {
            onSite = "mobile";
            this.loadGameBlockClean("e");
        }
        else
        {
            whereAt = "";
            onSite = "Local";
            this.loadGameBlockA();
        }
        whereAt = loaderInfo.url.substr(0, loaderInfo.url.lastIndexOf("/") + 1);
        if (LoadIt == "Level1-a" && DoorIt == 0)
        {
            if (FadeClip != null)
            {
                staticInteractObjects.InteractEnterFrameArray.splice(staticInteractObjects.InteractEnterFrameArray.indexOf(FadeClip), 1);
                FadeClip.parent.removeChild(FadeClip);
                FadeClip = null;
            }
            FadeClip = new FadeInWhite();
        }
        else if (LoadIt == "Level5-a")
        {
            if (FadeClip != null)
            {
                staticInteractObjects.InteractEnterFrameArray.splice(staticInteractObjects.InteractEnterFrameArray.indexOf(FadeClip), 1);
                FadeClip.parent.removeChild(FadeClip);
                FadeClip = null;
            }
            FadeClip = new FadeInBlack();
        }
        else if (FadeClip == null)
        {
            FadeClip = new FadeIn();
        }
        this.addChild(FadeClip);
        myLoadHUD = new LoadHUD();
        this.addChild(myLoadHUD);
        myLoadHUD.gotoAndStop(1);
        textBubbles.setupTextBubble();
        if (true || cleanForBrand || isScaleForm)
        {
            this.loadGameBlock4();
        }
        else if (daParameters.loadFrom == "W4" || debug)
        {
            addEventListener(Event.ENTER_FRAME, this.waitForParse);
            external = true;
        }
        else
        {
            Sounds.playMusic("Menus0");
            Sounds.musicPlaying = "CaveMusic";
            this.oTimer = Math.round(haxe.Timer.stamp() * 1000);
            addEventListener(Event.ENTER_FRAME, this.KongSplashScreen);
            this.splashLogo = new KongIntro(400, 250);
            addChild(this.splashLogo);
        }
        Sounds.startLoadSounds();
    }
    
    private function setupDevice() : Void
    {
        originalStageX = stageX = relativeStageX = realStageX = as3hx.Compat.parseInt(800 * 0.5);
        originalStageY = stageY = relativeStageY = realStageY = as3hx.Compat.parseInt(500 * 0.5);
        daParameters = stage.loaderInfo.parameters;
        if (deviceID == "Android")
        {
            if (stage.fullScreenWidth / stage.fullScreenHeight < 1.6)
            {
                deviceID = "iPad";
            }
            else
            {
                deviceID = "iPhone";
            }
        }
        stageRoot.addChild(new RootHUD());
        if (deviceID != "PC")
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            stage.quality = StageQuality.LOW;
            stageX = originalStageX = realStageX = as3hx.Compat.parseInt(Math.round(stage.fullScreenWidth) * 0.5);
            stageY = originalStageY = realStageY = as3hx.Compat.parseInt(Math.round(stage.fullScreenHeight) * 0.5);
            if (stage.fullScreenWidth / stage.fullScreenHeight < 1.6)
            {
                overRatio = stage.fullScreenWidth / (relativeStageX * 2);
                relativeStageY = as3hx.Compat.parseInt(relativeStageX * (stage.fullScreenHeight / stage.fullScreenWidth));
                if (stage.fullScreenWidth < 2000)
                {
                    bitRes = 0.5;
                }
                else if (overRatio > 1.3)
                {
                    bitRes = 1.3;
                }
                else
                {
                    bitRes = overRatio;
                }
                if (deviceID == "Android")
                {
                    deviceID = "iPad";
                }
            }
            else
            {
                overRatio = stage.fullScreenHeight / (relativeStageY * 2);
                relativeStageX = as3hx.Compat.parseInt(relativeStageY * (stage.fullScreenWidth / stage.fullScreenHeight));
                if (stage.fullScreenWidth < 1100)
                {
                    bitRes = 0.5;
                }
                else if (overRatio > 1.3)
                {
                    bitRes = 1.3;
                }
                else
                {
                    bitRes = overRatio;
                }
                if (deviceID == "Android")
                {
                    deviceID = "iPhone";
                }
            }
            rootHUD.HUD.scaleX = overRatio;
            rootHUD.HUD.scaleY = overRatio;
            this.masterSplit = 410 * overRatio;
            member = "Local";
            memberDisplay = "Local";
            rootHUD.HUD.isReallyMobile = true;
        }
        else if (isScaleForm)
        {
            member = "Local";
            memberDisplay = "Me";
            debug = true;
            if (Extensions.isScaleform)
            {
                rootHUD.HUD.isReallyMobile = true;
                originalStageX = stageX = Extensions.visibleRect.width * 0.5;
                originalStageY = stageY = Extensions.visibleRect.height * 0.5;
                realStageX = 400;
                realStageY = 250;
                if (Extensions.visibleRect.width == 800)
                {
                    rootHUD.HUD.scaleY = rootHUD.HUD.scaleX = Extensions.visibleRect.width / 800;
                }
                else
                {
                    rootHUD.HUD.scaleY = rootHUD.HUD.scaleX = Extensions.visibleRect.height / 500;
                }
                rootHUD.HUD.x += realStageX - originalStageX;
                rootHUD.HUD.y += realStageY - originalStageY;
                relativeStageX = as3hx.Compat.parseInt(Extensions.visibleRect.width * 0.5);
                relativeStageY = as3hx.Compat.parseInt(Extensions.visibleRect.height * 0.5);
            }
        }
        else
        {
            deviceID = "PC";
            if (daParameters.kongregate != null)
            {
                member = daParameters.kongregate_username + "_KG";
                memberDisplay = daParameters.kongregate_username;
            }
            else if (daParameters.member == null)
            {
                member = "Local";
                memberDisplay = "Local";
            }
            else if (daParameters.member == "")
            {
                member = "not_logged_in_BG";
                memberDisplay = "You";
            }
            else if (daParameters.facebookID == "")
            {
                member = daParameters.member + "_BG";
                memberDisplay = daParameters.member;
            }
            else
            {
                member = daParameters.display + "_FB";
                memberDisplay = daParameters.display;
            }
            originalStageX = stageX = 800 * 0.5;
            originalStageY = stageY = 500 * 0.5;
            this.masterSplit = 410;
        }
    }
    
    private function startTouchControls() : Void
    {
        if (deviceID == "iPad")
        {
            this.moveSplit = 77;
            this.buttonSplit = 738;
        }
        else
        {
            this.moveSplit = 156;
            this.buttonSplit = 751;
        }
        if (this.onlyMove)
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.cinMasterStart);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.cinMasterEnd);
        }
        else
        {
            this.moveTouchID = this.buttonsTouchID = -1;
            if (deviceID != "PC")
            {
                stage.addEventListener(TouchEvent.TOUCH_BEGIN, this.masterButtonStart);
                stage.addEventListener(TouchEvent.TOUCH_MOVE, this.masterButtonMove);
                stage.addEventListener(TouchEvent.TOUCH_END, this.masterButtonEnd);
            }
            else
            {
                stage.addEventListener(MouseEvent.MOUSE_DOWN, this.fakeButtonStart);
                stage.addEventListener(MouseEvent.MOUSE_MOVE, this.fakeButtonMove);
                stage.addEventListener(MouseEvent.MOUSE_UP, this.fakeButtonEnd);
            }
        }
    }
    
    private function killTouchControls() : Void
    {
        if (this.onlyMove)
        {
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.cinMasterStart);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.cinMasterEnd);
        }
        else if (deviceID != "PC")
        {
            stage.removeEventListener(TouchEvent.TOUCH_BEGIN, this.masterButtonStart);
            stage.removeEventListener(TouchEvent.TOUCH_MOVE, this.masterButtonMove);
            stage.removeEventListener(TouchEvent.TOUCH_END, this.masterButtonEnd);
        }
        else
        {
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.fakeButtonStart);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.fakeButtonMove);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.fakeButtonEnd);
        }
    }
    
    public function cinToMaster() : Void
    {
        this.killTouchControls();
        this.onlyMove = false;
        this.startTouchControls();
    }
    
    public function justArrowsVisible(vis : Bool) : Void
    {
        rootHUD.HUD.justArrowsVisible(vis);
        stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.cinMasterStart);
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.cinMasterEnd);
        this.cinToMaster();
    }
    
    private function masterPause(event : Event) : Bool
    {
        if (event.localY < 80)
        {
            rootHUD.HUD.buttonsVisible(false);
            PauseGame(true, 0);
            return true;
        }
        return false;
    }
    
    private function cinMasterStart(e : Event) : Void
    {
        if (!this.masterPause(e))
        {
            Char.CharArray[0].attackUD = -1;
        }
    }
    
    private function cinMasterEnd(e : Event) : Void
    {
        Char.CharArray[0].attackUD = 0;
    }
    
    private function masterButtonStart(e : Event) : Void
    {
        if (!rootHUD.HUD.checkDoorButton(e.localX / overRatio, e.localY / overRatio))
        {
            if (e.localX < this.masterSplit)
            {
                if (this.moveTouchID == -1)
                {
                    rootHUD.HUD.moveButtonStart(e.localX / overRatio - this.moveSplit, e.localY / overRatio);
                    this.moveTouchID = e.touchPointID;
                }
            }
            else if (this.buttonsTouchID == -1)
            {
                rootHUD.HUD.buttonsButtonStart(e.localX / overRatio - this.buttonSplit, e.localY / overRatio);
                this.buttonsTouchID = e.touchPointID;
            }
        }
    }
    
    private function masterButtonMove(e : Event) : Void
    {
        if (this.moveTouchID == e.touchPointID)
        {
            rootHUD.HUD.moveButtonMove(e.localX / overRatio - this.moveSplit, e.localY / overRatio);
        }
        else if (this.buttonsTouchID == e.touchPointID)
        {
            rootHUD.HUD.buttonsButtonMove(e.localX / overRatio - this.buttonSplit, e.localY / overRatio);
        }
    }
    
    private function masterButtonEnd(e : Event) : Void
    {
        if (this.moveTouchID == e.touchPointID)
        {
            rootHUD.HUD.moveButtonEnd(e.localX / overRatio - this.moveSplit, e.localY / overRatio);
            this.moveTouchID = -1;
        }
        else if (this.buttonsTouchID == e.touchPointID)
        {
            rootHUD.HUD.buttonsButtonEnd(e.localX / overRatio - this.buttonSplit, e.localY / overRatio);
            this.buttonsTouchID = -1;
        }
        Char.CharArray[0].fakeUpIsDown = false;
    }
    
    private function fakeButtonStart(e : Event) : Void
    {
        if (!rootHUD.HUD.checkDoorButton(e.localX / overRatio, e.localY / overRatio))
        {
            if (e.localX < this.masterSplit)
            {
                rootHUD.HUD.moveButtonStart(e.localX / overRatio - this.moveSplit, e.localY / overRatio);
            }
            else
            {
                rootHUD.HUD.buttonsButtonStart(e.localX / overRatio - this.buttonSplit, e.localY / overRatio);
            }
        }
        mouseIsDown = true;
    }
    
    private function fakeButtonMove(e : Event) : Void
    {
        if (mouseIsDown)
        {
            if (e.localX < this.masterSplit)
            {
                rootHUD.HUD.moveButtonMove(e.localX / overRatio - this.moveSplit, e.localY / overRatio);
            }
            else
            {
                rootHUD.HUD.buttonsButtonMove(e.localX / overRatio - this.buttonSplit, e.localY / overRatio);
            }
        }
    }
    
    private function fakeButtonEnd(e : Event) : Void
    {
        if (e.localX < this.masterSplit)
        {
            rootHUD.HUD.moveButtonEnd(e.localX / overRatio - this.moveSplit, e.localY / overRatio);
        }
        else
        {
            rootHUD.HUD.buttonsButtonEnd(e.localX / overRatio - this.buttonSplit, e.localY / overRatio);
        }
        mouseIsDown = false;
        Char.CharArray[0].fakeUpIsDown = false;
    }
    
    private function loadGameBlockAG(e : Event = null) : Dynamic
    {
        addEventListener(Event.ENTER_FRAME, this.AGSplashScreen);
        this.splashLogo = new AGIntro();
        this.splashLogo.stop();
        this.splashLogo.scaleX = 0.558975;
        this.splashLogo.scaleY = 0.558975;
        addChild(this.splashLogo);
        this.splashLogo.button.addEventListener(MouseEvent.MOUSE_DOWN, this.clickAGButton);
        this.oTimer = Math.round(haxe.Timer.stamp() * 1000);
    }
    
    private function clickAGButton(e : MouseEvent) : Dynamic
    {
        launchURL("http://www.miniclip.com");
    }
    
    private function loadGameBlockNG(e : Dynamic) : Dynamic
    {
        API.debugMode = API.RELEASE_MODE;
        API.addEventListener(APIEvent.API_CONNECTED, this.onAPIConnectedNG);
        API.connect(root, "38823:X0SZpdW4", "Iw5BU05iqCCU0sv1qYvu7oH1kQZAVcGR");
        this.startDelay.removeEventListener(TimerEvent.TIMER, this.loadGameBlockNG);
    }
    
    @:allow()
    private function onAPIConnectedNG(event : APIEvent) : Dynamic
    {
        API.removeEventListener(APIEvent.API_CONNECTED, this.onAPIConnectedNG);
        member = API.username + "_NG";
        memberDisplay = API.username;
        LevelStatus = "Normal";
        StatusName = "nothing";
        if (API.username != null)
        {
            this.loadGameBlock0();
            isOnline = true;
            rootHUD.spawnPopup("Logged in as " + memberDisplay + ", your game being saved online, log in from any computer to play!");
        }
        else
        {
            rootHUD.spawnPopup("You are not logged in, game will be saved locally");
            this.loadLocalGuest();
        }
    }
    
    @:allow()
    private function loadKiziLogo() : Dynamic
    {
        var mLoader : Loader = null;
        var logoUrl : String = null;
        var mRequest : URLRequest = null;
        mLoader = new Loader();
        if (ExternalInterface.available)
        {
            logoUrl = ExternalInterface.call("getLogoUrl");
        }
        else
        {
            logoUrl = "http://kizi.com/assets/kiziLogo.swf";
        }
        mRequest = new URLRequest(logoUrl);
        mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onKiziLogoComplete);
        mLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onKiziLogoError);
        mLoader.load(mRequest);
    }
    
    @:allow()
    private function onKiziLogoComplete(loadEvent : Event) : Dynamic
    {
        kiziLogo = loadEvent.currentTarget.content;
        rootHUD.HUD.logoKizi.addChild(kiziLogo);
        kiziLogo.x = -kiziLogo.width * 0.5;
        kiziLogo.y = -kiziLogo.height * 0.5;
    }
    
    @:allow()
    private function onKiziLogoError(errEvent : Event) : Dynamic
    {
    }
    
    private function loadGameBlockK(e : Dynamic) : Dynamic
    {
        this.startDelay.removeEventListener(TimerEvent.TIMER, this.loadGameBlockK);
        this.KongAPI();
    }
    
    private function loadGameBlockClean(e : Dynamic) : Dynamic
    {
        LevelStatus = "Normal";
        StatusName = "nothing";
        LoadIt = "Menus0Clean";
        DirIt = "World 1";
        this.loadLocalGuest();
        this.loadGameBlock4();
        rootHUD.popoutMenuMenu("nothing");
        rootHUD.HUD.popoutMenu.x = 810;
    }
    
    private function loadGameBlockA(e : Event = null) : Void
    {
        var urlLevel : String = null;
        var urlPoint : Int = 0;
        var doorPoint : Int = 0;
        if (daParameters.challenge != null)
        {
            StatusName = LevelStatus = daParameters.challenge;
        }
        else
        {
            LevelStatus = "Normal";
            StatusName = "nothing";
        }
        if (!(loaderInfo.url.indexOf("bornegames.com") == -1 && loaderInfo.url.indexOf("s3.amazonaws.com/BorneGames/Game_Files/") == -1))
        {
            if (cast(ExternalInterface.available, Bool) && Capabilities.playerType != "External")
            {
                urlLevel = ExternalInterface.call("reportHref");
                if (urlLevel != null)
                {
                    if (urlLevel.indexOf("level=") > -1)
                    {
                        rootHUD.HUD.debug.text += "\nlevel instead";
                        urlPoint = as3hx.Compat.parseInt(urlLevel.indexOf("level=") + 6);
                        if (daParameters.loadFrom == "W4")
                        {
                            if (urlLevel.substring(urlPoint, urlPoint + 1) == "1")
                            {
                                LoadIt = "Level1";
                                DirIt = "World 4";
                            }
                            else if (urlLevel.substring(urlPoint, urlPoint + 1) == "d")
                            {
                                LoadIt = "Dared3";
                                DirIt = "World 4";
                            }
                            else if (urlLevel.substring(urlPoint, urlPoint + 1) == "a")
                            {
                                LoadIt = "Arena1";
                                DirIt = "World 4";
                            }
                            else if (urlLevel.substring(urlPoint, urlPoint + 1) == "s")
                            {
                                LoadIt = "Arena0";
                                DirIt = "World 4";
                                LevelStatus = "Smash";
                            }
                            else
                            {
                                LoadIt = "Trans1";
                                DirIt = "World 4";
                            }
                        }
                        else if (daParameters.loadFrom == "remix")
                        {
                            rootHUD.HUD.debug.text += "\n wrong remix";
                            if (localSettings.role == "full")
                            {
                                LoadIt = "Level" + urlLevel.substring(urlPoint, urlPoint + 1);
                            }
                        }
                        else
                        {
                            loadedFromURL = true;
                            LoadIt = urlLevel.substring(urlPoint, urlPoint + 8);
                            doorPoint = as3hx.Compat.parseInt(urlLevel.indexOf("door=") + 5);
                            if (doorPoint > -1)
                            {
                                DoorIt = as3hx.Compat.parseInt(urlLevel.substring(doorPoint, doorPoint + 1));
                            }
                        }
                    }
                    else if (daParameters.loadFrom == "remix")
                    {
                        rootHUD.HUD.debug.text += daParameters.levelTo;
                        if (daParameters.levelTo == null)
                        {
                            LoadIt = "Menus0";
                        }
                        else
                        {
                            LoadIt = daParameters.levelTo;
                        }
                        DirIt = "World 1";
                    }
                    else if (daParameters.loadFrom == "W4")
                    {
                        LoadIt = "Trans1";
                        DirIt = "World 4";
                    }
                }
                rootHUD.HUD.debug.text += "\n" + LoadIt;
            }
        }
        if (DirIt == "World 1")
        {
            worldPrefix = "_W1R";
        }
        else
        {
            worldPrefix = "_W4A";
        }
        this.loadGameBlockB("nothing");
    }
    
    private function loadGameBlockB(e : Dynamic) : Dynamic
    {
        rootHUD.HUD.debug.text += "\n block A";
        if (memberDisplay == "Guest" || member == "Local" || member == "not_logged_in_BG")
        {
            this.loadLocalGuest();
        }
        else
        {
            rootHUD.spawnPopup("Logged in as " + memberDisplay + ", your game being saved online, log in from any computer to play!");
            isOnline = true;
            this.loadGameBlock0();
        }
    }
    
    private function loadGameBlock0() : Dynamic
    {
        parse_CheckSettingsLoad(this.loadGameBlock1);
    }
    
    private function loadGameBlock1() : Dynamic
    {
        parse_CheckScoresLoad(this.loadGameBlock2);
    }
    
    private function loadGameBlock2() : Dynamic
    {
        if ((stage.loaderInfo.url.indexOf("bornegames.com") > -1 || stage.loaderInfo.url.indexOf("s3.amazonaws.com/BorneGames/Game_Files/") > -1) && member != "Local")
        {
            parse_CheckKeys(false, this.loadGameBlock3);
        }
        else
        {
            rootHUD.HUD.keySwitch.gotoAndStop(2);
            this.loadGameBlock3();
        }
    }
    
    private function loadGameBlock3() : Dynamic
    {
        if (LevelStatus == "Normal")
        {
            sendAnalytics("logged_in");
            pauseStatus = "Ready";
        }
        else
        {
            if (Reflect.field(localScores, Std.string(LoadIt + "_" + StatusName)) != null && Reflect.field(localScores, Std.string(LoadIt + "_" + StatusName)) != 0)
            {
                rootHUD.HUD.debug.text += "\nBGConnect";
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("WriteToPage", "topshout", ["<strong>Floor Is Lava!</strong>  Challenge Complete!", "<strong>Squiggles Get!</strong>  Challenge Complete!", "<strong>AngryDragonBirdemic!</strong>  Challenge Complete!"][Lambda.indexOf(["Race", "Collect", "Birds"], LevelStatus)]);
                }
            }
            ScoresTable("Scores" + worldPrefix, LoadIt + "_" + StatusName, false, 21, function(tempText : Dynamic) : Dynamic
                    {
                        if (ExternalInterface.available)
                        {
                            ExternalInterface.call("WriteToPage", "highscores", "High Scores:<br/>" + tempText);
                        }
                        sendAnalytics("logged_in");
                    });
            pauseStatus = "Ready";
        }
    }
    
    private function loadLocalGuest() : Dynamic
    {
        localSettings = shared.data.settings;
        world4Progress = shared.data.world4Progress;
        fillUndefined();
        this.debugSettings();
        Char.Squiggles = localSettings.squiggles;
        if (shared.data.scores == null)
        {
            localScores = { };
        }
        else
        {
            localScores = shared.data.scores;
        }
        Sounds.setVolume(localSettings.sfxVol);
        Sounds.musicVol = localSettings.musicVol * 0.7;
        if (Sounds.musicPlaying != "nothing")
        {
            Sounds.setMusic(localSettings.musicVol);
            Sounds.updateMusic(1);
        }
        sendAnalytics("not_logged_in");
        if (LevelStatus == "Lava" || LevelStatus == "Collect" || LevelStatus == "Birds")
        {
            ScoresTable("Scores" + worldPrefix, LoadIt + "_" + StatusName, false, 21, function(tempText : Dynamic) : Dynamic
                    {
                        if (ExternalInterface.available)
                        {
                            ExternalInterface.call("WriteToPage", "highscores", "High Scores:<br/>" + tempText);
                        }
                    });
        }
        pauseStatus = "Ready";
    }
    
    private function debugSettings() : Void
    {
        if (!loadedFromURL)
        {
            if (shared.data.debug == null)
            {
                shared.data.debug = { };
                shared.data.debug.loadit = LoadIt;
                shared.data.debug.doorit = DoorIt;
                shared.data.debug.dirit = DirIt;
            }
            else if (shared.data.debug.loadit != "LevelSelect")
            {
                LoadIt = shared.data.debug.loadit;
                DoorIt = shared.data.debug.doorit;
                DirIt = shared.data.debug.dirit;
                trace("debug " + LoadIt + " " + DoorIt + " " + DirIt);
            }
        }
        if (DoorIt < 0)
        {
            DoorIt = 0;
        }
        debugGivePen(LoadIt, DirIt);
    }
    
    private function localToNetwork() : Dynamic
    {
        member = kongregate.services.getUsername() + "_KG";
        memberDisplay = kongregate.services.getUsername();
        localScores = [];
        tempSettings = localSettings;
        localSettings.gamerId = member;
        parse_CheckSettingsLoad(this.finishLocalToNetwork);
    }
    
    private function finishLocalToNetwork() : Dynamic
    {
        var i : Int = 0;
        rootHUD.spawnPopup("You have logged in, save file is now online!");
        if (localSettings.role == "beta")
        {
            rootHUD.spawnPopup("Thank you Beta Tester!  You rock at least a metric ton of socks!");
        }
        if (tempSettings.pantsN > 6)
        {
            tempSettings.pantsN = 0;
        }
        if (tempSettings.hatN > 9)
        {
            tempSettings.hatN = 0;
        }
        if (tempSettings.patternN > 3)
        {
            tempSettings.patternN = 0;
        }
        if (tempSettings.hasHatsString.length > 9)
        {
            tempSettings.hasHatsString = "";
        }
        if (tempSettings.hasPatternsString.length > 3)
        {
            tempSettings.hasPatternsString = "";
        }
        if (tempSettings.hasPantsString.length > 3)
        {
            tempSettings.hasPantsString = "";
        }
        if (tempSettings.hasHatsString.length > 11)
        {
            tempSettings.hasPantsString = "";
        }
        if (tempSettings.hasPatternsString.length > 4)
        {
            tempSettings.hasPatternsString = "";
        }
        localSettings.sfxVol = tempSettings.musicVol;
        localSettings.musicVol = tempSettings.musicVol;
        localSettings.pantsN = tempSettings.pantsN;
        localSettings.hatN = tempSettings.hatN;
        localSettings.patternN = tempSettings.patternN;
        for (i in 0...tempSettings.hasPantsString.length)
        {
            if (tempSettings.hasPantsString.substr(i, 1) == "y")
            {
                quickEditSaveString("Pants", i);
            }
        }
        for (i in 0...tempSettings.hasHatsString.length)
        {
            if (tempSettings.hasHatsString.substr(i, 1) == "y")
            {
                quickEditSaveString("Hats", i);
            }
        }
        for (i in 0...localSettings.hasPatternsString.length)
        {
            if (tempSettings.hasPatternsString.substr(i, 1) == "y")
            {
                quickEditSaveString("Patterns", i);
            }
        }
        if (tempSettings.pantsN > 3)
        {
            if (tempSettings.hasPantsString.substr(tempSettings.pantsN - 4, 1) != "y")
            {
                tempSettings.pantsN = 0;
            }
        }
        if (localSettings.hatN > 0)
        {
            if (localSettings.hasHatsString.substr(localSettings.hatN - 1, 1) != "y")
            {
                localSettings.hatN = 0;
            }
        }
        if (localSettings.patternN > 0)
        {
            if (localSettings.hasPatternsString.substr(localSettings.patternN - 1, 1) != "y")
            {
                localSettings.patternN = 0;
            }
        }
        if (localSettings.colorN > 4)
        {
            if (localSettings.hasPantsString.substr(localSettings.colorN - 5, 1) != "y")
            {
                localSettings.colorN = 0;
            }
        }
        tempSettings = null;
        shared.data.settings = null;
        shared.data.scores = null;
        parse_saveSettings();
        kongregate.mtx.requestUserItemList(null, this.onUserItems);
    }
    
    private function loadGameBlock4() : Dynamic
    {
        rootHUD.HUD.debug.text += "\n block 4";
        if (localSettings.role == "beta")
        {
            rootHUD.spawnPopup("Thank you Beta Tester!  You rock at least a metric ton of socks!");
        }
        if (localSettings.pantsN > 3)
        {
            if (localSettings.hasPantsString.substr(localSettings.pantsN - 4, 1) != "y")
            {
                localSettings.pantsN = 0;
            }
        }
        if (localSettings.hatN > 0)
        {
            if (localSettings.hasHatsString.substr(localSettings.hatN - 1, 1) != "y")
            {
                localSettings.hatN = 0;
            }
        }
        if (localSettings.patternN > 0)
        {
            if (localSettings.hasPatternsString.substr(localSettings.patternN - 1, 1) != "y")
            {
                localSettings.pantsN = 0;
                localSettings.patternN = 0;
            }
        }
        if (localSettings.colorN > 4)
        {
            if (localSettings.hasPantsString.substr(localSettings.colorN - 5, 1) != "y")
            {
                localSettings.colorN = 0;
            }
        }
        this.cacheEffects();
        if (isScaleForm)
        {
            stageRoot.addChild(rootHUD.HUD);
            rootHUD.HUD.setupLevelSelect();
        }
        else if (!debug || true)
        {
            Sounds.fadeOutMusic(Sounds.getMusic(LoadIt, DoorIt));
            this.startLoad(LoadIt, DirIt);
        }
        else
        {
            stageRoot.addChild(rootHUD.HUD);
            rootHUD.HUD.setupLevelSelect();
        }
    }
    
    public function startLoad(level : Dynamic, dir : Dynamic) : Dynamic
    {
        var subdir : String = null;
        var levelRequest : URLRequest = null;
        var _lc : LoaderContext = null;
        var levelClass : Class<Dynamic> = null;
        removeEventListener(Event.ENTER_FRAME, this.nullEnterFrame);
        LoadIt = level;
        DirIt = dir;
        if (FadeClip == null)
        {
            if (level == "Level1-a" && DoorIt == 0)
            {
                FadeClip = new FadeInWhite();
            }
            else if (level == "Level5-a")
            {
                FadeClip = new FadeInBlack();
            }
            else
            {
                FadeClip = new FadeIn();
            }
        }
        stageRoot.addChild(FadeClip);
        if (myLoadHUD == null)
        {
            myLoadHUD = new LoadHUD();
        }
        stageRoot.addChild(myLoadHUD);
        myLoadHUD.gotoAndStop(2);
        myLoadHUD.bar.scaleX = 0;
        rootHUD.HUD.debug.text += "\n start load " + level;
        if (external)
        {
            if (dir != "World 4")
            {
                if (level.substr(0, 5) == "Level")
                {
                    LastFullLevel = level;
                }
                subdir = "";
            }
            else if (level.substr(0, 5) == "Menus" || level.substr(0, 5) == "Bonus" || level.substr(0, 5) == "Dared")
            {
                subdir = "Level" + level.substr(5, level.indexOf("-") - 5) + "/";
            }
            else if (level.substr(0, 5) == "Level" || level.substr(0, 5) == "Villa")
            {
                LastFullLevel = level;
                subdir = level.substr(0, 6) + "/";
            }
            else
            {
                subdir = "";
            }
            trace("start load " + dir + "/" + subdir + level);
            this.levelLoader = new Loader();
            rootHUD.HUD.debug.text += "\n" + whereAt;
            if (isScaleForm)
            {
                levelRequest = new URLRequest(whereAt + "Levels/" + dir + "/" + subdir + level + ".swf");
            }
            else
            {
                levelRequest = new URLRequest(whereAt + "Levels/" + dir + "/" + subdir + level + ".swf?ver=1551080420");
            }
            this.levelLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onLevelLoadProgress);
            this.levelLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLevelLoadComplete);
            this.levelLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLevelLoadFail);
            if (deviceID == "PC")
            {
                this.levelLoader.load(levelRequest);
            }
            else
            {
                _lc = new LoaderContext(false, ApplicationDomain.currentDomain, null);
                this.levelLoader.load(levelRequest, _lc);
            }
        }
        else
        {
            levelClass = Type.getClass(Type.resolveClass("AllEverything" + worldPrefix + "_" + level));
            AllEverything = Type.createInstance(levelClass, []);
            levelClass = null;
            addChild(AllEverything);
            bitmapTotal = 0;
            if (justBitmaps)
            {
                AllEverything.x = AllEverything.y = 0;
                AllEverything.scaleX = AllEverything.scaleY = 1;
                myLoadHUD.bar.scaleX = 0;
                myLoadHUD.gotoAndStop(3);
                cacheBackgroundN = as3hx.Compat.parseInt(backgroundsN - 1);
                waitToCacheN = 10;
                addEventListener(Event.ENTER_FRAME, this.CacheLevelEnterFrame);
                stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
            }
            else
            {
                this.loadLevel(LoadIt, DoorIt);
            }
        }
    }
    
    @:allow()
    private function onLevelLoadProgress(mProgress : ProgressEvent) : Dynamic
    {
        myLoadHUD.bar.scaleX = mProgress.bytesLoaded / mProgress.bytesTotal * 1.3;
    }
    
    @:allow()
    private function onLevelLoadComplete(event : Event) : Dynamic
    {
        this.levelLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLevelLoadComplete);
        this.levelLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onLevelLoadProgress);
        this.levelLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onLevelLoadFail);
        levelContainer = try cast(event.target.content, MovieClip) catch(e:Dynamic) null;
        levelClasses = event.target.applicationDomain;
        AllEverything = levelContainer.AllEverything;
        addChild(levelContainer);
        levelContainer.visible = false;
        AllEverything.x = AllEverything.y = 0;
        AllEverything.scaleX = AllEverything.scaleY = 1;
        myLoadHUD.bar.scaleX = 0;
        if (justBitmaps)
        {
            if (AllEverything.aPlats != null)
            {
                AllEverything.removeChild(AllEverything.getChildByName("aPlats"));
                AllEverything.aPlats = null;
            }
            if (AllEverything.interact != null)
            {
                AllEverything.removeChild(AllEverything.getChildByName("interact"));
                AllEverything.interact = null;
            }
            if (AllEverything.baddies != null)
            {
                AllEverything.removeChild(AllEverything.getChildByName("baddies"));
                AllEverything.baddies = null;
            }
            myLoadHUD.gotoAndStop(3);
            cacheBackgroundN = as3hx.Compat.parseInt(backgroundsN - 1);
            waitToCacheN = 10;
            addEventListener(Event.ENTER_FRAME, this.CacheLevelEnterFrame);
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
        }
        else
        {
            this.loadLevel(LoadIt, DoorIt);
        }
    }
    
    private function onLevelLoadFail(event : IOErrorEvent) : Void
    {
        this.levelLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLevelLoadComplete);
        this.levelLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onLevelLoadProgress);
        this.levelLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onLevelLoadFail);
        trace("load fail " + LoadIt);
        LevelLoaded = "nothing";
        this.startLoad("Villa0-b", "World 4");
        Sounds.playMusic(LoadIt);
    }
    
    public function loadLevel(level : Dynamic, door : Dynamic) : Dynamic
    {
        var i : Dynamic = 0;
        var n : Int = 0;
        var back : Backgrounds = null;
        this.levelProgress(level, door, DirIt);
        this.getBackgroundZs(level, door);
        if (AllEverything.interact == null)
        {
            originalMinX = originalMinY = MinX = MinY = -10000;
            originalMaxX = originalMaxY = MaxX = MaxY = 10000;
        }
        else if (AllEverything.interact.getChildByName("MinX") == null)
        {
            originalMinX = originalMinY = MinX = MinY = -10000;
            originalMaxX = originalMaxY = MaxX = MaxY = 10000;
        }
        else
        {
            originalMinX = MinX = AllEverything.interact.MinX.x;
            originalMaxX = MaxX = AllEverything.interact.MaxX.x;
            originalMinY = MinY = AllEverything.interact.MinY.y;
            originalMaxY = MaxY = AllEverything.interact.MaxY.y;
            trace("level area is " + (MaxX - MinX) * (MaxY - MinY));
            if ((MaxX - MinX) * (MaxY - MinY) > 50000000)
            {
                foreRes = 50000000 / ((MaxX - MinX) * (MaxY - MinY));
                trace("huuuge " + foreRes);
            }
        }
        Achievements.SendScore("maxCombo", 2);
        this.toForeground = level.substr(0, 6) != "Level2" && backgroundZs.length > 2;
        if (this.simpleBackgrounds)
        {
            if (this.toForeground)
            {
                AllEverything["background" + 1].addChild(AllEverything["background" + 0]);
                n = 1;
            }
            else
            {
                n = 0;
            }
            i = as3hx.Compat.parseInt(backgroundsN - 2);
            while (i > n)
            {
                AllEverything["background" + (backgroundsN - 1)].addChild(AllEverything["background" + i]);
                i--;
            }
            if (level == "Villa0-f")
            {
                backgroundZs = [0, 0];
            }
            else if (level.substr(0, 6) == "Level2")
            {
                backgroundZs = [0, 30];
            }
            else
            {
                backgroundZs = [0, 60];
            }
        }
        i = as3hx.Compat.parseInt(backgroundsN - 1);
        while (i >= 0)
        {
            Reflect.setField(stageRatios, Std.string(i), Reflect.setField(rootRatios, Std.string(i), cameraFocalLength / (cameraFocalLength + Reflect.field(backgroundZs, Std.string(i)))));
            Reflect.setField(stageXs, Std.string(i), originalStageX / Reflect.field(rootRatios, Std.string(i)));
            Reflect.setField(stageYs, Std.string(i), originalStageY / Reflect.field(rootRatios, Std.string(i)));
            back = new Backgrounds(true);
            this.addChild(back);
            if (level != "Lockd0" && level != "Menus0Clean" && level != "Menus3")
            {
                back.mouseChildren = false;
            }
            back.mouseEnabled = false;
            StarlingBackgrounds.addBackground(i);
            i--;
        }
        if (AllEverything.background0.selectLanguage)
        {
            AllEverything.background0.selectLanguage.gotoAndStop(localSettings.language);
        }
        stageRoot.addChild(rootHUD.HUD);
        stageRoot.addChild(FadeClip);
        myLoadHUD.gotoAndStop(3);
        stageRoot.addChild(myLoadHUD);
        cacheBackgroundN = as3hx.Compat.parseInt(backgroundsN - 1);
        if (isScaleForm)
        {
            this.finishLevelCache();
        }
        else
        {
            waitToCacheN = 20;
            addEventListener(Event.ENTER_FRAME, this.waitToCacheEnterFrame);
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
        }
    }
    
    private function levelProgress(load : String, door : Int, dir : String) : Void
    {
        if (load == "Villa0-b" && (door == 1 || door == 3))
        {
            saveDebug("Villa0-b", 1, "World 4");
        }
        else if (dir == "Arcade" || dir == "World 1")
        {
            saveDebug("Villa0-b", 1, "World 4");
        }
        else if (LevelLoaded == "MapScreen" || load.substr(0, 5) == "Trans")
        {
            saveDebug(load, 0, dir);
        }
        else if (load.substr(0, 5) == "Bonus" || door == 20)
        {
            saveDebug("Level" + load.substr(5, load.length - 5), 20, dir);
        }
        else if (LevelLoaded.substr(5, 1) != load.substr(5, 1))
        {
            saveDebug(load, 0, dir);
        }
        else if (load.length > 7)
        {
            if (as3hx.Compat.parseFloat(this.alphaSort.indexOf(load.substr(load.length - 1, 1))) > as3hx.Compat.parseFloat(this.alphaSort.indexOf(LevelLoaded.substr(LevelLoaded.length - 1, 1))))
            {
                saveDebug(load, 0, dir);
            }
        }
    }
    
    public function hideAllHUD(vis : Bool) : Void
    {
        var i : Int = 0;
        for (i in 0...numPlayers)
        {
            rootHUD.HUD["HealthBar" + i].visible = vis;
            rootHUD.HUD["counterLives" + i].visible = vis;
            if (!Char.hasShoot)
            {
                rootHUD.HUD["InkBar" + i].visible = false;
            }
            else
            {
                rootHUD.HUD["InkBar" + i].visible = vis;
            }
        }
        rootHUD.HUD.counterSquiggles.visible = vis;
    }
    
    private function QuitToMenu() : Dynamic
    {
    }
    
    public function BeatGame() : Dynamic
    {
        W1RContProg = 0;
        LoadIt = "Menus0";
    }
    
    public function loadBitmap(level : Dynamic, dir : Dynamic, backN : Dynamic) : Dynamic
    {
        var url : URLRequest = null;
        this.bitmapLoader = new Loader();
        if (dir == "World 1" && backN > 0)
        {
            level = "Level1";
        }
        url = new URLRequest(whereAt + "Levels/" + dir + "/" + level + "-" + backN + ".swf");
        this.bitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onBitmapLoadComplete);
        this.bitmapLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onBitmapLoadProgress);
        this.bitmapLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onBitmapLoadError);
        this.bitmapLoader.load(url);
    }
    
    @:allow()
    private function onBitmapLoadProgress(mProgress : ProgressEvent) : Dynamic
    {
        var percent : Float = mProgress.bytesLoaded / mProgress.bytesTotal;
    }
    
    @:allow()
    private function onBitmapLoadError(event : Event) : Dynamic
    {
        this.bitmapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onBitmapLoadComplete);
        this.bitmapLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onBitmapLoadProgress);
        this.bitmapLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onBitmapLoadError);
        if (cacheBackgroundN > 0)
        {
            trace("skip cache " + cacheBackgroundN);
            --cacheBackgroundN;
            this.loadBitmap(LoadIt, DirIt, cacheBackgroundN);
        }
        else
        {
            trace("load from level");
            cacheBackgroundN = as3hx.Compat.parseInt(backgroundsN - 1);
            waitToCacheN = 10;
            addEventListener(Event.ENTER_FRAME, this.CacheLevelEnterFrame);
        }
    }
    
    @:allow()
    private function onBitmapLoadComplete(event : Event) : Dynamic
    {
        var backClip : MovieClip = null;
        this.bitmapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onBitmapLoadComplete);
        this.bitmapLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onBitmapLoadProgress);
        this.bitmapLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onBitmapLoadError);
        backClip = new MovieClip();
        Backgrounds.backgroundsArray[cacheBackgroundN].addChild(backClip);
        backClip.addChild(event.currentTarget.content);
        event.currentTarget.content.gotoAndStop(1);
        if (cacheBackgroundN > 0)
        {
            --cacheBackgroundN;
            this.loadBitmap(LoadIt, DirIt, cacheBackgroundN);
        }
        else
        {
            this.setupLevel();
        }
    }
    
    @:allow()
    private function CacheLevelEnterFrame(texture : Texture = null) : Void
    {
        var n : Int = 0;
        this.TickOrTock();
        if (this.tick)
        {
            if (this.fadingMusic)
            {
                Sounds.musicEnterFrame();
            }
        }
        this.checkGamepads();
        if (this.simpleBackgrounds && cacheBackgroundN == backgroundsN - 2)
        {
            cacheBackgroundN = 0;
        }
        if (cacheBackgroundN >= 0)
        {
            if (cacheBackgroundN == 0)
            {
                if (this.simpleBackgrounds)
                {
                    if (this.toForeground)
                    {
                        n = 1;
                    }
                    else
                    {
                        n = 0;
                    }
                    if (StarlingBackgrounds.toStarlingFromMC(AllEverything["background" + n], stageRatios[cacheBackgroundN] * bitRes * foreRes, StarlingBackgrounds.BackgroundArray[0], 0, 0, false, this.CacheLevelEnterFrame, (Main.stageRatios[0] - this.blurOffset) * this.blurStrength))
                    {
                        --cacheBackgroundN;
                        this.CacheLevelEnterFrame();
                    }
                }
                else if (StarlingBackgrounds.toStarlingFromMC(AllEverything["background" + cacheBackgroundN], stageRatios[cacheBackgroundN] * bitRes * foreRes, StarlingBackgrounds.BackgroundArray[cacheBackgroundN], 0, 0, false, this.CacheLevelEnterFrame, (Main.stageRatios[cacheBackgroundN] - this.blurOffset) * this.blurStrength))
                {
                    --cacheBackgroundN;
                    this.CacheLevelEnterFrame();
                }
            }
            else if (this.simpleBackgrounds)
            {
                if (StarlingBackgrounds.toStarlingFromMC(AllEverything["background" + cacheBackgroundN], stageRatios[1] * bitRes * backRes, StarlingBackgrounds.BackgroundArray[1], 0, 0, false, this.CacheLevelEnterFrame, (Main.stageRatios[cacheBackgroundN] - this.blurOffset) * this.blurStrength))
                {
                    --cacheBackgroundN;
                    this.CacheLevelEnterFrame();
                }
            }
            else if (StarlingBackgrounds.toStarlingFromMC(AllEverything["background" + cacheBackgroundN], stageRatios[cacheBackgroundN] * bitRes * backRes, StarlingBackgrounds.BackgroundArray[cacheBackgroundN], 0, 0, false, this.CacheLevelEnterFrame, (Main.stageRatios[cacheBackgroundN] - this.blurOffset) * this.blurStrength))
            {
                --cacheBackgroundN;
                this.CacheLevelEnterFrame();
            }
        }
        else if (AllEverything["uberforeground" + -cacheBackgroundN] != null)
        {
            if (StarlingBackgrounds.addScrollObject(AllEverything["uberforeground" + -cacheBackgroundN], uberSpacing * cacheBackgroundN, uberRes, this.CacheLevelEnterFrame))
            {
                AllEverything["uberforeground" + -cacheBackgroundN].visible = false;
                if (AllEverything["uberforeground" + -cacheBackgroundN].parent == null)
                {
                    AllEverything["uberforeground" + -cacheBackgroundN].parent.removeChild(AllEverything["uberforeground" + -cacheBackgroundN]);
                }
                --cacheBackgroundN;
                this.CacheLevelEnterFrame();
            }
        }
        else
        {
            trace("bitmap area " + bitmapTotal);
            bitmapTotal = 0;
            StarlingBackgrounds.flattenBackgrounds();
            this.finishLevelCache();
        }
    }
    
    private function finishLevelCache() : Dynamic
    {
        stageRoot.removeChild(myLoadHUD);
        myLoadHUD = null;
        this.fillWithFaux();
        if (justBitmaps)
        {
            this.setupJustBitmaps();
        }
        else
        {
            this.setupLevel();
        }
    }
    
    private function cacheEffects() : Dynamic
    {
        var bounds : Rectangle = null;
        var bmpData : BitmapData = null;
        cachedEffects.cacheMe("Splat");
        cachedEffects.cacheMe("Slash1");
        cachedEffects.cacheMe("Slash2");
        cachedEffects.cacheMe("Slash3");
        cachedEffects.cacheMe("Slash4");
        cachedEffects.cacheMe("SlashMedium1");
        cachedEffects.cacheMe("SlashMedium2");
        cachedEffects.cacheMe("SlashHeavy1");
        cachedEffects.cacheMe("BuzzSaw");
        cachedEffects.cacheMe("SwipeUp");
        cachedEffects.cacheMe("HeavyUp");
        cachedEffects.cacheMe("HeavyDown");
        cachedEffects.cacheMe("PokeDown");
        cachedEffects.cacheMe("SlashRising");
        cachedEffects.cacheMe("Impact");
        if (isScaleForm)
        {
            cachedEffects.cacheMe("Pop");
            cachedEffects.cacheMe("SquigPop");
            cachedEffects.cacheMe("SmokePuff");
            inkSplatEffect = new InkSplat();
            inkSplatEffect.stop();
            inkSplatEffect.visible = false;
            addChild(inkSplatEffect);
            effect = null;
        }
        bounds = null;
        if (bmpData != null)
        {
            bmpData.dispose();
        }
    }
    
    private function setupBackgrounds() : Dynamic
    {
        collision.collisionOffsets = new Array<Dynamic>();
        StarlingBackgrounds.originalStageX = originalStageX;
        StarlingBackgrounds.originalStageY = originalStageY;
        StarlingBackgrounds.cameraFocalLength = cameraFocalLength;
        this.setupUberForeground();
    }
    
    private function setupUberForeground() : Dynamic
    {
        hasUberForeground = false;
        if (DirIt == "World 1")
        {
            if (LoadIt == "Level1" || LoadIt == "Level2")
            {
                UberForeground = new UberForegroundW1();
                UberForeground.gotoAndStop(LoadIt);
                hasUberForeground = true;
            }
        }
        else if (DirIt == "World 4")
        {
            if (false && LoadIt == "Level0-a")
            {
                UberForeground = new UberForegroundW4();
                UberForeground.gotoAndStop(LoadIt);
                hasUberForeground = true;
                UberForeground.houseWall.alpha = 0;
                UberForeground.houseWall.visible = false;
            }
        }
    }
    
    private function fillWithFaux() : Dynamic
    {
        var i : Int = 0;
        for (i in 0...backgroundsN)
        {
            if (AllEverything.getChildByName("ground" + i) == null)
            {
                AllEverything["ground" + i] = fauxContainer;
            }
            if (AllEverything.getChildByName("platforms" + i) == null)
            {
                AllEverything["platforms" + i] = fauxContainer;
            }
            if (AllEverything.getChildByName("walls" + i) == null)
            {
                AllEverything["walls" + i] = fauxContainer;
            }
            if (AllEverything.getChildByName("background" + i) != null)
            {
                AllEverything.getChildByName("background" + i).visible = false;
                AllEverything.removeChild(AllEverything.getChildByName("background" + i));
            }
            AllEverything["ground" + i].visible = false;
            AllEverything["platforms" + i].visible = false;
            AllEverything["walls" + i].visible = false;
        }
    }
    
    private function setupChars() : Dynamic
    {
        var i : Int = 0;
        for (i in 0...Char.ActiveCharArray.length)
        {
            Char.ActiveCharArray[i].parent.mask = null;
            Char.ActiveCharArray[i].parent.alpha = 1;
            Char.ActiveCharArray[i].clearStompedOn();
        }
        for (i in 0...Char.InactiveCharArray.length)
        {
            Char.InactiveCharArray[i].parent.visible = false;
        }
        if (transLevelOffsetX != 0 || transLevelOffsetY != 0)
        {
            for (i in 0...staticInteractObjects.InteractArray.length)
            {
                if (staticInteractObjects.InteractArray[i].ItIs == "WarpBox" && staticInteractObjects.InteractArray[i].warpDoor == DoorIt && staticInteractObjects.InteractArray[i].warpLevel == LevelLoaded)
                {
                    if (staticInteractObjects.InteractArray[i] != this && cast(staticInteractObjects.InteractArray[i].pairBox, Bool))
                    {
                        Char.transOffsets(staticInteractObjects.InteractArray[i].x, staticInteractObjects.InteractArray[i].y, staticInteractObjects.InteractArray[i].onRail, staticInteractObjects.InteractArray[i].delay, transLevelOffsetX, transLevelOffsetY);
                    }
                }
            }
            setScroll();
            transLevelOffsetX = transLevelOffsetY = 0;
        }
        else if (preservePlayers)
        {
            Char.shufflePlayers();
        }
        else
        {
            if (Char.CharN < numPlayers)
            {
                for (i in Char.CharN...numPlayers)
                {
                    this.addChar(DoorIt);
                }
                if (netMaster)
                {
                    stageRoot.addChar(0, true);
                }
                startControls();
            }
            else if (numPlayers < Char.CharN)
            {
                i = Char.CharN;
                while (i > numPlayers)
                {
                    Char.removeChar();
                    i--;
                }
                Char.CharN = numPlayers;
            }
            setupCharIcons();
            Char.dontSquiggle = DirIt == "Custom" || LevelStatus != "Normal";
            for (i in 0...Char.ActiveCharArray.length)
            {
                Char.ActiveCharArray[i].onRail = -1;
                Char.ActiveCharArray[i].cameraMaster = false;
                Char.ActiveCharArray[i].vOffset = vOffset;
                if (LevelStatus == "Race")
                {
                    Char.CharArray[i].inkReserve = 0;
                }
                if (LevelStatus == "Smash")
                {
                    Char.CharArray[i].inkReserve = 0;
                    rootHUD.HUD["counterSmash" + Char.ActiveCharArray[i].ID].smoke.text = "0%";
                    rootHUD.HUD["counterLives" + Char.ActiveCharArray[i].ID].smoke.text = 3;
                    Char.ActiveCharArray[i].charOutDoor(Char.ActiveCharArray[i].ID);
                }
                else
                {
                    Char.ActiveCharArray[i].charOutDoor(DoorIt);
                }
            }
            if (Char.CharN > 1 && false)
            {
                this.levelTimer = function() : Dynamic
                        {
                            return null;
                        };
            }
            else if (LevelStatus == "Race")
            {
                if (Reflect.field(localScores, Std.string(LoadIt + "_" + StatusName)) == null)
                {
                    Reflect.setField(localScores, Std.string(LoadIt + "_" + StatusName), "_");
                }
                if (Reflect.field(localScores, Std.string(LoadIt + "_" + StatusName)) == 0)
                {
                    rootHUD.HUD.debug.text = "Best Time: " + Reflect.field(localScores, Std.string(LoadIt + "_" + StatusName));
                }
                if (aPlat.hasRaceWall())
                {
                    this.frameCounter = -90;
                    this.levelTimer = this.preCountdownTimer;
                }
                else
                {
                    this.frameCounter = 0;
                    this.levelTimer = this.waitTimer;
                }
                rootHUD.HUD.centerText.text = "0.00";
            }
            else
            {
                rootHUD.HUD.centerText.text = "";
                this.levelTimer = function() : Dynamic
                        {
                            return null;
                        };
            }
        }
        for (i in 0...Char.ActiveCharArray.length)
        {
            Char.ActiveCharArray[i].vOffset = Char.ActiveCharArray[i].toVOffset = vOffset;
        }
    }
    
    private function forceColors() : Void
    {
        if (LoadIt == "Lockd3")
        {
            StarlingEffect.setColor(5150);
            StarlingSmoke.setColor(5150);
            StarlingBackgrounds.charColor = 5150;
            for (i in 0...Char.ActiveCharArray.length)
            {
                Char.ActiveCharArray[i].shadowVanity();
            }
        }
        else if (true || LevelLoaded == "Lockd3")
        {
            StarlingEffect.setColor(16777215);
            StarlingSmoke.setColor(16777215);
            StarlingBackgrounds.charColor = 16777215;
            for (i in 0...Char.ActiveCharArray.length)
            {
                Char.ActiveCharArray[i].resetAllVanity();
            }
        }
    }
    
    public function setupLevel(e : Event = null) : Dynamic
    {
        var i : Int = 0;
        if (!isTouchScreen)
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
        }
        preferScrollX = 1;
        preferScrollY = -1;
        gameMode = "level";
        if (DirIt == "Custom")
        {
            LevelStatus = AllEverything.LevelStatus;
        }
        else if (LoadIt == "Tests4")
        {
            gameMode = "showAll";
        }
        else if (LevelLoaded == "Menus3" && LoadIt.substr(0, 5) == "Level" || LoadIt.substr(0, 5) == "Races")
        {
            LevelStatus = "Race";
        }
        else if (LoadIt == "Arena0")
        {
            LevelStatus = "Smash";
        }
        else if (LevelStatus != "Normal")
        {
            LevelStatus = "Normal";
        }
        if (LevelStatus == "Race")
        {
            StatusName = "Time";
        }
        else
        {
            StatusName = "nothing";
        }
        if (LevelStatus == "Smash")
        {
            preferScrollX = 0;
            preferScrollY = 0;
            if (numPlayers == 1)
            {
                numPlayers = 2;
            }
        }
        collision.MaxY = MaxY;
        cameraZ = 0;
        levelScale = 1;
        this.oTimer = Math.round(haxe.Timer.stamp() * 1000);
        allTheFrames = 0;
        this.setupBackgrounds();
        this.populateChallenge(LevelStatus);
        if ("Starling" == "Scaleform")
        {
            availableBaddies = ["JumpPad", "Spider", "Mouse", "Bat", "bowlingBall", "aScratch", "Bird", "BossPencil", "Baddie1", "InkFly", "InkBall", "InkFloat", "Boss1", "Boss2"];
            availableInteracts = ["Door", "WarpBox", "TriggerBox", "SwitchBox", "KillaBox", "slidePole", "PortalBox", "PortalTear", "inkBoard", "SquigglePop", "SquiggleCannon", "Squiggle", "textBubbles", "justALoop", "spaceTear", "catFall", "PenPickup", "Checkpoint", "inkDripper", "inkThrower", "inkSink", "baddiePuddle", "KingLoop", "assistant", "fallOnBoss1", "inkVein", "Mayor", "baddieSink", "inkPipe", "captAttackLoop", "inkValve", "InkFly", "inkSpout", "PirateStuck1", "PirateStuck2", "PirateStuck3", "Spinner", "justAttack"];
        }
        else if (LevelStatus == "Collect")
        {
            availableBaddies = ["JumpPad", "aScratch"];
            availableInteracts = ["Squiggle", "Door", "InterDecal", "PortalBox"];
        }
        else if (LevelStatus == "Lava" || LevelStatus == "Birds")
        {
            availableBaddies = ["Spider", "JumpPad", "bowlingBall", "Bird"];
            availableInteracts = ["Door", "InterDecal"];
        }
        else if (LevelStatus == "Race" && false)
        {
            availableBaddies = ["JumpPad", "bowlingBall", "WarpBox", "TriggerBox"];
            availableInteracts = ["Door", "InterDecal", "PortalBox", "PortalTear", "WarpBox", "TriggerBox", "SquiggleCannon"];
        }
        else
        {
            availableBaddies = ["JumpPad", "Spider", "Ninja", "Mouse", "Bat", "SnailShell", "bowlingBall", "aScratch", "Bird", "BossPencil", "Baddie1", "InkFly", "InkBall", "InkFloat", "Boss1", "Boss2", "FinalBossW4"];
            availableInteracts = ["Door", "Squiggle", "SquigglePop", "grassPop", "WarpBox", "TriggerBox", "SwitchBox", "KillaBox", "PortalBox", "PortalTear", "InterDecal", "shadowSquiggle", "Pickup", "buttonMiniClip", "inkBoard", "looseSquiggle", "doodleGrass", "inkBubbleDecal", "SquiggleCannon", "slidePole", "spikeDecal", "spikeBarDecal", "justALoop", "justALoopStarling", "textBubbles", "spaceTear", "catFall", "PenPickup", "Checkpoint", "inkDripper", "inkThrower", "inkSink", "inkSinkFake", "inkSinkRising", "baddiePuddle", "KingLoop", "assistant", "fallOnBoss1", "inkVein", "Mayor", "baddieSink", "inkPipe", "captAttackLoop", "inkValve", "inkSpout", "PirateStuck1", "PirateStuck2", "PirateStuck3", "Spinner", "justAttack", "fadeInHelp", "bedForCin", "windowCutscene", "WalkingWorker", "IceCreamBox", "MapIcon", "cutieBob", "kingAndMayor", "ShipAndBaddie", "tutorialIcon", "fadeInSpurt", "iceCreamCart", "superMask", "aScratch", "SuperPencilT4", "arcadeMachine", "progressNode"];
        }
        if (onSite == "MiniClip")
        {
            availableInteracts.push("highScoresButton");
        }
        collision.CreateCollisionGrid();
        if (DirIt == "Arcade")
        {
            if (LoadIt == "Races1")
            {
                StarlingTemporary.createCache(new ToBeCachedR1(), 1, false);
            }
        }
        else if (DirIt == "World 4")
        {
            if (LoadIt == "Level0-a")
            {
                StarlingTemporary.createCache(new ToBeCachedHouse(), 2, false);
            }
            else if (LoadIt == "Villa0-a")
            {
                StarlingTemporary.createCache(new ToBeCachedCamp(), 1, false);
            }
            else if (LoadIt == "Villa0-b")
            {
                StarlingTemporary.createCache(new ToBeCachedTub(), 3, false);
            }
            else if (LoadIt == "Villa0-f")
            {
                StarlingTemporary.createCache(new ToBeCachedBoss1(), 1, false);
            }
            else if (LoadIt == "Level2-j")
            {
                StarlingTemporary.createCache(new ToBeCachedCaptLiftoff(), 1, true);
            }
            else if (LoadIt == "Level3-a")
            {
                StarlingTemporary.createCache(new ToBeCachedShip2(), 1, true);
            }
        }
        else if (LoadIt == "Trans1")
        {
            StarlingTemporary.createCache(new ToBeCachedW1T1(), 1, false);
        }
        else if (LoadIt == "Bonus2")
        {
            StarlingTemporary.createCache(new ToBeCachedW1B2(), 1, false);
        }
        else if (LoadIt == "Bonus3")
        {
            StarlingTemporary.createCache(new ToBeCachedW1B3(), 1, false);
        }
        else if (LoadIt == "Bonus5")
        {
            StarlingTemporary.createCache(new ToBeCachedW1B5(), 1, false);
        }
        else if (LoadIt == "Level2")
        {
            StarlingTemporary.createCache(new ToBeCachedW1L2(), 1, false);
        }
        else if (LoadIt == "Bonus8")
        {
            StarlingTemporary.createCache(new ToBeCachedW1B8(), 3, false);
        }
        else if (LoadIt == "Level3")
        {
            StarlingTemporary.createCache(new ToBeCachedW1L3(), 1, false);
        }
        this.forceColors();
        populateLevelArray();
        populateLevel(true);
        this.checkDoorBack();
        StarlingInteract.meshCache(StarlingBackgrounds.BackgroundObjArray[0]);
        StarlingSmoke.meshCache(StarlingBackgrounds.BackgroundObjArray[0]);
        StarlingEffect.meshCache(StarlingBackgrounds.BackgroundObjArray[0]);
        Char.checkInactives();
        Char.checkHealths();
        this.setupChars();
        setupCamera();
        rootHUD.HUD.shoutTheBox(LoadIt);
        if (LoadIt == "Menus1-a")
        {
            this.QuitToMenu();
            fillUndefined(true);
        }
        if (LevelStatus != "Smash")
        {
            if (shouldHideHUD(LoadIt))
            {
                this.hideAllHUD(false);
                if (LevelLoaded != "nothing" && !shouldHideHUD(LevelLoaded))
                {
                    this.QuitToMenu();
                }
            }
            else
            {
                this.hideAllHUD(true);
            }
        }
        if (DirIt == "World 1" && LoadIt.substr(0, 5) == "Level" && LoadIt != "Level5" && LevelStatus == "Normal")
        {
            kongStats("progress", as3hx.Compat.parseFloat(LoadIt.substr(5, 1)));
            if (as3hx.Compat.parseFloat(LoadIt.substr(5, 1)) > Main.localSettings.W1RProgress)
            {
                Main.localSettings.W1RProgress = as3hx.Compat.parseFloat(LoadIt.substr(5, 1));
            }
            if (as3hx.Compat.parseFloat(LoadIt.substr(5, 1)) > Main.localSettings.W1RContProg)
            {
                Main.localSettings.W1RContProg = as3hx.Compat.parseFloat(LoadIt.substr(5, 1));
                parse_saveSettings();
            }
        }
        sendSessions();
        Char.countUnlockables("Hats");
        Char.countUnlockables("Pants");
        Char.countUnlockables("Patterns");
        if (hasUberForeground)
        {
            this.addChild(UberForeground);
        }
        this.addChild(rootHUD.HUD);
        setScroll();
        StarlingBackgrounds.myStarling.render();
        if (preservePlayers)
        {
            preservePlayers = false;
            staticInteractObjects.InteractEnterFrameArray.splice(staticInteractObjects.InteractEnterFrameArray.indexOf(FadeClip), 1);
            stageRoot.removeChild(FadeClip);
            FadeClip = null;
        }
        else
        {
            this.addChild(FadeClip);
            rootHUD.popupN = 30;
        }
        if (canPopOut)
        {
            if (LoadIt.substr(0, 5) == "Menus")
            {
                if (rootHUD.HUD.popoutMenu.alpha == 0)
                {
                    rootHUD.popoutMenuMenu("fadein");
                }
            }
            else if (LevelLoaded.substr(0, 5) == "Menus")
            {
                if (mouseX / rootHUD.HUD.scaleX <= 600)
                {
                    if (rootHUD.HUD.popoutMenu.status != "fadeout")
                    {
                        rootHUD.popoutMenuMenu("fadeout");
                    }
                }
                rootHUD.HUD.popOutLogic(mouseX / rootHUD.HUD.scaleX);
            }
        }
        else
        {
            rootHUD.popoutMenuMenu("nothing");
        }
        LevelLoaded = LoadIt;
        DoorLoaded = DoorIt;
        DirLoaded = DirIt;
        DoorIt = -1;
        rootHUD.HUD.debug.text = "";
        if (LevelStatus != "Normal" && LevelStatus != "Race" && LevelStatus != "Smash")
        {
            this.shoutTheChallenge(LevelStatus);
            this.MainEnterFrame60();
            pauseStatus = "Wait";
            rootHUD.HUD.popoutMenu.x = originalStageX * 2 - 10;
            rootHUD.popoutMenuMenu("fadeout");
            addEventListener(Event.ENTER_FRAME, this.ChallengeStartEnterFrame);
        }
        else
        {
            pauseStatus = "nothing";
            this.waitASec = 12;
            this.MainEnterFrame60();
            addEventListener(Event.ENTER_FRAME, this.MainEnterFrame60);
        }
    }
    
    private function checkDoorBack() : Void
    {
        if (DoorIt == 20)
        {
            DoorIt = staticInteractObjects.findLevelDoor("bonus");
        }
        else if (DoorIt == -1)
        {
            DoorIt = staticInteractObjects.findLevelDoor(LevelLoaded);
        }
    }
    
    private function setupJustBitmaps() : Dynamic
    {
        justBitmaps = false;
        if (isScaleForm)
        {
            removeEventListener(Event.ENTER_FRAME, VectorLevelEnterFrame);
        }
        else
        {
            removeEventListener(Event.ENTER_FRAME, this.CacheLevelEnterFrame);
        }
        if (!isTouchScreen)
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
        }
        StarlingBackgrounds.myStarling.render();
        staticInteractObjects.InteractEnterFrameArray.splice(staticInteractObjects.InteractEnterFrameArray.indexOf(FadeClip), 1);
        FadeClip.parent.removeChild(FadeClip);
        FadeClip = null;
        StarlingEffect.elevate();
        StarlingInteract.elevate();
        StarlingDecals.elevate();
        if (pauseStatus == "nothing")
        {
            addEventListener(Event.ENTER_FRAME, this.MainEnterFrame60);
        }
    }
    
    public function addChar(door : Int = 0, puppet : Bool = false) : Dynamic
    {
        var char : Char = null;
        var i : Int = 0;
        if (Char.DisabledArray.length == 0)
        {
            char = new Char(0, puppet);
            this.checkGamepads();
            while (i < this.workerGamepadID.length)
            {
                if (this.workerGamepadBinded[i] == null)
                {
                    if (char.addGamepad(this.workerGamepadID[i], this.workerGamepadName[i], i))
                    {
                        this.workerGamepadBinded[i] = true;
                    }
                    break;
                }
                i++;
            }
            Char.shuffleControls();
        }
        else
        {
            char = Char.DisabledArray.pop();
            char.reEnableChar();
        }
        char.parent.mouseEnabled = false;
        char.parent.mouseChildren = false;
        addChild(char.parent);
        char.onRail = -1;
        if (Char.ActiveCharArray.length > 1)
        {
            char.respawnChar(0);
        }
        else
        {
            char.charOutDoor(door);
        }
        if (hasUberForeground)
        {
            addChild(UberForeground);
        }
        addChild(rootHUD.HUD);
    }
    
    private function populateChallenge(status : Dynamic) : Dynamic
    {
        var baddiesClass : Class<Dynamic> = null;
        var interactClass : Class<Dynamic> = null;
        if (status == "Normal" || status == "Race" || status == "Smash")
        {
            baddiePlacers = AllEverything.getChildByName("baddies");
            interactPlacers = AllEverything.getChildByName("interact");
        }
        else
        {
            AllEverything.removeChild(AllEverything.getChildByName("baddies"));
            AllEverything.baddies = null;
            baddiesClass = Type.getClass(Type.resolveClass("baddie" + status + "Placers_" + LoadIt));
            baddiePlacers = Type.createInstance(baddiesClass, []);
            AllEverything.addChild(baddiePlacers);
            AllEverything.removeChild(AllEverything.getChildByName("interact"));
            AllEverything.interact = null;
            interactClass = Type.getClass(Type.resolveClass("interact" + status + "Placers_" + LoadIt));
            interactPlacers = Type.createInstance(interactClass, []);
            AllEverything.addChild(interactPlacers);
            this.frameCounter = 0;
            rootHUD.HUD.centerText.text = "0.00";
        }
    }
    
    @:allow()
    private function mouseDown(event : MouseEvent) : Dynamic
    {
        var emailLink : URLRequest = null;
        if (event.target.name == "logoKizi")
        {
            launchURL("http://www.kizi.com");
        }
        else if (event.target.name == "kiziWalkthrough")
        {
            launchURL("http://kizi.com/videos/fpa-world-1-remix");
        }
        else if (event.target.name == "Kong")
        {
            launchURL("http://www.kongregate.com?haref=fpa_remix&src=spon&cm=fpa_remix");
        }
        else if (event.target.name == "MiniClip")
        {
            launchURL("http://www.miniclip.com");
        }
        else if (event.target.name == "AddictingGames")
        {
            launchURL("http://www.addictinggames.com");
        }
        else if (event.target.name == "getakey" || event.target.name == "hasakey")
        {
            if (pauseStatus == "Key")
            {
                unKeyGame();
            }
            else
            {
                if (pauseStatus == "Menu")
                {
                    unPauseGame();
                }
                KeyGame();
            }
        }
        else if (event.target.name == "mute")
        {
            Sounds.muteButton();
        }
        else if (event.target.name == "highscores")
        {
            if (pauseStatus == "nothing")
            {
                MiniclipAPI.services.addEventListener(HighscoreEvent.CLOSE, this.handleHSBClosed);
                MiniclipAPI.services.showHighscores(event.target.parent.level);
                pauseStatus = "showhighscores";
                removeEventListener(Event.ENTER_FRAME, this.MainEnterFrame60);
            }
        }
        else if (LevelLoaded != "nothing")
        {
            if (pauseStatus == "hideUI")
            {
                pauseStatus = "Menu";
                PauseMenu.pausemenu.visible = true;
                rootHUD.HUD.visible = true;
            }
            else if (pauseStatus == "checkForKey")
            {
                unKeyGame();
                if (stage.loaderInfo.url.indexOf("bornegames.com") > -1 || cast(stage.loaderInfo.url.indexOf("s3.amazonaws.com/BorneGames/Game_Files/"), Bool))
                {
                    parse_CheckKeys(true, function() : Dynamic
                            {
                            });
                }
                else if (kongregate != null)
                {
                    kongregate.mtx.requestUserItemList(null, this.onUserItems);
                }
            }
            else if (pauseStatus == "tutorial")
            {
                this.clickPauseMenu(event);
            }
            else if (pauseStatus == "Menu")
            {
                this.clickPauseMenu(event);
            }
            else if (pauseStatus == "Language")
            {
                PauseMenu.pausemenu.selectLanguage(event);
            }
            else if (pauseStatus == "Credits")
            {
                PauseMenu.pausemenu.removeCredits();
            }
            else if (pauseStatus == "confirm")
            {
                if (event.target.name == "yes")
                {
                    LoadIt = "Menus0";
                    unPauseGame();
                }
                else
                {
                    PauseMenu.pausemenu.confirm.visible = false;
                    pauseStatus = "Menu";
                }
            }
            else if (pauseStatus == "Key")
            {
                if (event.target.name == "key" || event.target.name == "fancykey" || event.target.name == "silverkey" || event.target.name == "goldkey" || event.target.name == "platinumkey" || event.target.name == "extrafancykey")
                {
                    pauseStatus = "checkForKey";
                    KeyMenu.BuyKey();
                    buyAKey(event.target.name);
                }
                else
                {
                    unKeyGame();
                }
            }
            else if (pauseStatus == "Gamepad")
            {
                if (event.target.name == "gamepads")
                {
                    launchURL("http://www.bornegames.com/faqs/gamepads/");
                }
                else if (event.target.parent == null || event.target.name != "skip" && event.target.name != "startover" && event.target.parent.name != "setupGamepadButton")
                {
                    PauseMenu.gamepadmenu.killSetupGamepad();
                }
            }
            else if (pauseStatus == "arcadeSelect")
            {
                arcadeMachine.clickItems();
            }
            else if (pauseStatus == "nothing" && FadeClip == null)
            {
                if (mouseX / rootHUD.HUD.scaleX > 600 && canPopOut)
                {
                    var _sw29_ = (event.target.name);                    

                    switch (_sw29_)
                    {
                        case "world4":
                            launchURL("http://www.bornegames.com/games/fpa-world-4/");
                        case "challenges":
                            launchURL("http://www.bornegames.com/games/fpa-world-1/even-more/");
                        case "original":
                            launchURL("http://www.bornegames.com/games/fpa-world-1/original/");
                        case "world2":
                            launchURL("http://www.bornegames.com/games/fpa-world-2/");
                        case "world3":
                            launchURL("http://www.bornegames.com/games/fpa-world-3/play/");
                        case "contact":
                            emailLink = new URLRequest("mailto:brad@bornegames.com");
                            flash.Lib.getURL(emailLink);
                        case "gamepads":
                            launchURL("http://www.bornegames.com/faqs/gamepads/");
                        case "download":
                            launchURL("http://www.bornegames.com/files/downloadRemix.php");
                    }
                }
                else if (pauseStatus != "quitting")
                {
                    if (mouseX / rootHUD.HUD.scaleX < relativeStageX || Char.CharN == 1)
                    {
                        PauseGame(true, 0);
                    }
                    else
                    {
                        PauseGame(true, 1);
                    }
                }
            }
        }
        else
        {
            mouseIsDown = true;
        }
    }
    
    private function clickPauseMenu(event : Event) : Void
    {
        if (pauseStatus == "tutorial")
        {
            if (myTutorialPopup.clickTutorial(event))
            {
                this.unTutorialGame();
            }
            return;
        }
        PauseMenu.pausemenu.canClick = true;
        if (event.target.name == null)
        {
            if (PauseMenu.pausemenu.myLanguageSelector != null)
            {
                PauseMenu.pausemenu.removeLanguageSelector();
            }
            else
            {
                unPauseGame();
            }
        }
        else if (event.target.name == "tutorial")
        {
            cast((false), TutorialGame);
        }
        else if (PauseMenu.pausemenu.IconArray[0].x <= 800)
        {
            if (event.target.name != "knob")
            {
                if (Math.abs(PauseMenu.pausemenu.mouseY - 220) < 40)
                {
                    this.oMouseX = PauseMenu.pausemenu.mouseX;
                    PauseMenu.pausemenu.setScrollPantsOffset(PauseMenu.pausemenu.mouseX);
                    pauseStatus = "scrollPants";
                    stage.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseScrollPants);
                }
                else if (Math.abs(PauseMenu.pausemenu.mouseY - 140) < 40)
                {
                    this.oMouseX = PauseMenu.pausemenu.mouseX;
                    PauseMenu.pausemenu.setScrollHatsOffset(PauseMenu.pausemenu.mouseX);
                    pauseStatus = "scrollHats";
                    stage.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseScrollHats);
                }
                else if (event.target.name == "customize")
                {
                    PauseMenu.pausemenu.clickSomething(event.target);
                }
                else if (event.target.parent.name == "quitToMenu")
                {
                    LoadIt = "Menus1-a";
                    unPauseGame();
                }
                else if (event.target.name == "kongButton")
                {
                    Achievements.KongButton();
                }
                else if (event.target.parent.name == "debugSelect")
                {
                    LoadIt = "LevelSelect";
                    unPauseGame();
                }
                else if (event.target.name == "mapIcon")
                {
                    LoadIt = "MapScreen";
                    unPauseGame();
                }
                else if (event.target.parent.name == "setupGamepadButton")
                {
                    PauseMenu.pausemenu.clickSetupGamepad();
                }
                else if (event.target.parent.name == "languageButton")
                {
                    PauseMenu.pausemenu.clickLanguage();
                }
                else if (event.target.parent.name == "goFullscreen")
                {
                    goFullscreen(true);
                }
                else if (event.target.parent.name == "creditsButton")
                {
                    PauseMenu.pausemenu.clickCredits();
                }
                else if (event.target.parent.name == "quitButton")
                {
                    if (DirIt == "World 4")
                    {
                        NativeApplication.nativeApplication.exit();
                    }
                    else
                    {
                        unPauseGame();
                        leaveArcade();
                    }
                }
                else if (event.target.parent.name == ",")
                {
                    if (LevelStatus != "Normal" && LevelStatus != "Race" && LevelStatus != "Smash")
                    {
                        flash.Lib.getURL(new URLRequest("http://www.bornegames.com/games/fpa-world-1/remix/"), "_self");
                    }
                    else
                    {
                        PauseMenu.pausemenu.confirm.visible = true;
                        PauseMenu.pausemenu.addChild(PauseMenu.pausemenu.confirm);
                        pauseStatus = "confirm";
                    }
                }
                else if (event.target.parent.name == "Handed")
                {
                    if (localSettings.oneHanded)
                    {
                        PauseMenu.pausemenu.controlsSelector.gotoAndStop(1);
                        Char.CharArray[0].changeControls("twohanded");
                        localSettings.oneHanded = false;
                    }
                    else
                    {
                        PauseMenu.pausemenu.controlsSelector.gotoAndStop(2);
                        Char.CharArray[0].changeControls("onehanded");
                        localSettings.oneHanded = true;
                    }
                }
                else if (event.target.parent.name == "hideUI")
                {
                    pauseStatus = "hideUI";
                    PauseMenu.pausemenu.visible = false;
                    rootHUD.HUD.visible = false;
                }
                else
                {
                    if (isTouchScreen)
                    {
                        if (Char.CharArray[0].hasGamepad)
                        {
                            Char.CharArray[0].usingGamepad = rootHUD.usingGamepad = false;
                        }
                        rootHUD.HUD.buttonsVisible(!this.onlyMove);
                    }
                    unPauseGame();
                }
            }
        }
    }
    
    private function mouseDownMap(event : MouseEvent) : Void
    {
        var temp : String = "nothing";
        MapClip.clickX();
    }
    
    public function clickMap() : Void
    {
        stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownMap);
    }
    
    public function loadAfterMap() : Void
    {
        startControls();
        LevelStatus = "Normal";
        setupCharIcons();
        rootHUD.HUD.buttonsVisible(true);
        StarlingBackgrounds.volcanoBackground.visible = true;
        this.ticktockslow = 0;
        removeEventListener(Event.ENTER_FRAME, this.mapEnterFrame);
        MapClip.parent.removeChild(MapClip);
        MapClip = null;
        rootHUD.HUD.visible = true;
        this.hideAllHUD(true);
        this.startLoad(LoadIt, "World 4");
        Sounds.fadeOutMusic(Sounds.getMusic(LoadIt));
        stage.focus = stage;
    }
    
    private function mouseScrollPants(e : Event) : Void
    {
        PauseMenu.pausemenu.scrollPants(PauseMenu.pausemenu.mouseX);
    }
    
    private function mouseScrollHats(e : Event) : Void
    {
        PauseMenu.pausemenu.scrollHats(PauseMenu.pausemenu.mouseX);
    }
    
    private function handleHSBClosed(e : HighscoreEvent) : Dynamic
    {
        MiniclipAPI.services.removeEventListener(HighscoreEvent.CLOSE, this.handleHSBClosed);
        pauseStatus = "nothing";
        addEventListener(Event.ENTER_FRAME, this.MainEnterFrame60);
    }
    
    @:allow()
    private function mouseUp(event : Event) : Dynamic
    {
        mouseIsDown = false;
        if (pauseStatus == "scrollPants")
        {
            pauseStatus = "Menu";
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseScrollPants);
            if (event.target.name == "customize")
            {
                PauseMenu.pausemenu.clickSomething(event.target);
            }
        }
        else if (pauseStatus == "scrollHats")
        {
            pauseStatus = "Menu";
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseScrollHats);
            if (event.target.name == "customize")
            {
                PauseMenu.pausemenu.clickSomething(event.target);
            }
        }
    }
    
    private function mouseMove(event : MouseEvent) : Dynamic
    {
        if (this.hideMouseN == 0)
        {
            this.hideMouseN = 30;
            flash.ui.Mouse.show();
        }
    }
    
    private function onFullscreen(e : Dynamic) : Dynamic
    {
        changeRes(stage.stageWidth, stage.stageHeight);
        StarlingBackgrounds.onResize();
    }
    
    @:allow()
    private function getKeysDown(event : KeyboardEvent) : Dynamic
    {
        var i : Int = 0;
        if (event.keyCode == 27)
        {
            event.preventDefault();
        }
        for (i in 0...Char.CharArray.length)
        {
            Char.CharArray[i].CheckKeysDown(event.keyCode);
        }
        if (debug)
        {
            if (event.keyCode == 73 && DirIt == "Custom")
            {
                refreshLevelNow = true;
            }
            if (event.keyCode == 82)
            {
                quickResetLevel = true;
            }
            if (event.keyCode == 88)
            {
                debugKey = true;
            }
            if (event.keyCode == 87)
            {
                this.slowMo = true;
            }
            if (event.keyCode == 80)
            {
                if (Char.CharN < 4)
                {
                    ++numPlayers;
                    this.addChar(0);
                    setupCharIcons();
                }
            }
            if (event.keyCode == 79)
            {
                if (Char.CharN > 1)
                {
                    --numPlayers;
                    Char.removeChar();
                    setupCharIcons();
                }
            }
            if (event.keyCode > 47 && event.keyCode < 58)
            {
                if (LevelStatus == "Normal")
                {
                    if (event.keyCode - 48 < staticInteractObjects.DoorArray.length)
                    {
                        DoorIt = as3hx.Compat.parseInt(event.keyCode - 48);
                    }
                }
            }
        }
        if ((event.keyCode == 32 || event.keyCode == 27) && !this.SpaceIsDown)
        {
            this.SpaceIsDown = true;
            if (pauseStatus == "nothing" && FadeClip == null)
            {
                if (Char.CharN > 1)
                {
                    for (i in 0...Char.CharArray.length)
                    {
                        if (!Char.CharArray[i].hasGamepad)
                        {
                            PauseGame(true, i);
                            return;
                        }
                    }
                    PauseGame(true, 0);
                }
                else
                {
                    PauseGame(true, 0);
                }
            }
        }
    }
    
    @:allow()
    private function getKeysUp(event : KeyboardEvent) : Dynamic
    {
        var i : Int = 0;
        for (i in 0...Char.CharArray.length)
        {
            Char.CharArray[i].CheckKeysUp(event.keyCode);
        }
        if (event.keyCode == 87)
        {
            this.slowMo = false;
        }
        if (event.keyCode == 82)
        {
            quickResetLevel = false;
        }
        if (event.keyCode == 88)
        {
            debugKey = false;
        }
        if (event.keyCode == 32 || event.keyCode == 80 || event.keyCode == 27 || event.keyCode == Char.CharArray[0].rootJumpIsDown)
        {
            this.SpaceIsDown = false;
        }
    }
    
    @:allow()
    private function getKeysUnPause(event : KeyboardEvent) : Dynamic
    {
        if (event.keyCode == 27)
        {
            event.preventDefault();
        }
        Char.CharArray[0].CheckKeysDown(event.keyCode);
        if (event.keyCode == 32 || event.keyCode == 80 || event.keyCode == 27)
        {
            if (!this.SpaceIsDown)
            {
                if (pauseStatus == "tutorial")
                {
                    this.unTutorialGame();
                }
                else if (pauseStatus == "Menu")
                {
                    unPauseGame();
                }
                else if (pauseStatus == "Key")
                {
                    unKeyGame();
                }
            }
            if (event.keyCode == 32)
            {
                this.SpaceIsDown = true;
            }
            Char.CharArray[0].SisDown = true;
        }
        else if (Char.CharArray[0].JumpIsDown())
        {
            if (!Char.CharArray[0].SisDown)
            {
                if (pauseStatus == "Menu")
                {
                    if (PauseMenu.pausemenu.selectorCat == "Map")
                    {
                        LoadIt = "MapScreen";
                    }
                    unPauseGame();
                }
                Char.CharArray[0].SisDown = true;
            }
        }
    }
    
    private function touchArcade(e : Event) : Void
    {
        arcadeMachine.touchItems();
    }
    
    public function unTutorialGame() : Void
    {
        myTutorialPopup.parent.removeChild(myTutorialPopup);
        myTutorialPopup = null;
        removeEventListener(Event.ENTER_FRAME, this.TutorialEnterFrame);
        if (PauseMenu.pausemenu != null && PauseMenu.pausemenu.visible)
        {
            pauseStatus = "Menu";
            addEventListener(Event.ENTER_FRAME, this.PauseEnterFrame);
        }
        else
        {
            pauseStatus = "nothing";
            addEventListener(Event.ENTER_FRAME, this.MainEnterFrame60);
            unpauseTouchscreen();
            if (LoadIt != "LevelSelect")
            {
                Sounds.resumeMusic();
                if (stageRoot.fadingMusic)
                {
                    Sounds.musicEnterFrame();
                }
            }
            startControls();
        }
    }
    
    private function WorkerLoadComplete(event : Event = null) : Void
    {
        var workerBytes : ByteArray = null;
        workerBytes = try cast(event.target.data, ByteArray) catch(e:Dynamic) null;
        this.controllerWorker = WorkerDomain.current.createWorker(workerBytes);
        this.mainToWorker = Worker.current.createMessageChannel(this.controllerWorker);
        this.workerToMain = this.controllerWorker.createMessageChannel(Worker.current);
        this.controllerWorker.setSharedProperty("mainToWorker", this.mainToWorker);
        this.controllerWorker.setSharedProperty("workerToMain", this.workerToMain);
        this.workerToMain.addEventListener(Event.CHANNEL_MESSAGE, this.fromWorker);
        this.controllerWorker.start();
    }
    
    private function fromWorker(event : Event) : Void
    {
        var mes : Array<Dynamic> = null;
        mes = try cast(this.workerToMain.receive(), Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null;
        if (mes[0] == "Start")
        {
            this.workerControls = true;
        }
        else if (mes[0] == "Add")
        {
            this.addGamepad(mes[1], mes[2], mes[3], mes[4]);
        }
        else if (mes[0] == "Remove")
        {
            this.removeGamepad(mes[1]);
        }
        trace("[Worker] " + mes);
    }
    
    private function controllerAdded(e : Event) : Void
    {
        var inputNames : Array<String> = null;
        var i : Int = 0;
        inputNames = new Array<String>();
        for (i in 0...e.device.numControls)
        {
            inputNames[i] = e.device.getControlAt(i).id;
        }
        e.device.enabled = true;
        this.gamepadArray.push(e.device);
        trace("Add " + e.device.name + " " + e.device.id + " " + (this.gamepadArray.length - 1));
        this.addGamepad(e.device.id, e.device.name, this.gamepadArray.length - 1, inputNames);
    }
    
    private function controllerRemoved(e : Event) : Void
    {
        var i : Int = 0;
        i = as3hx.Compat.parseInt(this.gamepadArray.indexOf(e.device));
        this.gamepadArray.removeAt(i);
        this.removeGamepad(i);
        trace(e.device);
    }
    
    private function addGamepad(gamepadid : String, gamepadname : String, gamepadnum : Int, inputnames : Dynamic) : Void
    {
        this.workerGamepadID.push(gamepadid);
        this.workerGamepadName.push(gamepadname);
        setupGamepad.workerGamepadInputs.push(inputnames);
        if (Char.addGamepads(gamepadid, gamepadname, gamepadnum))
        {
            this.workerGamepadBinded.push(true);
        }
        else
        {
            this.workerGamepadBinded.push(false);
        }
        this.useGamepads = this.workerGamepadID.length > 0;
    }
    
    private function removeGamepad(i : Int) : Void
    {
        var n : Int = 0;
        this.workerGamepadID.removeAt(i);
        this.workerGamepadName.removeAt(i);
        this.workerGamepadBinded.removeAt(i);
        setupGamepad.workerGamepadInputs.removeAt(i);
        Char.removeGamepads(i);
        for (n in 0...Char.CharArray.length)
        {
            if (Char.CharArray[n].hasGamepad)
            {
                Char.CharArray[n].gamepadNum = this.workerGamepadID.indexOf(Char.CharArray[n].gamepadID);
            }
        }
    }
    
    private function debugTimes(e : String) : Void
    {
        if (Math.round(haxe.Timer.stamp() * 1000) - debugN > 3)
        {
            trace(e + (Math.round(haxe.Timer.stamp() * 1000) - debugN));
        }
        debugN = Math.round(haxe.Timer.stamp() * 1000);
    }
    
    @:allow()
    private function MainEnterFrame60(e : Event = null) : Void
    {
        var n : Int = 0;
        var i : Int = 0;
        if (deviceID != "PC")
        {
            StarlingBackgrounds.myStarling.render();
        }
        rootHUD.HUD.checkSpecial(true);
        this.checkGamepads();
        if (true || allTheFrames > 0)
        {
            this.TickOrTock();
            if (this.tick)
            {
                n = 0;
                if (true || allTheFrames >= 33)
                {
                    allTheFrames -= 33;
                    n++;
                    debugN = Math.round(haxe.Timer.stamp() * 1000);
                    this.hideMouse();
                    Achievements.counter();
                    if (gameMode != "vase")
                    {
                        StarlingDecals.staticOnDeckOverlord();
                    }
                    this.levelTimer();
                    this.clearAllAutoOns();
                    if (this.fadingMusic)
                    {
                        Sounds.musicEnterFrame();
                    }
                    cachedEffects.EffectEnterFrames(framin);
                    Char.CharsCheckMoving();
                    Baddies.BaddiesCheckMoving();
                    Baddies.BaddieEnterFrames();
                    InteractObjects.InteractEnterFrames();
                    staticInteractObjects.InteractEnterFrames();
                    StarlingDecals.InteractEnterFrames();
                    StarlingTemporary.tempEnterFrames();
                    StarlingEffect.effectsEnterFrames(framin);
                    StarlingInteract.interactsEnterFrames(framin);
                    Char.CharEnterFrames();
                    aPlat.PlatEnterFrames();
                    aWall.WallEnterFrames();
                    collision.InteractCollisions();
                    InteractObjects.runCollisions();
                    Baddies.EveryCollisions();
                    Baddies.BaddiesRootStuff();
                    Char.EveryCollisions();
                    Char.saveWallRots();
                    aGround.GroundEnterFrames(framin, true);
                    this.scrollEngine();
                    InteractObjects.checkKillInteracts();
                    staticInteractObjects.checkKillInteracts();
                    rootHUD.allElements();
                    showDoorIcon = false;
                    Char.CharsFinishUp();
                    this.cameraShake();
                    if (gameMode != "vase" && gameMode != "outVase")
                    {
                        this.scrollEverything();
                    }
                    if (LoadIt != LevelLoaded)
                    {
                        if (DoorIt < 0)
                        {
                            DoorIt = 0;
                        }
                        this.ChangeLevel(LoadIt);
                        return;
                    }
                    if (DoorIt > -1)
                    {
                        toCameraShiftRatio = cameraShiftRatio = 1;
                        lockShiftRatio = 0;
                        cameraShift = lockShift = false;
                        boundsShiftDistX = boundsShiftDistY = 0;
                        cameraShiftX = -10000;
                        lockShiftBack();
                        for (i in 0...Char.ActiveCharArray.length)
                        {
                            Char.ActiveCharArray[i].charOutDoor(DoorIt);
                        }
                        DoorLoaded = DoorIt;
                        DoorIt = -1;
                    }
                    if (refreshLevelNow)
                    {
                        refreshLevelNow = false;
                        this.refreshLevel();
                        return;
                    }
                    if (quickResetObjects)
                    {
                        quickResetObjects = false;
                        this.levelQuickReset(true);
                    }
                    else if (quickResetLevel)
                    {
                        quickResetLevel = false;
                        if (Char.CharArray[0].health > 0)
                        {
                            if (LevelLoaded != "Level7")
                            {
                                this.levelQuickReset();
                                return;
                            }
                            if (BossPencil.Level < 4)
                            {
                                this.levelQuickReset();
                                return;
                            }
                        }
                    }
                }
            }
            else
            {
                this.levelTimer();
                this.clearAllAutoOns();
                Char.CharsCheckMoving();
                Baddies.BaddiesCheckMoving();
                Char.HalfMoves();
                staticInteractObjects.HalfInteractEnterFrames();
                StarlingDecals.InteractEnterFrames();
                aWall.WallEnterFrames();
                aPlat.PlatEnterFrames();
                collision.InteractCollisions();
                StarlingEffect.effectsEnterFrames(framin);
                StarlingInteract.halfEnterFrames(framin);
                InteractObjects.runCollisions();
                Baddies.EveryCollisions();
                Char.EveryCollisions();
                aGround.GroundEnterFrames(framin, false);
                InteractObjects.checkKillInteracts();
                staticInteractObjects.checkKillInteracts();
                Char.HalfCharSwitchAnims();
                this.scrollEngine();
                collision.sendVars(cameraX, cameraY, stageXs, stageYs);
                if (gameMode != "vase" && gameMode != "outVase")
                {
                    this.scrollEverything();
                }
            }
        }
        StarlingInteract.pressMeshes();
        StarlingSmoke.pressMeshes();
        StarlingEffect.pressMeshes();
        if (deviceID == "PC")
        {
            StarlingBackgrounds.myStarling.render();
        }
    }
    
    @:allow()
    private function TurtleWarpEnterFrame(e : Event = null) : Void
    {
        if (deviceID != "PC")
        {
            StarlingBackgrounds.myStarling.render();
        }
        this.TickOrTock();
        if (this.tick)
        {
            Char.CharArray[0].CharEnterFrame();
            FadeClip.InteractEnterFrame();
        }
        Char.CharArray[0].x = -Math.sin(Char.CharArray[0].fakeRL) * 80;
        Char.CharArray[0].y = Math.cos(Char.CharArray[0].fakeRL) * 80;
        Char.CharArray[0].fakeRL += 0.2 * framin;
        Char.CharArray[0].rotation += Char.CharArray[0].rotter * framin;
        Char.HalfCharSwitchAnims();
        this.scrollEngine();
        if (LoadIt != LevelLoaded)
        {
            FadeClip.parent.removeChild(FadeClip);
            FadeClip = null;
            removeEventListener(Event.ENTER_FRAME, this.TurtleWarpEnterFrame);
            Main.saveProgress("beatGame", true);
            resetWorld();
            this.ChangeLevel(LoadIt);
            startControls();
            return;
        }
        if (deviceID == "PC")
        {
            StarlingBackgrounds.myStarling.render();
        }
    }
    
    @:allow()
    private function PauseEnterFrame(e : Event) : Dynamic
    {
        if (this.slowMo)
        {
            framin = 1 / 33;
        }
        else
        {
            framin = (Math.round(haxe.Timer.stamp() * 1000) - this.oTimer) / 33;
        }
        this.checkGamepads();
        if (framin > 1)
        {
            framin = 1;
        }
        this.oTimer = Math.round(haxe.Timer.stamp() * 1000);
        if (pauseStatus == "Menu")
        {
            PauseMenu.pausemenu.PauseEnterFrame();
        }
        else if (pauseStatus == "scrollPants" || pauseStatus == "scrollHats")
        {
            PauseMenu.pausemenu.scrollCustomsEnterFrame();
        }
        else if (pauseStatus == "Key")
        {
            KeyMenu.keymenu.PauseEnterFrame();
        }
        else if (pauseStatus == "Gamepad")
        {
            this.mainToWorker.send("");
            PauseMenu.gamepadmenu.controlsArray = this.controllerWorker.getSharedProperty("controlsArray");
            PauseMenu.gamepadmenu.PauseEnterFrame();
        }
        StarlingBackgrounds.myStarling.render();
    }
    
    private function TutorialEnterFrame(e : Event) : Dynamic
    {
        if (this.slowMo)
        {
            framin = 1 / 33;
        }
        else
        {
            framin = (Math.round(haxe.Timer.stamp() * 1000) - this.oTimer) / 33;
        }
        if (myTutorialPopup.alpha < 1)
        {
            myTutorialPopup.alpha += 0.1;
        }
        myTutorialPopup.menuKeys(Char.CharArray[0].wantRL);
        Char.CharArray[0].pauseStuff();
        if (framin > 1)
        {
            framin = 1;
        }
        this.oTimer = Math.round(haxe.Timer.stamp() * 1000);
        StarlingBackgrounds.myStarling.render();
    }
    
    private function waitToCacheEnterFrame(e : Event) : Dynamic
    {
        if (this.fadingMusic)
        {
            Sounds.musicEnterFrame();
        }
        StarlingBackgrounds.myStarling.render();
        if (waitToCacheN > 0)
        {
            --waitToCacheN;
        }
        else
        {
            removeEventListener(Event.ENTER_FRAME, this.waitToCacheEnterFrame);
            this.CacheLevelEnterFrame();
        }
    }
    
    private function nullEnterFrame(e : Event) : Dynamic
    {
        if (this.fadingMusic)
        {
            Sounds.musicEnterFrame();
        }
        StarlingBackgrounds.myStarling.render();
    }
    
    private function mapEnterFrame(e : Event) : Dynamic
    {
        this.TickOrTockSlow();
        MapClip.InteractEnterFrame();
        this.checkGamepads();
        if (this.tick)
        {
            if (this.fadingMusic)
            {
                Sounds.musicEnterFrame();
            }
            cachedEffects.EffectEnterFrames(0.5);
        }
        StarlingBackgrounds.myStarling.render();
    }
    
    @:allow()
    private function ChallengeStartEnterFrame(e : Event) : Dynamic
    {
        var n : Int = 0;
        this.TickOrTock();
        if (this.tick)
        {
            n = 0;
            while (allTheFrames >= 33)
            {
                if (n > 3)
                {
                    allTheFrames = 0;
                    break;
                }
                allTheFrames -= 33;
                if (FadeClip != null)
                {
                    FadeClip.InteractEnterFrame();
                }
            }
        }
        if (FadeClip == null || FadeClip.currentFrame > 15)
        {
            rootHUD.popup.x += (520 - rootHUD.popup.x) * 0.25 * framin;
        }
        if (rootHUD.popup.x < 530 && Char.CharArray[0].JumpIsDown() || Char.CharArray[0].RightIsDown() || Char.CharArray[0].LeftIsDown())
        {
            pauseStatus = "nothing";
            this.shakeRL = 0;
            this.levelTimer = this.raceTimer;
            if (LevelStatus == "Lava")
            {
                this.ChallengeRules = this.FloorIsLava;
            }
            else
            {
                this.ChallengeRules = function() : Dynamic
                        {
                        };
            }
            rootHUD.HUD.removeChild(rootHUD.popup);
            removeEventListener(Event.ENTER_FRAME, this.ChallengeStartEnterFrame);
            addEventListener(Event.ENTER_FRAME, this.MainEnterFrame60);
        }
    }
    
    private function TickOrTock() : Void
    {
        if (this.slowMo)
        {
            framin = 2 / 33;
            allTheFrames += 2;
            this.tick = allTheFrames >= 33;
        }
        else
        {
            this.tick = !this.tick;
            framin = 0.5;
            allTheFrames = 33;
        }
        aPlat.framin = StarlingDecals.framin = collision.framin = staticInteractObjects.framin = framin;
    }
    
    private function TickOrTockSlow() : Void
    {
        if (this.ticktockslow > 0)
        {
            this.tick = false;
            --this.ticktockslow;
        }
        else
        {
            this.tick = true;
            this.ticktockslow = 2;
        }
    }
    
    private function hideMouse() : Void
    {
        if (this.hideMouseN != 0)
        {
            if (this.hideMouseN == 1)
            {
                if (this.isFullscreen)
                {
                    flash.ui.Mouse.hide();
                }
                this.hideMouseN = 0;
            }
            else if (this.hideMouseN > 0)
            {
                --this.hideMouseN;
            }
        }
    }
    
    private function checkGamepads() : Void
    {
        var controls : Array<Dynamic> = null;
        var prop : String = null;
        var n : Int = 0;
        var c : Int = 0;
        var i : Int = 0;
        var wasNum : Int = 0;
        if (!this.useGamepads)
        {
            return;
        }
        if (this.workerControls)
        {
            this.mainToWorker.send("");
            controls = this.controllerWorker.getSharedProperty("controlsArray");
        }
        else
        {
            controls = [];
            for (n in 0...this.gamepadArray.length)
            {
                controls[n] = new Array<Float>();
                for (c in 0...this.gamepadArray[n].numControls)
                {
                    controls[n][c] = this.gamepadArray[n].getControlAt(c).value;
                }
            }
        }
        if (Char.CharN == 1 && pauseStatus != "Gamepad")
        {
            while (i < controls.length)
            {
                if (this.workerGamepadBinded[i] == null)
                {
                    if (Math.abs(controls[i][0]) > 0.4)
                    {
                        wasNum = Char.CharArray[0].gamepadNum;
                        if (Char.CharArray[0].addGamepad(this.workerGamepadID[i], this.workerGamepadName[i], i))
                        {
                            this.workerGamepadBinded[i] = true;
                            if (wasNum > -1)
                            {
                                this.workerGamepadBinded[wasNum] = false;
                            }
                        }
                    }
                }
                i++;
            }
        }
        Char.sendGamepadVectors(controls);
    }
    
    private function levelQuickReset(justObjects : Bool = false) : Dynamic
    {
        this.EndLevel(false, false);
        if (!justObjects)
        {
            levelScale = 1;
            cameraZ = 0;
            this.setupUberForeground();
        }
        tempFollow = [];
        tempFollowB = [];
        tempFollowR = [];
        DoorLoaded = 0;
        if (LevelLoaded == "Level7" || LevelStatus == "Collect")
        {
            staticInteractObjects.dontCheat[LevelLoaded] = [];
        }
        populateLevel(false);
        if (!justObjects)
        {
            if (DirIt == "World 1" && LoadIt == "Level3")
            {
                FadeClip = new FadeIn();
                stageRoot.addChild(Main.FadeClip);
            }
            preservePlayers = false;
            DoorIt = 0;
            this.setupChars();
            setupCamera();
            setScroll();
            DoorIt = -1;
            if (hasUberForeground)
            {
                addChild(UberForeground);
            }
            addChild(rootHUD.HUD);
            StarlingBackgrounds.flattenBackgrounds();
        }
        if (LevelStatus == "Race")
        {
            if (aPlat.hasRaceWall())
            {
                this.frameCounter = -90;
                this.levelTimer = this.preCountdownTimer;
            }
            else
            {
                this.frameCounter = 0;
                this.levelTimer = this.waitTimer;
            }
            rootHUD.HUD.centerText.text = "0.00";
            aPlat.replaceRaceWall();
            if (Sounds.musicPlaying == "nothing")
            {
                Sounds.playMusic(LevelLoaded);
            }
        }
        else if (LevelStatus != "Smash")
        {
            if (LevelStatus != "Normal")
            {
                this.setupChallenge();
            }
        }
    }
    
    public function EndLevel(clearAll : Bool, clearChars : Bool, controls : Bool = true) : Void
    {
        var b : Int = 0;
        var i : Int = 0;
        b = as3hx.Compat.parseInt(AllLoaders.length);
        for (n in 0...b)
        {
            Reflect.field(AllLoaders, Std.string(n)).unloadAndStop(true);
        }
        tempFollow = [];
        tempFollowB = [];
        tempFollowR = [];
        Baddies.clearAllBaddies();
        InteractObjects.clearAllInteracts();
        staticInteractObjects.clearAllInteracts(clearAll);
        StarlingDecals.clearAllInteracts();
        aWall.clearAllWalls();
        aGround.clearAllGrounds();
        rootHUD.HUD.clearSplashScreens();
        textBubbles.outID = -1;
        Sounds.clearSuperLoop();
        Char.forceStopLoops();
        if (clearAll)
        {
            aPlat.clearAllPlats();
        }
        rootHUD.HUD.removeBossHealth();
        if (Overlord != null)
        {
            if (Overlord.parent != null)
            {
                Overlord.parent.removeChild(Overlord);
            }
            Overlord = null;
        }
        if (clearChars)
        {
            Char.clearAllChars();
            preservePlayers = false;
        }
        else
        {
            preservePlayers = true;
        }
        cameraShiftX = cameraShiftY = -10000;
        Checkpoint.resetCurrent();
        if (hasUberForeground)
        {
            UberForeground.parent.removeChild(UberForeground);
        }
        UberForeground = null;
        StarlingInteract.clearAllInteracts();
        StarlingEffect.clearAllEffects();
        StarlingSmoke.clearAllSmokes();
        StarlingTemporary.clearAll();
        rootHUD.removeUpgradePanel();
        if (clearAll)
        {
            removeEventListener(Event.ENTER_FRAME, this.MainEnterFrame60);
            if (external && this.levelLoader != null)
            {
                this.levelLoader.unloadAndStop(true);
                this.levelLoader = null;
            }
            rootHUD.removeMyBlackBlank();
            textBubbles.removeTextBubble();
            StarlingBackgrounds.removeBackgrounds();
            StarlingBackgrounds.flushBackgrounds();
            if (LoadIt != LevelLoaded)
            {
                StarlingTemporary.wipeAtlas();
            }
            Backgrounds.flushBackgrounds();
            if (external)
            {
                removeChild(levelContainer);
            }
            else
            {
                removeChild(AllEverything);
            }
            levelContainer = null;
            i = 0;
            while (AllEverything["background" + i])
            {
                AllEverything["background" + i] = null;
                i++;
            }
            AllEverything = null;
            backgroundsN = 0;
        }
        else
        {
            StarlingBackgrounds.unflattenBackgrounds();
            Backgrounds.flushStranglers();
        }
        System.pauseForGCIfCollectionImminent(1);
        System.gc();
        if (Extensions.isScaleform)
        {
            ExternalInterface.call("ForceCollectGarbage");
        }
    }
    
    private function doTurtleWarp() : Void
    {
        removeEventListener(Event.ENTER_FRAME, this.MainEnterFrame60);
        killControls();
        cameraZ = 100;
        Char.CharArray[0].gotoBuffer = "TurtleWarp";
        Char.CharArray[0].coreSwitchAnim();
        Main.switchScroll("turtleWarpScroll");
        this.scrollEngine();
        addEventListener(Event.ENTER_FRAME, this.TurtleWarpEnterFrame);
    }
    
    public function refreshBackgrounds() : Dynamic
    {
        justBitmaps = true;
        FadeClip = new FadeIn();
        this.addChild(FadeClip);
        removeEventListener(Event.ENTER_FRAME, this.MainEnterFrame60);
        if (myLoadHUD == null)
        {
            myLoadHUD = new LoadHUD();
        }
        stageRoot.addChild(myLoadHUD);
        myLoadHUD.gotoAndStop(2);
        myLoadHUD.bar.scaleX = 0;
        StarlingBackgrounds.flushBackgrounds();
        cacheBackgroundN = as3hx.Compat.parseInt(backgroundsN - 1);
        waitToCacheN = 20;
        addEventListener(Event.ENTER_FRAME, this.waitToCacheEnterFrame);
    }
    
    public function ChangeLevel(load : Dynamic) : Dynamic
    {
        if (cleanForBrand)
        {
            if (load == "Menus0")
            {
                load = "Menus0Clean";
            }
        }
        if (load == "LevelSelect")
        {
            numPlayers = 1;
            this.QuitToMenu();
            this.EndLevel(true, true);
            FadeClip = null;
            rootHUD.HUD.setupLevelSelect();
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
            LevelLoaded = "LevelSelect";
            addEventListener(Event.ENTER_FRAME, this.nullEnterFrame);
        }
        else if (load == "MapScreen")
        {
            numPlayers = 1;
            this.EndLevel(true, true, false);
            FadeClip = null;
            MapClip = new MapScreen(DoorIt);
            StarlingBackgrounds.volcanoBackground.visible = false;
            this.addChild(MapClip);
            transLevelOffsetX = transLevelOffsetY = 0;
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownMap);
            rootHUD.HUD.visible = false;
            LevelLoaded = "MapScreen";
            pauseStatus = "Map";
            addEventListener(Event.ENTER_FRAME, this.mapEnterFrame);
        }
        else if (load == "Respawn")
        {
            Sounds.musicPlaying = "nothing";
            LoadIt = LevelLoaded;
            Char.checkHealths();
            this.levelQuickReset();
            if (LoadIt == "Level1-a" && DoorIt == 0)
            {
                FadeClip = new FadeInWhite();
            }
            else if (LoadIt == "Level5-a")
            {
                FadeClip = new FadeInBlack();
            }
            else
            {
                FadeClip = new FadeIn();
            }
            this.addChild(FadeClip);
            Sounds.playMusic(LoadIt);
        }
        else if (load == "TurtleWarp")
        {
            this.doTurtleWarp();
            LevelLoaded = load;
        }
        else
        {
            if (load == "bonus")
            {
                DoorIt = 0;
                load = "Bonus" + LevelLoaded.substr(5, LevelLoaded.length - 5);
            }
            else if (load == "return" || load == "finish")
            {
                if (DirIt == "Extra")
                {
                    leaveArcade();
                }
                else if (DirIt == "World 4")
                {
                    DoorIt = 20;
                    load = "Level" + LevelLoaded.substr(5, LevelLoaded.length - 5);
                }
                else
                {
                    DoorIt = -1;
                    load = LastFullLevel;
                }
            }
            this.EndLevel(true, true);
            this.startLoad(load, DirIt);
        }
    }
    
    private function CheckLevelTransition(load : Dynamic, dir : Dynamic) : Dynamic
    {
        if (load.substr(0, 5) == "Level" && LevelLoaded.substr(0, 5) == "Trans")
        {
            trace("midroll");
            if (onSite == "Kizi" && cast(ExternalInterface.available, Bool))
            {
                ExternalInterface.call("showMidRoll");
            }
        }
    }
    
    public function refreshLevel() : Void
    {
        var i : Int = 0;
        if (gameMode == "vase")
        {
            return;
        }
        dontCheat = StarlingInteract.dontCheat[LoadIt] = [];
        i = 0;
        while (i < Char.ActiveCharArray.length)
        {
            Char.ActiveCharArray[i].resetOnPlatSides();
            i++;
        }
        this.EndLevel(true, false);
        this.startLoad(LevelLoaded, DirLoaded);
    }
    
    @:allow()
    private function spawnSquiggles() : Dynamic
    {
    }
    
    private function shoutTheChallenge(status : Dynamic) : Dynamic
    {
        var shout : ChallengeShout = null;
        shout = new ChallengeShout();
        rootHUD.HUD.addChild(shout);
        shout.gotoAndStop(status);
        rootHUD.popup = shout;
        shout.x = 1000;
        shout.y = 100;
        shout = null;
    }
    
    private function preCountdownTimer() : Void
    {
        if (this.frameCounter < 0)
        {
            this.raceTimer();
        }
        else
        {
            aPlat.removeRaceWall();
            this.levelTimer = this.raceTimer;
        }
    }
    
    private function waitTimer() : Void
    {
        var i : Int = 0;
        for (i in 0...Char.CharArray.length)
        {
            if (Char.CharArray[i].Status != "Idle")
            {
                this.levelTimer = this.raceTimer;
                break;
            }
        }
    }
    
    private function raceTimer() : Dynamic
    {
        var tempString : String = null;
        this.frameCounter += framin;
        tempString = Math.round(this.frameCounter / 30 * 100) / 100;
        if (tempString.indexOf(".") == -1)
        {
            tempString += ".00";
        }
        else if (tempString.length - tempString.indexOf(".") < 3)
        {
            tempString += "0";
        }
        rootHUD.HUD.centerText.text = tempString;
    }
    
    public function finishRace() : Dynamic
    {
        pauseStatus = "finishRace";
        Sounds.fadeOutMusic("nothing", 0.2);
        Sounds.playSoundSimple("success");
        Sounds.playOnce("Stinger");
        if (onSite == "MiniClip")
        {
            if (this.frameCounter > 0 && this.frameCounter < Reflect.field(localScores, Std.string(LevelLoaded + "_" + StatusName)) || Reflect.field(localScores, Std.string(LevelLoaded + "_" + StatusName)) == 0 || Reflect.field(localScores, Std.string(LevelLoaded + "_" + StatusName)) == null)
            {
                updateScore(LevelLoaded + "_" + StatusName, this.frameCounter / 30, function() : Dynamic
                        {
                        });
                shared.data.scores = localScores;
            }
            b = 60;
            this.levelTimer = this.waitAfterRaceTimer;
        }
        else
        {
            updateTime(this.frameCounter / 30, function() : Dynamic
                    {
                        if (LevelStatus == "Lava" || LevelStatus == "Collect" || LevelStatus == "Birds")
                        {
                            if (ExternalInterface.available)
                            {
                                ExternalInterface.call("WriteToPage", "topshout", ["<strong>Floor Is Lava!</strong>  Challenge Complete!", "<strong>Squiggles Get!</strong>  Challenge Complete!", "<strong>AngryDragonBirdemic!</strong>  Challenge Complete!"][Lambda.indexOf(["Race", "Collect", "Birds"], LevelStatus)]);
                            }
                            ScoresTable("Scores" + worldPrefix, LevelLoaded + "_" + StatusName, false, 20, function(tempText : Dynamic) : Dynamic
                                    {
                                        if (ExternalInterface.available)
                                        {
                                            ExternalInterface.call("WriteToPage", "highscores", "High Scores:<br/>" + tempText);
                                        }
                                    });
                            if (loaderInfo.url.indexOf("bornegames.com") > -1 || debug)
                            {
                                BGConnect.send("_BorneGamesConnect", "BeatChallenge", LevelStatus, frameCounter, "-");
                            }
                        }
                    });
            b = 200;
            this.levelTimer = this.waitAfterRaceTimer;
        }
        new BigSpeechBubble(17, 17, function() : Dynamic
        {
        });
    }
    
    public function finishSmash() : Void
    {
        pauseStatus = "finishSmash";
        Sounds.fadeOutMusic("nothing", 0.2);
        Sounds.playSoundSimple("success");
        Sounds.playOnce("Stinger");
        b = 200;
        this.levelTimer = this.waitAfterRaceTimer;
    }
    
    private function waitAfterRaceTimer() : Dynamic
    {
        if (b - Main.framin > 0)
        {
            b -= Main.framin;
        }
        else if (onSite == "MiniClip")
        {
            MiniclipAPI.services.addEventListener(HighscoreEvent.CLOSE, this.handleCloseHSB);
            MiniclipAPI.services.saveHighscore(this.frameCounter * 1000, as3hx.Compat.parseFloat(LevelLoaded.substr(5)));
            this.levelTimer = function() : Dynamic
                    {
                    };
        }
        else if (LevelStatus == "Lava" || LevelStatus == "Collect" || LevelStatus == "Birds")
        {
            startControls();
            quickResetLevel = true;
        }
        else
        {
            leaveArcade();
        }
    }
    
    private function handleCloseHSB(e : Event) : Dynamic
    {
        LoadIt = "Menus3";
        DoorIt = as3hx.Compat.parseFloat(LevelLoaded.substr(5, 1));
    }
    
    private function FloorIsLava() : Dynamic
    {
        if (Char.CharArray[0].onGround)
        {
            Sounds.playSound("Ow", Char.CharArray[0].x, 1, Char.CharArray[0].onRail);
            Char.CharArray[0].FloatUp = 0;
            Char.CharArray[0].Jumper = 20;
            Char.CharArray[0].rotter = Char.CharArray[0].fakeRL * 1.5;
            Char.CharArray[0].hitPause = 5;
            Char.CharArray[0].shakeRL = 20;
            Char.CharArray[0].downTime = 5;
            this.shakeRL = 20;
            Char.CharArray[0].gotoBuffer = "Hurt";
            this.levelTimer = this.finishLava;
        }
    }
    
    private function finishLava() : Dynamic
    {
        if (Char.CharArray[0].onGround && Char.CharArray[0].downTime == 0)
        {
            Char.CharArray[0].downTime = 10;
            quickResetLevel = true;
        }
    }
    
    private function setupChallenge() : Dynamic
    {
        Char.CharArray[0].onGround = false;
        this.frameCounter = 0;
        rootHUD.HUD.centerText.text = "0.00";
        this.shoutTheChallenge(LevelStatus);
        this.tick = true;
        this.levelTimer = function() : Dynamic
                {
                };
        Baddies.BaddieEnterFrames();
        Char.CharSwitchAnims();
        pauseStatus = "Wait";
        if (FadeClip == null)
        {
            FadeClip = new FadeIn();
            Main.stageRoot.addChild(Main.FadeClip);
        }
        removeEventListener(Event.ENTER_FRAME, this.MainEnterFrame60);
        addEventListener(Event.ENTER_FRAME, this.ChallengeStartEnterFrame);
    }
    
    @:allow()
    private function clearAllAutoOns() : Dynamic
    {
        aWall.clearAllOns();
        aGround.clearAllOns();
        aPlat.clearAllOns();
    }
    
    private function KongAPI() : Dynamic
    {
        var apiPath : String = null;
        var request : URLRequest = null;
        var loader : Loader = null;
        removeEventListener(Event.ADDED_TO_STAGE, this.KongAPI);
        apiPath = daParameters.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
        Security.allowDomain(apiPath);
        trace(apiPath);
        request = new URLRequest(apiPath);
        loader = new Loader();
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.KongLoadComplete);
        loader.load(request);
        this.addChild(loader);
    }
    
    private function KongLoadComplete(event : Event) : Dynamic
    {
        trace("kong loaded");
        kongregate = event.target.content;
        kongregate.services.connect();
        member = kongregate.services.getUsername() + "_KG";
        memberDisplay = kongregate.services.getUsername();
        if (kongregate.services.getUsername() != "Guest")
        {
            kongregate.mtx.requestUserItemList(null, this.onUserItems);
        }
        else
        {
            rootHUD.HUD.keySwitch.gotoAndStop(keyMessage);
            kongregate.services.addEventListener("login", this.onKongregateInPageLogin);
        }
        this.loadGameBlockA(event);
    }
    
    private function onUserItems(result : Dynamic) : Dynamic
    {
        var tempKeyObject : Dynamic = null;
        var i : Int = 0;
        var e : String = null;
        if (result.success)
        {
            tempKeyObject = {};
            for (i in 0...result.data.length)
            {
                Reflect.setField(tempKeyObject, Std.string(result.data[i].identifier), 1);
            }
            for (e in Reflect.fields(tempKeyObject))
            {
                getThatKey(e);
                rootHUD.HUD.debug.text += e;
            }
            if (userHasKey)
            {
                parse_saveKey(tempKeyObject, "nothing");
                keyMessage = "stay_fancy";
            }
            else
            {
                rootHUD.HUD.keySwitch.gotoAndStop(keyMessage);
            }
        }
        else
        {
            rootHUD.HUD.keySwitch.gotoAndStop(keyMessage);
        }
    }
    
    private function onKongregateInPageLogin(event : Event) : Dynamic
    {
        this.localToNetwork();
    }
}


