package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol423")]
   public class Level3Overlord extends MovieClip
   {
      
      public var callBack:Object;
      
      public function Level3Overlord()
      {
         super();
         staticInteractObjects.InteractEnterFrameArray.push(this);
         if(Main.LevelStatus == "Normal")
         {
            if(Main.crossLevelStatus != "speechBubbled")
            {
               new bigSpeechBubble(15,15,function():*
               {
               });
               Main.crossLevelStatus = "speechBubbled";
            }
            else
            {
               new bigSpeechBubble(16,16,function():*
               {
               });
            }
         }
      }
      
      public function InteractEnterFrame() : *
      {
         if(currentFrameLabel != "2" && currentFrameLabel != "9")
         {
            nextFrame();
         }
         if(currentFrame == 158)
         {
            Main.MinY -= 200;
            Main.setMaxZ();
         }
         switch(currentFrameLabel)
         {
            case "1":
            case "3":
            case "5":
               Main.shakeScreen(20,0,true);
               break;
            case "4":
            case "6":
            case "7":
            case "8":
               ++this.callBack.step;
         }
      }
   }
}

