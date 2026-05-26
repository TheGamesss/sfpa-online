package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol812")]
   public class PirateStuck2 extends PirateStuck1
   {
      
      public function PirateStuck2(p:*)
      {
         super(p);
      }
      
      override public function buildThatWall() : void
      {
         new aWall({
            "x":4000,
            "y":1082,
            "scaleX":1.18,
            "scaleY":3.12,
            "rotation":0,
            "ID":2,
            "status":"Gate"
         });
      }
   }
}

