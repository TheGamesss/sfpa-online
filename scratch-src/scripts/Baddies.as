package
{
   import flash.display.*;
   
   public class Baddies extends collision
   {
      
      internal static var baddieContainer:MovieClip;
      
      public static var BaddieArray:Vector.<Baddies> = new Vector.<Baddies>(0);
      
      public static var activeBaddieArray:Vector.<Baddies> = new Vector.<Baddies>(0);
      
      public static var AggressorArray:Vector.<Baddies> = new Vector.<Baddies>(0);
      
      public static var JumpPadArray:Vector.<Baddies> = new Vector.<Baddies>(0);
      
      public static var CharX:int = 0;
      
      public static var CharY:int = 0;
      
      public static var CharRail:uint = 0;
      
      public static var killBaddies:Vector.<Baddies> = new Vector.<Baddies>(0);
      
      public var CharDistX:int = 0;
      
      public var CharDistY:int = 0;
      
      public var BaddieEnterFrame:Function;
      
      public var isWearing:String = "nothing";
      
      public var smokeName:String = "nothing";
      
      public var thrust:int = 16;
      
      public var float:int;
      
      public var hopRail:int = -1;
      
      public var forceStill:Boolean;
      
      public var canBall:Boolean = true;
      
      public var currentHitChar:Function;
      
      public var currentGetAttacked:Function = this.standardGetAttacked;
      
      public var solid:Boolean;
      
      public var lastStomped:Object;
      
      public function gonnaStomp(e:*):*
      {
      }
      public var stompingOn:Vector.<Char> = new Vector.<Char>(0);
      
      public var tilRangeCheck:uint;
      
      public var hatN:int = 0;
      
      public var knockback:Number = 1;
      
      public var grounded:Boolean;
      
      public var autopilot:Boolean;
      
      public var attentionRange:uint;
      
      public var tether:int = 10000;
      
      public var insomnia:Boolean;
      
      public var spawner:staticInteractObjects;
      
      public var onKilled:String;
      
      public var ledgeTimer:uint;
      
      public var attackN:int;
      
      public var temporary:Boolean;
      
      public var retreatThresh:int = 0;
      
      public var hasSmoke:Boolean;
      
      public var currentSmoke:StarlingSmoke;
      
      public var baddieFrame:uint = 1;
      
      public var resetOnFall:Boolean;
      
      public var backEffect:Boolean = true;
      
      public var canGetShot:Boolean = true;
      
      private var hasSpawner:Boolean;
      
      private var hasOnKilled:Boolean;
      
      public var explode:Boolean;
      
      public var smokeFrameOffset:int = -1;
      
      public var healthBarSmoke:StarlingSmoke;
      
      public var healthBarOutlineSmoke:StarlingSmoke;
      
      public function Baddies(wide:uint = 0, tall:uint = 0, rail:int = -20)
      {
         super(rail);
         isWide = wide;
         isTall = tall;
         mass = wide * tall / 20;
         originalSpringTall = springTall = tall * 2;
         BaddieArray.push(this);
         if(this.spawner != null)
         {
            this.hasOnKilled = this.hasSpawner = true;
         }
         if(this.onKilled != null && this.onKilled != "nothing")
         {
            this.hasOnKilled = true;
         }
      }
      
      public static function BaddieEnterFrames() : void
      {
         CharX = Char.CharArray[0].x;
         CharY = Char.CharArray[0].y;
         CharRail = Char.CharArray[0].onRail;
         var i:uint = 0;
         var l:uint = BaddieArray.length;
         while(i < l)
         {
            BaddieArray[i].doEnterFrames();
            i++;
         }
      }
      
      public static function BaddiesCheckMoving() : void
      {
         var i:int = 0;
         var l:uint = BaddieArray.length;
         while(i < l)
         {
            if(BaddieArray[i].BallRes > 0)
            {
               BaddieArray[i].CheckMovingStuff();
            }
            i++;
         }
      }
      
      public static function checkGonnaStomps(ex:*, ey:*, eWide:*, rail:*, hit:*, e:*) : Boolean
      {
         var i:int = 0;
         var l:uint = activeBaddieArray.length;
         while(i < l)
         {
            if(activeBaddieArray[i].onRail == rail && !activeBaddieArray[i].inky && activeBaddieArray[i].Status != "deadJump" && !activeBaddieArray[i].isABall)
            {
               if(Math.abs(ex - activeBaddieArray[i].x) < activeBaddieArray[i].isWide + eWide + 30 && Math.abs(ey - activeBaddieArray[i].y) < activeBaddieArray[i].isTall)
               {
                  e.tempY = activeBaddieArray[i].y + activeBaddieArray[i].isTall;
                  if(hit < 10)
                  {
                     activeBaddieArray[i].gonnaStomp(e);
                  }
                  return true;
               }
            }
            i++;
         }
         return false;
      }
      
      public static function EveryCollisions() : void
      {
         var i:uint = 0;
         var l:uint = activeBaddieArray.length;
         while(i < l)
         {
            activeBaddieArray[i].EveryCollision();
            i++;
         }
         if(killBaddies.length > 0)
         {
            for(i = 0; i < killBaddies.length; i++)
            {
               removeBaddie(killBaddies[i]);
            }
            killBaddies = new Vector.<Baddies>(0);
         }
      }
      
      public static function BaddiesRootStuff() : void
      {
         var i:uint = 0;
         var l:uint = activeBaddieArray.length;
         while(i < l)
         {
            activeBaddieArray[i].baddieRootStuff();
            i++;
         }
      }
      
      private static function removeBaddie(e:*) : void
      {
         var n:int = 0;
         e.cleanUp();
         e.clearHealthBar();
         if(BaddieArray.indexOf(e) > -1)
         {
            BaddieArray.splice(BaddieArray.indexOf(e),1);
         }
         if(activeBaddieArray.indexOf(e) > -1)
         {
            activeBaddieArray.splice(activeBaddieArray.indexOf(e),1);
         }
         if(AggressorArray.indexOf(e) > -1)
         {
            AggressorArray.splice(AggressorArray.indexOf(e),1);
         }
         e.removeFromFollow();
         if(e.onRail >= Main.backgroundsN)
         {
            for(n = 0; n < Main.AllBoxObjects.length; n++)
            {
               if(e.originX == Main.AllBoxObjects[n][1] && e.originY == Main.AllBoxObjects[n][2])
               {
                  Main.AllBoxObjects.splice(n,1);
                  break;
               }
            }
         }
         if(e.parent != null)
         {
            e.parent.removeChild(e);
         }
         if(e.hasOnKilled)
         {
            if(e.hasSpawner)
            {
               e.spawner.onKilled();
               e.spawner = null;
            }
            else if(e.onKilled == "removeGate0")
            {
               Main.saveProgress("defeatBigBad1",true);
               staticInteractObjects.findByName("Mayor").mayorArrive();
            }
         }
      }
      
      internal static function spawnSnailShell(ex:*, ey:*, rot:*) : void
      {
         var baddie:SnailShell = new SnailShell();
         baddie.x = ex;
         baddie.y = ey;
         baddie.rotation = rot;
         baddie.ItIs = "SnailShell";
      }
      
      internal static function findClosestCast(ex:*, ey:*, angle:*, rail:*) : Number
      {
         var distX:int = 0;
         var distY:int = 0;
         var angleDist:Number = NaN;
         var returnAngle:Number = angle;
         var dist:uint = 600;
         var i:uint = 0;
         var l:uint = activeBaddieArray.length;
         while(i < l)
         {
            if(rail == activeBaddieArray[i].onRail && activeBaddieArray[i].health > 0)
            {
               distX = activeBaddieArray[i].x - ex;
               distY = activeBaddieArray[i].y - ey;
               if(Math.abs(distX) < dist)
               {
                  angleDist = Math.abs(-Math.atan2(distX,distY) - angle);
                  if(angleDist < 0.3)
                  {
                     dist = Math.abs(distX);
                     returnAngle = -Math.atan2(distX,distY);
                  }
               }
            }
            i++;
         }
         return returnAngle;
      }
      
      internal static function clearAllBaddies() : void
      {
         var baddieArrayLength:int = int(BaddieArray.length);
         for(var i:int = 0; i < baddieArrayLength; i++)
         {
            BaddieArray[0].cleanUp();
            BaddieArray[0].clearHealthBar();
            if(BaddieArray[0].parent != null)
            {
               BaddieArray[0].parent.removeChild(BaddieArray[0]);
            }
            BaddieArray.shift();
         }
         AggressorArray = new Vector.<Baddies>(0);
         activeBaddieArray = new Vector.<Baddies>(0);
      }
      
      internal static function clearAllBaddiesOnRail(rail:*) : void
      {
         for(var i:* = 0; i < BaddieArray.length; i++)
         {
            if(BaddieArray[i].onRail == rail)
            {
               BaddieArray[i].cleanUp();
               BaddieArray[i].clearHealthBar();
               if(BaddieArray[i].parent != null)
               {
                  BaddieArray[i].parent.removeChild(BaddieArray[i]);
               }
               if(activeBaddieArray.indexOf(BaddieArray[i]) > -1)
               {
                  activeBaddieArray.splice(activeBaddieArray.indexOf(BaddieArray[i]),1);
               }
               if(AggressorArray.indexOf(BaddieArray[i]) > -1)
               {
                  AggressorArray.splice(AggressorArray.indexOf(BaddieArray[i]),1);
               }
               BaddieArray.splice(i,1);
               i--;
            }
         }
      }
      
      internal static function killAllSpiders() : void
      {
         var baddieArrayLength:int = int(BaddieArray.length);
         for(var i:int = 0; i < baddieArrayLength; i++)
         {
            if(BaddieArray[i].ItIs == "Spider")
            {
               BaddieArray[i].ChangeFrame("deadJump");
               BaddieArray[i].moveUD = -12;
            }
         }
      }
      
      internal static function findByItIs(itis:*) : Baddies
      {
         var i:int = 0;
         var l:* = BaddieArray.length;
         while(i < l)
         {
            if(BaddieArray[i].ItIs == itis)
            {
               return BaddieArray[i];
            }
            i++;
         }
      }
      
      public function resetBad() : void
      {
      }
      
      private function doEnterFrames() : void
      {
         if(hitPause > 0)
         {
            --hitPause;
            if(hitPause == 0 && this.explode)
            {
               Sounds.playSound("InkExplode",x,scale * 1.5,onRail);
               StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,(scale - 0.5) * 0.4 + 0.6,moveRL,moveUD,onRail);
               Main.shakeScreen(10,0,true);
               if(this.resetOnFall)
               {
                  this.resetBad();
               }
               else if(ItIs == "InkFloat")
               {
                  this.ChangeFrame("return");
               }
               else
               {
                  killBaddies.push(this);
               }
            }
         }
         if(hitPause == 0)
         {
            if(downTime > 0)
            {
               --downTime;
            }
            this.CharDistX = CharX - x;
            springBounce();
            this.BaddieEnterFrame();
         }
      }
      
      override public function checkAfterMove() : Boolean
      {
         InteractObjects.baddieCheckObjects(x,y,isWide + Math.abs(moveRL),isTall + Math.abs(moveUD),onRail,this);
         StarlingInteract.baddieCheckObjects(x,y,isWide + Math.abs(moveRL),isTall + Math.abs(moveUD),onRail,this);
         staticInteractObjects.baddieCheckObjects(x,y,isWide + Math.abs(moveRL),isTall + Math.abs(moveUD),onRail,this);
         StarlingDecals.baddieCheckObjects(x,y,isWide + Math.abs(moveRL),isTall + Math.abs(moveUD),onRail,this);
      }
      
      private function EveryCollision() : void
      {
         if(downTime == 0)
         {
            this.CheckBadOnBad();
         }
         if(Status != "Wait")
         {
            if(Status == "Fly")
            {
               if(hitPause == 0)
               {
                  x += moveRL * framin;
                  y += moveUD * framin;
                  rotation += rotter * framin;
                  this.checkAfterMove();
               }
            }
            else if(BallRes == 0 || health == 0)
            {
               if(hitPause == 0)
               {
                  x += moveRL * framin;
                  y += moveUD * framin;
                  if(Status == "Roll")
                  {
                     rotation += rotter * framin;
                  }
                  this.checkAfterMove();
               }
               if(Status == "Hit")
               {
                  rotation += rotter * 0.5 * framin;
               }
               else if(Status == "deadJump")
               {
                  rotation += rotter * framin;
               }
            }
            else if(hitPause > 0)
            {
               CheckAllPaused();
               if(Status == "Hit")
               {
                  rotation += rotter * 0.5 * framin;
               }
            }
            else if(Status == "Move" || Status == "Bullet")
            {
               x += moveRL * framin;
               y += moveUD * framin;
               rotation += rotter * framin;
            }
            else if(Status == "Stomped")
            {
               CheckAllGrounds();
            }
            else if(Status == "Roll")
            {
               CheckAllAir();
               if(!onGround)
               {
                  wallRot = wallAngle = 0;
                  if(almostPlat || almostGround)
                  {
                     rotter = rotPerc * fakeRL;
                  }
                  else
                  {
                     rotter += (moveRL * 3 - rotter) / 20 * framin;
                  }
               }
               if(y > MaxY + 400)
               {
                  resetCombo();
                  if(this.resetOnFall)
                  {
                     this.resetBad();
                  }
                  else
                  {
                     killBaddies.push(this);
                  }
               }
            }
            else if(Status == "Jump" || Status == "stunJump" || Status == "Hit" || Status == "Drop")
            {
               CheckAllAir();
               if(Status != "Hit")
               {
                  if(onGround)
                  {
                     if(fakeUD == 0 && Math.abs(wallRot) < 90)
                     {
                        rotation = wallRot;
                        this.JumpLand();
                     }
                     else
                     {
                        wallRot = wallAngle = 0;
                     }
                  }
                  else
                  {
                     wallRot = wallAngle = 0;
                     if(landSpeed * bounce > bounceThresh)
                     {
                        rotter = landSpeed * makeOne(moveRL);
                        spring = landSpeed * 0.5;
                        landSpeed = 0;
                        Sounds.playSound("Impact",x,landSpeed * 0.03,onRail);
                        this.baddie.gotoAndStop(1);
                     }
                  }
               }
               if(y > MaxY + 400)
               {
                  resetCombo();
                  killBaddies.push(this);
               }
            }
            else
            {
               CheckAllGrounds();
               if(Status != "Hit")
               {
                  if(onGround)
                  {
                     if(Status != "Attack")
                     {
                        if(onWall * scaleX > 0)
                        {
                           this.changeDirection(-onWall);
                           moveSpringBounce();
                           fakeRL = 0;
                        }
                        if(onWallPlat * scaleX > 0)
                        {
                           this.changeDirection(-onWallPlat);
                           moveSpringBounce();
                           fakeRL = 0;
                        }
                        if(!inky)
                        {
                           if(onLedge * scaleX > 0 && fakeRL * scaleX > 1)
                           {
                              this.changeDirection(-onLedge);
                              moveSpringBounce();
                              fakeRL = 0;
                           }
                        }
                     }
                     if(Math.abs(wallRot) > 120)
                     {
                        rotter = fakeRL * rotPerc * 0.5;
                        this.ChangeFrame("Jump");
                     }
                  }
                  else if(stunN == 0)
                  {
                     rotter = fakeRL * rotPerc * 0.5;
                     this.ChangeFrame("Jump");
                  }
                  else
                  {
                     this.ChangeFrame("stunJump");
                  }
               }
               rotation += rotCompare(wallRot,rotation) * (1 - Math.pow(1 - 1 / 3,framin));
            }
         }
         moveSpringBounce();
         if(showHealthBar)
         {
            this.healthBarSmoke.x = x - 24;
            this.healthBarSmoke.y = y - isTall * 1.8 - 10;
            this.healthBarOutlineSmoke.x = x;
            this.healthBarOutlineSmoke.y = y - isTall * 1.8 - 10;
         }
         if(hitPause == 0)
         {
            if(ItIs == "Mouse" && Status == "Roll" && stunN > 0)
            {
               this.stars.rotation = -rotation * makeOne(scaleX);
               angle = this.stars.rotation * (Math.PI / 180);
               this.stars.x = Math.sin(angle) * 35;
               this.stars.y = Math.cos(angle) * -35;
            }
         }
         this.placeSmoke();
      }
      
      private function baddieRootStuff() : void
      {
         if(Math.abs(shakeRL) > 1)
         {
            this.baddie.x = (shakeRL * 0.5 - Math.random() * shakeRL) / scale;
            this.baddie.y = (shakeRL * 0.5 - Math.random() * shakeRL) / scale;
         }
         if(hitPause > 0)
         {
            if(currentSound != null)
            {
               Sounds.updateSound(currentSound,x,0,onRail);
            }
            shakeRL *= -0.8;
         }
         else
         {
            shakeRL *= -0.6;
         }
         if(RedHurt > 0)
         {
            if(RedHurt == 3)
            {
               transform.colorTransform = Main.getTint(1,-0.6,-0.6);
            }
            else if(RedHurt == 1)
            {
               transform.colorTransform = Main.getTint(0,0,0);
               if(this.hasSmoke)
               {
                  this.currentSmoke.returnToMesh(onRail,false);
                  visible = false;
                  if(parent != null)
                  {
                     parent.removeChild(this);
                  }
               }
            }
            --RedHurt;
         }
      }
      
      private function CheckBadOnBad() : void
      {
         var n:uint = 0;
         for(n = 0; n < AggressorArray.length; n++)
         {
            if(AggressorArray[n].downTime == 0 && this.canBall && this != AggressorArray[n])
            {
               if(AggressorArray[n].mass > mass * 2 && Math.abs(AggressorArray[n].moveRL) > 5)
               {
                  if(ballCollision(AggressorArray[n],this))
                  {
                     Sounds.playSound("Hit",x,2,onRail);
                     hitPause = AggressorArray[n].hitPause = 7;
                     downTime = 5;
                     shakeRL = AggressorArray[n].shakeRL = 20;
                     Main.shakeScreen(10,0,true);
                     stunN = stunMax;
                     moveRL = makeOne(AggressorArray[n].moveRL) * 10;
                     moveUD = -20;
                     rotter = makeOne(AggressorArray[n].moveRL) * -10;
                     AggressorArray[n].hurtBaddie(health * 0.2);
                     this.hurtBaddie(100);
                     if(AggressorArray[n].ItIs == "Mouse")
                     {
                        Achievements.unlock("Mouse_Bowling");
                        Achievements.SendScore("Mouse_Bowling",1);
                     }
                     if(AggressorArray[n].health > 0)
                     {
                        if(stunN < stunMax * 0.5)
                        {
                           stunN = stunMax;
                        }
                     }
                     else
                     {
                        AggressorArray[n].moveUD = -(Math.abs(AggressorArray[n].moveRL) + 5);
                        AggressorArray[n].moveRL *= 0.5;
                        AggressorArray[n].ChangeFrame("deadJump");
                     }
                     Main.popBetween(AggressorArray[n],this,1.5);
                     if(Status != "deadJump")
                     {
                        this.ChangeFrame("Hit");
                     }
                  }
               }
               else if(!canAggressor)
               {
                  this.hitByAggressor(AggressorArray[n]);
               }
               else if(downTime == 0)
               {
                  solveBalls(this,AggressorArray[n]);
               }
            }
         }
      }
      
      public function hitByAggressor(bad:*) : void
      {
         if(solveUneven(bad,this))
         {
            bad.hitPause = hitPause = 3;
            bad.shakeRL = shakeRL = 10;
            Main.shakeScreen(10,0,true);
            Sounds.playSound("Hit",x,1,onRail);
            Main.popBetween(bad,this,1);
            stunN = stunMax;
            spring = 10;
            this.hurtBaddie(10);
            if(parent == null)
            {
               Backgrounds.backgroundsArray[onRail].addChild(this);
            }
            if(Status != "deadJump")
            {
               this.ChangeFrame("Hit");
            }
         }
      }
      
      public function chooseCharInteract(frame:*) : void
      {
      }
      
      public function cleanUp() : void
      {
         if(this.hasSmoke)
         {
            this.smokeFrameOffset = -1;
            this.currentSmoke.goSwim();
            this.currentSmoke = null;
            this.hasSmoke = false;
         }
      }
      
      public function changeDirection(e:Number) : void
      {
         if(e * facing < 0)
         {
            facing *= -1;
         }
         if(e * scaleX < 0)
         {
            scaleX *= -1;
         }
      }
      
      private function clearHealthBar() : void
      {
         if(showHealthBar)
         {
            this.healthBarSmoke.goSwim();
            this.healthBarOutlineSmoke.goSwim();
            this.healthBarSmoke = this.healthBarOutlineSmoke = null;
            showHealthBar = false;
         }
      }
      
      public function ChangeFrame(frame:*) : void
      {
         this.BaddieEnterFrame = this[frame + "EnterFrame"];
         gotoAndStop(frame);
         if(frame == "Wait")
         {
            if(activeBaddieArray.indexOf(this) > -1)
            {
               activeBaddieArray.splice(activeBaddieArray.indexOf(this),1);
            }
            if(parent != null)
            {
               parent.removeChild(this);
            }
            this.cleanUp();
         }
         else
         {
            MovieClip(this).baddie.gotoAndStop(1);
            if(activeBaddieArray.indexOf(this) == -1)
            {
               activeBaddieArray.push(this);
               aPlat.resetplatSides(x,y,this);
            }
            if(!this.hasSmoke)
            {
               if(this.smokeName == "nothing")
               {
                  if(parent == null)
                  {
                     Backgrounds.backgroundsArray[onRail].addChild(this);
                  }
               }
               else
               {
                  if(this.currentSmoke == null)
                  {
                     this.currentSmoke = StarlingSmoke.Spawn(this.smokeName,x,y,0,1,0,0,onRail);
                  }
                  this.hasSmoke = true;
               }
            }
            this.smokeSetFrame();
            this.placeSmoke();
         }
         this.chooseCharInteract(frame);
         Status = frame;
      }
      
      public function smokeSetFrame() : void
      {
         if(this.smokeFrameOffset > -1)
         {
            this.currentSmoke.currentFrame = this.smokeFrameOffset + this.baddie.currentFrame;
         }
      }
      
      public function groundStatus(frame:*) : Boolean
      {
         return !(frame == "Jump" || frame == "stunJump" || frame == "deadJump");
      }
      
      public function slopeStuff() : void
      {
         RotToAccel(wallRot);
         if(Math.abs(rotAccel) > 2)
         {
            rotAccel = rotAccel / Math.abs(rotAccel) * 2;
         }
         if(Math.abs(fakeRL + rotAccel) < 40)
         {
            fakeRL += rotAccel;
         }
         else
         {
            fakeRL *= 40 / Math.abs(fakeRL);
         }
      }
      
      public function JumpLand() : void
      {
         downTime = 0;
         if(inky)
         {
            rotation = wallRot;
            rotter = 0;
            this.ChangeFrame("Land");
         }
         else if(stunN > 0)
         {
            if(ItIs == "Mouse")
            {
               this.ChangeFrame("Roll");
            }
            else
            {
               rotter = 0;
               this.ChangeFrame("Stunned");
            }
         }
         else
         {
            rotter = 0;
            this.ChangeFrame("Land");
         }
      }
      
      public function hurtBaddie(hurt:Number, hrx:Number = 0, hry:Number = 0) : Boolean
      {
         if(health > 0)
         {
            if(this.hatN > 0)
            {
               if(hrx == 0)
               {
                  hrx = moveRL * 0.5;
               }
               if(hry == 0)
               {
                  hry = moveUD * 0.5;
               }
               new looseHat(x,y - isTall,hrx,hry,onRail,this.hatN);
               this.loseHat();
            }
            if(health - hurt > 0)
            {
               health -= hurt;
               if(healthMax > 0)
               {
                  if(!showHealthBar)
                  {
                     this.healthBarSmoke = StarlingSmoke.Spawn("healthBar",x - 24,y - 30,0,1,0,0,onRail);
                     this.healthBarOutlineSmoke = StarlingSmoke.Spawn("healthBar",x,y - 30,0,1,0,0,onRail);
                     this.healthBarOutlineSmoke.currentFrame = 2;
                     showHealthBar = true;
                  }
                  this.healthBarSmoke.scaleX = health / healthMax;
               }
               return false;
            }
            health = 0;
            aPlatOn = null;
            ++Main.baddiesSession;
            if(showHealthBar)
            {
               this.healthBarSmoke.goSwim();
               this.healthBarOutlineSmoke.goSwim();
               this.healthBarSmoke = this.healthBarOutlineSmoke = null;
               showHealthBar = false;
            }
            if(inky)
            {
               Achievements.track("Untouchable",-1,20,true);
            }
            return true;
         }
      }
      
      public function wearHat(n:uint) : Boolean
      {
         return false;
      }
      
      public function loseHat() : void
      {
      }
      
      public function standardHitChar(ex:*, ey:*, eRL:*, eUD:*, ax:*, ay:*, char:*) : String
      {
         angle = rotation * (Math.PI / 180);
         aRL = Math.cos(angle) * eRL + Math.sin(angle) * eUD;
         aUD = Math.cos(angle) * eUD - Math.sin(angle) * eRL;
         if(Math.abs(ax) > isWide + char.isWide || Math.abs(ay) > isTall + char.isTall)
         {
            return "nothing";
         }
         if(char.Status == "Zip" || char.Status == "ZipAir")
         {
            char.hitPause = 3;
            char.justAttackHit = char.justAttackQuick = true;
            if(char.JumpIsDown())
            {
               StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,(scale - 0.5) * 0.4 + 0.6,eRL * 0.2,0,onRail);
               char.jumpFromZip(true);
            }
            hitPause = 4;
            shakeRL = 20;
            downTime = 5;
            moveRL = eRL * 0.5;
            if(char.SpecialIsDown())
            {
               char.char.gotoAndStop(4);
               char.smokeB = 2 + isWide * 2 / 60;
            }
            moveUD = -20;
            spring = 0;
            StarlingEffect.Spawn("impactEffect",x,y,1.57 * char.scaleX,1,0,0,onRail);
            hurtPower = 20;
            return "Hit";
         }
         if(char.Status == "Kick" && char.char.currentFrame < 16)
         {
            angle = 30 * makeOne(eRL * 0.5) * Math.PI / 180;
            tempRL = 0;
            tempUD = -(20 + Math.abs(eRL));
            moveRL = Math.cos(angle) * tempRL - Math.sin(angle) * tempUD;
            moveUD = Math.cos(angle) * tempUD + Math.sin(angle) * tempRL;
            shakeRL = -tempUD;
            Main.shakeScreen(-tempUD / 2,0,true);
            rotter = moveRL * rotPerc;
            char.moveUD = -10;
            char.FloatUp = 2;
            char.char.gotoAndStop(1);
            char.placeHead(char.char);
            downTime = 5;
            hitPause = char.hitPause = 2;
            hurtPower = 20;
            return "Hit";
         }
         if(char.Status == "Roll" || char.Status == "DownSlide")
         {
            if(char.Status == "Roll")
            {
               Sounds.playSound("PinCrash",char.x,1,onRail);
            }
            Achievements.track("Super_Slider",120,4,true);
            if(CheckHead())
            {
               fakeRL = eRL * 1.3;
               moveRL = Math.cos(angle) * fakeRL;
               moveUD = Math.sin(angle) * fakeRL;
               hurtPower = 5;
               downTime = 20;
               shakeRL = eRL;
               Main.shakeScreen(-tempUD / 5,0,true);
            }
            else
            {
               angle = (char.wallRot + 35 * makeOne(eRL)) * Math.PI / 180;
               tempRL = 0;
               tempUD = -(5 + Math.abs(eRL * 1.5));
               Main.shakeScreen(-tempUD / 5,0,true);
               shakeRL = -tempUD;
               moveRL = Math.cos(angle) * tempRL - Math.sin(angle) * tempUD;
               moveUD = Math.cos(angle) * tempUD + Math.sin(angle) * tempRL;
               if(Math.abs(char.fakeRL) < 15)
               {
                  char.Jumper = 10;
                  char.fakeRL = -makeOne(char.scaleX) * 4;
                  char.FloatUp = 4;
                  char.gotoBuffer = "Jump";
               }
               if(stunN < 0)
               {
                  hurtPower = 60;
               }
               else
               {
                  hurtPower = 5;
               }
               rotter = Math.abs(moveUD) * rotPerc * -makeOne(moveRL);
               downTime = 5;
            }
            return "Hit";
         }
         if(char.StompedOn != null)
         {
            if(Status != "Stomped")
            {
               return;
            }
            return "nothing";
         }
         if(char.Status == "Skateboard")
         {
            angle = char.wallRot * Math.PI / 180;
            tempRL = 0;
            tempUD = -(5 + Math.abs(eRL * 1.5));
            Main.shakeScreen(-tempUD / 10,0,true);
            shakeRL = -tempUD;
            moveRL = Math.cos(angle) * tempRL - Math.sin(angle) * tempUD;
            moveUD = Math.cos(angle) * tempUD + Math.sin(angle) * tempRL;
            hurtPower = 60;
            rotter = Math.abs(moveUD) * rotPerc * -makeOne(moveRL);
            downTime = 5;
            hitPause = char.hitPause = 4;
            return "Hit";
         }
         if(ay + aUD * 2 + Math.abs(moveUD) + 5 > isTall + char.isTall && aUD > -2 && char.Status != "Hurt" && char.gotoBuffer != "Hurt" && char.Status != "Hang")
         {
            wallX = x;
            char.wallY = wallY = y + isTall;
            char.rotation = (char.rotation + rotation) * 0.5;
            char.rotter = (rotation - char.rotation) / 3;
            this.lastStomped = char;
            Sounds.playSound("BadStomp",x,3,onRail);
            if(this.hatN > 0)
            {
               spring = -3;
               springTall -= 5;
               char.downTime = 5;
               downTime = 10;
               char.FloatLock = false;
               if(char.JumpIsDown())
               {
                  char.Jumper = this.thrust * 1.3;
                  char.FloatUp = 0;
               }
               else
               {
                  char.Jumper = this.thrust;
                  char.FloatUp = 6;
               }
               char.resetPencil();
               char.wallRot = wallRot;
               char.wallAngle = wallAngle;
               char.fakeRL = char.moveRL;
               char.gotoBuffer = "Jump";
            }
            else
            {
               spring = -10;
               fakeRL = moveRL = fakeUD = moveUD = rotter = 0;
               rotter = 0;
               char.StompedOn = this;
               char.gotoBuffer = "Stomp";
               Achievements.track("Floor_Is_Lava",150,5,true);
               this.ChangeFrame("Stomped");
            }
            return "Stomped";
         }
         if(char.downTime == 0 && char.alpha == 1)
         {
            if(Math.abs(ax) < (isWide + char.isWide) * 0.75)
            {
               if(char.hurtChar(20,20,5,makeOne(ex - x) * 8,20,true))
               {
                  spring = 10 * scale;
                  springy = 10;
                  springDecay = 0.8;
               }
            }
            return "Attack";
         }
         return "nothing";
      }
      
      public function inkyHitChar(ex:*, ey:*, eRL:*, eUD:*, ax:*, ay:*, char:*) : String
      {
         angle = rotation * (Math.PI / 180);
         aRL = Math.cos(angle) * eRL + Math.sin(angle) * eUD;
         aUD = Math.cos(angle) * eUD - Math.sin(angle) * eRL;
         if(Math.abs(ax) > isWide + char.isWide || Math.abs(ay) > isTall + char.isTall)
         {
            return "nothing";
         }
         if(char.Status == "Zip" || char.Status == "ZipAir")
         {
            char.justAttackHit = char.justAttackQuick = true;
            if(char.JumpIsDown())
            {
               char.jumpFromZip(true);
            }
            StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,(scale - 0.5) * 0.4 + 0.8,eRL * 0.5,0,onRail);
            Main.shakeScreen(10,Math.random() * 6.28,true);
            hitPause = 3;
            shakeRL = 20;
            downTime = 10;
            moveRL = eRL * 0.5;
            if(ItIs == "Boss2")
            {
               rotter = -eRL;
            }
            else
            {
               rotter = -eRL * 10;
            }
            if(char.SpecialIsDown())
            {
               char.char.gotoAndStop(4);
               if(char.smokeB < 3 + isWide * 2 / 60)
               {
                  char.smokeB = 3 + isWide * 2 / 60;
               }
               if(Math.abs(char.attackRL) < 15)
               {
                  char.attackRL = 15 * makeOne(char.attackRL);
               }
            }
            moveUD = -20;
            spring = 0;
            StarlingEffect.Spawn("impactEffect",x,y,1.57 * char.scaleX,1,0,0,onRail);
            hurtPower = 20;
            return "Hit";
         }
         if(Status == "Roll")
         {
            if(char.hurtChar(30 * power,20,5,makeOne(ex - x) * 6,15 + Math.abs(moveRL),true))
            {
               spring = 5 * scale;
               Achievements.clearTracked("Untouchable");
            }
            return "Attack";
         }
         if(char.hurtChar(30 * power,20,5,makeOne(ex - x) * 12,16,true))
         {
            spring = 5 * scale;
            Achievements.clearTracked("Untouchable");
         }
      }
      
      public function smokeTrail() : *
      {
         var rand:Number = NaN;
         if(smokeB > 0)
         {
            if(smokeN > 0)
            {
               --smokeB;
               --smokeN;
            }
            else
            {
               rand = Math.random() * 0.5 + 0.5;
               StarlingEffect.Spawn("smokePuff",footX(),footY(),Math.random() * 6,-scaleX * rand,UDx(-2 * rand),UDy(-2 * rand),onRail);
               smokeN = 2;
            }
         }
      }
      
      public function standardGetAttacked(ex:Number, ey:Number, angle:Number, char:collision, hitMove:String, hitPower:Number, pow:Number = 1) : Boolean
      {
         if(char.justAttackHit)
         {
            if(char.hitPause > hitPower * 0.06 + 1)
            {
               hitPause = char.hitPause;
            }
            else
            {
               char.hitPause = hitPower * 0.06 + 1;
               hitPause = char.hitPause;
            }
         }
         else
         {
            char.hitPause = hitPower * 0.1 + 1;
            hitPause = char.hitPause;
         }
         this.lastStomped = char;
         facing = makeOne(char.x - x);
         moveSpringBounce();
         this.hurtBaddie(hitPower * pow,-(12 + hitPower * 0.5) * facing,-(4 + hitPower * 0.5));
         getAttackedShared(ex,ey,angle,char,hitMove,hitPower);
         ++combo;
         smokeN = 0;
         smokeB = 20;
         if(combo >= 20)
         {
            Achievements.unlock("combo20");
         }
         if(inky)
         {
            Sounds.playSound("InkHurt",x,1,onRail);
         }
         else
         {
            Sounds.playSound("Hit",x,1,onRail);
         }
         if(hitPower > 20)
         {
            if(char.Status == "Pencil" || this.grounded)
            {
               char.fakeRL = char.moveRL = scaleX * 4;
            }
            else
            {
               char.moveRL = char.scaleX * 2;
            }
         }
         if(Status == "Fly" && health > 0)
         {
            rotter *= 0.1;
         }
         else if(Status == "deadJump")
         {
            MovieClip(this).baddie.gotoAndStop(1);
            this.smokeSetFrame();
         }
         else if((onGround || scale >= 4) && hitPower < launchThresh && health > 0)
         {
            moveUD = 0;
         }
         else if(!(Status == "Roll" && health > 0))
         {
            if(aPlatOn != null)
            {
               aPlat.aPlatOnClear(this);
            }
            if(aWallOn != null)
            {
               aWall.aWallOnClear(this);
            }
            this.ChangeFrame("Hit");
         }
         if(Status != "Hit" || !inky)
         {
            if(this.hasSmoke)
            {
               this.currentSmoke.hideFromMesh();
               visible = true;
               if(parent == null)
               {
                  Backgrounds.backgroundsArray[onRail].addChild(this);
               }
            }
            if(scale > 2)
            {
               transform.colorTransform = Main.getTint(1,-0.6,-0.6);
            }
            else
            {
               transform.colorTransform = Main.getTint(1,1,1);
            }
            RedHurt = 5;
         }
         return true;
      }
      
      public function standardBeAFireball(ex:*, ey:*, eRL:*, eUD:*, ax:*, ay:*, char:*) : void
      {
         var distX:int = Math.abs(ex - x);
         var distY:int = Math.abs(ey - y);
         if(distX < isWide + char.isWide && distY < isTall + char.isTall)
         {
            if(!char.hurtChar(20,20,5,makeOne(moveRL) * 10,20,true))
            {
            }
            if(this.solid)
            {
               if(distX > distY * 0.6)
               {
                  char.x = x + (char.isWide + isWide) * makeOne(ex - x);
                  if(char.moveRL * makeOne(ex - x) < 0)
                  {
                     char.moveRL = char.fakeRL = 0;
                  }
               }
               else
               {
                  char.y = y + (char.isTall + isTall) * makeOne(ey - y);
                  if(char.moveUD * makeOne(ey - y) < 0)
                  {
                     char.moveUD = 0;
                  }
               }
            }
         }
      }
      
      public function simpleJump(jumper:*) : void
      {
         angle = rotation * (Math.PI / 180);
         moveRL = Math.cos(angle) * fakeRL - Math.sin(angle) * -jumper;
         moveUD = Math.cos(angle) * -jumper + Math.sin(angle) * fakeRL;
         this.ChangeFrame("Jump");
      }
      
      public function StompedEnterFrame() : void
      {
         if(spring > 0 && springTall + spring > originalSpringTall)
         {
            stunN = stunMax;
            moveRL = fakeRL = -makeOne(facing) * 5;
            rotter = fakeRL * 10;
            moveUD = -12;
            scaleX = facing;
            downTime = 30;
            if(health > 0)
            {
               this.ChangeFrame("stunJump");
            }
            else
            {
               this.ChangeFrame("deadJump");
            }
         }
      }
      
      public function HitEnterFrame() : void
      {
         if(Math.abs(moveUD) >= 0.5)
         {
            if(health > 0)
            {
               this.stunJumpEnterFrame();
            }
            else
            {
               this.deadJumpEnterFrame();
            }
         }
         if(hitPause == 0)
         {
            if(health == 0)
            {
               this.ChangeFrame("deadJump");
            }
            else if(inky)
            {
               if(Math.abs(moveUD) < 0.5)
               {
                  this.ChangeFrame("Idle");
               }
               else
               {
                  this.ChangeFrame("stunJump");
               }
            }
            else if(Math.abs(moveUD) < 2 || CheckHead())
            {
               canAggressor = false;
               this.ChangeFrame("Stunned");
            }
            else
            {
               this.ChangeFrame("stunJump");
            }
         }
      }
      
      public function stunJumpEnterFrame() : void
      {
         MovieClip(this).baddie.nextFrame();
         this.smokeSetFrame();
         if(Math.abs(rotter) > 40)
         {
            rotter *= 0.95;
         }
         if(moveUD < 20)
         {
            moveUD += 1.5;
         }
         if(Math.abs(moveRL) > 4)
         {
            moveRL *= 0.96;
         }
         if(Math.abs(moveUD) > 20)
         {
            moveUD *= 0.9;
         }
         this.smokeTrail();
         if(MovieClip(this).baddie.currentFrame == MovieClip(this).baddie.totalFrames)
         {
            MovieClip(this).baddie.gotoAndStop("loop");
         }
         if(y > Main.cameraY + Main.stageYs[onRail] + 50 || x < Main.MinX / Main.stageRatios[onRail] || x > Main.MaxX / Main.stageRatios[onRail])
         {
            resetCombo();
            killBaddies.push(this);
         }
      }
      
      public function deadJumpEnterFrame() : void
      {
         MovieClip(this).baddie.nextFrame();
         if(Math.abs(rotter) > 15)
         {
            rotter *= 0.95;
         }
         if(FloatUp > 0)
         {
            --FloatUp;
         }
         else
         {
            if(moveUD < 20)
            {
               moveUD += 1;
            }
            if(Math.abs(moveRL) > 4)
            {
               moveRL *= 0.98;
            }
            if(Math.abs(moveUD) > 20)
            {
               moveUD *= 0.9;
            }
         }
         this.smokeTrail();
         if(MovieClip(this).baddie.currentFrame == MovieClip(this).baddie.totalFrames)
         {
            MovieClip(this).baddie.gotoAndStop("loop");
         }
         this.smokeSetFrame();
         if(y > Main.cameraY + Main.stageYs[onRail] + 50 || x < Main.MinX / Main.stageRatios[onRail] || x > Main.MaxX / Main.stageRatios[onRail])
         {
            resetCombo();
            killBaddies.push(this);
         }
      }
      
      public function baddieHitChar(char:*) : String
      {
         var temp:String = this.currentHitChar(char.x,char.y,char.moveRL,char.moveUD,char.ax,char.ay,char);
         if(temp == "Hit")
         {
            if(inky)
            {
               Sounds.playSound("InkSpit",x,1.3,onRail);
            }
            else
            {
               Sounds.playSound("BadStomp",x,getSpeed(moveRL,moveUD) * 0.1,onRail);
            }
            ++combo;
            stunN = stunMax;
            smokeN = 0;
            smokeB = 20;
            if(combo >= 20)
            {
               Achievements.unlock("combo20");
            }
            Main.popBetween(char,this);
            this.lastStomped = char;
            this.hurtBaddie(hurtPower);
            if(platRL != 0)
            {
               x += platRL;
               moveRL += platRL;
               platRL = 0;
            }
            if(platUD != 0)
            {
               moveUD += platUD;
               platUD = 0;
            }
            if(wallRL != 0)
            {
               x += wallRL;
               moveRL += wallRL;
               wallRL = 0;
            }
            if(wallUD != 0)
            {
               moveUD += wallUD;
               wallUD = 0;
            }
            if(aPlatOn != null)
            {
               aPlat.aPlatOnClear(this);
            }
            if(aWallOn != null)
            {
               aWall.aWallOnClear(this);
            }
            if((Status != "Roll" && Status != "Fly" || health == 0) && Status != "deadJump")
            {
               rotation = 0;
               this.ChangeFrame("Hit");
            }
            springTall += spring;
            scaleY = springTall / originalSpringTall * scale;
            scaleX = (scale - scaleY + scale) * makeOne(scaleX);
         }
         else if(temp != "nothing")
         {
            moveSpringBounce();
         }
         return temp;
      }
      
      override public function addToFollow(b:uint, ex:Number = -10000, ey:Number = -10000) : void
      {
         if(Main.tempFollow.indexOf(this) == -1)
         {
            Main.tempFollow.push(this);
            Main.tempFollowB.push(b);
            if(Math.abs(ex - x) < 100 && Math.abs(ey - y) < 100)
            {
               Main.tempFollowR.push(1);
            }
            else
            {
               Main.tempFollowR.push(0);
            }
         }
         else
         {
            Main.tempFollowB[Main.tempFollow.indexOf(this)] = b;
         }
      }
      
      public function removeFromFollow() : void
      {
         if(Main.tempFollow.indexOf(this) > -1)
         {
            Main.tempFollowB.splice(Main.tempFollow.indexOf(this),1);
            Main.tempFollow.splice(Main.tempFollow.indexOf(this),1);
         }
      }
      
      public function Projectile(ex:*, ey:*, eRL:*) : Boolean
      {
         if(Math.abs(x - (ex - eRL * framin)) < isWide + 15)
         {
            return false;
         }
         if(scale > 1)
         {
            eRL = 30 / mass * (60 * eRL / Math.abs(eRL));
         }
         hitPause = 3;
         this.hurtBaddie(10);
         shakeRL = 15;
         moveRL += (eRL * 0.4 - moveRL) * 0.8;
         fakeRL = moveRL;
         rotter = moveRL * 5;
         moveUD = -5;
         if(scale > 1)
         {
            spring = 2 * (20 / mass);
         }
         else
         {
            spring += 2 * scale;
         }
         if(onGround)
         {
            facing = makeOne(-eRL);
         }
         else
         {
            facing = makeOne(-eRL);
            if(facing * rotation < 0)
            {
               rotation *= -1;
            }
         }
         smokeN = 0;
         smokeB = 20;
         Sounds.playSound("InkBurst",x,0.8,onRail);
         Sounds.playSound("InkSpit",x,0.8,onRail);
         if(false && health == 0 && inky)
         {
            cachedEffects.spawnCachedEffect("Splat",x,y,rotation * (Math.PI / 180),(scale - 0.5) * 0.4 + 0.6,eRL * 0.2,0,onRail,parent);
            killBaddies.push(this);
         }
         else if(Status == "deadJump")
         {
            this.baddie.gotoAndStop(1);
            this.smokeSetFrame();
         }
         else if(!((Status == "Roll" || Status == "Fly") && health > 0))
         {
            if(inky)
            {
               if(health == 0)
               {
                  Achievements.track("Inkinator",300,10);
                  this.explode = true;
                  hitPause = 3;
                  spring = 0;
               }
               else if(onGround)
               {
                  moveUD = 0;
                  rotter = 0;
               }
               else
               {
                  spring = 0;
                  this.ChangeFrame("Hit");
               }
            }
            else
            {
               if(health > 0)
               {
                  moveRL = eRL * 0.1;
                  moveUD = -15;
                  rotter = eRL * 0.2;
                  stunN = stunMax;
               }
               else
               {
                  moveRL = eRL * 0.3;
                  moveUD = -15;
                  rotter = eRL * 1.2;
                  shakeRL += 20;
                  hitPause += 4;
               }
               hitPause = 4;
               this.ChangeFrame("Hit");
            }
         }
         if(Status != "Hit")
         {
            RedHurt = 2;
            transform.colorTransform = Main.getTint(1,-0.6,-0.6);
            if(this.hasSmoke)
            {
               this.currentSmoke.hideFromMesh();
               visible = true;
               if(parent == null)
               {
                  Backgrounds.backgroundsArray[onRail].addChild(this);
               }
            }
            this.baddie.x = (shakeRL * 0.5 - Math.random() * shakeRL) / scale;
            this.baddie.y = (shakeRL * 0.5 - Math.random() * shakeRL) / scale;
         }
         return true;
      }
      
      public function setFacing(n:*) : void
      {
         if(this.ledgeTimer < 5 && n * facing < 0)
         {
            trace("facing jump! " + Status + " " + facing);
            if(onWall != 0 || onLedge != 0)
            {
               originX = x + (x - originX) * 0.5;
            }
            this.simpleJump(16);
         }
         else
         {
            this.ledgeTimer = 0;
         }
         facing = n;
         if(scaleX * n < 0)
         {
            scaleX *= -1;
         }
         fakeRL = 0;
      }
      
      public function placeSmoke() : void
      {
         if(this.hasSmoke)
         {
            if(this.currentSmoke.pivotY == 0)
            {
               this.currentSmoke.x = x;
               this.currentSmoke.y = y;
            }
            else
            {
               this.currentSmoke.x = footX();
               this.currentSmoke.y = footY();
            }
            if(Math.abs(shakeRL) > 1)
            {
               this.currentSmoke.x += this.baddie.x;
               this.currentSmoke.y += this.baddie.y;
            }
            this.currentSmoke.scaleX = scaleX;
            this.currentSmoke.scaleY = scaleY;
            this.currentSmoke.rotation = rotation * (Math.PI / 180);
         }
      }
      
      internal function nullHitChar() : Boolean
      {
      }
   }
}

