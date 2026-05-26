import flash.errors.Error;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol1267"))

class LanguageSelector extends Sprite
{
    
    public var __id75_ : MovieClip;
    
    public var __id76_ : MovieClip;
    
    public var __id77_ : MovieClip;
    
    public var __id78_ : MovieClip;
    
    public var __id79_ : MovieClip;
    
    public var __id80_ : MovieClip;
    
    public var __id81_ : MovieClip;
    
    public function new()
    {
        super();
        this.__setProp___id75__languageSelector_Layer4_0();
        this.__setProp___id76__languageSelector_Layer4_0();
        this.__setProp___id77__languageSelector_Layer4_0();
        this.__setProp___id78__languageSelector_Layer4_0();
        this.__setProp___id79__languageSelector_Layer4_0();
        this.__setProp___id80__languageSelector_Layer4_0();
        this.__setProp___id81__languageSelector_Layer4_0();
    }
    
    public function levelClicked(event : MouseEvent) : Void
    {
        Main.localSettings.language = ["English", "Spanish", "French", "Italian", "Portuguese", "German", "Russian"][event.target.parent.door];
        staticInteractObjects.swapTextBubbles(Main.localSettings.language);
    }
    
    @:allow()
    private function __setProp___id75__languageSelector_Layer4_0() : Dynamic
    {
        try
        {
            this.__id75_["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.__id75_.dir = "World 4";
        this.__id75_.ID = "language";
        this.__id75_.door = 0;
        try
        {
            this.__id75_["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp___id76__languageSelector_Layer4_0() : Dynamic
    {
        try
        {
            this.__id76_["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.__id76_.dir = "World 4";
        this.__id76_.ID = "language";
        this.__id76_.door = 1;
        try
        {
            this.__id76_["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp___id77__languageSelector_Layer4_0() : Dynamic
    {
        try
        {
            this.__id77_["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.__id77_.dir = "World 4";
        this.__id77_.ID = "language";
        this.__id77_.door = 2;
        try
        {
            this.__id77_["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp___id78__languageSelector_Layer4_0() : Dynamic
    {
        try
        {
            this.__id78_["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.__id78_.dir = "World 4";
        this.__id78_.ID = "language";
        this.__id78_.door = 3;
        try
        {
            this.__id78_["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp___id79__languageSelector_Layer4_0() : Dynamic
    {
        try
        {
            this.__id79_["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.__id79_.dir = "World 4";
        this.__id79_.ID = "language";
        this.__id79_.door = 4;
        try
        {
            this.__id79_["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp___id80__languageSelector_Layer4_0() : Dynamic
    {
        try
        {
            this.__id80_["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.__id80_.dir = "World 4";
        this.__id80_.ID = "language";
        this.__id80_.door = 5;
        try
        {
            this.__id80_["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp___id81__languageSelector_Layer4_0() : Dynamic
    {
        try
        {
            this.__id81_["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.__id81_.dir = "World 4";
        this.__id81_.ID = "language";
        this.__id81_.door = 6;
        try
        {
            this.__id81_["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
}


