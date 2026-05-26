package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol7555")]
   public class Bird extends Baddies
   {
      
      public var baddie:MovieClip;
      
      private var lifetime:uint = 300;
      
      public function Bird(p:*)
      {
         super(40,15,p.onRail);
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
         if(p.hatN > 0 && Main.localSettings.hasHatsString.substr(p.hatN - 1,1) != "y")
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
         ChangeFrame("Wait");
         Backgrounds.backgroundsArray[onRail].addChild(this);
      }
      
      override public function chooseCharInteract(frame:*) : void
      {
         switch(frame)
         {
            case "Jump":
               if(hatN > 0)
               {
                  this.baddie.body.hat.gotoAndStop(hatN);
               }
               else
               {
                  this.baddie.body.hat.gotoAndStop(1);
                  this.baddie.body.hat.visible = false;
               }
               break;
            case "stunJump":
            case "deadJump":
               springDecay = 0.9;
               currentHitChar = standardBeABall;
               break;
            case "Stomped":
               springDecay = 1;
         }
      }
      
      public function WaitEnterFrame() : *
      {
         if(inRange())
         {
            moveRL = -3;
            moveUD = 20;
            ChangeFrame("Jump");
         }
      }
      
      private function BulletEnterFrame() : *
      {
         this.baddie.nextFrame();
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            this.baddie.gotoAndStop(1);
         }
         --this.lifetime;
         if(this.lifetime == 0)
         {
            killBaddies.push(this);
         }
      }
      
      public function JumpEnterFrame() : *
      {
         this.baddie.nextFrame();
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            this.baddie.gotoAndStop(1);
         }
         if(moveUD > 0)
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
}

