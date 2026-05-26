package
{
   public class ScratchStarling extends StarlingInteract
   {
      
      private var lifetime:int;
      
      public var inky:Boolean = false;
      
      private var fall:Boolean;
      
      private var rotter:Number;
      
      public function ScratchStarling(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, id:int)
      {
         super(e,ex,ey,rot,scale,eRL,eUD,rail);
         ID = id;
         killOnAttack = false;
      }
      
      override public function interactsEnterFrame() : Boolean
      {
         if(this.lifetime > 0)
         {
            --this.lifetime;
            if(this.lifetime < 20)
            {
               scaleX = scaleY = this.lifetime / 20;
            }
            if(currentFrame == 7)
            {
               currentFrame = 1;
            }
            else
            {
               ++currentFrame;
            }
            if(downTime > 0)
            {
               --downTime;
            }
            if(this.fall)
            {
               this.rotter *= 0.8;
               ++moveUD;
            }
            return this.halfEnterFrame();
         }
         return true;
      }
      
      override public function halfEnterFrame() : Boolean
      {
         x += moveRL * framin;
         y += moveUD * framin;
         rotation += this.rotter * framin;
         return false;
      }
      
      override public function reset() : void
      {
         this.lifetime = ID;
         halfArray.push(this);
         canAttackArray.push(this);
         isWide = 5 * scaleY;
         isTall = 5 * scaleY;
         this.fall = false;
         downTime = 0;
         this.rotter = moveRL * 0.05;
         downTime = 2;
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(char.hurtChar(20,20,5,moveRL * 0.5,20))
         {
            char.rotter = moveRL * 2;
            Main.popBetween(this,char,1.5);
         }
      }
      
      public function currentGetAttacked(ex:Number, ey:Number, angle:Number, char:collision, hitMove:String, hitPower:Number, pow:Number = 1) : Boolean
      {
         Sounds.playSound("Hit",x,1,onRail);
         this.getAttackedShared(ex,ey,angle,char,hitMove,hitPower);
         this.fall = true;
         char.hitPause = hitPower * 0.2;
         this.rotter = makeOne(moveRL) * 20;
         if(this.lifetime < 100)
         {
            this.lifetime = 100;
         }
         return true;
      }
      
      override public function hitBaddie(ex:Number, ey:Number, eRL:Number, eUD:Number, bad:Baddies) : Boolean
      {
         if(downTime == 0 && bad.BallRes > 0)
         {
            this.fall = true;
            bad.moveRL = moveRL;
            bad.moveUD = -10;
            bad.hurtBaddie(40);
            bad.rotter = 40;
            bad.ChangeFrame("Hit");
            bad.placeSmoke();
            downTime = 4;
            bad.shakeRL = 30;
            bad.hitPause = 2;
            if(this.lifetime < 100)
            {
               this.lifetime = 100;
            }
            Sounds.playSound("Impact",x,2,onRail);
            Main.popBetween(this,bad);
            if(bad.ItIs == "Mouse")
            {
               Achievements.unlock("Play_Ball");
               Achievements.SendScore("baddieWithScratch",1);
            }
            moveRL = (x - ex) * 0.2;
            moveUD = -16;
            this.rotter = makeOne(moveRL) * 20;
         }
      }
      
      private function getAttackedShared(ex:*, ey:*, angle:*, char:*, hitMove:*, hitPower:*) : void
      {
         var tempUD:Number = NaN;
         shakeRL = hitPower + 10;
         downTime = 6;
         if(hitMove == "PokeDown")
         {
            char.hitPause = 2;
         }
         this.rotter = hitPower * char.scaleX * 3;
         if(health == 0 && Math.abs(this.rotter) < 80)
         {
            this.rotter = makeOne(this.rotter) * 80;
         }
         if(ItIs == "Char")
         {
            if(hitPower < 18)
            {
               tempUD = -(hitPower * 0.5 + 10) * this.smashKnockback() * 0.75;
            }
            else
            {
               tempUD = -(hitPower * 0.5 + 10) * this.smashKnockback();
            }
         }
         else if(hitMove == "SwipeUp")
         {
            tempUD = -hitPower * 1.5;
            if(health > 0 && Status != "Jump")
            {
               tempUD *= 1.5;
            }
         }
         else if(hitPower < 20)
         {
            if(health == 0)
            {
               tempUD = -hitPower;
            }
            else
            {
               tempUD = -hitPower * 0.6;
            }
         }
         else if(hitPower < 25)
         {
            tempUD = -hitPower * 1.2;
         }
         else
         {
            tempUD = -hitPower;
         }
         fakeRL = moveRL = -Math.sin(angle) * tempUD;
         fakeUD = moveUD = Math.cos(angle) * tempUD;
         if(hitPower < 20)
         {
            moveRL += char.moveRL * 0.8;
         }
      }
      
      public function smashKnockback(e:Number) : Number
      {
         return e;
      }
      
      public function nowSpeed() : *
      {
         return Math.sqrt(moveRL * moveRL + moveUD * moveUD);
      }
   }
}

