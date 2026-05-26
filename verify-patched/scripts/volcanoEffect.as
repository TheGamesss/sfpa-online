package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol264")]
   public class volcanoEffect extends staticInteractObjects
   {
      
      private var triggered:Boolean;
      
      private var from:WarpBox;
      
      public function volcanoEffect(ex:*, ey:*, esx:*, esy:*, f:*)
      {
         super("volcanoEffect",ex,ey,esx,esy,3,"nothing",-1);
         InteractEnterFrameArray.push(this);
         this.from = f;
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(currentFrame == totalFrames)
         {
            this.from.changeProperties("dropBaddie",1,5,10);
            Char.CharArray[0].maxRL = 20;
            rootHUD.HUD.shoutTheBox("RUN");
            Sounds.fadeOutMusic("Volcano_Slow",0.005,"crossFade",0.75);
            killInteract.push(this);
         }
         else
         {
            nextFrame();
            x = StarlingBackgrounds.volcanoBackground.x;
            y = StarlingBackgrounds.volcanoBackground.y;
            scaleX = scaleY = StarlingBackgrounds.volcanoBackground.scaleX;
         }
      }
   }
}

