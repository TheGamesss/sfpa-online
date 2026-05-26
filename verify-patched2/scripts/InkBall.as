package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol6421")]
   public class InkBall extends Baddies
   {
      
      public var baddie:MovieClip;
      
      public var stars:MovieClip;
      
      private var b:uint;
      
      private var concernedN:int = -1;
      
      private var freeze:Boolean;
      
      private var lifetimeN:int = -1;
      
      private var distX:int;
      
      private var distY:int;
      
      private var dist:uint;
      
      private var shootN:uint;
      
      private var state:uint;
      
      public function InkBall(p:*)
      {
         var i:String = null;
         onKilled = p.onKilled;
         spawner = p.spawner;
         p.hatN = 0;
         super(20 * Math.abs(p.scaleY),20 * Math.abs(p.scaleY),p.onRail);
         for(i in p)
         {
            if(i != "componentInspectorSetting")
            {
               this[i] = p[i];
            }
         }
         x = p.x;
         originY = y = p.y;
         if(p.originX == undefined)
         {
            originX = x;
         }
         wallRot = rotation = p.rotation;
         facing = makeOne(p.scaleX);
         inky = true;
         scaleY = scale = Math.abs(p.scaleY);
         scaleX = scale * p.scaleX;
         BallRes = 10;
         bounce = 0.8;
         bounceThresh = 5;
         maxRL = 6 / ((scale - 1) * 0.5 + 1);
         springy = 10;
         stunMax = 120;
         healthMax = health = isTall * isWide / 10;
         power = 0.5 + scale;
         retreatThresh = health - 50 - Math.random() * 50;
         attackN = -1;
         rotPerc = 360 / (Math.PI * (isTall * 2));
         springTall = isTall * 2;
         overReach = 5;
         knockback = 0.5;
         spring = 0;
         if(scale > 2)
         {
            grounded = true;
         }
         launchThresh = mass * 0.5;
         attentionRange = 300 + isWide * 2;
         if(tether == -1)
         {
            tether = 10000;
         }
         currentHitChar = inkyHitChar;
         springBounce = standardSpringBounce;
         if(!resetOnFall)
         {
            canAggressor = true;
            AggressorArray.push(this);
         }
         isABall = true;
         if(scale < 2.5)
         {
            visible = false;
            smokeName = "InkBallSmoke";
         }
         if(moveUD == 0)
         {
            ChangeFrame("Wait");
         }
         else
         {
            ChangeFrame("Drop");
         }
         spring = 5 * scale;
         this.shootN = 50 + 50 * Math.random();
      }
      
      override public function resetBad() : void
      {
         x = originX;
         y = originY;
         moveRL = moveUD = 0;
         health = healthMax;
         explode = false;
         currentHitChar = inkyHitChar;
         ChangeFrame("Roll");
      }
      
      override public function chooseCharInteract(frame:*) : void
      {
         if(groundStatus(frame))
         {
            moveSpringBounce = function():*
            {
            };
         }
         else
         {
            moveSpringBounce = standardMoveSpringBounce;
         }
         if(hasSmoke)
         {
            if(frame == "Roll")
            {
               smokeFrameOffset = 0;
            }
            else if(frame == "Hit")
            {
               smokeFrameOffset = 2;
            }
            else if(frame == "deadJump")
            {
               smokeFrameOffset = 4;
            }
         }
         switch(frame)
         {
            case "Wait":
            case "Roll":
               scaleX = makeOne(scaleX) * scale;
               scaleY = Math.abs(scaleX);
               spring = 0;
               break;
            case "Drop":
               wallRot = 0;
               rotation = -Math.atan2(-moveRL,-moveUD) / (Math.PI / 180);
               springBounce = standardSpringBounce;
               this.baddie.x = this.baddie.y = 0;
               break;
            case "Freeze":
               break;
            case "deadJump":
               currentHitChar = function(ex:*, ey:*, eRL:*, eUD:*, ax:*, ay:*, char:*):String
               {
               };
               wallRot = 0;
               spring = 5 * scale;
               springBounce = standardSpringBounce;
               this.baddie.x = this.baddie.y = 0;
         }
         if(hasSmoke)
         {
            currentSmoke.currentFrame = smokeFrameOffset + this.baddie.currentFrame;
         }
      }
      
      public function WaitEnterFrame() : *
      {
         if(inRange())
         {
            tilRangeCheck = 300;
            ChangeFrame("Roll");
            this.state = 0;
         }
      }
      
      public function RollEnterFrame() : *
      {
         ++moveUD;
         if(Math.abs(moveRL) > 3)
         {
            moveRL -= makeOne(moveRL) * 0.05;
         }
      }
      
      public function DropEnterFrame() : *
      {
         this.baddie.nextFrame();
         if(moveUD < 0 && this.baddie.currentFrame == 21)
         {
            this.baddie.gotoAndStop(3);
         }
         rotter = rotCompare(-Math.atan2(-moveRL,-moveUD) / (Math.PI / 180),rotation);
         if(Math.abs(rotter) > 10)
         {
            makeOne(rotter) * 10;
         }
         if(facing * moveRL < 0)
         {
            facing *= -1;
            scaleX = scale * facing;
         }
         if(moveUD < 2)
         {
            ++moveUD;
         }
         else
         {
            originX = x;
            originY = y;
            ChangeFrame("Fly");
         }
      }
      
      override public function deadJumpEnterFrame() : void
      {
         var rand:Number = NaN;
         rotter *= 0.95;
         if(FloatUp > 0)
         {
            --FloatUp;
         }
         else
         {
            ++moveUD;
         }
         if(smokeB > 0)
         {
            --smokeB;
            if(smokeN > 0)
            {
               --smokeN;
            }
            else
            {
               rand = Math.random() * 0.5 + 0.5;
               StarlingEffect.Spawn("smokePuff",footX(),footY(),Math.random() * 3,-scaleX * rand,UDx(-2 * rand),UDy(-2 * rand),onRail);
               smokeN = 2;
            }
         }
         else
         {
            Sounds.playSound("InkBurst",x,scale * 1.2,onRail);
            StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,(scale - 0.5) * 0.4 + 0.6,moveRL,moveUD,onRail);
            if(resetOnFall)
            {
               this.resetBad();
            }
            else
            {
               killBaddies.push(this);
            }
         }
      }
   }
}

