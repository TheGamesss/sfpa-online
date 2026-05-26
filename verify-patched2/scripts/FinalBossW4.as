package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol7031")]
   public class FinalBossW4 extends Baddies
   {
      
      public var baddie:MovieClip;
      
      private var faceN:int;
      
      private var concernedN:int = -1;
      
      private var freeze:Boolean;
      
      private var intStatus:String;
      
      private var totalHealth:uint = 1000;
      
      private var active:Boolean = false;
      
      private var b:uint;
      
      public function FinalBossW4(p:*)
      {
         var i:String = null;
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
         facing = scx = scaleX = p.scaleX;
         inky = true;
         super(15,25,0);
         BallRes = 10;
         bounce = 0;
         bounceThresh = 8;
         maxRL = 2.5;
         stunMax = 120;
         health = this.totalHealth;
         rotPerc = 360 / (Math.PI * (isTall * 2));
         springTall = isTall * 2;
         overReach = 5;
         knockback = 0.5;
         launchThresh = 200;
         currentHitChar = this.FinalBossW4HitChar;
         currentGetAttacked = function(ex:Number, ey:Number, angle:Number, char:collision, hitMove:String, hitPower:Number, pow:Number = 1):Boolean
         {
         };
         rootHUD.HUD.spawnBossHealth();
         ChangeFrame("Wait");
      }
      
      override public function chooseCharInteract(frame:*) : void
      {
         switch(frame)
         {
            case "Wait":
               scaleX = makeOne(scaleX);
               scaleY = 1;
               smokeB = 120;
               break;
            case "Enter":
               spring = 0.5;
               springThresh = 2;
               springy = 35;
               isWide = 40;
               springBounce = standardIdleBounce;
               moveSpringBounce = standardMoveSpringBounce;
               this.baddie.stop();
               break;
            case "Morph":
               spring = 0;
               Main.switchScroll("customMultiScroll");
               break;
            case "Walk":
            case "Knockback":
               isWide = 15;
               maxRL = 2.5;
               break;
            case "Punch":
               Sounds.playSound("InkJump",x,1,onRail);
               isWide = 15;
               hurtPower = 12;
               this.baddie.hurtReach.visible = false;
               break;
            case "Dash":
               Sounds.playSound("InkJump",x,1,onRail);
               if(this.intStatus == "avoid")
               {
                  changeDirection(-CharDistX);
               }
               else
               {
                  changeDirection(CharDistX);
               }
               maxRL = 20;
               break;
            case "Throw":
               Sounds.playSound("InkJump",x,1,onRail);
               break;
            case "Jump":
               Sounds.playSound("InkJump",x,1,onRail);
               break;
            case "Land":
               if(health < 0)
               {
                  Main.shakeScreen(60,0,true);
                  Sounds.playSound("InkExplode",x,2,onRail);
                  ChangeFrame("Die");
               }
               else
               {
                  Main.shakeScreen(10,0,true);
                  Sounds.playSound("InkLand",x,1,onRail);
               }
               break;
            case "stunJump":
               health = -1;
               shakeRL = 120;
               Main.shakeScreen(80,0,true);
               fakeRL = moveRL = makeOne(moveRL) * 5;
               changeDirection(moveRL);
               moveUD = -25;
               isWide = 15;
               Sounds.playSound("InkBurst",x,2,onRail);
               this.b = 5;
         }
      }
      
      public function WaitEnterFrame() : *
      {
         if(smokeB > 0)
         {
            --smokeB;
         }
         else
         {
            ChangeFrame("Enter");
         }
      }
      
      public function EnterEnterFrame() : *
      {
         if(smokeB > 0)
         {
            --smokeB;
         }
         else
         {
            smokeB = 1;
            this.baddie.nextFrame();
         }
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            this.baddie.gotoAndStop(1);
         }
         if(Math.abs(spring) > 1)
         {
            springThresh = 0;
            fakeRL = 0;
            facing = scaleX = 1;
            ChangeFrame("Morph");
         }
         else if(x < -350)
         {
            springThresh = 0;
            if(fakeRL < 0)
            {
               fakeRL += 0.1;
            }
            else
            {
               fakeRL = 0;
               facing = scaleX = 1;
               ChangeFrame("Morph");
            }
         }
         else
         {
            fakeRL += (-(Math.abs(spring) * 12) - fakeRL) * 0.25;
         }
      }
      
      public function MorphEnterFrame() : *
      {
         this.baddie.nextFrame();
         if(this.baddie.currentFrame == 22 || this.baddie.currentFrame == 63 || this.baddie.currentFrame == 110 || this.baddie.currentFrame == 170)
         {
            Sounds.playSound("InkJump",x,1,onRail);
         }
         if(this.baddie.currentFrame > 160)
         {
            if(rootHUD.HUD.myBossHealth.alpha < 1)
            {
               rootHUD.HUD.myBossHealth.alpha += 0.05;
            }
         }
         if(this.baddie.currentFrame == 165)
         {
            Sounds.fadeOutMusic("W4FinalBoss",0.02);
         }
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            currentGetAttacked = this.FinalBossW4GetAttacked;
            scaleX = facing = -1;
            x += 25;
            this.intStatus = "creep";
            ChangeFrame("Walk");
            this.active = true;
         }
      }
      
      public function IdleEnterFrame() : *
      {
         this.baddie.nextFrame();
         fakeRL *= 0.95;
         if(Math.abs(fakeRL) > 2)
         {
            fakeRL -= makeOne(fakeRL) * 2;
         }
         else
         {
            fakeRL = 0;
         }
         changeDirection(CharDistX);
         if(this.intStatus == "creep")
         {
            if(Math.abs(CharDistX) > 120)
            {
               ChangeFrame("Walk");
            }
         }
      }
      
      public function WalkEnterFrame() : *
      {
         this.baddie.nextFrame();
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            this.baddie.gotoAndStop("loop");
         }
         changeDirection(CharDistX);
         if(fakeRL * facing < 0)
         {
            fakeRL *= 0.95;
            fakeRL -= makeOne(fakeRL);
         }
         else if(fakeRL != facing * maxRL)
         {
            if(Math.abs(fakeRL - facing * maxRL) > maxRL / 10)
            {
               if(fakeRL * facing > maxRL)
               {
                  fakeRL -= maxRL * facing / 10;
               }
               else
               {
                  fakeRL += maxRL * facing / 10;
               }
            }
            else
            {
               fakeRL = facing * maxRL;
            }
         }
         if(onLedge * fakeRL > 0)
         {
            x -= fakeRL;
            fakeRL = 0;
         }
         if(this.intStatus == "creep")
         {
            if(Math.abs(CharDistX) < 150)
            {
               this.intStatus = "approach";
            }
         }
         else if(this.intStatus == "approach")
         {
            if(Math.abs(CharDistX) < 250)
            {
               ChangeFrame("Punch");
            }
            else if(Math.abs(CharDistX) > 400)
            {
               ChangeFrame("Dash");
            }
         }
      }
      
      public function SlideEnterFrame() : *
      {
         this.baddie.nextFrame();
         fakeRL *= 0.95;
         if(Math.abs(fakeRL) > 2)
         {
            fakeRL -= makeOne(fakeRL) * 2;
         }
         if(onLedge * fakeRL > 0)
         {
            x -= fakeRL;
            fakeRL = 0;
         }
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            if(this.intStatus == "approach")
            {
               ChangeFrame("Punch");
            }
            else if(this.intStatus == "avoid")
            {
               changeDirection(-facing);
               ChangeFrame("Throw");
            }
            else
            {
               this.chooseIntStatus();
            }
         }
      }
      
      public function KnockbackEnterFrame() : *
      {
         this.baddie.nextFrame();
         fakeRL *= 0.95;
         if(Math.abs(fakeRL) > 2)
         {
            fakeRL -= makeOne(fakeRL) * 2;
         }
         if(onLedge * fakeRL > 0)
         {
            x -= fakeRL;
            fakeRL = 0;
         }
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            this.chooseIntStatus();
         }
      }
      
      public function PunchEnterFrame() : *
      {
         this.baddie.nextFrame();
         fakeRL *= 0.95;
         if(Math.abs(fakeRL) > 2)
         {
            fakeRL -= makeOne(fakeRL) * 2;
         }
         else
         {
            fakeRL = 0;
         }
         if(CharDistX * facing < 0)
         {
            isWide = 15;
         }
         else
         {
            isWide = this.baddie.hurtReach.x;
         }
         this.baddie.hurtReach.visible = false;
         if(this.baddie.currentFrame == 15)
         {
            Sounds.playSound("InkSpit",x,1,onRail);
         }
         else if(this.baddie.currentFrame > 16 && this.baddie.currentFrame < 23)
         {
            hurtPower = 25;
         }
         else
         {
            hurtPower = 12;
         }
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            this.chooseIntStatus();
         }
      }
      
      public function ThrowEnterFrame() : *
      {
         this.baddie.nextFrame();
         if(Math.abs(fakeRL) > 2)
         {
            fakeRL -= makeOne(fakeRL) * 2;
         }
         else
         {
            fakeRL = 0;
         }
         changeDirection(CharDistX);
         var temp:int = facing * 30;
         if(this.baddie.currentFrame == 12)
         {
            Sounds.playSound("HeavySwosh",x,1,onRail);
         }
         else if(this.baddie.currentFrameLabel == "throw")
         {
            Sounds.playSound("InkSpit",x,1,onRail);
            StarlingInteract.Spawn("inkShotBad",x,y - 25,-1.57 * facing,1.5,temp,0,onRail,50);
         }
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            ChangeFrame("Crouch");
         }
      }
      
      public function DashEnterFrame() : *
      {
         this.baddie.nextFrame();
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            this.baddie.gotoAndStop("loop");
         }
         if(this.intStatus == "avoid")
         {
            changeDirection(-CharDistX);
         }
         else
         {
            changeDirection(CharDistX);
         }
         if(fakeRL != facing * maxRL)
         {
            if(Math.abs(fakeRL - facing * maxRL) > maxRL / 10)
            {
               if(fakeRL * facing > maxRL)
               {
                  fakeRL -= maxRL * facing / 10;
               }
               else
               {
                  fakeRL += maxRL * facing / 10;
               }
            }
            else
            {
               fakeRL = facing * maxRL;
            }
         }
         if(Math.abs(CharDistX) < 250 + Math.abs(moveRL) * 2)
         {
            if(this.intStatus == "approach")
            {
               ChangeFrame("Slide");
            }
            else if(this.intStatus == "jumping")
            {
               ChangeFrame("Crouch");
            }
         }
         if(Math.abs(x) > 600 && facing * x > 0 || Math.abs(CharDistX) > 600 && facing * CharDistX < 0)
         {
            ChangeFrame("Slide");
         }
      }
      
      public function CrouchEnterFrame() : *
      {
         this.baddie.nextFrame();
         fakeRL *= 0.95;
         if(Math.abs(fakeRL) > 2)
         {
            fakeRL -= makeOne(fakeRL) * 2;
         }
         else
         {
            fakeRL = 0;
         }
         if(onLedge * fakeRL > 0)
         {
            x -= fakeRL;
            fakeRL = 0;
         }
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            moveUD = -30;
            if(Math.abs(CharX) < 750)
            {
               moveRL = CharDistX / (60 / 1.8);
            }
            if(Math.abs(moveRL) > 15)
            {
               moveRL = makeOne(CharDistX) * 15;
            }
            changeDirection(CharDistX);
            ChangeFrame("Jump");
         }
      }
      
      public function JumpEnterFrame() : *
      {
         this.baddie.nextFrame();
         if(moveUD < 30)
         {
            moveUD += 1.8;
         }
         if(y > 500)
         {
            moveRL = 0;
            x = makeOne(x) * 600;
            y = -500;
         }
      }
      
      public function LandEnterFrame() : *
      {
         this.baddie.nextFrame();
         fakeRL *= 0.95;
         if(Math.abs(fakeRL) > 2)
         {
            fakeRL -= makeOne(fakeRL) * 2;
         }
         else
         {
            fakeRL = 0;
         }
         if(onLedge * fakeRL > 0)
         {
            x -= fakeRL;
            fakeRL = 0;
         }
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            this.chooseIntStatus();
         }
      }
      
      override public function stunJumpEnterFrame() : void
      {
         this.baddie.nextFrame();
         if(moveUD < 0)
         {
            moveUD += 0.5;
         }
         else
         {
            ++moveUD;
         }
         rotter = -facing * 40;
         if(this.b > 0)
         {
            --this.b;
         }
         else
         {
            Sounds.playSound("Twirl",x,0.3,onRail);
            this.b = 4;
         }
      }
      
      public function DieEnterFrame() : void
      {
         this.baddie.nextFrame();
         fakeRL *= 0.95;
         if(Math.abs(fakeRL) > 2)
         {
            fakeRL -= makeOne(fakeRL) * 2;
         }
         else
         {
            fakeRL = 0;
         }
         if(onLedge * fakeRL > 0)
         {
            x -= fakeRL;
            fakeRL = 0;
         }
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            maxRL = 30;
            ChangeFrame("Chase");
         }
      }
      
      public function ChaseEnterFrame() : void
      {
         this.baddie.nextFrame();
         changeDirection(CharDistX);
         if(fakeRL * facing < 0)
         {
            fakeRL *= 0.95;
            fakeRL -= makeOne(fakeRL);
         }
         else if(fakeRL != facing * maxRL)
         {
            if(Math.abs(fakeRL - facing * maxRL) > maxRL / 10)
            {
               if(fakeRL * facing > maxRL)
               {
                  fakeRL -= maxRL * facing / 10;
               }
               else
               {
                  fakeRL += maxRL * facing / 10;
               }
            }
            else
            {
               fakeRL = facing * maxRL;
            }
         }
         if(onLedge * fakeRL > 0)
         {
            x -= fakeRL;
            fakeRL = 0;
         }
         if(this.baddie.currentFrame == this.baddie.totalFrames)
         {
            this.baddie.gotoAndStop(1);
         }
      }
      
      public function GrabEnterFrame() : void
      {
         this.baddie.nextFrame();
         this.baddie.char.visible = false;
         fakeRL *= 0.95;
         if(Math.abs(fakeRL) > 2)
         {
            fakeRL -= makeOne(fakeRL) * 2;
         }
         else
         {
            fakeRL = 0;
         }
         if(this.baddie.currentFrame == 6)
         {
            Sounds.playSound("PillarImpact",x,2,onRail);
            Main.shakeScreen(40,0,true);
         }
         else if(this.baddie.currentFrame == 40 || this.baddie.currentFrame == 50 || this.baddie.currentFrame == 60)
         {
            Sounds.playSound("Twirl",x,1,onRail);
         }
         else if(this.baddie.currentFrame == 60)
         {
            Sounds.playSound("HeavySwosh",x,2,onRail);
         }
         else if(this.baddie.currentFrame == 84)
         {
            Char.CharArray[0].changeFrame("Hurt");
            Char.CharArray[0].CharEnterFrame = Char.CharArray[0].SuperFallEnterFrame;
            Char.CharArray[0].facing = Char.CharArray[0].scaleX = 1;
            Char.CharArray[0].moveRL = 2 * facing;
            Char.CharArray[0].moveUD = -20;
            Char.CharArray[0].rotter = 40 * facing;
            Char.CharArray[0].Status = "Fly";
            Main.switchScroll("scrollChars");
            Char.CharArray[0].resetCamera();
            Main.shakeScreen(60,0,true);
            Sounds.playSound("Hit",x,2,onRail);
            Char.CharArray[0].wallX = Char.CharArray[0].x;
            Char.CharArray[0].wallY = Char.CharArray[0].y + 50;
            Char.CharArray[0].landPuffs(10,0,1.5);
            rootHUD.HUD.myBossHealth.visible = false;
         }
      }
      
      private function chooseIntStatus() : void
      {
         this.intStatus = ["approach","jumping","avoid"][Math.floor(Math.random() * 3)];
         if(this.intStatus == "jumping")
         {
            if(Math.abs(CharDistX) > 400)
            {
               ChangeFrame("Dash");
            }
            else
            {
               ChangeFrame("Crouch");
            }
         }
         else if(this.intStatus == "avoid")
         {
            ChangeFrame("Dash");
         }
         else
         {
            ChangeFrame("Walk");
         }
      }
      
      public function FinalBossW4GetAttacked(ex:Number, ey:Number, angle:Number, char:collision, hitMove:String, hitPower:Number, pow:Number = 1) : Boolean
      {
         if(!this.active)
         {
            return false;
         }
         shakeRL = hitPower + 10;
         downTime = 4;
         char.hitPause = hitPause = hitPower * 0.1 + 1;
         hurtBaddie(hitPower);
         Sounds.playSound("InkHurt",x,1,onRail);
         rootHUD.HUD.updateBossHealth(health / this.totalHealth);
         if(health == 0)
         {
            RedHurt = 10;
            char.hitPause = hitPause = 20;
            this.active = false;
            Sounds.fadeOutMusic("nothing",0.08);
            ChangeFrame("stunJump");
         }
         else
         {
            RedHurt = 4;
            if(hitPower > 20 && Status != "Jump")
            {
               fakeRL = moveRL = hitPower * makeOne(x - ex);
               if(Math.abs(moveRL) > 10)
               {
                  ChangeFrame("Knockback");
               }
            }
            else
            {
               fakeRL = moveRL = hitPower * makeOne(x - ex) * 0.4;
            }
         }
         transform.colorTransform = Main.getTint(1,-0.6,-0.6);
         return true;
      }
      
      public function FinalBossW4HitChar(ex:*, ey:*, eRL:*, eUD:*, ax:*, ay:*, char:*) : String
      {
         if(health < 0)
         {
            if(Status == "Chase")
            {
               if(Math.abs(ax) < Math.abs(fakeRL))
               {
                  scaleX = facing = -makeOne(x);
                  fakeRL = 0;
                  char.StompedOn = this;
                  ChangeFrame("Grab");
                  char.gotoBuffer = "Grabbed";
               }
            }
            return;
         }
         if(Math.abs(ax) < isWide + char.isWide && Math.abs(ay) < isTall + char.isTall)
         {
            if(isWide > 100)
            {
               if(char.hurtChar(hurtPower,40,10,makeOne(ex - x) * hurtPower,16,true))
               {
                  hitPause = 10;
                  Sounds.playSound("InkBurst",x,2,onRail);
                  StarlingEffect.Spawn("Splat",(ex + x) * 0.5,ey,Math.random() * 3.14,0.8,scaleX * 40,0,onRail);
               }
            }
            else
            {
               if(inkyHitChar(ex,ey,eRL,eUD,ax,ay,char) == "Hit")
               {
                  hurtBaddie(hurtPower);
                  rootHUD.HUD.updateBossHealth(health / this.totalHealth);
                  hurtPower = 12;
                  Sounds.playSound("InkHurt",x,1,onRail);
                  if(health == 0)
                  {
                     RedHurt = 10;
                     char.hitPause = hitPause = 20;
                     this.active = false;
                     Sounds.fadeOutMusic("nothing",0.08);
                     ChangeFrame("stunJump");
                  }
                  else
                  {
                     RedHurt = 3;
                  }
                  transform.colorTransform = Main.getTint(1,-0.6,-0.6);
               }
               spring = 0;
            }
            rotter = 0;
            return "Boss";
         }
         return "nothing";
      }
      
      override public function Projectile(ex:*, ey:*, eRL:*) : Boolean
      {
         if(!this.active || Math.abs(x - (ex - eRL * framin)) < isWide + 15)
         {
            return false;
         }
         hurtBaddie(5);
         Sounds.playSound("InkBurst",x,0.8,onRail);
         Sounds.playSound("InkSpit",x,0.8,onRail);
         rootHUD.HUD.updateBossHealth(health / this.totalHealth);
         if(health == 0)
         {
            moveRL = eRL * 0.4;
            RedHurt = 10;
            hitPause = 20;
            this.active = false;
            Sounds.fadeOutMusic("nothing",0.08);
            ChangeFrame("stunJump");
         }
         else
         {
            fakeRL += (eRL * 0.05 - fakeRL) * 0.5;
            RedHurt = 2;
         }
         transform.colorTransform = Main.getTint(1,-0.6,-0.6);
         return true;
      }
      
      public function FreezeEnterFrame() : *
      {
      }
      
      public function StunnedEnterFrame() : *
      {
         var rand:Number = NaN;
         this.baddie.nextFrame();
         stars.nextFrame();
         stars.scaleX = stars.scaleY = stunN / stunMax;
         slopeStuff();
         slideSlow(1);
         if(smokeN > 0)
         {
            smokeN -= Math.abs(fakeRL);
         }
         else
         {
            rand = Math.random() * 0.5 + 0.5;
            StarlingEffect.Spawn("smokePuff",footX(),footY(),wallAngle - Math.random() * 0.2 * scaleX,-scaleX * rand,UDx(-2 * rand),UDy(-2 * rand),onRail);
            smokeN = 20;
         }
         if(stars.currentFrame == stars.totalFrames)
         {
            stars.gotoAndStop(1);
         }
         if(stunN > 0)
         {
            --stunN;
         }
         else
         {
            ChangeFrame("Walk");
         }
      }
      
      private function gonnaStompHalp(e:*) : *
      {
         if(this.baddie.head.currentFrame < 12)
         {
            lastStomped = e;
            this.baddie.head.gotoAndStop(12);
         }
      }
   }
}

