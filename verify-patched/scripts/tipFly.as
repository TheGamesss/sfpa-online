package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5674")]
   public class tipFly extends MovieClip
   {
      
      private var moveRL:Number;
      
      private var moveUD:Number;
      
      private var rotter:Number;
      
      public var b:int = 100;
      
      public function tipFly(ex:*, ey:*, eRL:*, eUD:*, rot:*, char:*)
      {
         super();
         char.parent.addChild(this);
         staticInteractObjects.InteractEnterFrameArray.push(this);
         staticInteractObjects.HalfInteractEnterFrameArray.push(this);
         x = ex;
         y = ey;
         this.moveRL = eRL;
         this.moveUD = eUD;
         this.rotter = rot;
         stop();
      }
      
      public function InteractEnterFrame() : *
      {
         ++this.moveUD;
         x += this.moveRL * Main.framin;
         y += this.moveUD * Main.framin;
         rotation += this.rotter * Main.framin;
         if(this.b > 0)
         {
            --this.b;
         }
         else
         {
            staticInteractObjects.InteractEnterFrameArray.splice(staticInteractObjects.InteractEnterFrameArray.indexOf(this),1);
            staticInteractObjects.HalfInteractEnterFrameArray.splice(staticInteractObjects.HalfInteractEnterFrameArray.indexOf(this),1);
            this.parent.removeChild(this);
         }
      }
      
      public function HalfInteractEnterFrame() : *
      {
         x += this.moveRL * Main.framin;
         y += this.moveUD * Main.framin;
         rotation += this.rotter * Main.framin;
      }
      
      public function hitChar() : *
      {
      }
   }
}

