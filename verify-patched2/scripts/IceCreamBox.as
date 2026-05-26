package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4219")]
   public class IceCreamBox extends staticInteractObjects
   {
      
      public var popup:MovieClip;
      
      public var priceText:TextField;
      
      private var moveUD:int;
      
      private var rotOffset:Number;
      
      private var level:uint;
      
      private var max:uint;
      
      private var price:uint;
      
      private var under:Boolean;
      
      public function IceCreamBox(p:*)
      {
         isTall = 200;
         super("IceCreamBox",p.x,p.y,p.scaleX,p.scaleY,p.onRail);
         ID = p.ID;
         this.loadLevel();
         this.price = [20,50,400,600,800,0][ID];
         this.max = [10,6,1,1,1,0][ID];
         Backgrounds.backgroundsArray[p.onRail].addChild(this);
         InteractEnterFrameArray.push(this);
         HalfInteractEnterFrameArray.push(this);
         this.updateAlpha();
         if(this.level >= this.max)
         {
            this.priceText.text = " ---";
         }
         else
         {
            this.priceText.text = this.price * (this.level + 1);
         }
         if(Main.localSettings.language == "English")
         {
            gotoAndStop(ID + 1);
         }
         else if(Main.localSettings.language == "Spanish")
         {
            gotoAndStop(8 + ID);
         }
         else if(Main.localSettings.language == "French")
         {
            gotoAndStop(15 + ID);
         }
         else if(Main.localSettings.language == "Italian")
         {
            gotoAndStop(22 + ID);
         }
         else if(Main.localSettings.language == "Portuguese")
         {
            gotoAndStop(29 + ID);
         }
         else if(Main.localSettings.language == "German")
         {
            gotoAndStop(36 + ID);
         }
         else if(Main.localSettings.language == "Russian")
         {
            gotoAndStop(43 + ID);
         }
         this.popup.gotoAndStop(ID + 1);
         this.popup.alpha = 0;
      }
      
      private static function updateAlphas() : void
      {
         for(var i:uint = 0; i < InteractArray.length; i++)
         {
            if(InteractArray[i].ItIs == "IceCreamBox")
            {
               InteractArray[i].updateAlpha();
            }
         }
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(Math.abs(ex - x) < 50)
         {
            this.under = true;
         }
         if(alpha < 1)
         {
            return false;
         }
         if(Math.abs(ey - y) < 50 + char.isTall)
         {
            if(ey - eUD > y + 50 + char.isTall)
            {
               char.moveUD = 0;
               char.y = y + 50 + char.isTall;
               this.moveUD = -30;
               this.rotOffset = (x - ex) * 0.003;
               char.spendSquiggles(this.price * (this.level + 1));
               new iceCreamPickup(x,y - 50 - 20,(x - ex) * 0.08 + eRL * 0.3,-(14 + 6 * Math.random()),4,ID);
               ++this.level;
               this.saveLevel();
               if(this.level >= this.max)
               {
                  this.priceText.text = " ---";
               }
               else
               {
                  this.priceText.text = this.price * (this.level + 1);
               }
               updateAlphas();
               Achievements.SendScore("icecreamsBought",1);
               this.popup.alpha = 0;
            }
            else if(Math.abs(ex - x) < isWide + char.isWide && Math.abs(ex - eRL - x) > isWide + char.isWide)
            {
               char.moveRL = 0;
               if(ex > x)
               {
                  char.x = x + isWide + char.isWide;
               }
               else
               {
                  char.x = x - isWide - char.isWide;
               }
            }
            return true;
         }
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(y != anchorY)
         {
            if(y < anchorY)
            {
               this.moveUD += 5;
            }
         }
         if(Boolean(this.under) && this.level < this.max && y == anchorY)
         {
            if(this.popup.alpha < 1)
            {
               this.popup.alpha += 0.2;
            }
         }
         else
         {
            this.popup.alpha += -this.popup.alpha * 0.2;
         }
         this.under = false;
      }
      
      override public function HalfInteractEnterFrame() : void
      {
         rotation = (anchorY - y) * this.rotOffset;
         y += this.moveUD * Main.framin;
         if(y > anchorY)
         {
            this.moveUD = 0;
            y = anchorY;
         }
      }
      
      public function updateAlpha() : void
      {
         if(Char.Squiggles < this.price * (this.level + 1))
         {
            alpha = 0.5;
         }
         else if(this.level >= this.max)
         {
            alpha = 0.5;
         }
      }
      
      private function loadLevel() : void
      {
         if(ID == 0)
         {
            this.level = Main.world4Progress.healthLevel;
         }
         else if(ID == 1)
         {
            this.level = Main.world4Progress.powerLevel;
         }
         else if(ID == 2)
         {
            this.level = Main.world4Progress.threeLevel;
         }
         else if(ID == 3)
         {
            this.level = Main.world4Progress.fourLevel;
         }
         else if(ID == 4)
         {
            this.level = Main.world4Progress.fiveLevel;
         }
         else if(ID == 5)
         {
            this.level = Main.world4Progress.sixLevel;
         }
      }
      
      private function saveLevel() : void
      {
         if(ID == 0)
         {
            Main.saveProgress("healthLevel",this.level);
         }
         else if(ID == 1)
         {
            Main.saveProgress("powerLevel",this.level);
         }
         else if(ID == 2)
         {
            Main.saveProgress("threeLevel",this.level);
         }
         else if(ID == 3)
         {
            Main.saveProgress("fourLevel",this.level);
         }
         else if(ID == 4)
         {
            Main.saveProgress("fiveLevel",this.level);
         }
         else if(ID == 5)
         {
            Main.saveProgress("sixLevel",this.level);
         }
      }
   }
}

