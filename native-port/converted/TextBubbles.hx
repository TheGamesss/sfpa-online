import flash.display.*;
import flash.display3D.textures.RectangleTexture;
import flash.display3D.textures.Texture;
import flash.geom.*;
import flash.utils.*;
import starling.display.*;
import starling.textures.*;

class TextBubbles extends StaticInteractObjects
{
    
    private static var textStamp : flash.display.MovieClip;
    
    private static var mySmoke : Image;
    
    private static var textTexture : starling.textures.Texture;
    
    private static var textNative : RectangleTexture;
    
    private static var textNativeConstrained : flash.display3D.textures.Texture;
    
    private static var bitmapData : BitmapData;
    
    private static var constrained : Bool;
    
    public static var outID : Int = -1;
    
    private var spring : Float = 0;
    
    private var b : Int;
    
    private var rootb : Int;
    
    private var start : Int;
    
    private var thisFrame : Int;
    
    private var end : Int;
    
    private var after : String;
    
    private var hasLoop : Bool;
    
    private var advIsDown : Bool;
    
    private var charCollision : Bool;
    
    private var auto : Bool;
    
    private var persist : Bool;
    
    public var out : Bool;
    
    private var disable : Bool;
    
    private var doneAfter : Bool;
    
    private var reset : Bool;
    
    private var scale : Float;
    
    private var superScale : Float = 1;
    
    private var superScaleX : Float = 1;
    
    private var superScaleY : Float = 1;
    
    private var backAndForth : Int = 0;
    
    private var backAndForthUD : Int = 0;
    
    private var myDecal : flash.display.MovieClip;
    
    public function new(p : Dynamic)
    {
        this.superScale = p.scaleY;
        if (p.onRail != null)
        {
            onRail = p.onRail;
        }
        super("textBubbles", p.x, p.y, 1, 1, onRail, "nothing", -1);
        Backgrounds.backgroundsArray[onRail].addChild(this);
        textBubbleArray[p.ID] = this;
        ID = p.ID;
        this.rootb = this.b = p.b;
        this.after = p.after;
        if (p.auto)
        {
            this.auto = true;
        }
        if (p.persist)
        {
            this.persist = true;
        }
        if (p.reset)
        {
            this.reset = true;
        }
        if (p.backAndForth != null)
        {
            this.backAndForth = p.backAndForth;
        }
        if (p.backAndForthUD != null)
        {
            this.backAndForthUD = p.backAndForthUD;
        }
        this.scale = scaleX = scaleY = 0;
        if (Main.localSettings.language == "English")
        {
            this.myDecal = new TextDecalEnglish();
        }
        else
        {
            this.myDecal = new TextDecalNoText();
        }
        addChild(this.myDecal);
        this.myDecal.gotoAndStop(p.start);
        this.start = this.thisFrame = this.myDecal.currentFrame;
        this.end = this.thisFrame + p.end - 1;
        alpha = 0;
        visible = false;
    }
    
    public static function setupTextBubble() : Void
    {
        bitmapData = new BitmapData(640 * 1.5, 320 * 1.5, true, 0);
        textTexture = Texture.empty(640, 320, true, false, true, 1.5);
        if (constrained)
        {
            textNativeConstrained = try cast(textTexture.base, flash.display3D.textures.Texture) catch(e:Dynamic) null;
        }
        else
        {
            textNative = try cast(textTexture.base, RectangleTexture) catch(e:Dynamic) null;
        }
        mySmoke = new Image(textTexture);
        spawnTextStamp();
    }
    
    public static function spawnTextStamp() : Void
    {
        if (textStamp != null)
        {
            textStamp = null;
        }
        var classType : Class<Dynamic> = Type.getClass(Type.resolveClass("textBubbles" + Main.localSettings.language));
        textStamp = Type.createInstance(classType, []);
    }
    
