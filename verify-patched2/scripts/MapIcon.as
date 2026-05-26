package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3730")]
   public class MapIcon extends staticInteractObjects
   {
      
      public var jump:MovieClip;
      
      private var disabled:Boolean;
      
      private var spring:Number;
      
      private var b:uint;
      
      private var select:int = -1;
      
      public function MapIcon(p:*)
      {
         isWide = 20;
         isTall = 20;
         alpha = 0.8;
         this.b = 120;
         if(p.select != null)
         {
            this.select = p.select;
         }
         super("MapIcon",p.x,p.y,1,1,p.onRail);
         if(Main.world4Progress.canMapAround)
         {
            this.patch();
         }
         else
         {
            this.disabled = true;
         }
         this.jump.upgrades.visible = false;
      }
      
      public function get getDisabled() : Boolean
      {
         return this.disabled;
      }
      
      public function patch() : void
      {
         this.disabled = false;
         InteractEnterFrameArray.push(this);
         Backgrounds.backgroundsArray[onRail].addChild(this);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(!this.disabled)
         {
            this.disabled = true;
            this.spring = 0.2;
            this.jump.y = 0;
            Sounds.playSoundSimple("Pause");
         }
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(this.disabled)
         {
            if(scaleX + this.spring > 0)
            {
               scaleX += this.spring;
               this.spring += -scaleX * 0.05;
            }
            else if(!(scaleX == 0 && this.spring == 0))
            {
               this.spring = scaleX = scaleY = 0;
               Main.FadeItOut("MapScreen",this.select);
            }
            scaleY = scaleX;
         }
         else
         {
            if(this.b > 0)
            {
               --this.b;
            }
            else
            {
               this.b = 90;
            }
            if(this.b == 8 || this.b == 20)
            {
               this.spring = -10;
            }
            this.spring += 1.5;
            this.jump.y += this.spring;
            if(this.jump.y > 0)
            {
               this.jump.y = 0;
               this.spring = 0;
            }
         }
      }
   }
}

