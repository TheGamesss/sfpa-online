package
{
   public class inkSinkRising extends staticInteractObjects
   {
      
      private var moveUD:Number = 0;
      
      private var currentSmoke:StarlingSmoke;
      
      private var spacing:uint = 60;
      
      private var disabled:Boolean;
      
      private var speedUp:Boolean;
      
      private var stagger:uint;
      
      public function inkSinkRising(p:*)
      {
         isTall = p.scaleY * 50 + 20;
         super(p.ItIs,p.x,p.y,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         visible = false;
         if(p.disabled)
         {
            this.disabled = true;
         }
         var temp:uint = Math.floor(isWide * 2 / this.spacing);
         this.spacing = isWide * 2 / temp;
         for(var i:uint = 0; i < temp; i++)
         {
            new inkBubbleDecalStarling({
               "x":x + this.spacing * 0.5 - isWide + i * this.spacing,
               "y":y - isTall + 20,
               "rotation":0,
               "scaleX":1,
               "scaleY":1,
               "onRail":onRail
            });
         }
         InteractEnterFrameArray.push(this);
         HalfInteractEnterFrameArray.push(this);
         this.currentSmoke = StarlingSmoke.Spawn("blackBlock",x,y,0,scaleX,0,0,onRail);
         this.currentSmoke.scaleY = scaleY;
         this.currentSmoke.textureSmoothing = "none";
         if(p.propX > 0)
         {
            this.moveUD = -2;
         }
         if(p.propY == 0)
         {
            this.speedUp = true;
         }
      }
      
      public function startInk() : void
      {
         this.moveUD = -0.1;
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(char.Status != "Disabled")
         {
            if(char.lastY + char.isTall < y - isTall + 20)
            {
               char.parent.mask = null;
               if(eUD > 5 && ey + char.isTall > y - isTall + 20)
               {
                  Sounds.playSound("FallInInk",x,1,onRail);
                  StarlingEffect.Spawn("inkSplash",ex,y - isTall + 20,0,2,0,0,onRail);
               }
            }
            else if(this.stagger <= 0)
            {
               if(!char.onGround && ey > y - isTall + 60 || char.onGround && ey > y - isTall + 30)
               {
                  this.stagger = 5;
                  char.superHurtChar(30,true,40);
                  if(Char.ActiveCharArray.length == 1)
                  {
                     char.hitPause = 60;
                     Char.CharArray[0].superTumble = true;
                     Main.FadeItOut("Level1",8);
                  }
                  else if(char.health == 0)
                  {
                     char.gotoBuffer = "Dead";
                  }
               }
               else
               {
                  char.setMask(ex,y - isTall + 20,0);
                  char.moveRL -= char.moveRL * 0.05 * Main.framin;
                  char.moveUD -= char.moveUD * 0.1 * Main.framin;
               }
            }
         }
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(this.stagger > 0)
         {
            --this.stagger;
         }
         if(this.moveUD < 0)
         {
            if(this.speedUp)
            {
               this.moveUD = -((anchorY + 500 - y) * 0.002);
            }
            else
            {
               this.moveUD = -2;
            }
            HalfInteractEnterFrames();
         }
      }
      
      override public function HalfInteractEnterFrame() : void
      {
         if(this.moveUD < 0)
         {
            if(y > Char.CharArray[0].y + 700)
            {
               this.moveUD -= (anchorY - Char.CharArray[0].y + 700) * 0.0008;
            }
            y += this.moveUD * framin;
            this.currentSmoke.y = y;
            StarlingDecals.shiftAllDecals(y - isTall + 20);
            updateCache();
         }
      }
   }
}

