package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol5125")]
   public class bedForCin extends staticInteractObjects
   {
      
      private var disabled:Boolean;
      
      public function bedForCin(p:*)
      {
         isWide = 120;
         isTall = 40;
         super("bedForCin",p.x,p.y,1,1,0);
         Backgrounds.backgroundsArray[0].addChild(this);
         stop();
         visible = false;
      }
   }
}

