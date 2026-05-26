package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol4297")]
   public class fadeInSpurt extends staticInteractObjects
   {
      
      private var spring:Number = 0;
      
      private var hitting:Boolean;
      
      public var disabled:Boolean = true;
      
      public function fadeInSpurt(p:*)
      {
         isWide = 300;
         isTall = 200;
         super("fadeInSpurt",p.x,p.y,p.scaleX,p.scaleY,p.onRail);
         Backgrounds.backgroundsArray[p.onRail].addChild(this);
         InteractEnterFrameArray.push(this);
         this.disabled = !Char.hasShoot;
         gotoAndStop(Main.localSettings.language);
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(this.hitting)
         {
            this.spring = (1 - alpha) * 0.1;
         }
         else
         {
            this.spring = -0.2;
         }
         alpha += this.spring;
         if(alpha < 0)
         {
            alpha = 0;
         }
         else if(alpha > 1)
         {
            alpha = 1;
         }
         this.hitting = false;
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(!this.disabled)
         {
            this.hitting = true;
         }
      }
   }
}