    public static function addTextBubble() : Void
    {
        if (Main.LoadIt == "Villa0-a")
        {
            StarlingBackgrounds.BackgroundObjArray[4].addChild(mySmoke);
        }
        else
        {
            StarlingBackgrounds.BackgroundObjArray[0].addChild(mySmoke);
        }
    }
    
    public static function removeTextBubble() : Void
    {
        mySmoke.parent.removeChild(mySmoke);
    }
    
    public static function setConstrained(e : Bool) : Void
    {
        constrained = e;
    }
    
    public function setupLanguage() : Void
    {
        removeChild(this.myDecal);
        this.myDecal = null;
        if (Main.localSettings.language == "English")
        {
            this.myDecal = new TextDecalEnglish();
        }
        else
        {
            this.myDecal = new TextDecalNoText();
        }
        addChild(this.myDecal);
        this.myDecal.gotoAndStop(this.thisFrame);
        this.pressBitmapFrame();
    }
    
    private function nextBitmapFrame() : Void
    {
        ++this.thisFrame;
        this.myDecal.gotoAndStop(this.thisFrame);
        this.pressBitmapFrame();
    }
    
    private function pressBitmapFrame() : Void
    {
        textStamp.gotoAndStop(this.thisFrame);
        this.superScaleX = textStamp.width / 600;
        this.superScaleY = textStamp.height / 300;
        bitmapData.fillRect(bitmapData.rect, 0);
        bitmapData.drawWithQuality(textStamp, new Matrix(1.5 / this.superScaleX, 0, 0, 1.5 / this.superScaleY, 315 * 1.5, 155 * 1.5), null, null, null, true, StageQuality.BEST);
        if (constrained)
        {
            textNativeConstrained.uploadFromBitmapData(bitmapData);
        }
        else
        {
            textNative.uploadFromBitmapData(bitmapData);
        }
        mySmoke.texture = textTexture;
        mySmoke.pivotX = 315;
        mySmoke.pivotY = 155;
    }
    
    public function popupText(up : Bool) : Bool
    {
        if (!this.disable)
        {
            if (this.out)
            {
                return this.advanceText(up);
            }
            if (outID <= -1)
            {
                outID = ID;
                InteractEnterFrameArray.push(this);
                HalfInteractEnterFrameArray.push(this);
                visible = true;
                mySmoke.visible = true;
                this.out = true;
                this.advIsDown = true;
                mySmoke.x = x;
                mySmoke.y = y;
                this.pressBitmapFrame();
                mySmoke.scaleX = mySmoke.scaleY = 0;
            }
        }
        return false;
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (Math.abs(this.spring) < 0.001)
        {
            this.spring = 0;
        }
        if (this.b == 1 && (cast(this.persist, Bool) || cast(this.reset, Bool)) && cast(this.charCollision, Bool) && this.thisFrame == this.end)
        {
            this.spring += (1 - this.scale) * 0.3;
            this.spring *= 0.6;
            if (!this.doneAfter)
            {
                this.doAfter();
            }
        }
        else if (this.b > 0)
        {
            --this.b;
            this.spring += (1 - this.scale) * 0.3;
            this.spring *= 0.6;
        }
        else if (this.b == 0)
        {
            if (this.auto)
            {
                this.spring = 0.2;
                this.b = -1;
            }
            else if (this.charCollision)
            {
                this.spring += (1 - this.scale) * 0.3;
                this.spring *= 0.6;
                if (this.thisFrame != 72)
                {
                    Main.showDoorIcon = true;
                }
                if (this.scale == 0 || this.spring < -0.05)
                {
                    this.b = 10;
                }
                else if (alpha < 1)
                {
                    if (!visible)
                    {
                        visible = true;
                    }
                    alpha += 0.2;
                }
            }
            else
            {
                if (alpha > 0)
                {
                    alpha -= 0.2;
                    if (alpha <= 0)
                    {
                        visible = false;
                    }
                }
                else
                {
                    this.spring += -this.scale * 0.1;
                    this.spring *= 0.8;
                }
                this.advIsDown = true;
            }
        }
        else if (this.scale + this.spring > 0)
        {
            this.spring += -this.scale * 0.1;
            this.spring *= 0.8;
        }
        this.charCollision = false;
        this.HalfInteractEnterFrame();
    }
    
