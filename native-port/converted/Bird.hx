import flash.display.MovieClip;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol7555"))

class Bird extends Baddies
{
    
    public var baddie : MovieClip;
    
    private var lifetime : Int = 300;
    
    public function new(p : Dynamic)
    {
        super(40, 15, p.onRail);
        ItIs = "Bird";
        x = p.x;
        y = p.y;
        scaleX = -1;
        BallRes = 0;
        bounce = 0.9;
        bounceThresh = 2;
        maxRL = 4;
        springy = 4;
        springDecay = 0.9;
        stunMax = 120;
        health = 1;
        rotPerc = 360 / (Math.PI * (isWide * 2));
        overReach = 10;
        if (p.hatN > 0 && Main.localSettings.hasHatsString.substr(p.hatN - 1, 1) != "y")
        {
            hatN = p.hatN;
        }
        else
        {
            hatN = 0;
        }
        currentHitChar = standardHitChar;
        springBounce = standardSpringBounce;
        moveSpringBounce = standardMoveSpringBounce;
        cast(("Wait"), ChangeFrame);
        Backgrounds.backgroundsArray[onRail].addChild(this);
    }
    
    override public function chooseCharInteract(frame : Dynamic) : Void
    {
        switch (frame)
        {
            case "Jump":
                if (hatN > 0)
                {
                    this.baddie.body.hat.gotoAndStop(hatN);
                }
                else
                {
                    this.baddie.body.hat.gotoAndStop(1);
                    this.baddie.body.hat.visible = false;
                }
            case "stunJump", "deadJump":
                springDecay = 0.9;
                currentHitChar = standardBeABall;
            case "Stomped":
                springDecay = 1;
        }
    }
    
    public function WaitEnterFrame() : Dynamic
    {
        if (inRange())
        {
            moveRL = -3;
            moveUD = 20;
            cast(("Jump"), ChangeFrame);
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
    
    public function JumpEnterFrame() : Dynamic
    {
        this.baddie.nextFrame();
        if (this.baddie.currentFrame == this.baddie.totalFrames)
        {
            this.baddie.gotoAndStop(1);
        }
        if (moveUD > 0)
        {
            moveUD *= 0.95;
            moveUD -= 0.5;
        }
        else
        {
            moveUD = 0;
        }
    }
}


