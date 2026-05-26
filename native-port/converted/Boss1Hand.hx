
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol7231"))

class Boss1Hand extends InteractObjects
{
    
    private var waveB : Int = 0;
    
    private var b : Int = 0;
    
    private var anchorX : Float = -350;
    
    private var anchorY : Float = -50;
    
    private var state : Int = 0;
    
    private var sinMove : Float = 1.57;
    
    private var attackN : Int = 0;
    
    private var myBoss1 : Baddies;
    
    public var myCacheN : Int;
    
    private var rotConvert : Float = 0.017453292519943295;
    
    public var status : String = "idle";
    
    public var backEffect : Bool = true;
    
    public function new(ex : Int, ey : Int, boss : Boss1)
    {
        super();
        ItIs = "boss1Hand";
        BallRes = 0;
        isWide = 60;
        isTall = 50;
        theX = x = ex;
        theY = y = ey;
        health = 100;
        inky = true;
        this.myBoss1 = boss;
        canAttackArray.push(this);
        onRail = 0;
        visible = false;
    }
    
    override public function EveryCollision() : Void
    {
    }
    
    public function goSwipe() : Void
    {
        this.state = 0;
        this.status = "swipe";
        gotoAndStop("swipe");
    }
    
    public function goPound() : Void
    {
        moveUD = -30;
        this.attackN = 0;
        this.status = "pound";
        gotoAndStop("pound");
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        distRL = theX - ex;
        distUD = theY - ey;
        if ((char.Status == "Pencil" || char.Status == "PencilAir") && char.char.currentFrame > 6 || Math.abs(shakeRL) > 1)
        {
            if (Math.abs(moveRL) < 20 && Math.abs(moveUD) < 20)
            {
                char.ax = char.distRL = distRL;
                char.ay = char.distUD = distUD;
                char.pushBack(this);
                return false;
            }
        }
        if (Math.abs(shakeRL) > 1)
        {
            return false;
        }
        if (this.status == "idle" || this.status == "lower" || this.status == "dead" || this.status == "shake")
        {
            return false;
        }
        if (Math.abs(distRL) < 60 + char.isWide && Math.abs(distUD) < 50 + char.isTall)
        {
            if (char.alpha == 1 && char.health > 0)
            {
                hitPause = 7;
                if (this.status == "swipe")
                {
                    this.myBoss1.hitPause = 7;
                    char.hurtChar(10, 20, 10, moveRL * 1.5, 30);
                }
                else if (this.status == "slap")
                {
                    if (moveUD <= 20)
                    {
                        return false;
                    }
                    char.hurtChar(10, 50, 10, char.makeOne(ex - x) * 30, 10);
                }
                else if (moveUD > 20)
                {
                    if (char.onGround)
                    {
                        char.hurtChar(10, 50, 10, char.makeOne(ex - x) * 5, 50);
                    }
                    else
                    {
                        char.hurtChar(10, 40, 10, char.makeOne(ex - x) * 20, -80);
                    }
                }
                else
                {
                    char.hurtChar(10, 20, 10, char.makeOne(ex - x) * 15, 20);
                }
                Main.shakeScreen(120, 0, true);
            }
        }
        return true;
    }
    
