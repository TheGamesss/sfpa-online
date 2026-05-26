import flash.errors.Error;
import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol1252"))

class MapScreen extends MovieClip
{
    
    public static var revealVolcano : Bool;
    
    public var icon0 : MovieClip;
    
    public var icon1 : MovieClip;
    
    public var icon2 : MovieClip;
    
    public var icon3 : MovieClip;
    
    public var icon4 : MovieClip;
    
    public var icon5 : MovieClip;
    
    public var icon6 : MovieClip;
    
    public var overlay : MovieClip;
    
    public var reveal : MovieClip;
    
    public var revealBlack : MovieClip;
    
    public var volcanoOpening : MovieClip;
    
    private var fadeMusic : Bool;
    
    private var ItIs : String = "MapScreen";
    
    private var leaving : Bool;
    
    private var springs : Array<Dynamic> = [];
    
    private var b : Int;
    
    private var levels : Int;
    
    private var selected : Int;
    
    private var menuKeyThresh : Float;
    
    private var popup : Int;
    
    private var volcanoUnlock : Int;
    
    private var slowFadeIn : Bool;
    
    private var setup : Bool;
    
    private var swipeBlack : Bool;
    
    public function new(door : Int = -1)
    {
        super();
        this.reveal.stop();
        x = Main.realStageX;
        y = Main.realStageY;
        scaleX = scaleY = Main.overRatio;
        this.levels = 5;
        this.selected = door;
        this.volcanoUnlock = 0;
        var i : Int = 0;
        while (i < 7)
        {
            this.springs[i] = 0;
            i++;
        }
        this.overlay.stop();
        this.overlay.alpha = 0;
        this.revealBlack.gotoAndStop(59);
        if (door == 6)
        {
            Main.world4Progress.centerUnlocked = true;
        }
        if (revealVolcano)
        {
            revealVolcano = false;
            this.slowFadeIn = true;
            this.volcanoUnlock = 1;
            this.volcanoOpening.stop();
            this.overlay.gotoAndStop(6);
            this.icon5.scaleX = this.icon5.scaleY = 0;
            Main.saveProgress("canMapAround", true);
            if (Main.world4Progress.centerUnlocked)
            {
                this.levels = 7;
            }
        }
        else if (Main.world4Progress.centerUnlocked)
        {
            this.levels = 7;
            this.volcanoOpening.gotoAndStop(2);
            this.setup = true;
        }
        else if (Main.world4Progress.volcanoUnlocked)
        {
            this.levels = 6;
            this.volcanoOpening.gotoAndStop(2);
            this.setup = true;
        }
        else
        {
            this.volcanoOpening.stop();
            this.setup = true;
            this.icon5.visible = false;
        }
        if (!Main.world4Progress.centerUnlocked)
        {
            this.icon6.visible = false;
        }
        this.__setProp_icon0_MapScreen_x_0();
        this.__setProp_icon1_MapScreen_x_0();
        this.__setProp_icon3_MapScreen_x_0();
        this.__setProp_icon4_MapScreen_x_0();
        this.__setProp_icon5_MapScreen_x_0();
        this.__setProp_icon2_MapScreen_x_0();
        this.__setProp_icon6_MapScreen_x_0();
    }
    
