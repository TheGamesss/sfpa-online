package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol788")]
   public class PirateStuck3 extends PirateStuck1
   {
      
      public function PirateStuck3(p:*)
      {
         super(p);
      }
      
      override public function buildThatWall() : void
      {
         new aWall({
            "x":5577,
            "y":588,
            "scaleX":1.18,
            "scaleY":3.12,
            "rotation":0,
            "ID":2,
            "status":"Gate"
         });
      }
   }
}