    override public function HalfInteractEnterFrame() : Void
    {
        this.scale += this.spring * Main.framin;
        if (this.scale < 0)
        {
            this.spring = this.scale = scaleX = scaleY = 0;
            if (this.thisFrame == this.end && (cast(this.persist, Bool) || cast(this.auto, Bool)) && !this.doneAfter)
            {
                this.doAfter();
            }
            else
            {
                x += this.backAndForth;
                y += this.backAndForthUD;
                mySmoke.x = x;
                mySmoke.y = y;
                this.backAndForth *= -1;
                this.backAndForthUD *= -1;
            }
            if (this.b > -1)
            {
                if (cast(this.reset, Bool) && this.thisFrame == this.end)
                {
                    this.thisFrame = this.start;
                }
                spliceEnterFrames();
                outID = -1;
                this.out = false;
                mySmoke.visible = visible = false;
            }
            else if (this.thisFrame == this.end)
            {
                outID = -1;
                this.disable = true;
                killInteract.push(this);
            }
            else
            {
                this.b = this.rootb;
                this.nextBitmapFrame();
                mySmoke.scaleX = mySmoke.scaleY = 0;
            }
        }
        scaleX = scaleY = this.scale * this.superScale;
        mySmoke.scaleX = this.scale * this.superScaleX * this.superScale;
        mySmoke.scaleY = this.scale * this.superScaleY * this.superScale;
    }
    
    public function advanceText(up : Bool) : Bool
    {
        this.charCollision = true;
        if (!up)
        {
            this.advIsDown = false;
        }
        if (this.scale > 0 && this.b == 0 && (!this.advIsDown && up || cast(this.auto, Bool)))
        {
            this.advIsDown = true;
            this.spring = 0.2;
            this.b = -1;
            alpha = 0;
            visible = false;
            if (this.thisFrame == this.end && !this.auto && !this.persist)
            {
                this.doAfter();
            }
            return true;
        }
        return false;
    }
    
    private function doAfter() : Void
    {
        this.doneAfter = true;
        trace("after " + this.after);
        if (this.after == "superZoom")
        {
            Main.setTempCameras();
            Main.switchScroll("panOutScroll");
        }
        else if (this.after == "cutieRunEnd")
        {
            Main.cutieRunEnd();
        }
        else if (this.after == "heyLady")
        {
            Main.saveProgress("cutieHasHeyLady", true);
        }
        else if (this.after == "tellDesk")
        {
            Main.saveProgress("talkToIceCream", true);
        }
        else if (this.after == "clearGate")
        {
            aWall.findByType("Gate").inkGateBreak();
        }
        else if (this.after == "clearGate0")
        {
            aWall.findByType("Gate").inkGateBreak();
            Main.saveProgress("talkToMayor0", true);
        }
        else if (this.after == "shoutFindPirates")
        {
            rootHUD.HUD.shoutTheBox("findPirates");
        }
        else if (this.after == "clearGate1")
        {
            aWall.findByType("Gate").inkGateBreak();
            Main.saveProgress("talkToCapt0", true);
            rootHUD.HUD.shoutTheBox("rescueCrew");
        }
        else if (this.after == "shoutGoZip")
        {
            rootHUD.HUD.shoutTheBox("goZip");
        }
        else if (this.after == "floodW1Box")
        {
            staticInteractObjects.findByUnique(0).y = staticInteractObjects.findByUnique(0).y + 500;
            staticInteractObjects.findByUnique(0).updateCache();
            staticInteractObjects.findByName("inkSinkRising").startInk();
        }
    }
    
    override public function cleanUp() : Void
    {
        mySmoke.visible = false;
    }
}


