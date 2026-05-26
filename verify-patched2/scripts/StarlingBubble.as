package
{
   public class StarlingBubble extends StarlingEffect
   {
      
      public function StarlingBubble(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, lop:Boolean)
      {
         super(e,ex,ey,rot,scale,eRL,eUD,rail,lop);
      }
      
      override public function effectsEnterFrame() : Boolean
      {
         x += moveRL * Main.framin;
         y += moveUD * Main.framin;
         return nextFrameStep(framin);
      }
   }
}

