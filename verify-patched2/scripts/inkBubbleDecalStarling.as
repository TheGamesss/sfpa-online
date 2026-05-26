package
{
   public class inkBubbleDecalStarling extends StarlingDecals
   {
      
      private var anchorX:int;
      
      public function inkBubbleDecalStarling(p:*)
      {
         isTall = 20;
         isWide = 15;
         this.anchorX = p.x;
         super("inkBubbleDecal",p.x,p.y,p.rotation,1,1,p.onRail,"nothing",-1);
         realCurrent = currentFrame = uint((numFrames - 1) * Math.random()) + 1;
         this.reset();
         cleanUp = function():*
         {
         };
      }
      
      override public function decalEnterFrame() : void
      {
         realCurrent += framin / scaleY * 0.5 + 0.3;
         currentFrame = uint(realCurrent);
         if(realCurrent >= 46)
         {
            this.reset();
            realCurrent = currentFrame = 1;
         }
      }
      
      private function reset() : void
      {
         scaleX = scaleY = Math.random() * 1 + 0.2;
         x = this.anchorX + Math.random() * 50 - 25;
         if(Math.random() > 0.5)
         {
            scaleX *= -1;
         }
      }
   }
}

