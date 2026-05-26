import flash.display.MovieClip;
import flash.text.TextField;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol5041"))

class BigSpeechBubble extends MovieClip
{
    
    public var best : TextField;
    
    public var time : TextField;
    
    private var spring : Float = 0;
    
    private var step : Int = -1;
    
    private var b : Float;
    
    private var lifeTime : Int;
    
    private var lastFrame : Int;
    
    private var callBack : Dynamic;
    
    private var inPause : Bool;
    
    public var HalfInteractEnterFrame : Dynamic;
    
    public function new(start : Dynamic, end : Dynamic, back : Dynamic)
    {
        var tempString : String = null;
        super();
        this.HalfInteractEnterFrame = this.InteractEnterFrame;
        gotoAndStop(start);
        switch (start)
        {
            case 16, 15:
                x = 580;
                y = 150;
                rootHUD.HUD.addChild(this);
                staticInteractObjects.InteractEnterFrameArray.push(this);
                staticInteractObjects.HalfInteractEnterFrameArray.push(this);
                this.inPause = true;
                this.b = 10;
                this.lifeTime = 40;
            case 8:
                x = 200;
                y = 130;
                rootHUD.HUD.addChild(this);
                staticInteractObjects.InteractEnterFrameArray.push(this);
                staticInteractObjects.HalfInteractEnterFrameArray.push(this);
                this.inPause = true;
                this.b = 0;
                this.lifeTime = 200;
            case 5:
                x = 620;
                y = 170;
                PauseMenu.pausemenu.addChild(this);
                this.inPause = true;
                this.b = 5;
                this.lifeTime = 200;
            case 17:
                x = 400;
                y = 120;
                rootHUD.HUD.addChild(this);
                this.inPause = true;
                staticInteractObjects.InteractEnterFrameArray.push(this);
                staticInteractObjects.HalfInteractEnterFrameArray.push(this);
                this.b = 0;
                this.lifeTime = 160;
                tempString = Math.round(Main.stageRoot.frameCounter / 30 * 100) / 100;
                if (tempString.indexOf(".") == -1)
                {
                    tempString += ".00";
                }
                else if (tempString.length - tempString.indexOf(".") < 3)
                {
                    tempString += "0";
                }
                this.time.text = tempString;
                tempString = Math.round(Main.localScores[Main.LevelLoaded + "_" + Main.StatusName] * 100) / 100;
                if (tempString.indexOf(".") == -1)
                {
                    tempString += ".00";
                }
                else if (tempString.length - tempString.indexOf(".") < 3)
                {
                    tempString += "0";
                }
                this.best.text = tempString;
            default:
                x = (Main.MinX + Main.MaxX) * 0.5;
                y = Main.cameraY - 100;
                Main.UberForeground.addChild(this);
                staticInteractObjects.InteractEnterFrameArray.push(this);
                staticInteractObjects.HalfInteractEnterFrameArray.push(this);
                this.b = 10;
                this.lifeTime = 100;
        }
        scaleX = scaleY = 0;
        alpha = 0.9;
        this.lastFrame = end;
        this.callBack = back;
    }
    
    public function InteractEnterFrame() : Dynamic
    {
        var _sw1_ = (this.step);        

        switch (_sw1_)
        {
            case -1:
                if (this.b > 0)
                {
                    this.b -= Main.framin * 0.5;
                }
                else
                {
                    this.b = this.lifeTime;
                    ++this.step;
                }
            case 0:
                if (!this.inPause)
                {
                    y += (Main.cameraY - 100 - y) * (1 - Math.pow(1 - 0.2, Main.framin));
                }
                this.spring += (1 - scaleX) * 0.2 * Main.framin;
                this.spring *= Math.pow(0.7, Main.framin);
                scaleX += this.spring * Main.framin;
                scaleY = scaleX;
                if (this.b < this.lifeTime * 0.7 && Char.CharArray[0].JumpIsDown())
                {
                    this.b = this.lifeTime;
                    ++this.step;
                }
                else if (this.b > 0)
                {
                    this.b -= Main.framin;
                }
                else
                {
                    this.b = this.lifeTime;
                    ++this.step;
                }
            case 1:
                if (!this.inPause)
                {
                    y += (Main.cameraY - 100 - y) * (1 - Math.pow(1 - 0.2, Main.framin));
                }
                this.spring += (-0.5 - scaleX) * 0.2 * Main.framin;
                this.spring *= Math.pow(0.7, Main.framin);
                scaleX += this.spring * Main.framin;
                scaleY = scaleX;
                if (scaleX < 0)
                {
                    if (currentFrame == 5)
                    {
                        PauseMenu.pausemenu.displayColors();
                        Main.localSettings.canColor = true;
                        Main.parse_saveSettings();
                    }
                    this.b = this.lifeTime;
                    this.step = this.spring = scaleX = scaleY = 0;
                    if (currentFrame == this.lastFrame)
                    {
                        this.callBack();
                        if (staticInteractObjects.InteractEnterFrameArray.indexOf(this) > -1)
                        {
                            staticInteractObjects.InteractEnterFrameArray.splice(staticInteractObjects.InteractEnterFrameArray.indexOf(this), 1);
                        }
                        if (staticInteractObjects.HalfInteractEnterFrameArray.indexOf(this) > -1)
                        {
                            staticInteractObjects.HalfInteractEnterFrameArray.splice(staticInteractObjects.HalfInteractEnterFrameArray.indexOf(this), 1);
                        }
                        parent.removeChild(this);
                    }
                    else
                    {
                        nextFrame();
                    }
                }
        }
    }
}


