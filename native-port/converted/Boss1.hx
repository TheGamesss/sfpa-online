import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol7540"))

class Boss1 extends Baddies
{
    
    public var baddie : MovieClip;
    
    private var bossTimer : Int = 0;
    
    private var faceN : Int;
    
    private var concernedN : Int = -1;
    
    private var freeze : Bool;
    
    private var lifetimeN : Int = -1;
    
    private var handB : Int = 0;
    
    private var targetX : Int = 0;
    
    private var targetY : Int = 0;
    
    private var eyeRx : Int = 0;
    
    private var eyeRy : Int = 0;
    
    private var eyeLx : Int = 0;
    
    private var eyeLy : Int = 0;
    
    public var handR : Boss1Hand;
    
    public var handL : Boss1Hand;
    
    public var handRCacheN : Int;
    
    public var handLCacheN : Int;
    
    public var bodyCacheN : Int;
    
    public function new(p : Dynamic)
    {
        var i : String = null;
        super(2000, 1000, 1);
        for (i in Reflect.fields(p))
        {
            if (i != "componentInspectorSetting")
            {
                Reflect.setField(this, i, Reflect.field(p, i));
            }
        }
        originX = x = p.x;
        originY = y = p.y;
        wallRot = rotation = p.rotation;
        facing = makeOne(p.scaleX);
        BallRes = 0;
        bounce = 0.5;
        bounceThresh = 20;
        maxRL = 6 / ((scale - 1) * 0.5 + 1);
        springy = 20;
        stunMax = 120;
        retreatThresh = as3hx.Compat.parseInt(health - 50 - Math.random() * 50);
        attackN = -1;
        rotPerc = 360 / (Math.PI * (isTall * 2));
        originalSpringTall = springTall = 342;
        overReach = 5;
        knockback = 0.5;
        if (scale > 2)
        {
            grounded = true;
        }
        launchThresh = mass * 0.5;
        attentionRange = as3hx.Compat.parseInt(300 + isWide * 2);
        if (tether == -1)
        {
            tether = 10000;
        }
        currentHitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : String
                {
                };
        currentGetAttacked = function(ex : Dynamic, ey : Dynamic, angle : Dynamic, char : Dynamic, hitMove : Dynamic, hitPower : Dynamic) : Bool
                {
                };
        springDecay = 1;
        springThresh = 3;
        gonnaStomp = function(e : Dynamic) : Dynamic
                {
                };
        this.handRCacheN = StarlingTemporary.Spawn("Boss1Hand", 0, 1000, 0, -1, 0);
        this.handLCacheN = StarlingTemporary.Spawn("Boss1Hand", 0, 1000, 0, 1, 0);
        this.bodyCacheN = StarlingTemporary.Spawn("Boss1Body", 0, 1000, 0, 1, 1);
        StarlingTemporary.setVisible(this.bodyCacheN, false);
        cast(("Wait"), ChangeFrame);
    }
    
    override public function chooseCharInteract(frame : Dynamic) : Void
    {
        ledgeTimer = 10;
        switch (frame)
        {
            case "Emerge":
            case "Idle":
                this.handL.stop();
                this.handR.stop();
                this.handR.facing = -1;
                attackN = as3hx.Compat.parseInt(20 + 80 * Math.random());
            case "Pound":
                if (CharX < 0)
                {
                    this.handL.goPound();
                }
                else
                {
                    this.handR.goPound();
                }
            case "Swipe":
                if (CharX < 0)
                {
                    this.handR.goSwipe();
                }
                else
                {
                    this.handL.goSwipe();
                }
                this.baddie.hand.visible = false;
            case "Hurt":
                if (this.handR.status != "shake")
                {
                    this.handR.status = "idle";
                    this.handR.rotation = 0;
                }
                if (this.handL.status != "shake")
                {
                    this.handL.status = "idle";
                    this.handL.rotation = 0;
                }
            case "Smashed":
                this.handB = 0;
                this.faceN = 60;
                spring = -100;
                this.handR.status = "dead";
                this.handR.rotation = 0;
                this.handR.gotoAndStop("dead");
                this.handL.status = "dead";
                this.handL.rotation = 0;
                this.handL.gotoAndStop("dead");
                new InkVein({
                    x : 2,
                    y : 142,
                    scaleX : 1,
                    scaleY : 1
                });
                if (this.bossTimer < 900)
                {
                    Achievements.unlock("Boss_Rush");
                }
                Achievements.SendScore("defeatBoss1", this.bossTimer / 30);
        }
        if (frame != "Wait" && frame != "Emerge" && frame != "Hurt" && frame != "Smashed")
        {
            this.baddie.eyeL.x = this.eyeLx;
            this.baddie.eyeL.y = this.eyeLy;
            this.baddie.eyeR.x = this.eyeRx;
            this.baddie.eyeR.y = this.eyeRy;
            this.baddie.scaleY = springTall / originalSpringTall * scale;
            this.baddie.scaleX = (scale - this.baddie.scaleY + scale) * makeOne(this.baddie.scaleX);
            this.baddie.y = (originalSpringTall - springTall) * 0.5;
        }
    }
    
