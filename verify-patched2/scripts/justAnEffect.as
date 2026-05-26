package
{
   import flash.display.MovieClip;
   
   public class justAnEffect extends MovieClip
   {
      
      public function justAnEffect()
      {
         super();
         staticInteractObjects.InteractEnterFrameArray.push(this);
         stop();
      }
      
      public function InteractEnterFrame() : *
      {
         if(currentFrame == totalFrames)
         {
            staticInteractObjects.killInteract.push(this);
         }
         else
         {
            nextFrame();
         }
      }
   }
}

