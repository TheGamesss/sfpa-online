package
{
   public class inkShotBadStarling extends StarlingInteract
   {
      
      private var lifetime:int;
      
      public var inky:Boolean = true;
      
      public function inkShotBadStarling(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, id:int)
      {
         super(e,ex,ey,rot,scale,eRL,eUD,rail);
         ID = id;
      }
      
      override public function interactsEnterFrame() : Boolean
      {
         if(this.lifetime > 0)
         {
            --this.lifetime;
            if(currentFrame == 8)
            {
               currentFrame = 1;
            }
            else
            {
               ++currentFrame;
            }
            return this.halfEnterFrame();
         }
         StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,scaleY * 0.2,moveRL * 0.25,moveUD * 0.25,onRail);
         return true;
      }
      
      override public function halfEnterFrame() : Boolean
      {
         x += moveRL * framin;
         y += moveUD * framin;
         if(checkByName("inkShot",x,y,isWide + 20,isTall + 20,onRail) != null)
         {
            StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,scaleY * 0.2,moveRL * 0.5,moveUD * 0.5,onRail);
            return true;
         }
         return false;
      }
      
      override public function reset() : void
      {
         this.lifetime = ID;
         halfArray.push(this);
         canAttackArray.push(this);
         isWide = 5 * scaleY;
         isTall = 5 * scaleY;
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(char.hurtChar(30 * scale,20,4,moveRL * 0.25,20))
         {
            char.rotter = moveRL * 3;
            Sounds.playSound("InkBurst",x,scale * 1.2,onRail);
            StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,scaleY * 0.3,moveRL * 0.4,moveUD * 0.4,onRail);
            return true;
         }
      }
      
      public function currentGetAttacked(ex:Number, ey:Number, angle:Number, char:collision, hitMove:String, hitPower:Number, pow:Number = 1) : Boolean
      {
         var ang:Number = -Math.atan2(-moveRL,-moveUD) + 0.1 - Math.random() * 0.2;
         Sounds.playSound("InkBurst",x,scale * 1.2,onRail);
         StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,scaleY * 0.3,-moveRL * 0.4,-moveUD * 0.4,onRail);
         StarlingInteract.Spawn("inkShot",x,y,ang,scaleY,-Math.sin(ang) * 40,Math.cos(ang) * 40,onRail,20);
         char.hitPause = hitPower * 0.2;
         char.updateInk(20);
         return true;
      }
      
      public function smashKnockback(e:Number) : Number
      {
         return e;
      }
   }
}

