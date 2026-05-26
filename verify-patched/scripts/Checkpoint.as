package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol4967")]
   public class Checkpoint extends staticInteractObjects
   {
      
      private static var checkpointArray:Vector.<Checkpoint> = new Vector.<Checkpoint>(0);
      
      private static var currentCheckpoint:int = -1;
      
      private static var currentScaleX:int = 1;
      
      public function Checkpoint(p:*)
      {
         super("Checkpoint",p.x,p.y,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         ID = checkpointArray.length;
         checkpointArray.push(this);
      }
      
      public static function getcurrentCheckpoint() : int
      {
         return currentCheckpoint;
      }
      
      public static function resetCurrent() : void
      {
         currentCheckpoint = -1;
      }
      
      public static function checkpointX() : int
      {
         return checkpointArray[currentCheckpoint].x;
      }
      
      public static function checkpointY() : int
      {
         return checkpointArray[currentCheckpoint].y + checkpointArray[currentCheckpoint].isTall;
      }
      
      public static function checkpointRail() : uint
      {
         return checkpointArray[currentCheckpoint].onRail;
      }
      
      public static function checkpointScaleX() : int
      {
         return currentScaleX / Math.abs(currentScaleX);
      }
      
      public static function resetCheckpoints() : void
      {
         checkpointArray = new Vector.<Checkpoint>(0);
         currentCheckpoint = -1;
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(currentCheckpoint != ID)
         {
            currentCheckpoint = ID;
         }
         if(Math.abs(eRL) > 1)
         {
            currentScaleX = eRL;
         }
      }
   }
}

