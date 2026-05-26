package
{
   import flash.display.Sprite;
   
   public class BackgroundObjects extends Sprite
   {
      
      public static var originalStageX:int;
      
      public static var originalStageY:int;
      
      public static var cameraFocalLength:int = 200;
      
      public static var backgroundObjectssArray:* = new Array();
      
      public function BackgroundObjects()
      {
         super();
      }
      
      public static function scrollBackgroundObjects(cameraX:*, cameraY:*, cameraZ:*) : *
      {
         var ratio:Number = NaN;
         for(var i:int = 0; i < backgroundObjectssArray.length; i++)
         {
            ratio = cameraFocalLength / (cameraFocalLength + backgroundObjectssArray[i].theZ - cameraZ) * Main.overRatio;
            if(ratio > 0)
            {
               backgroundObjectssArray[i].visible = true;
               backgroundObjectssArray[i].x = (backgroundObjectssArray[i].theX - cameraX) * ratio + originalStageX;
               backgroundObjectssArray[i].y = (backgroundObjectssArray[i].theY - cameraY) * ratio + originalStageY;
               backgroundObjectssArray[i].scaleX = backgroundObjectssArray[i].scaleY = ratio;
            }
            else
            {
               backgroundObjectssArray[i].visible = false;
            }
         }
      }
      
      public static function addObject(e:*, ez:*) : *
      {
         e.theX = e.x;
         e.theY = e.y;
         e.theZ = ez;
         backgroundObjectssArray.push(e);
      }
      
      private function objectEnterFrame() : *
      {
      }
   }
}

