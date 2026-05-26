package
{
   public class inkSpoutStarling extends StarlingInteract
   {
      
      public function inkSpoutStarling(e:*, ex:*, ey:*, rot:*, scale:*, eRL:*, eUD:*, rail:*, id:int = -1)
      {
         isWide = 40;
         isTall = 10;
         super(e,ex,ey,rot,scale,eRL,eUD,rail,id);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         char.updateInk(20);
      }
      
      override public function interactsEnterFrame() : Boolean
      {
         ++currentFrame;
         if(currentFrame > 36)
         {
            currentFrame = 1;
         }
      }
   }
}

