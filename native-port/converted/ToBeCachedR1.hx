import flash.errors.Error;
import flash.accessibility.*;
import flash.desktop.*;
import flash.display.*;
import flash.errors.*;
import flash.events.*;
import flash.external.*;
import flash.filters.*;
import flash.geom.*;
import flash.media.*;
import flash.net.*;
import flash.net.drm.*;
import flash.system.*;
import flash.text.*;
import flash.text.ime.*;
import flash.ui.*;
import flash.utils.*;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol7843"))

class ToBeCachedR1 extends MovieClip
{
    
    public var aGround0 : MovieClip;
    
    public var aGround2 : MovieClip;
    
    public var aGround3 : MovieClip;
    
    public function new()
    {
        super();
        this.__setProp_aGround3_toBeCachedR1_Layer1_0();
        this.__setProp_aGround2_toBeCachedR1_Layer1_0();
        this.__setProp_aGround0_toBeCachedR1_Layer1_0();
    }
    
    @:allow()
    private function __setProp_aGround3_toBeCachedR1_Layer1_0() : Dynamic
    {
        try
        {
            this.aGround3["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.aGround3.ID = 4;
        this.aGround3.ItIs = "aGround";
        this.aGround3.moveRot = 0;
        this.aGround3.rail = 0;
        this.aGround3.status = "pillar1";
        this.aGround3.wait = true;
        try
        {
            this.aGround3["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp_aGround2_toBeCachedR1_Layer1_0() : Dynamic
    {
        try
        {
            this.aGround2["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.aGround2.ID = 2;
        this.aGround2.ItIs = "aGround";
        this.aGround2.moveRot = 0.5;
        this.aGround2.rail = 0;
        this.aGround2.status = "Rotate";
        this.aGround2.fromTemp = true;
        try
        {
            this.aGround2["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
    
    @:allow()
    private function __setProp_aGround0_toBeCachedR1_Layer1_0() : Dynamic
    {
        try
        {
            this.aGround0["componentInspectorSetting"] = true;
        }
        catch (e : Error)
        {
        }
        this.aGround0.ID = 0;
        this.aGround0.ItIs = "aGround";
        this.aGround0.moveRot = 1;
        this.aGround0.rail = 0;
        this.aGround0.status = "Rotate";
        this.aGround0.fromTemp = true;
        try
        {
            this.aGround0["componentInspectorSetting"] = false;
        }
        catch (e : Error)
        {
        }
    }
}


