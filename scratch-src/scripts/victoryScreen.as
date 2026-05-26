package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol856")]
   public class victoryScreen extends MovieClip
   {
      
      public function victoryScreen()
      {
         super();
      }
      
      public function elementEnterFrame() : void
      {
         nextFrame();
         if(currentFrameLabel == "a")
         {
            gotoAndStop("loopa");
         }
      }
   }
}

