package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol332")]
   public class ShipAndBaddie extends MovieClip
   {
      
      public var onRail:uint;
      
      public var ItIs:String = "cutieBob";
      
      public function ShipAndBaddie(p:*)
      {
         super();
         x = p.x;
         y = p.y;
         this.onRail = p.onRail;
         Backgrounds.backgroundsArray[this.onRail].addChild(this);
         staticInteractObjects.InteractEnterFrameArray.push(this);
         staticInteractObjects.HalfInteractEnterFrameArray.push(this);
      }
      
      public function InteractEnterFrame() : *
      {
      }
      
      public function HalfInteractEnterFrame() : void
      {
         x -= 8;
      }
   }
}

