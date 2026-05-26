package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol429")]
   public class inkWaves extends levelDecals
   {
      
      public function inkWaves()
      {
         super();
         isTall = 20;
         isWide = 40;
         Backgrounds.backgroundsArray[0].addChild(this);
         hitChar = hitBaddie = function(ex:*, ey:*, eRL:*, eUD:*, baddie:*):*
         {
         };
         cleanUp = function():*
         {
         };
      }
   }
}

