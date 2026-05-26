package
{
   public class inkSink extends staticInteractObjects
   {
      
      private var spacing:uint = 60;
      
      public function inkSink(p:*)
      {
         isTall = p.scaleY * 50 + 20;
         super(p.ItIs,p.x,p.y,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         visible = false;
         if(p.disabled)
         {
            disabled = true;
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
            else if(!char.onGround && ey > y - isTall + 60 || char.onGround && ey > y - isTall + 30)
            {
               char.superHurtChar(40,true,0);
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
}

