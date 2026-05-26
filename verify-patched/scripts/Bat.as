package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol7593")]
   public class Bat extends Baddies
   {
      
      public var baddie:MovieClip;
      
      public var stars:MovieClip;
      
      private var fakeDist:int;
      
      public function Bat(p:*)
      {
         var i:String = null;
         super(40,15,p.onRail);
         for(i in p)
         {
            if(i != "componentInspectorSetting")
            {
               this[i] = p[i];
            }
         }
         wallAngle = wallRot * (Math.PI / 180);
         originX = x = p.x;
         originY = y = p.y;
         facing = scx = scaleX = p.scaleX;
         BallRes = 0;
         isTall = 20;
         isWide = 40;
         bounce = 0.5;
         bounceThresh = 8;
         springThresh = 3;
         springy = 3;
         springDecay = 0.9;
         stunMax = 120;
         health = healthMax = 1;
         rotPerc = 360 / (Math.PI * (isTall * 2));
         overReach = 10;
         mass = 40;
         currentHitChar = standardHitChar;
         currentGetAttacked = standardGetAttacked;
         springBounce = standardSpringBounce;
         visible = false;
         smokeName = "BatSmoke";
         ChangeFrame("Fly");
         this.baddie.gotoAndStop(Math.floor(Math.random() * 30));
         fakeRL = maxRL;
         this.fakeDist = 0;
         bounce = 150;
      }
      
      override public function chooseCharInteract(frame:*) : void
      {
         if(!hasSmoke)
         {
            smokeFrameOffset = -1;
         }
         else if(frame == "Fly")
         {
            smokeFrameOffset = 0;
         }
         else if(frame == "stunJump" || frame == "Stomped" || frame == "Hit")
         {
            smokeFrameOffset = 33;
         }
         else if(frame == "deadJump")
         {
            smokeFrameOffset = 34;
         }
         switch(frame)
         {
            case "Idle":
               cleanUp();
            case "Fly":
               isWide = 40;
               currentHitChar = standardHitChar;
               break;
            case "deadJump":
               isWide = 15;
               currentHitChar = standardBeABall;
               moveSpringBounce = standardMoveSpringBounce;
               if(moveUD > -20)
               {
                  moveUD = -20;
               }
               if(hasSmoke)
               {
                  currentSmoke.pivotY = 0;
               }
               break;
            case "Stomped":
               scaleX = makeOne(scaleX);
               scaleY = 1;
               moveSpringBounce = stompedMoveSpringBounce;
               if(hasSmoke)
               {
                  currentSmoke.pivotY = 15;
               }
         }
         smokeSetFrame();
      }
      
      public function FlyEnterFrame() : *
      {
         this.baddie.nextFrame();
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            this.baddie.gotoAndStop("loop");
         }
         smokeSetFrame();
         if(Math.abs(fakeX) > this.fakeDist)
         {
            fakeRL -= (fakeX - this.fakeDist * fakeX / Math.abs(fakeX)) / bounce;
         }
         fakeX += fakeRL;
         moveRL = RLx(fakeRL);
         moveUD = RLy(fakeRL);
         x = originX + RLx(fakeX);
         y = originY + RLy(fakeX);
      }
   }
}

