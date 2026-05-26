package
{
   import flash.display.SimpleButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol869")]
   public class buttonMiniClip extends staticInteractObjects
   {
      
      public var MiniClip:SimpleButton;
      
      public function buttonMiniClip(p:*)
      {
         super("buttonMiniClip",p.x,p.y,1,1,0,"nothing",-1);
         Backgrounds.backgroundsArray[0].addChild(this);
      }
   }
}

