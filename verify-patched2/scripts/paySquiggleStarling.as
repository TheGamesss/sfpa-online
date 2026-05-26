package
{
   public class paySquiggleStarling extends StarlingInteract
   {
      
      public function paySquiggleStarling(e:*, ex:*, ey:*, rot:*, scale:*, eRL:*, eUD:*, rail:*, id:int = -1)
      {
         super(e,ex,ey,rot,scale,eRL,eUD,rail,id);
      }
      
      override public function interactsEnterFrame() : Boolean
      {
         moveUD -= 2;
         this.halfEnterFrame();
      }
      
      override public function halfEnterFrame() : Boolean
      {
         x += moveRL * framin;
         y += moveUD * framin;
         rotation -= 1 * framin;
         return y < -400;
      }
      
      override public function reset() : void
      {
         halfArray.push(this);
      }
   }
}

