package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol5022")]
   public class captAttackLoop extends staticInteractObjects
   {
      
      private var finished:Boolean;
      
      private var b:uint;
      
      private var disabled:Boolean;
      
      public function captAttackLoop(p:*)
      {
         isWide = 120;
         super(p.ItIs,p.x,p.y,1,1,p.onRail,"nothing",-1);
         Backgrounds.backgroundsArray[onRail].addChild(this);
         staticInteractObjects.InteractEnterFrameArray.push(this);
         if(Main.world4Progress.bentPipe0)
         {
            findByUnique(0).changeProperties("nothing",-1,-1,-1,"Lounge");
            gotoAndStop("b");
            this.finished = true;
            isWide = 620;
            updateCache();
         }
         else
         {
            new WarpBox({
               "x":2800,
               "y":-1550,
               "scaleX":2,
               "scaleY":2,
               "ItIs":"TriggerBox",
               "onRail":0,
               "warpLevel":"triggerText",
               "propX":0,
               "propY":0,
               "propZ":0,
               "uniqueID":1
            });
         }
         if(Main.world4Progress.talkToCapt0)
         {
            this.disabled = true;
         }
         else
         {
            new aWall({
               "x":4024,
               "y":-1666,
               "scaleX":2,
               "scaleY":5.3,
               "rotation":0,
               "ID":2,
               "status":"Gate"
            });
         }
         stop();
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(currentFrameLabel == "a")
         {
            if(this.finished)
            {
               gotoAndStop("b");
            }
            else
            {
               gotoAndStop(1);
            }
         }
         else if(currentFrameLabel != "b")
         {
            if(currentFrame > 1)
            {
               nextFrame();
            }
         }
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(Boolean(this.finished) && !this.disabled)
         {
            if(ex > x)
            {
               if(!Main.world4Progress.talkToCapt0)
               {
                  staticInteractObjects.textBubbleArray[1].popupText(char.UpIsDown());
               }
            }
         }
      }
      
      override public function hitBaddie(ex:Number, ey:Number, eRL:Number, eUD:Number, baddie:Baddies) : Boolean
      {
         if(baddie.health > 0)
         {
            if(currentFrame == 1)
            {
               gotoAndStop(2);
            }
            if(currentFrame == 6)
            {
               baddie.health = 0;
               baddie.shakeRL = 20;
               baddie.hitPause = 6;
               baddie.smokeN = 0;
               baddie.smokeB = 20;
               baddie.ChangeFrame("Hit");
               baddie.moveRL = 2 + 6 * Math.random();
               baddie.moveUD = -10 - 6 * Math.random() - 30 / baddie.mass;
               StarlingEffect.Spawn("Splat",ex,ey,Math.random() * 3.14,baddie.scale,0,0,onRail);
               baddie.rotter = 60;
               Sounds.playSound("InkExplode",x,2,0);
               Sounds.playSound("InkSpit",x,1,0);
               Main.shakeScreen(5,0,true);
               StarlingEffect.Spawn("impactEffect",ex,ey,2.5,1,0,0,onRail);
            }
         }
      }
      
      public function finish() : void
      {
         this.finished = true;
         if(currentFrame == 1)
         {
            gotoAndStop("b");
         }
         isWide = 620;
         updateCache();
         Sounds.fadeOutMusic("Lounge",0.05);
         findByUnique(1).x = 5000;
         findByUnique(1).updateCache();
      }
   }
}

