package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol4047")]
   public class iceCreamPickup extends InteractObjects
   {
      
      private static var first:Boolean = true;
      
      private var ID:uint;
      
      public function iceCreamPickup(ex:Number, ey:Number, eRL:Number, eUD:Number, rail:uint, id:uint)
      {
         super(rail);
         rotter = eRL * 2;
         rotation = 360 * Math.random();
         x = ex;
         y = ey;
         moveRL = eRL + 1 - Math.random() * 2;
         moveUD = eUD;
         ItIs = "iceCreamPickup";
         downTime = 5;
         this.ID = id;
         ground = Main.AllEverything["ground" + rail];
         platforms = Main.AllEverything["platforms" + rail];
         walls = Main.AllEverything["walls" + rail];
         BallRes = 4;
         isTall = isWide = 20;
         bounce = 0.5;
         bounceThresh = 2;
         rotPerc = 360 / (Math.PI * (isTall * 2));
         overReach = 4;
         mass = 10;
         Backgrounds.backgroundsArray[rail].addChild(this);
         Status = "Jump";
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         StarlingEffect.Spawn("SquigPop",x,y,Math.random() * 3,1,eRL * 0.25,eUD * 0.25,onRail);
         Sounds.playSoundSimple("success");
         this.updateStats(char);
      }
      
      public function updateStats(char:*) : void
      {
         if(this.ID == 0)
         {
            char.updateMaxHealth();
         }
         else if(this.ID == 1)
         {
            char.updatePower();
         }
         else if(this.ID == 2)
         {
            char.unlockBuzzSaw();
         }
         else if(this.ID == 3)
         {
            char.unlockPokeDown();
         }
         else if(this.ID == 4)
         {
            char.unlockRising();
         }
         if(first)
         {
            Achievements.unlock("First_Ice_Cream");
            first = false;
         }
         killInteract.push(this);
      }
      
      override public function InteractEnterFrame() : void
      {
         if(onGround)
         {
            if(Math.abs(moveRL) > 0.5)
            {
               moveRL -= moveRL / Math.abs(moveRL) * 0.5;
            }
            else
            {
               moveRL = 0;
            }
            rotter += (-rotation * 0.5 - rotter) * 0.5;
         }
         else if(moveUD < 20)
         {
            ++moveUD;
         }
      }
   }
}

