package
{
   import starling.display.Sprite;
   
   public class ScrollingObject extends Sprite
   {
      
      public var theX:int;
      
      public var theY:int;
      
      public var theZ:int;
      
      public function ScrollingObject(ex:*, ey:*, ez:*)
      {
         super();
         this.theX = ex;
         this.theY = ey;
         this.theZ = ez;
      }
   }
}

