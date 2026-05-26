
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3681"))

class PortalTear extends StaticInteractObjects
{
    
    public var Status : String;
    
    public var stringVar : String;
    
    public var numVar : String;
    
    public var spring : Float = 0;
    
    private var springTall : Int;
    
    private var springy : Int = 3;
    
    private var disabled : Bool;
    
    public var tumble : Bool;
    
    public var waitN : Int = -1;
    
    private var hide : Bool;
    
    public var stayStraight : Bool;
    
    public var jumper : Int = 24;
    
    private var tearSmoke : StarlingSmoke;
    
    public function new(p : Dynamic)
    {
        var i : String = null;
        for (i in Reflect.fields(p))
        {
            if (i != "componentInspectorSetting")
            {
                Reflect.setField(this, i, Reflect.field(p, i));
            }
        }
        isWide = 200;
        isTall = 200;
        super("PortalTear", p.x, p.y, p.scaleX, p.scaleY, onRail, this.stringVar, this.numVar);
        rotation = p.rotation;
        angle = rotation * (Math.PI / 180);
        isTall = 10;
        isWide = as3hx.Compat.parseInt(40 * p.scaleX);
        this.springTall = isTall * 2;
        if (this.Status == "door")
        {
            DoorArray[ID] = this;
            if (this.stringVar == "nothing")
            {
                this.disabled = true;
            }
        }
        if (!this.hide)
        {
            this.tearSmoke = StarlingSmoke.Spawn("tearStamp", x, y, rotation * (Math.PI / 180), scaleX * 0.6666, 0, 0, onRail);
            visible = false;
        }
        visible = false;
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        var i : Int = 0;
        if (this.disabled)
        {
            return false;
        }
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
                ax = 0;
                if (aUD > -5 && ay + char.isTall > -isTall * 2 && ay + char.isTall - aUD < -isTall + 20)
                {
                    char.ax = ax;
                    char.ay = ay;
                    char.aRL = aRL;
                    char.aUD = aUD;
                    char.angle = angle;
                    this.setChar(char);
                    if (this.Status == "door" || this.Status == "trigger")
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
                            if (InteractArray[i].ItIs == "PortalTear")
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
    
    public function setChar(char : Char) : Void
    {
        ax = -Math.sin(angle) * 9 * scaleX;
        ay = Math.cos(angle) * 9 * scaleX;
        char.setMask(x + ax, y + ay, rotation, scaleX * 0.6, scaleX);
    }
    
    public function clearChar() : Void
    {
    }
    
    override public function cleanUp() : Void
    {
        if (!this.hide)
        {
            this.tearSmoke.goSwim();
            this.tearSmoke = null;
        }
    }
}


