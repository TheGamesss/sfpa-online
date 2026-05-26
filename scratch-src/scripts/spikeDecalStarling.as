package
{
   public class spikeDecalStarling extends StarlingDecals
   {
      
      private var hurtPointX:int;
      
      private var hurtPointY:int;
      
      private var centerPointX:int;
      
      private var centerPointY:int;
      
      public function spikeDecalStarling(p:*)
      {
         isTall = 50;
         isWide = 50;
         super("spikeDecal",p.x,p.y,p.rotation,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         this.hurtPointX = x + Math.sin(rotation) * (40 * p.scaleY);
         this.hurtPointY = y + -Math.cos(rotation) * (40 * p.scaleY);
         this.centerPointX = x + Math.sin(rotation) * (20 * p.scaleY);
         this.centerPointY = y + -Math.cos(rotation) * (20 * p.scaleY);
         cleanUp = function():*
         {
         };
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : void
      {
         if(char.gotoBuffer != "Hurt" && char.Status != "Hurt")
         {
            if(Math.abs(this.hurtPointX - ex) < char.isWide + 10 && Math.abs(this.hurtPointY - ey) < char.isTall || Math.abs(this.centerPointX - ex) < char.isWide + 10 && Math.abs(this.centerPointY - ey) < char.isTall)
            {
               char.superHurtChar(10,true);
            }
         }
      }
      
      override public function hitBaddie(ex:Number, ey:Number, eRL:Number, eUD:Number, baddie:Baddies) : void
      {
         if((ex - x) * baddie.facing < 0 && Math.abs(this.centerPointX - ex) < baddie.isWide + 40 && Math.abs(this.centerPointY - ey) < baddie.isTall)
         {
            baddie.facing *= -1;
            baddie.scaleX *= -1;
         }
      }
   }
}

