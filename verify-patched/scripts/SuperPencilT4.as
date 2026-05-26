package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol328")]
   public class SuperPencilT4 extends staticInteractObjects
   {
      
      public var pencilShell:MovieClip;
      
      public var callBack:Object;
      
      public function SuperPencilT4(p:*)
      {
         super("SuperPencilT4",0,0,1,1,p.onRail,"nothing",-1);
         InteractEnterFrameArray.push(this);
         HalfInteractEnterFrameArray.push(this);
         Backgrounds.backgroundsArray[onRail].addChild(this);
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(currentFrame != totalFrames)
         {
            if(currentFrame == 400)
            {
               if(Char.CharArray[0].x > 6770)
               {
                  gotoAndStop(410);
               }
            }
            else if(currentFrame < 390)
            {
               nextFrame();
               if(currentFrame > 36)
               {
                  this.pencilShell.sparks.scaleX = this.pencilShell.sparks.scaleY = Math.random() + 0.5;
                  this.pencilShell.sparks.rotation = Math.random() * 360;
               }
            }
            else if(currentFrame > 408)
            {
               nextFrame();
               this.pencilShell.sparks.scaleX = this.pencilShell.sparks.scaleY = Math.random() + 0.5;
               this.pencilShell.sparks.rotation = Math.random() * 360;
            }
         }
         switch(currentFrameLabel)
         {
            case "1":
               Main.MaxX += 9000;
               Main.setMaxZ();
               break;
            case "2":
               gotoAndStop(400);
               break;
            case "3":
               gotoAndStop(454);
         }
      }
      
      override public function HalfInteractEnterFrame() : void
      {
         this.InteractEnterFrame();
      }
   }
}

