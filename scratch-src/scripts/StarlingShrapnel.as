package
{
   public class StarlingShrapnel extends StarlingEffect
   {
      
      private var rotter:Number;
      
      public function StarlingShrapnel(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, lop:Boolean)
      {
         super(e,ex,ey,rot,scale,eRL,eUD,rail,lop);
      }
      
      override public function effectsEnterFrame() : Boolean
      {
         moveUD += 1.5 * framin;
         rotation += this.rotter * (Math.PI / 180) * framin;
         x += moveRL * framin;
         y += moveUD * framin;
         return y > Main.MaxY / Main.stageRatios[onRail] + 400;
      }
      
      override public function setupEffect() : void
      {
         this.rotter = Math.sqrt(moveRL * moveRL + moveUD * moveUD) * (Math.random() * 0.5 + 0.5) * moveRL / Math.abs(moveRL);
      }
   }
}

