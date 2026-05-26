package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol884")]
   public class tutorialPopup extends MovieClip
   {
      
      public var arrowL:SimpleButton;
      
      public var arrowR:SimpleButton;
      
      private var menuKeyThresh:Number;
      
      public function tutorialPopup(ex:int, ey:int, scale:Number, frame:uint)
      {
         super();
         x = ex;
         y = ey;
         scaleX = scaleY = scale;
         gotoAndStop(frame);
         if(currentFrame == 1)
         {
            this.arrowL.visible = false;
         }
         if(currentFrame == totalFrames)
         {
            this.arrowR.visible = false;
         }
         alpha = 0;
      }
      
      public function clickTutorial(event:Event) : Boolean
      {
         if(event.target.name == "arrowR")
         {
            this.changeFrame(1);
         }
         else
         {
            if(event.target.name != "arrowL")
            {
               return true;
            }
            this.changeFrame(-1);
         }
         return false;
      }
      
      public function menuKeys(ex:Number) : void
      {
         if(Math.abs(ex) > 0.3)
         {
            this.menuKeyThresh -= Math.abs(ex);
         }
         else
         {
            this.menuKeyThresh = 0;
         }
         if(this.menuKeyThresh <= 0)
         {
            if(Math.abs(ex) > 0.3)
            {
               this.menuKeyThresh = 20;
               this.changeFrame(ex / Math.abs(ex));
            }
         }
      }
      
      private function changeFrame(n:*) : void
      {
         gotoAndStop(currentFrame + n);
         if(currentFrame == 1)
         {
            this.arrowL.visible = false;
         }
         else if(currentFrame == totalFrames)
         {
            this.arrowR.visible = false;
         }
         else
         {
            this.arrowL.visible = true;
            this.arrowR.visible = true;
         }
      }
   }
}

