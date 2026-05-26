package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol7035")]
   public class bowlingBall extends Baddies
   {
      
      public var baddie:MovieClip;
      
      internal var myTunnel:Object;
      
      internal var actionStage:uint = 0;
      
      internal var b:int;
      
      public function bowlingBall(p:*)
      {
         var crack:Level1Crack = null;
         super(15,15,p.onRail);
         ItIs = "BowlingBall";
         health = 1000;
         BallRes = 0;
         bounce = 0.2;
         bounceThresh = 2;
         springy = 3;
         rotPerc = 360 / (Math.PI * (isTall * 2));
         springTall = isTall * 2;
         overReach = 10;
         mass = 100;
         canAggressor = false;
         BaddieEnterFrame = this.WaitEnterFrame;
         Status = "Wait";
         currentGetAttacked = function(ex:*, ey:*, eRL:*, eUD:*, char:*, hitMove:*, hitPower:*):*
         {
         };
         activeBaddieArray.push(this);
         if(Main.LevelStatus == "Race")
         {
            currentHitChar = function(ex:*, ey:*, eRL:*, eUD:*, ax:*, ay:*, char:*):*
            {
            };
            this.myTunnel = new tunnelCover();
            this.myTunnel.x = 5388.55;
            this.myTunnel.y = -283.1;
            Main.UberForeground.tunnel.visible = false;
            Backgrounds.backgroundsArray[p.onRail].addChild(this.myTunnel);
            return;
         }
         if(Main.levelStates.bowlingBalled)
         {
            x = 7570;
            y = 115;
            canBall = false;
            currentHitChar = function(ex:*, ey:*, eRL:*, eUD:*, ax:*, ay:*, char:*):*
            {
            };
            crack = new Level1Crack();
            crack.x = 7588.7;
            crack.y = 127.3;
            Backgrounds.backgroundsArray[p.onRail].addChild(crack);
            Main.AllEverything["walls" + p.onRail].wall0.gotoAndStop(2);
         }
         else
         {
            x = p.x;
            y = p.y;
            this.myTunnel = new tunnelCover();
            this.myTunnel.x = 5388.55;
            this.myTunnel.y = -283.1;
            Main.UberForeground.tunnel.visible = false;
            Backgrounds.backgroundsArray[p.onRail].addChild(this.myTunnel);
            currentHitChar = function(ex:*, ey:*, eRL:*, eUD:*, ax:*, ay:*, char:*):*
            {
               if(eRL > 0 && char.scaleX > 0 && x - ex < 50)
               {
                  Sounds.playSound("Hit",x,2,onRail);
                  currentSound = Sounds.playSoundContinuous("Rolling",x,0,onRail);
                  canAggressor = true;
                  AggressorArray.push(this);
                  BaddieEnterFrame = RollEnterFrame;
                  Status = "Roll";
                  Main.setScrollOther(this,20);
                  if(char.x > x)
                  {
                     char.x = x;
                  }
                  distRL = x - char.x;
                  distUD = y - char.y;
                  theX = x;
                  char.Jumper = 10;
                  char.fakeRL = char.moveRL = 0;
                  char.FloatUp = 2;
                  char.wallRot = char.rotation = 0;
                  char.gotoBuffer = "Kick";
                  Char.setAllSuperStill(true);
                  Main.shakeScreen(30,0,true);
                  shakeRL = 20 * char.scaleX;
                  moveRL = 12;
                  moveUD = -22;
                  rotter = 80;
                  hitPause = char.hitPause = 8;
                  downTime = 10;
                  Main.popBetween(char,this);
                  BallRes = 10;
                  currentHitChar = function(ex:*, ey:*, eRL:*, eUD:*, ax:*, ay:*, char:*):*
                  {
                     return null;
                  };
               }
            };
         }
         Backgrounds.backgroundsArray[p.onRail].container.addChild(this);
      }
      
      override public function firstCircleCheck(ex:*, ey:*, eUD:*) : *
      {
         return testOnlyGround(ex,ey);
      }
      
      public function WaitEnterFrame() : *
      {
         return null;
      }
      
      public function RollEnterFrame() : *
      {
         if(Math.abs(moveRL) > 0.25)
         {
            moveRL -= makeOne(moveRL) * 0.25;
         }
         else
         {
            moveRL = 0;
            BaddieEnterFrame = this.FallEnterFrame;
         }
         if(moveUD < 25)
         {
            moveUD += 1;
         }
      }
      
      public function FallEnterFrame() : *
      {
         var land:uint = 0;
         var scale:uint = 0;
         var crack:Level1Crack = null;
         if(moveUD < 25)
         {
            moveUD += 1;
         }
         if(nowSpeed() > 30)
         {
            moveRL *= 30 / nowSpeed();
            moveUD *= 30 / nowSpeed();
         }
         if(wallX - x > -30)
         {
            Sounds.updateSound(currentSound,x,1,onRail);
         }
         else
         {
            Sounds.updateSound(currentSound,x,0,onRail);
         }
         switch(this.actionStage)
         {
            case 0:
               if(x > 5200)
               {
                  ++this.actionStage;
                  Main.AllEverything["walls" + onRail].wall0.gotoAndStop(2);
               }
               break;
            case 1:
               if(x > 5340)
               {
                  ++this.actionStage;
                  x = 5340;
                  Main.shakeScreen(60,0,true);
                  hitPause = 20;
                  shakeRL = 20;
                  Sounds.playSound("InkBoom",x,2,onRail);
                  StarlingEffect.Spawn("popEffect",(this.myTunnel.x + x) / 2,(this.myTunnel.y + y) / 2,Math.random() * 3,2,0,0,onRail);
                  land = 10;
                  scale = 3;
                  StarlingEffect.Spawn("smokePuff",this.myTunnel.x,this.myTunnel.y,-0.785,scale,-land,-land,onRail);
                  StarlingEffect.Spawn("smokePuff",this.myTunnel.x,this.myTunnel.y,0.785,scale,land,-land,onRail);
                  StarlingEffect.Spawn("smokePuff",this.myTunnel.x,this.myTunnel.y,2.356,-scale,land,land,onRail);
                  StarlingEffect.Spawn("smokePuff",this.myTunnel.x,this.myTunnel.y,-2.356,-scale,-land,land,onRail);
                  this.myTunnel.parent.removeChild(this.myTunnel);
                  this.myTunnel = null;
                  Main.UberForeground.tunnel.visible = true;
               }
               break;
            case 2:
               if(x > 7550)
               {
                  ++this.actionStage;
                  x = 7570;
                  y = 115;
                  moveRL = 0;
                  moveUD = 0;
                  canBall = false;
                  this.b = 40;
                  Main.shakeScreen(200,0,true);
                  BaddieEnterFrame = this.FinishEnterFrame;
                  Status = "Wait";
                  Sounds.stopSound(currentSound);
                  currentSound = null;
                  Sounds.playSound("InkBoom",x,1.5,onRail);
                  crack = new Level1Crack();
                  crack.x = 7588.7;
                  crack.y = 127.3;
                  Backgrounds.backgroundsArray[onRail].addChild(crack);
                  Main.levelStates.bowlingBalled = true;
               }
         }
      }
      
      private function FinishEnterFrame() : *
      {
         if(this.b > 0)
         {
            --this.b;
            rotter *= 0.9;
         }
         else
         {
            ++this.actionStage;
            BallRes = 0;
            rotter = 0;
            BaddieEnterFrame = this.WaitEnterFrame;
            Main.startControls(true);
            Char.setAllSuperStill(false);
            Main.switchScroll("scrollChars");
         }
      }
   }
}

