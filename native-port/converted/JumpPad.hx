import flash.display.MovieClip;
import starling.display.Image;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol6269"))

class JumpPad extends Baddies
{
    
    public var springing : MovieClip;
    
    public var surface : MovieClip;
    
    private var postSpring : Bool;
    
    private var mSin : Float;
    
    private var mCos : Float;
    
    private var inABox : Bool;
    
    private var moving : Bool;
    
    public var springRot : Int;
    
    private var surfaceShadow : Image;
    
    private var springShadow : Image;
    
    public function new(p : Dynamic)
    {
        var i : String = null;
        super(40 * Math.abs(p.scaleX), p.thrust + 10, p.onRail);
        for (i in Reflect.fields(p))
        {
            if (i != "componentInspectorSetting")
            {
                Reflect.setField(this, i, Reflect.field(p, i));
            }
        }
        scaleY = 1;
        ItIs = "JumpPad";
        x = p.x;
        y = p.y;
        scaleX = p.scaleX;
        rotation = wallRot = p.rotation;
        y -= isTall - 30;
        this.surface.y = originalSpringTall * 0.5 - springTall;
        this.springing.y = originalSpringTall * 0.5;
        this.springing.scaleY = springTall / 60;
        originX = x;
        originY = y;
        wallAngle = rotation * (Math.PI / 180);
        this.mSin = -Math.sin(wallAngle);
        this.mCos = Math.cos(wallAngle);
        wallX = footX();
        wallY = footY();
        if (p.Status == null)
        {
            p.Status = "Idle";
        }
        Backgrounds.backgroundsArray[onRail].addChild(this);
        BallRes = 0;
        isTall = as3hx.Compat.parseInt(originalSpringTall * 0.5);
        canBall = false;
        bounce = 0;
        bounceThresh = 0;
        maxRL = 4;
        springy = 5;
        if (this.springRot == 0 || this.springRot == -360)
        {
            this.springRot = rotation;
        }
        health = 0;
        rotPerc = 360 / (Math.PI * thrust);
        canGetShot = false;
        overReach = 0;
        BaddieEnterFrame = this[p.Status + "EnterFrame"];
        activeBaddieArray.push(this);
        JumpPadArray.push(this);
        BaddieEnterFrame();
        springBounce = this.jumppadSpringBounce;
        moveSpringBounce = this.jumppadMoveSpringBounce;
        this.doSpringStamp();
        this.doSurfaceStamp();
        if (p.Status == "Move")
        {
            this.moving = true;
            Status = "Move";
            fakeRL = moveRL = 10;
        }
        else
        {
            Status = "Stomped";
        }
        visible = false;
        currentHitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : String
                {
                    angle = rotation * (Math.PI / 180);
                    aRL = Math.cos(angle) * eRL + Math.sin(angle) * eUD;
                    aUD = Math.cos(angle) * eUD - Math.sin(angle) * eRL;
                    oDistRL = x - char.lastX;
                    oDistUD = y - char.lastY;
                    oy = Math.cos(angle) * oDistUD - Math.sin(angle) * oDistRL;
                    if (char.StompedOn != this)
                    {
                        if (char.Status != "Hurt" && ay < char.isTall + isTall && oy > char.isTall + isTall && aUD > 0.2 && Math.abs(ax) < isWide + char.isWide)
                        {
                            Sounds.playSound("Spring", x, thrust * 0.05, onRail);
                            char.wallX = wallX = footX();
                            char.wallY = wallY = footY();
                            spring = -thrust * 0.8;
                            char.wallRot = rotation;
                            char.canAutoLook = false;
                            char.rotation = (char.rotation + rotation) * 0.5;
                            char.rotter = (rotation - char.rotation) / 3;
                            char.StompedOn = this;
                            char.fakeRL = aRL;
                            stompingOn.push(char);
                            postSpring = true;
                            char.fakeUD = char.moveUD = 0;
                            springTall = as3hx.Compat.parseInt(ay - char.isTall + isTall);
                            jumppadMoveSpringBounce();
                            char.gotoBuffer = "Stomp";
                        }
                    }
                    return "nothing";
                };
        currentGetAttacked = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Dynamic
                {
                    return false;
                };
    }
    
    public function IdleEnterFrame() : Dynamic
    {
    }
    
    public function MoveEnterFrame() : Dynamic
    {
        moveRL += (originX - x) * 0.0015;
        if (Math.abs(originX - x) < Math.abs(moveRL))
        {
            moveRL = fakeRL * makeOne(moveRL);
        }
    }
    
    public function jumppadSpringBounce() : Void
    {
        var mass : Float = 20;
        var force : Float = 20 * spring;
        for (i in 0...stompingOn.length)
        {
            force += stompingOn[i].mass * spring;
            mass += stompingOn[i].mass;
        }
        if (stompingOn.length == 0)
        {
            if (this.postSpring)
            {
                force += (originalSpringTall * 1.2 - springTall) * 3;
                if (force < 0)
                {
                    this.postSpring = false;
                }
            }
            else
            {
                force += (originalSpringTall - springTall) * 3;
            }
            spring = force / mass;
            spring *= 0.9;
        }
        else
        {
            force += (originalSpringTall * 1.5 - springTall) * 6;
            spring = force / mass;
        }
    }
    
    public function jumppadMoveSpringBounce() : Void
    {
        springTall += as3hx.Compat.parseInt(spring * framin);
        if (this.moving)
        {
            wallX = footX();
            wallY = footY();
            this.springShadow.x = wallX;
            this.springShadow.y = wallY;
        }
        this.surfaceShadow.x = wallX - this.mSin * springTall;
        this.surfaceShadow.y = wallY - this.mCos * springTall;
        this.springShadow.scaleY = springTall / 60 * 0.6666;
    }
    
    public function doSpringStamp() : Void
    {
        var angle : Float = rotation * (Math.PI / 180);
        this.springShadow = StarlingSmoke.Spawn("springStamp", wallX, wallY, angle, scaleX * 0.6666, 0, 0, onRail);
        this.springShadow.scaleY = springTall / 60 * 0.6666;
    }
    
    public function doSurfaceStamp() : Void
    {
        this.surfaceShadow = StarlingSmoke.Spawn("surfaceStamp", x, y - springTall * 0.5, rotation * (Math.PI / 180), scaleX * 0.6666, 0, 0, onRail);
    }
    
    public function updateRotation() : Void
    {
        wallAngle = rotation * (Math.PI / 180);
        this.mSin = -Math.sin(wallAngle);
        this.mCos = Math.cos(wallAngle);
        x = wallX + this.mSin * -isTall;
        y = wallY + this.mCos * -isTall;
        this.surfaceShadow.rotation = wallAngle;
        this.springShadow.rotation = wallAngle;
        this.surfaceShadow.x = wallX + this.mSin * -springTall;
        this.surfaceShadow.y = wallY + this.mCos * -springTall;
        this.springShadow.scaleY = springTall / 60 * 0.6666;
    }
    
    override public function cleanUp() : Void
    {
        this.surfaceShadow.goSwim();
        this.springShadow.goSwim();
        this.surfaceShadow = null;
        this.springShadow = null;
    }
}