    public function InteractEnterFrame() : Dynamic
    {
        var i : Int = 0;
        Char.CharArray[0].pauseStuff();
        this.mapKeys(Char.CharArray[0].wantRL, Char.CharArray[0].wantUD, Char.CharArray[0].JumpIsDown() && !Char.CharArray[0].SisDown);
        if (Char.CharArray[0].JumpIsDown())
        {
            Char.CharArray[0].SisDown = true;
        }
        else
        {
            Char.CharArray[0].SisDown = false;
        }
        if (this.setup)
        {
            this.popupOnMap();
            this.overlay.alpha = 1;
            this["icon" + this.selected].scaleX = this["icon" + this.selected].scaleY = 1.4;
            this.setup = false;
        }
        else if (this.leaving)
        {
            for (i in 0...this.levels)
            {
                if (i == this.selected)
                {
                    this.springs[i] -= (this["icon" + i].scaleX - 1.4) * 0.2;
                    this.springs[i] *= 0.6;
                    this["icon" + i].scaleX += this.springs[i];
                    this["icon" + i].scaleY = this["icon" + i].scaleX;
                }
                else if (this["icon" + i].scaleX > 0)
                {
                    this.springs[i] -= 0.05;
                    this["icon" + i].scaleX += this.springs[i];
                    this["icon" + i].scaleY = this["icon" + i].scaleX;
                }
                else
                {
                    this["icon" + i].scaleX = this["icon" + i].scaleY = 0;
                }
            }
            if (this.swipeBlack)
            {
                if (this.b > 0)
                {
                    --this.b;
                }
                else if (this.revealBlack.currentFrame > 1)
                {
                    this.revealBlack.prevFrame();
                }
                else
                {
                    Main.stageRoot.loadAfterMap();
                }
            }
            else if (this.b > 0)
            {
                --this.b;
            }
            else if (this.reveal.currentFrame > 1)
            {
                this.reveal.prevFrame();
            }
            else
            {
                Main.stageRoot.loadAfterMap();
            }
        }
        else if (this.slowFadeIn)
        {
            if (this.reveal.currentFrame < this.reveal.totalFrames)
            {
                this.reveal.nextFrame();
            }
            if (this.volcanoUnlock > 0)
            {
                ++this.volcanoUnlock;
                if (this.volcanoUnlock == 89)
                {
                    this.volcanoOpening.gotoAndStop(2);
                    Sounds.playSoundSimple("InkExplode_0");
                    cachedEffects.spawnCachedEffect("Splat", -25, -114, Math.random() * 360, 1, 0, 0, 0, this);
                }
                else if (this.volcanoUnlock == 200)
                {
                    if (this.levels < 6)
                    {
                        this.levels = 6;
                    }
                    this.popup = this.selected = 5;
                }
                else if (this.volcanoUnlock > 200)
                {
                    this.icon5.scaleX += (1.5 - this.icon5.scaleX) * 0.05;
                    this.icon5.scaleY = this.icon5.scaleX;
                    this.overlay.alpha += 0.01;
                    if (this.overlay.alpha > 0.8)
                    {
                        this.overlay.alpha = 1;
                        this.slowFadeIn = false;
                    }
                }
            }
        }
        else if (this.reveal.currentFrame < this.reveal.totalFrames)
        {
            this.reveal.nextFrame();
        }
        else
        {
            for (i in 0...this.levels)
            {
                if (Math.abs(this["icon" + i].x - mouseX) < 40 && Math.abs(this["icon" + i].y - mouseY) < 40)
                {
                    this.selected = i;
                }
                if (i == this.selected)
                {
                    this.springs[i] = 0.08;
                }
                this.springs[i] -= (this["icon" + i].scaleX - 1) * 0.2;
                this.springs[i] *= 0.6;
                this["icon" + i].scaleX += this.springs[i];
                this["icon" + i].scaleY = this["icon" + i].scaleX;
            }
            if (this.selected >= 0)
            {
                this.overlay.visible = true;
                if (this.selected != this.popup)
                {
                    if (this.overlay.alpha > 0)
                    {
                        this.overlay.alpha -= 0.2;
                    }
                    else
                    {
                        this.popupOnMap();
                    }
                }
                else if (this.overlay.alpha < 1)
                {
                    this.overlay.alpha += 0.2;
                }
            }
        }
    }
    
    public function popupOnMap() : Void
    {
        this.popup = this.selected;
        this.overlay.gotoAndStop(this.popup + 1);
        var temp : String = this["icon" + this.selected].level.substr(0, 6);
        var b : Int = 0;
        var n : Int = as3hx.Compat.parseInt(Main[temp + "Rewards"].length);
        for (i in 0...n)
        {
            if (Main.hasReward(Main[temp + "Rewards"][i]))
            {
                b++;
            }
        }
        this.overlay.rewardText.text = b + " / " + n + " items";
    }
    
