package
{
   import starling.display.Image;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4289")]
   public class fallOnBoss1 extends staticInteractObjects
   {
      
      public var health:int = 0;
      
      public var hitPause:uint = 0;
      
      public var downTime:Number = 0;
      
      private var theX:int;
      
      private var theY:int;
      
      public var inky:Boolean = true;
      
      private var myRed:Image;
      
      public function fallOnBoss1(p:*)
      {
         super("fallOnBoss1",p.x,p.y,1,1,p.onRail,"nothing",-1);
         isTall = 150;
         isWide = 50;
         this.health = 50;
         this.theX = x;
         this.theY = y;
         canAttackArray.push(this);
         gotoAndStop(1);
         Backgrounds.backgroundsArray[onRail].addChild(this);
         transform.colorTransform = Main.getTint(1,-0.6,-0.6);
         this.myRed = StarlingBackgrounds.toStarlingObj(this,1,StarlingBackgrounds.BackgroundObjArray[0]);
         transform.colorTransform = Main.getTint(0,0,0);
         visible = false;
         this.myRed.visible = false;
         backEffect = true;
      }
      
      public function currentGetAttacked(ex:Number, ey:Number, ang:Number, char:collision, hitMove:String, hitPower:Number, power:Number) : Boolean
      {
         if(this.downTime == 0)
         {
            char.hitPause = hitPower * 0.1 + 1;
            this.hitPause = this.hitPause = char.hitPause * 2;
            this.downTime = this.hitPause + 2;
            RedHurt = 4;
            this.myRed.visible = true;
            this.health -= hitPower * power;
            Sounds.playSound("PillarImpact",x,1,0);
            if(this.health > 0)
            {
               shakeRL = 40;
               Main.shakeScreen(20,ang,false);
            }
            else
            {
               shakeRL = 120;
               Main.shakeScreen(200,ang,true);
               nextFrame();
               Sounds.fadeOutMusic("Wind_Cave",0.1);
               Sounds.playSound("PillarCrack",x,1.5,0);
               char.hitPause = 20;
               char.disableControls();
               Main.switchScroll("simpleScroll");
               Main.cameraShiftX = x;
               Main.cameraShiftY = y + 100;
               Main.cameraShiftZ = 0;
               StarlingEffect.Spawn("Splat",x,y,Math.random() * 6,1.5,0,0,onRail);
               visible = true;
               this.downTime = 500;
               gotoAndStop(2);
               Baddies.findByItIs("Boss1").resetHands();
            }
            if(InteractEnterFrameArray.indexOf(this) == -1)
            {
               InteractEnterFrameArray.push(this);
            }
            return true;
         }
         return false;
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(currentFrame > 1)
         {
            if(currentFrameLabel != "c")
            {
               nextFrame();
            }
            if(currentFrame > 15 && currentFrame < 83)
            {
               Main.cameraShiftY -= 2;
            }
            if(currentFrameLabel == "a")
            {
               Main.shakeScreen(200,0,true);
               StarlingEffect.Spawn("Splat",x,y - 220,Math.random() * 6,1.5,0,0,onRail);
               Sounds.playSound("PillarImpact",x,2,0);
               Sounds.playSound("InkBoom",x,1.5,onRail);
            }
            else if(currentFrameLabel == "b")
            {
               Main.cameraShiftY = 50;
               Main.cameraShiftZ = -60;
               Char.CharArray[0].enableControls();
            }
            else if(currentFrameLabel != "d")
            {
               if(currentFrameLabel == "c")
               {
                  this.theY += 50;
                  if(this.theY > -200)
                  {
                     this.theY = -200;
                     gotoAndStop("d");
                     Main.shakeScreen(200,0,true);
                     Sounds.playSound("InkBoom",x,3,onRail);
                     Sounds.playSound("PillarImpact",x,2,0);
                     StarlingEffect.Spawn("blockPiece",x,y + 200,0,3,1,-40,onRail,false,true,2 * 4 + Math.floor(Math.random() * 4) + 1);
                     StarlingEffect.Spawn("blockPiece",x,y + 150,0,3,5,-30,onRail,false,true,2 * 4 + Math.floor(Math.random() * 4) + 1);
                     StarlingEffect.Spawn("blockPiece",x,y + 150,0,3,-5,-30,onRail,false,true,2 * 4 + Math.floor(Math.random() * 4) + 1);
                     StarlingEffect.Spawn("blockPiece",x - 80,y - 100,0,2,-7,-10,onRail,false,true,2 * 4 + Math.floor(Math.random() * 4) + 1);
                     StarlingEffect.Spawn("blockPiece",x,y - 100,0,2,-2,-15,onRail,false,true,2 * 4 + Math.floor(Math.random() * 4) + 1);
                     StarlingEffect.Spawn("blockPiece",x + 80,y - 100,0,2,7,-10,onRail,false,true,2 * 4 + Math.floor(Math.random() * 4) + 1);
                     StarlingEffect.Spawn("blockPiece",x - 50,y,0,2,-10,-20,onRail,false,true,2 * 4 + Math.floor(Math.random() * 4) + 1);
                     StarlingEffect.Spawn("blockPiece",x,y,0,2,2,-25,onRail,false,true,2 * 4 + Math.floor(Math.random() * 4) + 1);
                     StarlingEffect.Spawn("blockPiece",x + 50,y,0,2,10,-20,onRail,false,true,2 * 4 + Math.floor(Math.random() * 4) + 1);
                     StarlingEffect.Spawn("Splat",x,y + 100,Math.random() * 6,2,0,0,onRail);
                     StarlingEffect.Spawn("Splat",x + 70,y - 50,Math.random() * 6,1.5,0,0,onRail);
                     StarlingEffect.Spawn("Splat",x - 70,y - 50,Math.random() * 6,1.5,0,0,onRail);
                     Baddies.findByItIs("Boss1").ChangeFrame("Smashed");
                     visible = false;
                  }
               }
            }
         }
         this.hurtStuff();
      }
      
      private function hurtStuff() : void
      {
         if(RedHurt > 0)
         {
            if(RedHurt == 2 || RedHurt == 4)
            {
               this.myRed.visible = true;
            }
            if(RedHurt == 1 || RedHurt == 3 || RedHurt == 5)
            {
               this.myRed.visible = false;
            }
            --RedHurt;
         }
         x = this.theX + shakeRL * 0.5 - shakeRL * Math.random();
         y = this.theY + shakeRL * 0.5 - shakeRL * Math.random();
         shakeRL *= 0.6;
         if(this.downTime > 0)
         {
            --this.downTime;
         }
         if(Math.abs(shakeRL) < 0.1)
         {
            x = this.theX;
            y = this.theY;
            if(RedHurt == 0 && this.downTime == 0)
            {
               InteractEnterFrameArray.splice(InteractEnterFrameArray.indexOf(this),1);
            }
         }
      }
      
      public function smashKnockback(e:Number) : Number
      {
         return e;
      }
   }
}

