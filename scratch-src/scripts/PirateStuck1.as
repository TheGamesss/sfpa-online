package
{
   import flash.media.SoundChannel;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol826")]
   public class PirateStuck1 extends staticInteractObjects
   {
      
      private var shakeN:uint = 10;
      
      private var shakeRL:Number = 2;
      
      private var stuck:Boolean = true;
      
      private var dance:Boolean;
      
      private var disabled:Boolean;
      
      private var currentSound:SoundChannel;
      
      public function PirateStuck1(p:*)
      {
         isTall = 200;
         isWide = 600;
         ID = p.ID;
         super(p.ItIs,p.x,p.y,1,1,p.onRail,"nothing",-1);
         Backgrounds.backgroundsArray[onRail].addChild(this);
         staticInteractObjects.InteractEnterFrameArray.push(this);
         if(Main.world4Progress["bentPipe" + ID])
         {
            this.dance = true;
            gotoAndStop(2);
            findByUnique(0).changeProperties("nothing",-1,-1,-1,"Wind_Cave");
            this.disabled = true;
         }
         else
         {
            this.buildThatWall();
            gotoAndStop(1);
         }
      }
      
      public function buildThatWall() : void
      {
         new aWall({
            "x":3866,
            "y":-1390,
            "scaleX":2,
            "scaleY":5.3,
            "rotation":0,
            "ID":2,
            "status":"Gate"
         });
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(this.dance)
         {
            nextFrame();
            if(currentFrameLabel == "a")
            {
               gotoAndStop(2);
            }
         }
         else if(this.stuck)
         {
            if(this.shakeN > 0)
            {
               --this.shakeN;
               if(this.shakeN < 10)
               {
                  x = anchorX + this.shakeRL;
                  this.shakeRL *= -1;
               }
            }
            else
            {
               this.shakeN = 20 + Math.random() * 40;
            }
         }
         else if(this.shakeN < 60)
         {
            ++this.shakeN;
            this.shakeRL *= -1;
            this.shakeRL += this.shakeRL / Math.abs(this.shakeRL) * 0.3;
            x = anchorX + this.shakeRL;
            Main.shakeScreen(this.shakeN * 0.2,0,true);
            Sounds.updateSound(this.currentSound,x,this.shakeN * 0.1,onRail);
         }
         else
         {
            x = anchorX;
            StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,1.5,0,0,onRail);
            gotoAndStop(2);
            Main.shakeScreen(60,0,true);
            this.dance = true;
            Sounds.fadeOutMusic("Lounge",0.2);
            Sounds.playSound("InkExplode",x,2,onRail);
            Sounds.stopSound(this.currentSound);
         }
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(Boolean(this.dance) && !this.disabled)
         {
            if(!staticInteractObjects.textBubbleArray[0].popupText(char.UpIsDown()))
            {
            }
         }
      }
      
      public function finish() : void
      {
         this.stuck = false;
         this.shakeN = 0;
         this.shakeRL = 0.1;
         this.currentSound = Sounds.playSoundContinuous("LowRumble",x,0,onRail);
         findByUnique(0).changeProperties("nothing",0.02,-1,-1,"Wind_Cave");
         Sounds.fadeOutMusic("Wind_Cave",0.05);
      }
   }
}