    public function currentGetAttacked(ex : Float, ey : Float, ang : Float, char : Collision, hitMove : String, hitPower : Float, power : Float) : Bool
    {
        if (downTime == 0 && Math.abs(moveRL) < 20 && Math.abs(moveUD) < 20 && this.status != "lower" && this.status != "slap" && this.status != "dead")
        {
            Main.shakeScreen(20, ang, false);
            shakeRL = 120;
            char.hitPause = hitPower * 0.2 + 1;
            this.myBoss1.hitPause = hitPause = char.hitPause * 2;
            downTime = hitPause + 2;
            RedHurt = 4;
            transform.colorTransform = Main.getTint(1, -0.6, -0.6);
            health -= as3hx.Compat.parseInt(hitPower * power);
            Sounds.playSound("InkExplode", x, 1, 0);
            Sounds.playSound("Impact", x, 2, 0);
            StarlingEffect.Spawn("Splat", x * 0.5 + ex * 0.5, y * 0.2 + ey * 0.8, Math.random() * 3.14, 0.6, (ex - x) * 0.08, -5, onRail);
            if (hitPower > 20)
            {
                char.fakeRL = char.moveRL = -char.scaleX * 15;
            }
            else
            {
                char.fakeRL = char.moveRL = -char.scaleX * 2;
            }
            if (health <= 0)
            {
                this.myBoss1.handR.health = 100;
                this.myBoss1.handL.health = 100;
                moveRL = -Math.sin(ang) * -200;
                moveUD = Math.cos(ang) * -200;
                rotation = 0;
                this.status = "shake";
                gotoAndStop("shake");
                this.myBoss1.ChangeFrame("Hurt");
            }
            return true;
        }
        return false;
    }
    
    override public function InteractEnterFrame() : Void
    {
        if (hitPause > 0)
        {
            --hitPause;
        }
        else if (this.status == "idle")
        {
            this.idleEnterFrame();
        }
        else if (this.status == "swipe")
        {
            this.swipeEnterFrame();
        }
        else if (this.status == "pound")
        {
            this.poundEnterFrame();
        }
        else if (this.status == "shake")
        {
            this.shakeEnterFrame();
        }
        else if (this.status == "slap")
        {
            this.slapEnterFrame();
        }
        else if (this.status == "lower")
        {
            this.lowerEnterFrame();
        }
        this.hurtStuff();
    }
    
    private function idleEnterFrame() : Void
    {
        nextFrame();
        if (this.waveB > 0)
        {
            --this.waveB;
        }
        else
        {
            this.waveB = 10;
            this.anchorX = (320 + Math.random() * 60) * -facing;
            this.anchorY = -20 - Math.random() * 60;
        }
        moveRL += (this.anchorX - x) * 0.02;
        moveRL *= 0.8;
        moveUD += (this.anchorY - y) * 0.02;
        moveUD *= 0.8;
        theX += moveRL;
        theY += moveUD;
        if (currentFrameLabel == "loopidle" || currentFrameLabel == "pounded" || currentFrameLabel == "swiped" || currentFrameLabel == "shook")
        {
            gotoAndStop("idle");
        }
    }
    
    private function swipeEnterFrame() : Void
    {
        if (currentFrameLabel != "swiping")
        {
            nextFrame();
        }
        if (facing > 0)
        {
            moveRL = this.myBoss1.baddie.hand.x - x;
            rotation = this.myBoss1.baddie.hand.rotation;
        }
        else
        {
            moveRL = -this.myBoss1.baddie.hand.x - x;
            rotation = -this.myBoss1.baddie.hand.rotation;
        }
        moveUD = this.myBoss1.baddie.hand.y - theY;
        theX += moveRL;
        theY += moveUD;
    }
    
    private function poundEnterFrame() : Void
    {
        if (currentFrameLabel == "pounding")
        {
            moveUD = 0;
        }
        else
        {
            nextFrame();
        }
        if (this.attackN > 1)
        {
            --this.attackN;
        }
        else if (this.attackN == 1)
        {
            this.status = "idle";
            this.myBoss1.ChangeFrame("Idle");
            this.attackN = 0;
            moveUD = 0;
        }
        else
        {
            moveRL = (Char.CharArray[0].x - x) * 0.1;
            if (moveUD > 0)
            {
                moveRL *= 0.6;
            }
            theX += moveRL;
            if (moveUD < 0)
            {
                moveUD += 2;
            }
            else
            {
                moveUD += 3;
            }
            theY += moveUD;
            if (this.myBoss1.groundHitTest(x, theY + 80))
            {
                while (this.myBoss1.groundHitTest(x, theY + 79))
                {
                    --theY;
                }
                Sounds.playSound("InkBoom", x, 2, onRail);
                Main.shakeScreen(200, 0, true);
                this.attackN = 50;
            }
        }
    }
    
