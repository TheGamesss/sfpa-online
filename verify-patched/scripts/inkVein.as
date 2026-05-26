package
{
   import flash.media.SoundChannel;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3871")]
   public class inkVein extends staticInteractObjects
   {
      
      private var currentSound:SoundChannel;
      
      public function inkVein(p:*)
      {
         super("inkVein",p.x,p.y,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         Backgrounds.backgroundsArray[0].addChild(this);
         isWide = 400;
         isTall = 50;
         stop();
         InteractEnterFrameArray.push(this);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         char.fakeX = x - 60;
         if(char.Status != "PenUpgradeStab" && char.onGround)
         {
            char.gotoBuffer = "PenUpgradeStab";
         }
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(currentFrame > 1 && currentFrameLabel != "b")
         {
            Sounds.updateSound(this.currentSound,x,1,onRail);
            nextFrame();
         }
         if(currentFrameLabel == "a")
         {
            gotoAndStop("d");
         }
      }
      
      public function start() : void
      {
         nextFrame();
         this.currentSound = Sounds.playSoundContinuous("InkVeinLoop",x,1,onRail);
      }
      
      public function finishSound() : void
      {
         Sounds.stopSound(this.currentSound);
      }
   }
}

