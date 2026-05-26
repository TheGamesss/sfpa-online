package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1258")]
   public class loadHUD extends MovieClip
   {
      
      public var bar:MovieClip;
      
      public function loadHUD()
      {
         super();
         stop();
         x = Main.realStageX;
         y = Main.realStageY;
         scaleX = Main.originalStageX / 400;
         scaleY = Main.originalStageY / 250;
      }
   }
}

