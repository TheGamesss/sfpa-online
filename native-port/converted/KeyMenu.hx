import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.*;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol1320"))

class KeyMenu extends MovieClip
{
    
    public static var keymenu : Dynamic;
    
    public var banner : MovieClip;
    
    public var extrafancykey : SimpleButton;
    
    public var fancykey : SimpleButton;
    
    public var goldkey : SimpleButton;
    
    public var key : SimpleButton;
    
    public var platinumkey : SimpleButton;
    
    public var silverkey : SimpleButton;
    
    public function new()
    {
        super();
        keymenu = this;
        alpha = 0;
        this.banner.stop();
        if (Main.hasKey())
        {
            gotoAndStop(2);
        }
        else
        {
            gotoAndStop(1);
        }
        this.key.addEventListener(MouseEvent.MOUSE_OVER, this.buttonOver, false, 0, true);
        this.fancykey.addEventListener(MouseEvent.MOUSE_OVER, this.buttonOver, false, 0, true);
        this.silverkey.addEventListener(MouseEvent.MOUSE_OVER, this.buttonOver, false, 0, true);
        this.goldkey.addEventListener(MouseEvent.MOUSE_OVER, this.buttonOver, false, 0, true);
        this.platinumkey.addEventListener(MouseEvent.MOUSE_OVER, this.buttonOver, false, 0, true);
        this.extrafancykey.addEventListener(MouseEvent.MOUSE_OVER, this.buttonOver, false, 0, true);
        this.key.addEventListener(MouseEvent.MOUSE_OUT, this.buttonOut, false, 0, true);
        this.fancykey.addEventListener(MouseEvent.MOUSE_OUT, this.buttonOut, false, 0, true);
        this.silverkey.addEventListener(MouseEvent.MOUSE_OUT, this.buttonOut, false, 0, true);
        this.goldkey.addEventListener(MouseEvent.MOUSE_OUT, this.buttonOut, false, 0, true);
        this.platinumkey.addEventListener(MouseEvent.MOUSE_OUT, this.buttonOut, false, 0, true);
        this.extrafancykey.addEventListener(MouseEvent.MOUSE_OUT, this.buttonOut, false, 0, true);
    }
    
    public static function BuyKey() : Dynamic
    {
        keymenu.clearButtons();
        keymenu.gotoAndStop(3);
    }
    
    public static function destroy() : Dynamic
    {
        keymenu.stage.focus = keymenu.stage;
        keymenu.parent.removeChild(keymenu);
        keymenu = null;
    }
    
    public function PauseEnterFrame() : Dynamic
    {
        if (alpha != 1)
        {
            if (alpha < 1)
            {
                alpha += 0.5 * Main.framin;
            }
            else
            {
                alpha = 1;
            }
        }
    }
    
    private function BuyAKey(e : MouseEvent) : Dynamic
    {
        if (Main.stageRoot.stage.loaderInfo.url.indexOf("www.bornegames.com") > -1 || Main.debug)
        {
            trace("buy a key");
            Main.pauseStatus = "checkForKey";
            this.clearButtons();
            gotoAndStop(3);
        }
        Main.buyAKey(e.target.name);
    }
    
    private function buttonOver(e : MouseEvent) : Dynamic
    {
        this.banner.gotoAndStop(e.target.name);
    }
    
    private function buttonOut(e : MouseEvent) : Dynamic
    {
        this.banner.gotoAndStop(1);
    }
    
    private function clearButtons() : Dynamic
    {
        this.key.removeEventListener(MouseEvent.MOUSE_OVER, this.buttonOver);
        this.fancykey.removeEventListener(MouseEvent.MOUSE_OVER, this.buttonOver);
        this.silverkey.removeEventListener(MouseEvent.MOUSE_OVER, this.buttonOver);
        this.goldkey.removeEventListener(MouseEvent.MOUSE_OVER, this.buttonOver);
        this.platinumkey.removeEventListener(MouseEvent.MOUSE_OVER, this.buttonOver);
        this.extrafancykey.removeEventListener(MouseEvent.MOUSE_OVER, this.buttonOver);
        this.key.removeEventListener(MouseEvent.MOUSE_OUT, this.buttonOut);
        this.fancykey.removeEventListener(MouseEvent.MOUSE_OUT, this.buttonOut);
        this.silverkey.removeEventListener(MouseEvent.MOUSE_OUT, this.buttonOut);
        this.goldkey.removeEventListener(MouseEvent.MOUSE_OUT, this.buttonOut);
        this.platinumkey.removeEventListener(MouseEvent.MOUSE_OUT, this.buttonOut);
        this.extrafancykey.removeEventListener(MouseEvent.MOUSE_OUT, this.buttonOut);
    }
}


