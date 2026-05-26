package
{
   public class inkDropStarling extends StarlingInteract
   {
      
      public var groundY:int;
      
      public var spawner:staticInteractObjects;
      
      public function inkDropStarling(e:*, ex:*, ey:*, rot:*, scale:*, eRL:*, eUD:*, rail:*, id:int = -1)
      {
         isWide = 2;
         isTall = 10;
         super(e,ex,ey,rot,scale,eRL,eUD,rail,id);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(char.alpha == 1 && y < this.groundY && visible)
         {
            char.wallRot = 0;
            char.hurtChar(35,20,5,char.makeOne(ex - x) * 8,20);
            char.downTime = 60;
         }
      }
      
      override public function interactsEnterFrame() : Boolean
      {
         if(visible)
         {
            if(currentFrame == 70)
            {
               return true;
            }
            if(y == this.groundY)
            {
               ++currentFrame;
            }
            else if(y + moveUD * 0.5 > this.groundY && moveUD > 0)
            {
               currentFrame = 38;
               moveUD = 0;
               y = this.groundY;
               scaleX *= -1;
               this.spawner.inkLand();
            }
            else if(currentFrame == 37)
            {
               currentFrame = 36;
            }
            else
            {
               moveUD += 0.8;
               if(currentFrame > 21 && moveUD < 0)
               {
                  if(currentFrame > 1)
                  {
                     --currentFrame;
                  }
               }
               else
               {
                  ++currentFrame;
                  if(scaleY < 0)
                  {
                     scaleY *= -1;
                  }
               }
            }
         }
         if(moveUD < 5 && currentFrame == 21)
         {
            currentFrame = 3;
         }
         this.halfEnterFrame();
         return false;
      }
      
      override public function halfEnterFrame() : Boolean
      {
         y += moveUD * framin;
      }
      
      override public function reset() : void
      {
         originY = Math.floor(y);
         halfArray.push(this);
      }
   }
}

