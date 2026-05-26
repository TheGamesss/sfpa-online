package
{
   import flash.display.SimpleButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol866")]
   public class highScoresButton extends staticInteractObjects
   {
      
      public var highscores:SimpleButton;
      
      public var level:uint;
      
      public function highScoresButton(p:*)
      {
         super("highScoresButton",p.x,p.y,1,1,0,"nothing",-1);
         this.level = p.level;
         Backgrounds.backgroundsArray[0].addChild(this);
      }
   }
}

