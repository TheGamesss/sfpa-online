package
{
   import flash.display.MovieClip;
   
   public class Arena5Overlord extends MovieClip
   {
      
      public function Arena5Overlord()
      {
         super();
         staticInteractObjects.InteractEnterFrameArray.push(this);
      }
      
      public function InteractEnterFrame() : *
      {
         var scale:Number = NaN;
         var obj:Object = null;
         if(Baddies.BaddieArray.length < 15)
         {
            scale = Math.random() * 2;
            scale *= scale;
            scale *= 0.8;
            scale += 1;
            scale *= 0.4;
            if(Math.random() > 0.5)
            {
               scale *= -1;
            }
            obj = {
               "x":Math.random() * 1100,
               "y":-500,
               "rotation":0,
               "scaleX":scale,
               "scaleY":scale,
               "autopilot":true
            };
            new Baddie1(obj);
         }
      }
   }
}

