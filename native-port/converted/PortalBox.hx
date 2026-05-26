import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3690"))

class PortalBox extends StaticInteractObjects
{
    
    public var box : MovieClip;
    
    public var Status : String;
    
    public var stringVar : String;
    
    public var numVar : String;
    
    public var spring : Float = 0;
    
    private var springTall : Int;
    
    private var springy : Int = 3;
    
    public var superID : Int = -1;
    
    public var tumble : Bool;
    
    public var waitN : Int = -1;
    
    private var stamp : StarlingSmoke;
    
    private var myChar : Char;
    
    public var stayStraight : Bool;
    
    public var jumper : Int = 24;
    
    public function new(p : Dynamic)
    {
        var i : String = null;
        for (i in Reflect.fields(p))
        {
            if (i != "componentInspectorSetting" && i != "status")
            {
                Reflect.setField(this, i, Reflect.field(p, i));
            }
        }
        super("PortalBox", p.x, p.y, 1, 1, onRail, this.stringVar, this.numVar);
        rotation = p.rotation;
        this.Status = p.status;
        isTall = 35;
        isWide = 40;
        this.box.stop();
        this.box.color.gotoAndStop(ID + 1);
        this.springTall = isTall * 2;
        visible = false;
        if (Math.abs(rotation) < 12)
        {
            this.stayStraight = true;
        }
        if (this.Status == "door")
        {
            DoorArray[ID] = this;
            if (this.stringVar == "nothing")
            {
                disabled = true;
            }
        }
        angle = rotation * (Math.PI / 180);
        this.stamp = StarlingSmoke.Spawn("PortalBoxStamp", x, y, angle, scaleX, 0, 0, onRail);
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        var i : Int = 0;
        ex -= x;
        ey -= y;
        ax = Math.cos(angle) * ex + Math.sin(angle) * ey;
        ay = Math.cos(angle) * ey - Math.sin(angle) * ex;
        aRL = Math.cos(angle) * eRL + Math.sin(angle) * eUD;
        aUD = Math.cos(angle) * eUD - Math.sin(angle) * eRL;
        if (Math.abs(ax) < isWide)
        {
            if (char.Status != "enterBox" && char.Status != "Hurt")
            {
                if (ay + char.isTall > -isTall && ay + char.isTall - aUD < -isTall)
                {
                    char.ax = ax;
                    char.ay = ay;
                    char.aRL = aRL;
                    char.aUD = aUD;
                    char.angle = angle;
                    this.spring = -20;
                    if (InteractEnterFrameArray.indexOf(this) == -1)
                    {
                        InteractEnterFrameArray.push(this);
                    }
                    this.setChar(char);
                    if (this.Status == "door")
                    {
                        char.enterBox(this, this);
                    }
                    else if (this.Status == "vase")
                    {
                        char.enterBox(this, this);
                    }
                    else
                    {
                        for (i in 0...InteractArray.length)
                        {
                            if (InteractArray[i].ItIs == "PortalBox")
                            {
                                if (this != InteractArray[i] && ID == InteractArray[i].ID)
                                {
                                    char.enterBox(this, InteractArray[i]);
                                }
                            }
                        }
                    }
                }
            }
        }
        else
        {
            char.parent.mask = null;
        }
    }
    
    override public function InteractEnterFrame() : Bool
    {
        this.spring += (isTall * 2 - this.springTall) / this.springy;
        this.spring *= 0.8;
        this.springTall += this.spring;
        this.stamp.scaleY = this.springTall / (isTall * 2);
        this.stamp.scaleX = 1 - this.stamp.scaleY + 1;
        ax = -Math.sin(angle) * (15 - 15 * this.stamp.scaleY);
        ay = Math.cos(angle) * (15 - 15 * this.stamp.scaleY);
        this.stamp.x = x + ax;
        this.stamp.y = y + ay;
        ax = -Math.sin(angle) * (15 - 30 * this.stamp.scaleY);
        ay = Math.cos(angle) * (15 - 30 * this.stamp.scaleY);
        if (this.myChar != null)
        {
            this.myChar.updateMask(x + ax, y + ay);
        }
        if (Math.abs(this.spring + (isTall * 2 - this.springTall) / this.springy) < 0.01)
        {
            this.spring = 0;
            this.springTall = isTall * 2;
            return true;
        }
    }
    
    public function setChar(char : Char) : Void
    {
        this.myChar = char;
        ax = -Math.sin(angle) * (15 - 30 * this.stamp.scaleY);
        ay = Math.cos(angle) * (15 - 30 * this.stamp.scaleY);
        char.setMask(x + ax, y + ay, rotation, scaleX, scaleY);
    }
    
    public function clearChar() : Void
    {
        this.myChar = null;
    }
    
    override public function cleanUp() : Void
    {
        if (this.stamp != null)
        {
            this.stamp.goSwim();
            this.stamp = null;
        }
        if (this.myChar != null)
        {
            this.myChar = null;
        }
    }
}