    private function mapKeys(ex : Float, ey : Float, click : Bool) : Void
    {
        if (Math.abs(ey) > 0.3)
        {
            this.menuKeyThresh -= Math.abs(ey);
        }
        else if (Math.abs(ex) > 0.3)
        {
            this.menuKeyThresh -= Math.abs(ex);
        }
        else
        {
            this.menuKeyThresh = 0;
        }
        if (this.menuKeyThresh <= 0)
        {
            if (this.selected == -1)
            {
                if (Math.abs(ex) > 0.3 || Math.abs(ey) > 0.3)
                {
                    this.menuKeyThresh = 20;
                    this.selected = 0;
                }
            }
            else if (Math.abs(ex) > 0.3)
            {
                this.menuKeyThresh = 20;
                if (this.selected == 0 && ex > 0 && this.levels > 5)
                {
                    this.selected = 5;
                }
                else if (this.selected == 4)
                {
                    if (ex < 0)
                    {
                        if (this.levels == 7)
                        {
                            this.selected = 6;
                        }
                        else if (this.levels == 6)
                        {
                            this.selected = 5;
                        }
                        else
                        {
                            this.selected = 3;
                        }
                    }
                }
                else if (this.selected == 5)
                {
                    if (ex < 0)
                    {
                        this.selected = 0;
                    }
                    else if (this.levels == 7)
                    {
                        this.selected = 6;
                    }
                    else
                    {
                        this.selected = 4;
                    }
                }
                else if (this.selected == 6)
                {
                    if (ex < 0)
                    {
                        this.selected = 5;
                    }
                    else
                    {
                        this.selected = 4;
                    }
                }
                else
                {
                    this.selected += ex / Math.abs(ex);
                }
                if (this.selected == -1)
                {
                    ++this.selected;
                }
            }
            else if (Math.abs(ey) > 0.3)
            {
                this.menuKeyThresh = 20;
                if (ey > 0)
                {
                    if (this.selected == 0)
                    {
                        this.selected = 1;
                    }
                    else if (this.selected == 4)
                    {
                        this.selected = 3;
                    }
                    else if (this.selected == 5)
                    {
                        this.selected = 2;
                    }
                    else if (this.selected == 6)
                    {
                        this.selected = 4;
                    }
                }
                else if (this.selected == 1)
                {
                    this.selected = 0;
                }
                else if (this.levels > 5 && this.selected == 2)
                {
                    this.selected = 5;
                }
                else if (this.selected == 3)
                {
                    this.selected = 4;
                }
                else if (this.levels == 7 && this.selected == 4)
                {
                    this.selected = 6;
                }
                else if (this.levels == 6 && this.selected == 4)
                {
                    this.selected = 5;
                }
            }
        }
        if (click && !this.leaving)
        {
            this.selectIt();
        }
    }
    
    public function clickX() : Bool
    {
        for (i in 0...this.levels)
        {
            if (Math.abs(this["icon" + i].x - mouseX) < 40 && Math.abs(this["icon" + i].y - mouseY) < 40)
            {
                if (i == this.selected)
                {
                    this.selectIt();
                    return true;
                }
                this.selected = i;
                break;
            }
        }
        return false;
    }
    
    private function selectIt() : Void
    {
        this.leaving = true;
        Main.LoadIt = this["icon" + this.selected].level;
        Main.DoorIt = this["icon" + this.selected].door;
        this.b = 5;
        Sounds.playSoundSimple("UnPause");
        Main.stageRoot.clickMap();
        if (Main.LoadIt == "Level5-a")
        {
            this.swipeBlack = true;
            this.reveal.visible = false;
            this.revealBlack.visible = true;
        }
        for (i in 0...this.levels)
        {
            if (i == this.selected)
            {
                this.springs[i] = -0.5;
            }
            else
            {
                this.springs[i] = 0.15;
            }
        }
    }
    
    @:allow()
    private function __setProp_icon0_MapScreen_x_0() : Dynamic
    {
        try
        {
            this.icon0["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.icon0.level = "Level0-a";
        this.icon0.door = 2;
        try
        {
            this.icon0["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp_icon1_MapScreen_x_0() : Dynamic
    {
        try
        {
            this.icon1["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.icon1.level = "Level1-a";
        this.icon1.door = 2;
        try
        {
            this.icon1["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp_icon3_MapScreen_x_0() : Dynamic
    {
        try
        {
            this.icon3["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.icon3.level = "Level2-a";
        this.icon3.door = 0;
        try
        {
            this.icon3["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp_icon4_MapScreen_x_0() : Dynamic
    {
        try
        {
            this.icon4["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.icon4.level = "Level3-a";
        this.icon4.door = 1;
        try
        {
            this.icon4["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp_icon5_MapScreen_x_0() : Dynamic
    {
        try
        {
            this.icon5["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.icon5.level = "Level4-a";
        this.icon5.door = 0;
        try
        {
            this.icon5["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp_icon2_MapScreen_x_0() : Dynamic
    {
        try
        {
            this.icon2["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.icon2.level = "Villa0-b";
        this.icon2.door = 0;
        try
        {
            this.icon2["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp_icon6_MapScreen_x_0() : Dynamic
    {
        try
        {
            this.icon6["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.icon6.level = "Level4-g";
        this.icon6.door = 2;
        try
        {
            this.icon6["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
}


