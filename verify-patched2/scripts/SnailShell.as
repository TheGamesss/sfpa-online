package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5672")]
   public class SnailShell extends Baddies
   {
      
      public var baddie:MovieClip;
      
      public function SnailShell(p:*)
      {
         var i:String = null;
         super(15,15,p.onRail);
         for(i in p)
         {
            if(i != "componentInspectorSetting")
            {
               this[i] = p[i];
            }
         }
         originX = x = p.x;
         originY = y = p.y;
         wallRot = realRot = rotation = p.rotation;
         facing = scx = scaleX = 1;
         BallRes = 10;
         bounce = 0.8;
         bounceThresh = 4;
         maxRL = 4;
         springy = 5;
         springDecay = 0.7;
         stunMax = 80;
         health = 10000;
         healthMax = 0;
         rotPerc = 360 / (Math.PI * (isTall * 2));
         springTall = isTall * 2;
         overReach = 4;
         isABall = true;
         canAggressor = true;
         AggressorArray.push(this);
         currentHitChar = standardBeABall;
         springBounce = standardSpringBounce;
         moveSpringBounce = standardMoveSpringBounce;
         smokeName = "SnailShellSmoke";
         visible = false;
         this.ChangeFrame("Wait");
      }
      
      public function WaitEnterFrame() : void
      {
         if(inRange())
         {
            tilRangeCheck = 60;
            this.ChangeFrame("Roll");
         }
      }
      
      public function RollEnterFrame() : Boolean
      {
         ++moveUD;
         if(moveUD < -10)
         {
            tilRangeCheck = 40;
         }
         if(tilRangeCheck > 0)
         {
            --tilRangeCheck;
         }
         else if(inRange())
         {
            tilRangeCheck = 40;
         }
         else
         {
            this.ChangeFrame("Wait");
         }
      }
      
      override public function ChangeFrame(frame:*) : void
      {
         if(frame != "Wait" && frame != "Roll")
         {
            return;
         }
         BaddieEnterFrame = this[frame + "EnterFrame"];
         if(frame == "Wait")
         {
            if(activeBaddieArray.indexOf(this) > -1)
            {
               activeBaddieArray.splice(activeBaddieArray.indexOf(this),1);
            }
            cleanUp();
         }
         else
         {
            if(activeBaddieArray.indexOf(this) == -1)
            {
               activeBaddieArray.push(this);
               aPlat.resetplatSides(x,y,this);
            }
            if(!hasSmoke)
            {
               hasSmoke = true;
               currentSmoke = StarlingSmoke.Spawn(smokeName,x,y,0,1,0,0,onRail);
            }
            smokeSetFrame();
            placeSmoke();
         }
         Status = frame;
      }
   }
}

