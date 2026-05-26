package
{
   public class superMask extends staticInteractObjects
   {
      
      private var tempForce:Boolean;
      
      public function superMask(p:*)
      {
         isWide = p.scaleX * 50 + 50;
         isTall = p.scaleY * 50 + 60;
         super("superMask",p.x,p.y,p.scaleX,p.scaleY,0);
         Backgrounds.backgroundsArray[onRail].addChild(this);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(Math.abs(ex - x) > isWide - 30 || Math.abs(ey - y) > isTall - 30)
         {
            char.toggleForceBitmap(false);
         }
         else
         {
            char.toggleForceBitmap(true);
         }
      }
   }
}

