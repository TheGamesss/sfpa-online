import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol6147"))

class Scratch extends Baddies
{
    
    public var baddie : MovieClip;
    
    private var lifetime : Int = 300;
    
    public function new(ex : Dynamic, ey : Dynamic, speed : Dynamic, rot : Dynamic)
    {
        super();
        ItIs = "Scratch";
        x = ex;
        y = ey;
        angle = rot * (Math.PI / 180);
        moveRL = speed * Math.sin(angle);
        moveUD = speed * -Math.cos(angle);
        rotter = moveRL * 2.5;
        this.baddie.ItIs = "Scratch";
        Backgrounds.backgroundsArray[0].addChild(this);
        BallRes = 0;
        isTall = 10;
        isWide = 10;
        bounce = 0.9;
        bounceThresh = 2;
        maxRL = 4;
        springy = 3;
        stunMax = 120;
        health = 0;
        rotPerc = 360 / (Math.PI * (isTall * 2));
        springTall = as3hx.Compat.parseInt(isTall * 2);
        overReach = 10;
        mass = 15;
        currentHitChar = standardBeAFireball;
        BaddieEnterFrame = this.BulletEnterFrame;
        Status = "Bullet";
        activeBaddieArray.push(this);
    }
    
    override public function chooseCharInteract(frame : Dynamic) : Void
    {
        if (frame == "deadJump")
        {
            canAggressor = true;
            AggressorArray.push(this);
        }
    }
    
    private function BulletEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            this.baddie.gotoAndStop(1);
        }
        --this.lifetime;
        if (this.lifetime == 0)
        {
            killBaddies.push(this);
        }
    }
    
    override public function deadJumpEnterFrame() : Void
    {
        this.FlyEnterFrame();
    }
    
    public function FlyEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            this.baddie.gotoAndStop(1);
        }
        ++moveUD;
        if (y > Main.cameraY + Main.stageYs[onRail] + 50)
        {
            killBaddies.push(this);
        }
    }
}


