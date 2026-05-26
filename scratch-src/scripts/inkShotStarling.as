package
{
   public class inkShotStarling extends StarlingInteract
   {
      
      private var lifetime:int;
      
      public function inkShotStarling(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, id:int)
      {
         super(e,ex,ey,rot,scale,eRL,eUD,rail);
         isWide = isTall = 5;
         ID = id;
      }
      
      override public function interactsEnterFrame() : Boolean
      {
         if(this.lifetime > 0)
         {
            --this.lifetime;
            StarlingEffect.Spawn("inkTrail" + int(Math.random() * 3),x,y,rotation,1,moveRL * 0.05,moveUD * 0.05,onRail);
            this.halfEnterFrame();
            if(aWall.checkOutlines(x,y,isWide,isTall,onRail))
            {
               Sounds.playSound("InkSplat",x,1,onRail);
               StarlingEffect.Spawn("inkImpact" + int(Math.random() * 3),x,y,rotation,1,-moveRL * 0.2,-moveUD * 0.2,onRail);
               StarlingEffect.Spawn("Splat",x,y,Math.random() * 6,scaleY * 0.3,moveRL * 0.4,moveUD * 0.4,onRail);
               return true;
            }
            if(staticInteractObjects.checkInk(x,y,moveRL,isWide,isTall,onRail,this))
            {
               Sounds.playSound("InkSplat",x,0.5,onRail);
               StarlingEffect.Spawn("Splat",x,y,Math.random() * 6,scaleY * 0.3,moveRL * 0.4,moveUD * 0.4,onRail);
               return true;
            }
            return;
         }
         StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,scaleY * 0.2,moveRL * 0.5,moveUD * 0.5,onRail);
         return true;
      }
      
      override public function halfEnterFrame() : Boolean
      {
         if(currentFrame == 8)
         {
            currentFrame = 1;
         }
         else
         {
            ++currentFrame;
         }
         x += moveRL * framin;
         y += moveUD * framin;
      }
      
      override public function reset() : void
      {
         this.lifetime = ID;
         halfArray.push(this);
      }
      
      override public function hitBaddie(ex:Number, ey:Number, eRL:Number, eUD:Number, bad:Baddies) : Boolean
      {
         if(bad.canGetShot && bad.downTime == 0)
         {
            if(bad.Projectile(x,y,moveRL))
            {
               StarlingEffect.Spawn("inkImpact" + int(Math.random() * 3),x + moveRL * 0.3,y + moveUD * 0.3,rotation,-scaleX * 1.3,0,0,onRail);
               StarlingEffect.Spawn("Splat",x,y,Math.random() * 6,scaleY * 0.3,moveRL * 0.3,moveUD * 0.3,onRail);
               if(bad.isWide > 200)
               {
                  return true;
               }
               scaleY -= 0.3;
               scaleX *= scaleY / scaleX;
               return scaleY < 0.3;
            }
            return false;
         }
      }
   }
}

