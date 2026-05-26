package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol3942")]
   public class inkSpout extends staticInteractObjects
   {
      
      public function inkSpout(p:*)
      {
         isWide = 40;
         isTall = 10;
         super("inkSpout",p.x,p.y,p.scaleX,p.scaleY,0,"nothing",-1);
         Backgrounds.backgroundsArray[0].addChild(this);
         stop();
         InteractEnterFrameArray.push(this);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         char.updateInk(2);
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         nextFrame();
         if(currentFrameLabel == "a")
         {
            gotoAndStop(1);
         }
      }
   }
}

