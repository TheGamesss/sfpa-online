package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol385")]
   public class Level6Overlord extends MovieClip
   {
      
      public var pencilShell:MovieClip;
      
      public var callBack:Object;
      
      private var step:uint = 0;
      
      private var dist:int;
      
      public function Level6Overlord()
      {
         super();
         staticInteractObjects.InteractEnterFrameArray.push(this);
         stop();
      }
      
      public function InteractEnterFrame() : *
      {
         switch(this.step)
         {
            case 0:
               this.dist = Char.checkClosest(2725,-730,0);
               if(this.dist < 1000 && this.dist > 0)
               {
                  ++this.step;
               }
               break;
            case 1:
               nextFrame();
               if(currentFrameLabel == "1")
               {
                  ++this.step;
               }
               break;
            case 2:
               this.dist = Char.checkClosest(3170,-730,0);
               if(this.dist < 1000 && this.dist > 0)
               {
                  ++this.step;
               }
               break;
            case 3:
               nextFrame();
               if(currentFrameLabel == "2")
               {
                  ++this.step;
               }
               break;
            case 4:
               this.dist = Char.checkClosest(3532,-730,0);
               if(this.dist < 1000 && this.dist > 0)
               {
                  ++this.step;
               }
               break;
            case 5:
               nextFrame();
               if(currentFrameLabel == "3")
               {
                  this.pencilShell.sparks.stop();
                  this.pencilShell.sparks.visible = false;
                  ++this.step;
               }
               break;
            case 6:
               nextFrame();
               if(currentFrameLabel == "4")
               {
                  gotoAndStop("loop");
               }
         }
      }
   }
}

