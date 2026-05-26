package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5341")]
   public class shadowFire extends MovieClip
   {
      
      private var moveRL:Number;
      
      private var moveUD:Number;
      
      public var onRail:int;
      
      public function shadowFire(ex:*, ey:*, eRL:*, eUD:*, char:*)
      {
         var tempX:Number = NaN;
         super();
         char.parent.addChild(this);
         staticInteractObjects.InteractEnterFrameArray.push(this);
         staticInteractObjects.HalfInteractEnterFrameArray.push(this);
         tempX = Math.random() * 10 - 5;
         x = ex + tempX;
         y = ey + Math.random() * 6 - 3;
         rotation = -Math.atan2(eRL,eUD + 2) / (Math.PI / 180);
         scaleX = scaleY = 0.2 + Math.random() * 1;
         if(Math.random() > 0.5)
         {
            scaleX *= -1;
         }
         scaleY += char.nowSpeed() * 0.05;
         this.moveRL = -tempX * 0.15;
         this.moveUD = -(Math.random() * 3) + 0.1;
         gotoAndStop(Math.round(char.nowSpeed() * 0.4));
      }
      
      public function InteractEnterFrame() : *
      {
         x += this.moveRL * Main.framin;
         y += this.moveUD * Main.framin;
         if(currentFrame == totalFrames)
         {
            staticInteractObjects.killInteract.push(this);
         }
         else
         {
            nextFrame();
         }
      }
      
      public function HalfInteractEnterFrame() : *
      {
         x += this.moveRL * Main.framin;
         y += this.moveUD * Main.framin;
      }
      
      public function hitChar() : *
      {
      }
   }
}

