package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1169")]
   public class popupMessage extends MovieClip
   {
      
      public var smoke:TextField;
      
      public var anchorY:int = 450;
      
      private var lifetime:uint;
      
      private var rootlife:uint = 90;
      
      private var moveRL:Number = 0;
      
      private var moveUD:Number = 0;
      
      public function popupMessage(e:*)
      {
         super();
         x = 690;
         y = 570;
         this.lifetime = (rootHUD.popupsArray.length + 1) * 10 + this.rootlife;
         this.smoke.text = e;
      }
      
      public function popupEnterFrame() : *
      {
         if(this.lifetime > 0)
         {
            --this.lifetime;
            this.moveUD = (this.anchorY - y) * 0.4;
            if(this.moveUD < -10)
            {
               y -= 10;
            }
            else
            {
               y += this.moveUD;
            }
            if(y == 540)
            {
               for(i = 0; i < rootHUD.popupsArray.length - 1; ++i)
               {
                  rootHUD.popupsArray[i].lifetime = (i + 1) * 10 + this.rootlife;
                  rootHUD.popupsArray[i].anchorY -= this.rootlife;
               }
            }
         }
         else if(x < 900)
         {
            this.moveRL += 2;
            x += this.moveRL;
         }
         else
         {
            rootHUD.popupsArray.splice(rootHUD.popupsArray.indexOf(this),1);
            parent.removeChild(this);
         }
      }
   }
}

