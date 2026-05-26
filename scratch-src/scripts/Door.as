package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4427")]
   public class Door extends staticInteractObjects
   {
      
      public var icon:MovieClip;
      
      public var vanish:Boolean;
      
      public var quickDrop:Boolean;
      
      public var delay:int;
      
      private var myText:Object;
      
      private var disabled:Boolean;
      
      private var finishDoor:Boolean;
      
      public var jumper:int = 0;
      
      public var tumble:Boolean;
      
      public var startDisabled:Boolean;
      
      public var waitN:int = -1;
      
      private var doorStamp:StarlingSmoke;
      
      private var doorPrompt:StarlingSmoke;
      
      private var charsFinished:Vector.<Char>;
      
      public function Door(p:*)
      {
         var i:String = null;
         var tempString:String = null;
         this.charsFinished = new Vector.<Char>();
         for(i in p)
         {
            if(i != "componentInspectorSetting")
            {
               this[i] = p[i];
            }
         }
         isTall = 50;
         isWide = 35;
         super("Door",p.x,p.y,p.scaleX,1,p.onRail,"nothing",-1);
         if(onRail < Main.backgroundsN)
         {
            DoorArray[ID] = this;
         }
         Backgrounds.backgroundsArray[onRail].addChild(this);
         if(Main.LevelStatus != "Normal" && Main.LevelStatus != "Smash")
         {
            if(ID == 0)
            {
               this.icon.visible = false;
               this.quickDrop = true;
               gotoAndStop("gone");
            }
            else if(warpLevel == "finish" || warpLevel.substr(0,5) == "Trans" || warpLevel == "Level6")
            {
               gotoAndStop("finish");
            }
            else
            {
               gotoAndStop("gone");
            }
         }
         else if(this.vanish)
         {
            gotoAndStop("gone");
         }
         else if(Main.cleanForBrand && warpLevel.substr(0,5) == "Lockd")
         {
            gotoAndStop("gone");
         }
         else if(warpLevel == "Menus1" && Main.localSettings.W1RProgress == 0)
         {
            gotoAndStop("disabled");
         }
         else if(warpLevel == "Menus3" && Main.localSettings.W1RProgress < 2)
         {
            gotoAndStop("disabled");
         }
         else if(Main.LoadIt == "Menus1" && warpLevel.substr(0,5) == "Level" && Number(warpLevel.substr(5,1)) > Main.localSettings.W1RProgress)
         {
            gotoAndStop("disabled");
         }
         else if(Main.LoadIt == "Menus3" && warpLevel.substr(0,5) == "Level")
         {
            if(Number(warpLevel.substr(5,1)) >= Main.localSettings.W1RProgress)
            {
               gotoAndStop("disabled");
            }
            else
            {
               this.myText = new DoorText();
               addChild(this.myText);
               if(Main.localScores[warpLevel + "_Time"] != null)
               {
                  tempString = Math.round(Main.localScores[warpLevel + "_Time"] * 100) / 100;
                  if(tempString.indexOf(".") == -1)
                  {
                     tempString += ".00";
                  }
                  else if(tempString.length - tempString.indexOf(".") < 3)
                  {
                     tempString += "0";
                  }
                  this.myText.Text.text = tempString;
               }
               this.icon.visible = false;
            }
         }
         else if(warpLevel == "startorcontinue")
         {
            if(Main.localSettings.W1RContProg == 0)
            {
               warpLevel = "Level1";
            }
            else if(Main.localSettings.W1RContProg > 6)
            {
               warpLevel = "Level6";
            }
            else
            {
               warpLevel = "Level" + Main.localSettings.W1RContProg;
            }
            this.icon.visible = false;
         }
         else if(warpLevel.substr(0,5) != "Lockd" || true)
         {
            this.icon.visible = false;
         }
         if(Main.LoadIt == "Lockd3")
         {
            transform.colorTransform = Main.getColorTransform(12);
         }
         stop();
         if(currentFrameLabel == "disabled" || this.vanish)
         {
            this.disabled = true;
         }
         else if(currentFrameLabel == "finish")
         {
            isTall = 80;
            this.finishDoor = true;
         }
         else
         {
            this.doorStamp = StarlingSmoke.Spawn("doorStamp",x,y,0,scaleX,0,0,onRail);
            this.doorStamp.scaleX *= 0.6666;
            this.doorStamp.scaleY = 0.6666;
            visible = false;
            if(Main.DirIt == "World 1")
            {
               this.doorStamp.currentFrame = 1;
            }
            else if(warpLevel == "bonus")
            {
               if(Main.hasReward("Bonus" + Main.LoadIt.substr(5,Main.LoadIt.length - 5)))
               {
                  if(scaleX > 0)
                  {
                     this.doorStamp.currentFrame = 3;
                  }
                  else
                  {
                     this.doorStamp.currentFrame = 4;
                  }
               }
               else
               {
                  this.doorStamp.currentFrame = 2;
               }
            }
            else
            {
               this.doorStamp.currentFrame = 1;
            }
         }
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(this.delay > 0)
         {
            --this.delay;
         }
         else
         {
            if(currentFrame == 4)
            {
               Sounds.playSound("DoorOpen",x,1,onRail);
            }
            if(currentFrame == 38)
            {
               Sounds.playSound("DoorClose",x,1,onRail);
            }
            if(currentFrame == 120)
            {
               if(alpha > 0)
               {
                  alpha -= 0.02;
               }
               else
               {
                  killInteract.push(this);
               }
            }
            else if(currentFrame == 42)
            {
               if(this.vanish)
               {
                  gotoAndStop("vanish");
               }
               else
               {
                  gotoAndStop(1);
                  if(warpLevel.substr(0,5) != "Lockd" || true)
                  {
                     this.icon.visible = false;
                  }
                  InteractEnterFrameArray.splice(InteractEnterFrameArray.indexOf(this),1);
                  this.doorStamp = StarlingSmoke.Spawn("doorStamp",x,y,0,scaleX,0,0,onRail);
                  this.doorStamp.scaleX *= 0.6666;
                  this.doorStamp.scaleY = 0.6666;
                  this.doorStamp.currentFrame = 3;
                  visible = false;
                  if(warpLevel == "bonus")
                  {
                     if(Main.hasReward("Bonus" + Main.LoadIt.substr(5,Main.LoadIt.length - 5)))
                     {
                        if(scaleX > 0)
                        {
                           this.doorStamp.currentFrame = 3;
                        }
                        else
                        {
                           this.doorStamp.currentFrame = 4;
                        }
                     }
                     else
                     {
                        this.doorStamp.currentFrame = 2;
                     }
                  }
                  else
                  {
                     this.doorStamp.currentFrame = 1;
                  }
               }
            }
            else
            {
               nextFrame();
               if(currentFrame == 33)
               {
                  if(warpLevel.substr(0,5) != "Lockd" || true)
                  {
                     this.icon.visible = false;
                  }
               }
            }
         }
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(!this.disabled)
         {
            if(this.finishDoor)
            {
               if(!(Main.LevelStatus == "Collect" && Char.Squiggles < 86))
               {
                  if(this.charsFinished.indexOf(char) == -1)
                  {
                     this.charsFinished.push(char);
                     if(this.charsFinished.length == 1)
                     {
                        Main.stageRoot.finishRace();
                        Sounds.playSoundSimple("success");
                     }
                     else if(this.charsFinished.length < Char.ActiveCharArray.length)
                     {
                        Sounds.playSoundSimple("success");
                     }
                     else
                     {
                        Main.setScrollAfterRace(this.charsFinished[0],80);
                        this.disabled = true;
                     }
                  }
               }
            }
            else
            {
               if(currentFrame == 1 && char.Status != "DoorIn")
               {
                  Main.showDoorIcon = true;
                  char.startDoorIcon(x,y,onRail);
               }
               if(char.UpIsDown() || Boolean(Main.localSettings.oneHanded && char.DownIsDown() && (char.Status == "Duck" || char.Status == "DownSlide")) && Boolean(char.char.currentFrame == 2))
               {
                  if(!(char.currentFrame > 45 || currentFrame > 1 || char.Status == "DoorIn" || char.rotItems == 0 && !char.onGround))
                  {
                     char.warpDoor = this;
                     char.gotoBuffer = "DoorIn";
                     char.LoadIt = warpLevel;
                     char.DoorIt = warpDoor;
                  }
               }
            }
         }
      }
      
      public function openDoor() : void
      {
         visible = true;
         this.cleanUp();
         gotoAndStop(2);
         if(warpLevel.substr(0,5) != "Lockd" || true)
         {
            this.icon.visible = false;
         }
         if(InteractEnterFrameArray.indexOf(this) == -1)
         {
            InteractEnterFrameArray.push(this);
         }
      }
      
      override public function cleanUp() : void
      {
         if(this.doorStamp != null)
         {
            this.doorStamp.goSwim();
            this.doorStamp = null;
         }
      }
   }
}

