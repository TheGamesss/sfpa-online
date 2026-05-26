import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol4055"))

class IceCreamCart extends StaticInteractObjects
{
    
    public var thumbL : MovieClip;
    
    public var thumbR : MovieClip;
    
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
    
    public var superID : Int;
    
    private var thumbFrame : Int = 1;
    
    private var message : Bool = false;
    
    public var stayStraight : Bool;
    
    public function new(p : Dynamic)
    {
        isWide = 200;
        isTall = 200;
        super("PortalBox", p.x, p.y, p.scaleX, 1, 0);
        rotation = p.rotation;
        angle = rotation * (Math.PI / 180);
        if (p.hide != null)
        {
            this.hide = p.hide;
        }
        if (!this.hide)
        {
            Backgrounds.backgroundsArray[0].addChild(this);
        }
        isTall = 10;
        isWide = 40;
        this.springTall = isTall * 2;
        this.Status = "vase";
        this.superID = 0;
        this.message = p.message;
        InteractEnterFrameArray.push(this);
    }
    
    override public function InteractEnterFrame() : Bool
    {
        if (Math.random() < 0.1)
        {
            if (this.thumbFrame == 1)
            {
                this.thumbFrame = 2;
            }
            else
            {
                this.thumbFrame = 1;
            }
            this.thumbL.gotoAndStop(this.thumbFrame);
        }
        if (Math.random() < 0.1)
        {
            if (this.thumbFrame == 1)
            {
                this.thumbFrame = 2;
            }
            else
            {
                this.thumbFrame = 1;
            }
            this.thumbR.gotoAndStop(this.thumbFrame);
        }
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
                if (aUD > -5 && ay + char.isTall > -isTall * 2 && ay + char.isTall - aUD < -isTall + 20)
                {
                    char.ax = ax;
                    char.ay = ay;
                    char.aRL = aRL;
                    char.aUD = aUD;
                    char.angle = angle;
                    this.setChar(char);
                    if (InteractEnterFrameArray.indexOf(this) == -1)
                    {
                        InteractEnterFrameArray.push(this);
                    }
                    if (this.Status == "door" || this.Status == "trigger")
                    {
                        char.enterBox(this, this);
                    }
                    else if (this.Status == "vase")
                    {
                        if (this.message)
                        {
                            staticInteractObjects.findByUnique(0).changeProperties("nothing", 0, 30, -1, "nothing");
                        }
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
        char.setMask(x, y - 15, rotation, scaleX, scaleY);
    }
    
    public function clearChar() : Void
    {
    }
}


