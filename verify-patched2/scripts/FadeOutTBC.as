package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol1445")]
   public class FadeOutTBC extends FadeOut
   {
      
      public function FadeOutTBC(load:*, door:*)
      {
         super(load,door);
      }
      
      override public function InteractEnterFrame() : *
      {
         if(currentFrameLabel == "wait")
         {
            if(Main.LevelLoaded != "TurtleWarp")
            {
               Main.LoadIt = "TurtleWarp";
            }
         }
         else if(currentFrame == totalFrames)
         {
            Main.LoadIt = LoadIt;
         }
         else
         {
            nextFrame();
         }
      }
   }
}