    private function boss1HitChar(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : String
    {
        this.targetX = ex;
        this.targetY = ey;
    }
    
    public function resetHands() : Dynamic
    {
        cast(("Idle"), ChangeFrame);
        this.handR.status = "idle";
        this.handR.rotation = 0;
        this.handL.status = "idle";
        this.handL.rotation = 0;
        attackN = 130;
    }
    
    public function WaitEnterFrame() : Dynamic
    {
        if (CharY > y)
        {
            cast(("Emerge"), ChangeFrame);
            springBounce = bossHeadSpringBounce;
        }
    }
    
    public function EmergeEnterFrame() : Dynamic
    {
        if (this.baddie.currentFrame == 1)
        {
            onRail = 1;
            Sounds.fadeOutMusic("Wind_Cave", 0.02);
        }
        this.baddie.nextFrame();
        if (this.baddie.currentFrameLabel == "a")
        {
            Sounds.playSound("InkBoom", -300, 2, onRail);
            Main.shakeScreen(80, 0, true);
        }
        else if (this.baddie.currentFrameLabel == "b")
        {
            Sounds.playSound("InkBoom", 300, 2, onRail);
            Main.shakeScreen(80, 0, true);
        }
        else if (this.baddie.currentFrameLabel == "c")
        {
            StarlingTemporary.setVisible(this.bodyCacheN, true);
        }
        if (this.baddie.currentFrame == 418)
        {
            Sounds.fadeOutMusic("BossMusic", 5);
        }
        if (this.baddie.currentFrame > 421 && this.baddie.currentFrame < 456)
        {
            Main.shakeScreen(60 * Math.random(), Math.random() * 3.14, true);
        }
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            spring = 2;
            this.eyeLx = -54;
            this.eyeLy = 10;
            this.eyeRx = 62;
            this.eyeRy = 0;
            this.handL = new Boss1Hand(-337, -50, this);
            this.handR = new Boss1Hand(358, -48, this);
            this.handL.myCacheN = this.handLCacheN;
            this.handR.myCacheN = this.handRCacheN;
            Backgrounds.backgroundsArray[0].addChild(this.handL);
            Backgrounds.backgroundsArray[0].addChild(this.handR);
            this.handR.scaleX = -1;
            cast(("Idle"), ChangeFrame);
            onRail = 1;
            currentHitChar = this.boss1HitChar;
            this.handR.gotoAndStop(10);
        }
    }
    
    public function IdleEnterFrame() : Void
    {
        this.moveEyes(CharX, CharY);
        if (attackN > 0)
        {
            --attackN;
        }
        else if (Math.random() > 0.5)
        {
            cast(("Swipe"), ChangeFrame);
        }
        else
        {
            cast(("Pound"), ChangeFrame);
        }
    }
    
