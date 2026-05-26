package
{
   public class SquiggleStarling extends StarlingInteract
   {
      
      public function SquiggleStarling(e:*, ex:*, ey:*, rot:*, scale:*, eRL:*, eUD:*, rail:*, id:int = -1)
      {
         super(e,ex,ey,rot,scale,eRL,eUD,rail,id);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(onRail < backgroundsN)
         {
            dontCheat[Main.LevelLoaded][ID] = true;
         }
         else
         {
            dontCheat[Main.LevelLoaded + "_" + onRail][ID] = true;
         }
         ++char.squiggleBuffer;
         char.squiggleBuffer > 0 && StarlingEffect.Spawn("SquigPop",x,y,Math.random() * 3,1,eRL * 0.25,eUD * 0.25,onRail);
         return true;
      }
   }
}

