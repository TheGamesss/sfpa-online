package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol3875")]
   public class inkValve extends staticInteractObjects
   {
      
      private var baddieInterval:uint;
      
      private var baddiesOut:uint = 0;
      
      private var baddiesTotal:uint;
      
      private var b:uint = 0;
      
      private var shootX:int;
      
      private var shootY:int;
      
      private var shootRL:Number;
      
      private var shootUD:Number;
      
      private var lifetime:int;
      
      public var downTime:uint = 0;
      
      public var health:uint = 1;
      
      public var inky:Boolean = true;
      
      public function inkValve(p:*)
      {
         isWide = 20;
         isTall = 50;
         super("inkPipe",p.x,p.y,1,1,p.onRail,"nothing",-1);
         Backgrounds.backgroundsArray[onRail].addChild(this);
         rotation = p.rotation;
         this.baddieInterval = p.interval;
         this.lifetime = p.lifetime;
         this.baddiesTotal = p.total;
         InteractEnterFrameArray.push(this);
         ID = p.ID;
         scaleY = p.scaleX;
         if(Main.world4Progress["bentPipe" + ID])
         {
            gotoAndStop(2);
         }
         angle = rotation * (Math.PI / 180);
         this.shootX = x + -Math.sin(angle) * 10 * scaleY;
         this.shootY = y + Math.cos(angle) * 10 * scaleY;
         this.shootRL = -Math.sin(angle) * 10 * scaleY;
         this.shootUD = Math.cos(angle) * 10 * scaleY;
         canAttackArray.push(this);
         stop();
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(this.downTime > 0)
         {
            --this.downTime;
         }
         if(quickCheckDist(Char.CharArray[0].x,Char.CharArray[0].y,1000,800,0))
         {
            if(this.b > 0)
            {
               --this.b;
            }
            else if(currentFrame == 1 && this.baddiesOut < this.baddiesTotal)
            {
               this.b = this.baddieInterval;
               ++this.baddiesOut;
               new Baddie1({
                  "ItIs":"Baddie1",
                  "x":this.shootX,
                  "y":this.shootY,
                  "rotation":0,
                  "scaleX":1,
                  "scaleY":0.3 + Math.random() * 0.5,
                  "onRail":0,
                  "moveRL":this.shootRL,
                  "moveUD":this.shootUD,
                  "originX":x + 300 * scaleY,
                  "autopilot":true,
                  "lifetimeN":-1,
                  "spawner":this,
                  "tether":200
               });
            }
         }
      }
      
      public function currentGetAttacked(ex:Number, ey:Number, angle:Number, char:collision, hitMove:String, hitPower:Number, power:Number = 1) : Boolean
      {
         if(this.downTime > 0)
         {
            return false;
         }
         Sounds.playSound("PoleLand",x,2,onRail);
         Sounds.playSound("Impact",x,1,onRail);
         if((x - ex) * scaleY > 0)
         {
            gotoAndStop(2);
         }
         else
         {
            gotoAndStop(3);
         }
         shakeRL = 20;
         if(hitPower < 20)
         {
            this.downTime = 5;
         }
         else
         {
            this.downTime = 10;
         }
         if(ID > -1)
         {
            if(!Main.world4Progress["bentPipe" + ID])
            {
               Main.saveProgress("bentPipe" + ID,true);
               if(this.baddiesOut == 0)
               {
                  if(ID == 0)
                  {
                     staticInteractObjects.findByName("captAttackLoop").finish();
                  }
                  else
                  {
                     staticInteractObjects.findByName("PirateStuck" + ID).finish();
                  }
               }
            }
         }
         char.hitPause = hitPower * 0.2;
         this.downTime += hitPower * 0.2;
         return true;
      }
      
      public function onKilled() : void
      {
         --this.baddiesOut;
         if(this.baddiesOut == 0)
         {
            if(Main.world4Progress["bentPipe" + ID])
            {
               if(ID == 0)
               {
                  staticInteractObjects.findByName("captAttackLoop").finish();
               }
               else
               {
                  staticInteractObjects.findByName("PirateStuck" + ID).finish();
               }
            }
         }
      }
      
      public function smashKnockback(e:Number) : Number
      {
         return e;
      }
   }
}