    public function SwipeEnterFrame() : Void
    {
        this.baddie.nextFrame();
        this.moveEyes(CharX, CharY);
        if (this.baddie.currentFrame == 56)
        {
            if (this.handR.status == "swipe")
            {
                Sounds.playSound("InkBoom", this.handR.x, 1.5, onRail);
            }
            if (this.handL.status == "swipe")
            {
                Sounds.playSound("InkBoom", this.handL.x, 1.5, onRail);
            }
            Main.shakeScreen(80, 0, true);
        }
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            if (this.handR.status == "swipe")
            {
                this.handR.status = "idle";
                this.handR.nextFrame();
                this.handR.rotation = 0;
            }
            if (this.handL.status == "swipe")
            {
                this.handL.status = "idle";
                this.handL.nextFrame();
                this.handL.rotation = 0;
            }
            cast(("Idle"), ChangeFrame);
        }
    }
    
    public function PoundEnterFrame() : Void
    {
        this.baddie.nextFrame();
        this.targetX = CharX;
        this.targetY = CharY;
        this.moveEyes(this.targetX, this.targetY);
    }
    
    public function HurtEnterFrame() : Void
    {
        this.baddie.nextFrame();
        if (this.baddie.currentFrame > 34)
        {
            this.moveEyes(CharX, CharY);
        }
        else
        {
            ++this.bossTimer;
        }
        if (this.baddie.currentFrame == 238 || this.baddie.currentFrame == 242)
        {
            this.baddie.eyeL.visible = this.baddie.eyeR.visible = false;
        }
        else if (this.baddie.currentFrame == 240 || this.baddie.currentFrame == 245)
        {
            this.baddie.eyeL.visible = this.baddie.eyeR.visible = true;
        }
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            this.handR.gotoAndStop(10);
            this.handL.gotoAndStop("idle");
            this.handR.status = "idle";
            this.handL.status = "idle";
            cast(("Idle"), ChangeFrame);
        }
    }
    
    public function SmashedEnterFrame() : Void
    {
        if (scaleY != 0)
        {
            if (this.faceN == 1)
            {
                --this.faceN;
                springBounce = function() : Dynamic
                        {
                        };
                scale = 0;
            }
            else if (this.faceN > 0)
            {
                --this.faceN;
            }
            else
            {
                scale += 0.0001;
                scaleX -= scale;
                scaleY -= scale;
                if (scaleY < 0)
                {
                    staticInteractObjects.clearByName("TriggerBox");
                    staticInteractObjects.findByName("inkVein").start();
                    new WarpBox({
                        x : 0,
                        y : 80,
                        scaleX : 5.4,
                        scaleY : 2.3,
                        ItIs : "TriggerBox",
                        onRail : 0,
                        warpLevel : "cameraShift",
                        propY : 50,
                        propZ : 30,
                        removeID : 0
                    });
                    new APlat({
                        ItIs : "aPlat",
                        x : 12,
                        y : 165,
                        rotation : 0,
                        scaleX : 2.350845,
                        status : "Invisible",
                        onRail : 0
                    });
                    aPlat.resetplatSides(CharX, CharY, Char.CharArray[0]);
                    Main.switchScroll("scrollChars");
                    scale = scaleX = scaleY = 0;
                    killBaddies.push(this);
                }
                y = 170 - 170 * scaleY;
                this.handR.theX *= 1 - scale * 2;
                this.handR.theY -= y;
                this.handR.theY *= 1 - scale * 2;
                this.handR.theY += y;
                this.handL.theX *= 1 - scale * 2;
                this.handL.theY -= y;
                this.handL.theY *= 1 - scale * 2;
                this.handL.theY += y;
                this.handR.scaleY = this.handL.scaleX = this.handL.scaleY = scaleY;
                this.handR.scaleX = this.handR.scaleY * -1;
                StarlingTemporary.setScales(this.bodyCacheN, scaleX, scaleY);
                StarlingTemporary.justGetWithN(this.bodyCacheN).y = y;
                if (this.handB > 0)
                {
                    --this.handB;
                }
                else
                {
                    this.handB = 3;
                    Sounds.playSound("InkJump", x, 1, 0);
                    StarlingEffect.Spawn("Splat", (200 - 400 * Math.random()) * scaleY, y + (150 - 300 * Math.random()) * scaleY, Math.random() * 6, scaleY * 2, 0, -20 * scaleY, onRail);
                }
            }
        }
    }
    
    private function moveEyes(ex : Dynamic, ey : Dynamic) : Dynamic
    {
        ++this.bossTimer;
        this.eyeLx += (-80 + (ex - (x - 80)) * 0.08 - this.eyeLx) * 0.2;
        this.eyeLy += ((ey - y) * 0.05 - this.eyeLy) * 0.2;
        this.eyeRx += (80 + (ex - (x + 80)) * 0.08 - this.eyeRx) * 0.2;
        this.eyeRy += (-10 + (ey - y) * 0.05 - this.eyeRy) * 0.2;
        this.baddie.eyeL.x = this.eyeLx;
        this.baddie.eyeL.y = this.eyeLy;
        this.baddie.eyeR.x = this.eyeRx;
        this.baddie.eyeR.y = this.eyeRy;
    }
}


