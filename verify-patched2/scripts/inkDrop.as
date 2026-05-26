package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol5302")]
   public class inkDrop extends InteractObjects
   {
      
      private var groundY:int;
      
      private var spawner:staticInteractObjects;
      
      public function inkDrop(ex:*, ey:*, rail:*, gY:*, spawn:*)
      {
         super();
         isWide = 2;
         isTall = 10;
         x = ex;
         y = originY = Math.floor(ey);
         onRail = rail;
         this.spawner = spawn;
         BallRes = 0;
         this.groundY = Math.floor(gY);
         Backgrounds.backgroundsArray[rail].addChild(this);
         visible = false;
         stop();
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(char.alpha == 1 && y < this.groundY && visible)
         {
            char.wallRot = 0;
            char.hurtChar(35,20,5,makeOne(ex - x) * 8,20);
            char.downTime = 60;
         }
      }
      
      override public function InteractEnterFrame() : void
      {
         if(visible)
         {
            if(currentFrame == totalFrames)
            {
               visible = false;
            }
            else if(y == this.groundY)
            {
               nextFrame();
            }
            else if(y + moveUD * 0.5 > this.groundY && moveUD > 0)
            {
               gotoAndStop("b");
               moveUD = 0;
               y = this.groundY;
               scaleX *= -1;
               this.spawner.inkLand();
            }
            else if(currentFrameLabel == "loopa")
            {
               gotoAndStop("a");
            }
            else
            {
               moveUD += 0.8;
               if(currentFrame > 21 && moveUD < 0)
               {
                  prevFrame();
               }
               else
               {
                  nextFrame();
                  if(scaleY < 0)
                  {
                     scaleY *= -1;
                  }
               }
            }
         }
         if(moveUD < 5 && currentFrame == 21)
         {
            gotoAndStop(3);
         }
      }
   }
}

