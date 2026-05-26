package
{
   public class doodleGrassStarling extends StarlingDecals
   {
      
      public function doodleGrassStarling(p:*)
      {
         isTall = 20;
         isWide = 15;
         super("doodleGrass",p.x,p.y,p.rotation,1,1,p.onRail,"nothing",-1);
         cleanUp = function():*
         {
         };
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : void
      {
         this.hitAny(eRL,eUD);
      }
      
      override public function hitBaddie(ex:Number, ey:Number, eRL:Number, eUD:Number, baddie:Baddies) : void
      {
         this.hitAny(eRL,eUD);
      }
      
      private function hitAny(eRL:Number, eUD:Number) : void
      {
         if(currentFrame < 22 || currentFrame > 31 && currentFrame < 59 || currentFrame > 131 && currentFrame < 159)
         {
            if(eUD > 10 && Math.abs(eRL) < 10)
            {
               currentFrame = 25;
            }
            else if(eRL < 0)
            {
               currentFrame = 122;
            }
            else
            {
               currentFrame = 22;
            }
            realCurrent = currentFrame;
         }
         else if(currentFrame == 131)
         {
            realCurrent = currentFrame = 130;
         }
         else if(currentFrame == 31)
         {
            realCurrent = currentFrame = 30;
         }
         else if(Math.abs(eRL) > 10 && currentFrame != 130 && currentFrame != 30)
         {
            this.decalEnterFrame();
         }
      }
      
      override public function decalEnterFrame() : void
      {
         realCurrent += framin;
         currentFrame = uint(realCurrent);
         if(currentFrame == 20 || currentFrame == 66 || currentFrame == 166)
         {
            realCurrent = currentFrame = 1;
         }
      }
   }
}

