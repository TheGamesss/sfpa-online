package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3039")]
   public class spaceTear extends MovieClip
   {
      
      public var cat:MovieClip;
      
      public var inTear:MovieClip;
      
      public var pen:MovieClip;
      
      public var ItIs:String = "spaceTear";
      
      public var playing:Boolean;
      
      private var penRL:Number = 0;
      
      private var penUD:Number = 10;
      
      public function spaceTear(p:*)
      {
         super();
         x = p.x;
         y = p.y;
         Backgrounds.backgroundsArray[0].addChild(this);
         staticInteractObjects.InteractEnterFrameArray.push(this);
         staticInteractObjects.HalfInteractEnterFrameArray.push(this);
         stop();
         this.cat.stop();
         if(Main.world4Progress.catIsDown)
         {
            gotoAndStop(176);
         }
      }
      
      public function InteractEnterFrame() : *
      {
         var pickup:PenPickup = null;
         if(this.playing)
         {
            nextFrame();
            if(this.cat.currentFrame > 1 && this.cat.currentFrame != 44)
            {
               this.cat.nextFrame();
            }
            if(this.cat.currentFrameLabel == "2b")
            {
               this.cat.gotoAndStop("2a");
            }
            if(this.cat.currentFrame == 8)
            {
               Sounds.playSoundSimple("JustCat");
            }
            this.HalfInteractEnterFrame();
            if(currentFrame == 168)
            {
               Sounds.playSound("Impact",x - 100,1,0);
            }
            else if(currentFrame == 177)
            {
               if(!Char.hasPen)
               {
                  pickup = staticInteractObjects.findByName("PenPickup");
                  pickup.x = x + this.pen.x;
                  pickup.y = y + this.pen.y;
                  pickup.rotation = this.pen.rotation;
                  pickup.updateCache();
               }
               nextFrame();
            }
         }
      }
      
      public function HalfInteractEnterFrame() : void
      {
         if(currentFrame > 1)
         {
            this.inTear.x = -((x - Main.cameraX) * Main.rootRatios[0] / Main.overRatio) * 0.6;
            this.inTear.y = -((y - Main.cameraY) * Main.rootRatios[0] / Main.overRatio) * 0.6;
            this.inTear.scaleX = this.inTear.scaleY = 1 / parent.scaleX * Main.overRatio;
         }
      }
   }
}

