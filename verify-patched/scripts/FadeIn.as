package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1499")]
   public class FadeIn extends MovieClip
   {
      
      public var superDebug:TextField;
      
      public var fadeMusic:Boolean;
      
      public var ItIs:String = "FadeIn";
      
      public function FadeIn()
      {
         super();
         staticInteractObjects.InteractEnterFrameArray.push(this);
         stop();
         x = Main.realStageX;
         y = Main.realStageY;
         scaleX = Main.originalStageX / 400;
         scaleY = Main.originalStageY / 250;
         mouseEnabled = false;
      }
      
      public function InteractEnterFrame() : *
      {
         if(currentFrame == totalFrames)
         {
            staticInteractObjects.InteractEnterFrameArray.splice(staticInteractObjects.InteractEnterFrameArray.indexOf(this),1);
            Main.FadeClip = null;
            if(parent != null)
            {
               parent.removeChild(this);
            }
         }
         else
         {
            nextFrame();
         }
      }
   }
}

