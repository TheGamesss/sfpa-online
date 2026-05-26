package
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol862")]
   public class upgradePanel extends Sprite
   {
      
      public var healthText:TextField;
      
      public var powerText:TextField;
      
      private var b:uint = 20;
      
      public var spring:Number = 0;
      
      public function upgradePanel()
      {
         super();
         this.updateHealthText(Char.CharArray[0].healthMax / 100);
         this.updatePowerText(Char.CharArray[0].power);
      }
      
      public function elementEnterFrame() : *
      {
         scaleX += this.spring;
         scaleY = scaleX;
         this.spring += (1 - scaleX) * 0.1;
         this.spring *= 0.5;
         if(this.b > 0)
         {
            --this.b;
         }
         else if(Char.CharArray[0].x > 320 || Char.CharArray[0].moveUD < -20)
         {
            y += (-100 - y) * 0.2;
         }
         else
         {
            y += (80 - y) * 0.2;
         }
      }
      
      public function updateHealthText(e:String) : void
      {
         this.spring = 0.1;
         if(e.indexOf(".") == -1)
         {
            e += ".0";
         }
         this.healthText.text = "x" + e;
      }
      
      public function updatePowerText(e:String) : void
      {
         this.spring = 0.1;
         if(e.indexOf(".") == -1)
         {
            e += ".0";
         }
         this.powerText.text = "x" + e;
      }
   }
}

