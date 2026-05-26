package
{
   public class spikeBarDecalStarling extends StarlingDecals
   {
      
      private var rotter:Number = 0;
      
      public function spikeBarDecalStarling(p:*)
      {
         isTall = p.scaleY * 100;
         isWide = p.scaleY * 100;
         super("spikeBarDecal",p.x,p.y,p.rotation,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         this.rotter = p.rotter;
         cleanUp = function():*
         {
         };
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : void
      {
         if(char.gotoBuffer != "Hurt" && char.Status != "Hurt")
         {
            ax = Math.cos(rotation) * (x - ex) + Math.sin(rotation) * (y - ey);
            ay = Math.cos(rotation) * (y - ey) - Math.sin(rotation) * (x - ex);
            if(Math.abs(ax) < char.isTall + 10 && Math.abs(ay) < isTall + char.isTall)
            {
               char.superHurtChar(10,true);
            }
         }
      }
      
      override public function hitBaddie(ex:Number, ey:Number, eRL:Number, eUD:Number, baddie:Baddies) : void
      {
         this.hitChar(ex,ey,eRL,eUD,baddie);
      }
      
      override public function decalEnterFrame() : void
      {
         rotation += this.rotter * framin;
      }
   }
}

