package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol3725")]
   public class Mayor extends staticInteractObjects
   {
      
      private var disabled:Boolean;
      
      private var Status:uint;
      
      public function Mayor(p:*)
      {
         isWide = 400;
         isTall = 100;
         super("Mayor",p.x,p.y,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         this.Status = p.Status;
         if(this.Status == 0)
         {
            scaleX = -1;
            if(Main.world4Progress.talkToMayor0)
            {
               gotoAndStop("a");
               this.Status = 6;
               this.disabled = true;
            }
            else if(Main.world4Progress.defeatBigBad1)
            {
               gotoAndStop("a");
               Backgrounds.backgroundsArray[0].addChild(this);
               InteractEnterFrameArray.push(this);
               this.Status = 2;
               new aWall({
                  "x":3130,
                  "y":455,
                  "scaleX":2,
                  "scaleY":5.3,
                  "rotation":0,
                  "ID":2,
                  "status":"Gate"
               });
            }
            else
            {
               this.disabled = true;
               visible = false;
               new aWall({
                  "x":3130,
                  "y":455,
                  "scaleX":2,
                  "scaleY":5.3,
                  "rotation":0,
                  "ID":2,
                  "status":"Gate"
               });
               new Baddie1({
                  "x":2270,
                  "y":760,
                  "scaleX":-1,
                  "scaleY":5,
                  "rotation":0,
                  "onRail":0,
                  "tether":800,
                  "onKilled":"removeGate0"
               });
            }
         }
         else
         {
            gotoAndStop("a");
            if(Main.world4Progress.defeatBoss1)
            {
               InteractEnterFrameArray.push(this);
               Backgrounds.backgroundsArray[0].addChild(this);
               inkCollideArray.push(this);
               new aWall({
                  "x":0,
                  "y":-1612,
                  "scaleX":2.362,
                  "scaleY":2.362,
                  "rotation":0,
                  "ID":2,
                  "status":"Breakable"
               });
               new WarpBox({
                  "x":-760,
                  "y":-1850,
                  "scaleX":6.2,
                  "scaleY":3.5,
                  "ItIs":"TriggerBox",
                  "onRail":0,
                  "warpLevel":"cameraShift",
                  "propX":-100,
                  "propY":0,
                  "propZ":30
               });
               new WarpBox({
                  "x":-760,
                  "y":-1850,
                  "scaleX":6.2,
                  "scaleY":3.5,
                  "ItIs":"TriggerBox",
                  "onRail":0,
                  "warpLevel":"MusicSwitch",
                  "propX":0.075,
                  "propY":0,
                  "propZ":0,
                  "stringVar":"Lounge"
               });
               this.disabled = false;
            }
            else
            {
               visible = false;
               new WarpBox({
                  "x":-888,
                  "y":-1950,
                  "scaleX":11.7,
                  "scaleY":4.7,
                  "ItIs":"TriggerBox",
                  "onRail":0,
                  "warpLevel":"throughShift",
                  "propX":40,
                  "propY":-80
               });
               new WarpBox({
                  "x":545,
                  "y":-1950,
                  "scaleX":11.7,
                  "scaleY":4.7,
                  "ItIs":"TriggerBox",
                  "onRail":0,
                  "warpLevel":"throughShift",
                  "propX":-80,
                  "propY":40
               });
               new WarpBox({
                  "x":-2050,
                  "y":-1910,
                  "scaleX":3.26,
                  "scaleY":2.76,
                  "ItIs":"TriggerBox",
                  "onRail":0,
                  "warpLevel":"shoutPopup",
                  "propX":0,
                  "propY":0,
                  "propZ":0,
                  "stringVar":"findSource"
               });
               this.disabled = true;
            }
         }
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         var temp:Object = null;
         if(!this.disabled)
         {
            if(this.Status == 0)
            {
               this.Status = 1;
            }
            else if(this.Status == 3)
            {
               if(char.onGround && char.Status != "PenShowOff")
               {
                  char.gotoBuffer = "PenShowOff";
               }
               if(char.Status == "PenShowOff")
               {
                  this.Status = 4;
               }
            }
            else if(this.Status == 4)
            {
               if(char.Status != "PenShowOff")
               {
                  this.Status = 5;
               }
            }
            else if(this.Status == 5)
            {
               staticInteractObjects.textBubbleArray[1].popupText(char.UpIsDown());
            }
            else if(this.Status == 10)
            {
               if(ex > x + 20)
               {
                  if(staticInteractObjects.textBubbleArray[0].popupText(char.UpIsDown()))
                  {
                     this.Status = 11;
                     rootHUD.HUD.giveShoot();
                     temp = staticInteractObjects.findByUnique(28);
                     if(temp != null)
                     {
                        temp.changeProperties("nothing",2,600);
                     }
                  }
               }
            }
            else if(this.Status == 11)
            {
               if(ex >= x + 20)
               {
                  if(staticInteractObjects.textBubbleArray[0].popupText(char.SpecialIsDown()))
                  {
                     this.Status = 12;
                     char.inkReserve = char.inkMax;
                  }
               }
            }
            else if(this.Status == 12)
            {
               if(char.scaleX * (x - ex) < 0)
               {
                  char.scaleX *= -1;
                  char.head.scaleX = char.scaleX;
               }
               char.gotoBuffer = "Shoot";
               if(char.Status == "Shoot")
               {
                  this.Status = 13;
                  Char.giveShoot();
                  staticInteractObjects.textBubbleArray[0].popupText(false);
                  staticInteractObjects.findByName("fadeInSpurt").disabled = false;
               }
            }
            else if(this.Status == 13)
            {
               if(staticInteractObjects.textBubbleArray[0].popupText(true))
               {
                  this.Status = 14;
               }
            }
            else if(this.Status == 14)
            {
               staticInteractObjects.textBubbleArray[0].popupText(char.UpIsDown());
            }
            else if(this.Status > 1)
            {
               if((ex - x) * scaleX > 0)
               {
                  if(staticInteractObjects.textBubbleArray[0].popupText(char.UpIsDown()))
                  {
                     if(this.Status == 2)
                     {
                        this.Status = 3;
                     }
                  }
               }
            }
         }
      }
      
      public function hitInk(ex:*, ey:*, eRL:*, ink:*) : Boolean
      {
         gotoAndStop(12);
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(this.Status == 1)
         {
            y += 30;
            if(y > anchorY)
            {
               y = anchorY;
               scaleY = 1;
               this.Status = 2;
               isWide = 250;
               updateCache();
            }
         }
         else if(this.Status > 1)
         {
            nextFrame();
            if(currentFrameLabel == "b")
            {
               gotoAndStop("a");
            }
         }
      }
      
      public function mayorArrive() : void
      {
         isWide = 600;
         updateCache();
         y -= 400;
         Backgrounds.backgroundsArray[0].addChild(this);
         InteractEnterFrameArray.push(this);
         this.disabled = false;
         visible = true;
         scaleY = 1.5;
         gotoAndStop(1);
         Sounds.fadeOutMusic("Lounge");
      }
   }
}

