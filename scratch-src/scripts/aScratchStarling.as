package
{
   public class aScratchStarling extends StarlingInteract
   {
      
      private var fakeX:Number = 0;
      
      private var fakeRL:Number = 0;
      
      private var fakeDist:Number = 0;
      
      private var RLx:Number = 0;
      
      private var RLy:Number = 0;
      
      private var wallAngle:Number = 0;
      
      private var originX:Number = 0;
      
      private var originY:Number = 0;
      
      private var distX:Number = 0;
      
      private var distY:Number = 0;
      
      public function aScratchStarling(e:*, ex:*, ey:*, rot:*, scale:*, eRL:*, eUD:*, rail:*, id:int = -1)
      {
         isTall = 15;
         isWide = 15;
         super(e,ex,ey,rot,scale,eRL,eUD,rail,id);
      }
      
      override public function reset() : void
      {
         this.RLx = Math.sin(rotation + 1.57);
         this.RLy = -Math.cos(rotation + 1.57);
         rotation = Math.random() * 3;
         currentFrame = uint(Math.random() * 20) + 1;
         this.originX = x;
         this.originY = y;
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         this.distX = ex - x;
         this.distY = ey - y;
         if(Math.abs(this.distX) < isWide + char.isWide && Math.abs(this.distY) < isTall + char.isTall)
         {
            char.superHurtChar(20,true);
            if(Math.abs(this.distX) > Math.abs(this.distY) * 0.6)
            {
               char.x = x + (char.isWide + isWide) * makeOne(this.distX);
               if(char.moveRL * this.distX < 0)
               {
                  trace("stop");
                  char.moveRL = char.fakeRL = 0;
               }
            }
            else
            {
               char.y = y + (char.isTall + isTall) * makeOne(this.distY);
               if(char.moveUD * this.distY < 0)
               {
                  char.moveUD = 0;
               }
            }
         }
      }
      
      override public function interactsEnterFrame() : Boolean
      {
         if(currentFrame == 26)
         {
            currentFrame = 1;
         }
         else
         {
            ++currentFrame;
         }
         if(Math.abs(this.fakeX) > this.fakeDist)
         {
            this.fakeRL -= (this.fakeX - this.fakeDist * this.fakeX / Math.abs(this.fakeX)) / bounce;
         }
         this.fakeX += this.fakeRL;
         moveRL = this.RLx * this.fakeRL;
         moveUD = this.RLy * this.fakeRL;
         x = this.originX + this.RLx * this.fakeX;
         y = this.originY + this.RLy * this.fakeX;
      }
   }
}

