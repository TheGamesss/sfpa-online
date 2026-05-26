package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol3734")]
   public class kingAndMayor extends staticInteractObjects
   {
      
      public function kingAndMayor(p:*)
      {
         super("kingAndMayor",p.x,p.y,1,1,3,"nothing",-1);
         if(!Main.world4Progress.defeatBigBad1)
         {
            StarlingTemporary.Spawn("kingAndMayor",x,y,0,1,4,false);
            new WarpBox({
               "x":-915,
               "y":440,
               "scaleX":27.4,
               "scaleY":4.44,
               "ItIs":"TriggerBox",
               "onRail":2,
               "warpLevel":"triggerText",
               "propX":0,
               "propY":1,
               "propZ":0
            });
         }
      }
   }
}