    private function shakeEnterFrame() : Void
    {
        nextFrame();
        moveRL += (350 * -facing - x) * 0.05;
        moveRL *= 0.8;
        moveUD += (-100 - y) * 0.05;
        moveUD *= 0.8;
        theX += moveRL;
        theY += moveUD;
        if (currentFrameLabel == "shook")
        {
            this.attackN = 20;
            this.status = "slap";
        }
    }
    
    private function slapEnterFrame() : Void
    {
        if (currentFrameLabel == "slapping")
        {
            moveUD = 0;
        }
        nextFrame();
        if (this.attackN == 1)
        {
            if (moveUD < 50)
            {
                moveUD += 10;
            }
            if (this.myBoss1.groundHitTest(x, theY + 20 + moveUD * 2))
            {
                while (!this.myBoss1.groundHitTest(x, theY + 19))
                {
                    ++theY;
                }
                this.attackN = 0;
                Main.shakeScreen(200, 0, true);
                Sounds.playSound("InkBoom", x, 2, onRail);
                aPlat.forceAllWaits(x);
            }
            else
            {
                rotation += -rotation * 0.5;
                theX += moveRL;
                theY += moveUD * 2;
            }
        }
        else if (this.attackN > 0)
        {
            --this.attackN;
            moveRL = (350 * -facing - x) * 0.2;
            moveUD = (-300 - y) * 0.2;
            rotation += (40 - rotation) * 0.2;
            theX += moveRL;
            theY += moveUD;
        }
        if (currentFrameLabel == "lower")
        {
            this.status = "lower";
        }
        else if (currentFrameLabel == "slapped")
        {
            if (this.myBoss1.handL.status != "slap")
            {
                this.myBoss1.handL.gotoAndStop("lower");
                this.myBoss1.handL.status = "lower";
            }
            if (this.myBoss1.handR.status != "slap")
            {
                this.myBoss1.handR.gotoAndStop("lower");
                this.myBoss1.handR.status = "lower";
            }
        }
    }
    
    private function lowerEnterFrame() : Void
    {
        moveRL = (60 * -facing - x) * 0.2;
        moveUD = (200 - y) * 0.2;
        theX += moveRL;
        theY += moveUD;
    }
    
    private function hurtStuff() : Void
    {
        if (RedHurt > 0)
        {
            if (RedHurt == 2 || RedHurt == 4)
            {
                transform.colorTransform = Main.getTint(1, -0.6, -0.6);
            }
            if (RedHurt == 1 || RedHurt == 3 || RedHurt == 5)
            {
                transform.colorTransform = Main.getTint(0, 0, 0);
            }
            --RedHurt;
        }
        x = theX + shakeRL * 0.5 - shakeRL * Math.random();
        y = theY + shakeRL * 0.5 - shakeRL * Math.random();
        if (currentFrame < 44 && y < 0 || currentFrame == 78 || currentFrame == 156)
        {
            visible = RedHurt > 0;
            StarlingTemporary.placeTemp(this.myCacheN, x, y, rotation * this.rotConvert);
            StarlingTemporary.setVisible(this.myCacheN, true);
            if (currentFrame == 78)
            {
                StarlingTemporary.setFrame(this.myCacheN, 23);
            }
            else if (currentFrame == 156)
            {
                StarlingTemporary.setFrame(this.myCacheN, 24);
            }
            else
            {
                StarlingTemporary.setFrame(this.myCacheN, Math.floor(currentFrame * 0.5) + 1);
            }
        }
        else
        {
            visible = true;
            StarlingTemporary.setVisible(this.myCacheN, false);
        }
        shakeRL *= 0.7;
    }
}


