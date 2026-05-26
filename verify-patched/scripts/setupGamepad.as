package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.*;
   import flash.system.*;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1165")]
   public class setupGamepad extends MovieClip
   {
      
      public static var workerGamepadInputs:Array = new Array();
      
      public static var workerGamepadRange:Vector.<Number> = new Vector.<Number>();
      
      public var debug:TextField;
      
      public var dpadIcon:MovieClip;
      
      public var gamepadConfig:MovieClip;
      
      public var gamepads:SimpleButton;
      
      public var skip:SimpleButton;
      
      public var startover:SimpleButton;
      
      private var gotNumbers:Array;
      
      private var padX:int;
      
      private var padY:int;
      
      private var flipY:int = 1;
      
      private var status:String = "findY";
      
      private var oldBiggest:Number = 0;
      
      private var circle:Number;
      
      private var isDownArray:Array;
      
      private var currentID:int = -1;
      
      private var lockID:int = -1;
      
      private var skippedAnalog:Boolean;
      
      private var skippedDpad:Boolean;
      
      private var axisHistory:Array;
      
      private var biggestObj:Array;
      
      private var ignoreTimer:Array;
      
      private var saveControls:Array;
      
      private var saveRange:Number;
      
      public var controlsArray:Array;
      
      public var PauseEnterFrame:Function;
      
      public function setupGamepad()
      {
         var prop:String = null;
         this.gotNumbers = [];
         this.isDownArray = [];
         this.axisHistory = [];
         this.biggestObj = [];
         this.ignoreTimer = [];
         this.saveControls = [];
         super();
         stop();
         this.gamepadConfig.stop();
         this.PauseEnterFrame = this.AnalogConfigEnterFrame;
         for(prop in Main.gamepadObject)
         {
            Main.gamepadObject[prop].reference.enabled = true;
            this.setHistory(prop);
         }
         this.skip.addEventListener(MouseEvent.MOUSE_DOWN,this.clickSkip,false,0,true);
         this.startover.addEventListener(MouseEvent.MOUSE_DOWN,this.clickStartOver,false,0,true);
         this.startover.visible = false;
      }
      
      public static function getLayout(e:String) : Array
      {
         if(Main.shared.data.controllers[e] != undefined)
         {
            return Main.shared.data.controllers[e].controls;
         }
         if(e == "Sony Computer Entertainment Wireless Controller")
         {
            return [0,1,7,7,6,6,8,9,4,17,16,12];
         }
         if(Main.deviceID != "PC")
         {
            if(e.indexOf("Remote") > -1)
            {
               return [0,0,4,3,1,2,5,6,0,0,0,0,0];
            }
            return [11,12,1,2,3,4,6,5,16,10,9,8,7];
         }
         if(e == "Xbox 360 Controller (XInput STANDARD GAMEPAD)")
         {
            return [0,-1,16,17,18,19,6,4,11,9,13,7,8];
         }
         if(e == "Controller" || e.indexOf("360") > -1)
         {
            if(e.indexOf("Vendor") > -1)
            {
               return [0,1,16,17,18,19,6,4,11,13,12,9];
            }
            return [0,1,6,7,8,9,19,17,5,15,10,20,2];
         }
         switch(e)
         {
            case "Logitech RumblePad 2 USB":
               if(Capabilities.os.substr(0,3) == "Mac")
               {
                  return [1,2,5,6,7,8,9,10,18];
               }
               if(Capabilities.os.substr(0,7) == "Windows")
               {
                  return [0,1,4,5,6,7,8,9,17];
               }
               break;
            case "HORIPAD ULTIMATE":
               break;
            case "Wireless Controller":
               return [0,1,6,7,8,9,10,11,4,15,19,13,12];
            case "PLAYSTATION(R)3 Controller":
               return [0,1,8,10,11,9,19,18,13,15,7,4,15];
            case "Xbox One Wired Controller":
               return [0,1,6,7,8,9,19,17,5,5,10,11,12];
            case "Pro Controller":
               return [0,1,4,5,6,7,10,8,15,17,16,12];
            case "Joy-Con (L)":
               return [0,1,4,5,6,7,11,9,13,12,16,0,1];
            case "Joy-Con (R)":
               return [0,1,4,5,6,7,10,8,13,12,16,0,1];
            default:
               return [];
         }
         return [0,-1,5,5,5,5,10,8,15,13,12,11,9];
      }
      
      public static function getRange(e:String) : Number
      {
         if(Main.shared.data.controllers[e] != undefined)
         {
            return Main.shared.data.controllers[e].padRange;
         }
         if(e == "Pro Controller")
         {
            return 0.75;
         }
         return 1;
      }
      
      private function setHistory(e:uint) : void
      {
         this.axisHistory[e] = [];
         for(var i:int = 0; i < this.controlsArray[e].length; i++)
         {
            this.axisHistory[e][i] = this.controlsArray[e][i];
         }
      }
      
      private function AnalogConfigEnterFrame() : *
      {
         var i:int = 0;
         var value:Number = NaN;
         var biggest:Number = NaN;
         var secondbiggest:Number = NaN;
         this.debug.text = this.currentID + " " + this.status + " ";
         for(var n:uint = 0; n < this.controlsArray.length; n++)
         {
            this.debug.appendText(" ");
            for(i = 0; i < this.controlsArray[n].length; i++)
            {
               value = Number(this.controlsArray[n][i]);
               if(workerGamepadInputs[n][i].substr(0,4) == "AXIS")
               {
                  if(this.currentID != n)
                  {
                     if(this.axisHistory[n] == undefined)
                     {
                        this.setHistory(n);
                     }
                     if(Math.abs(value) > 0.2 && Math.abs(value - this.axisHistory[n][i]) > 0.1)
                     {
                        this.saveRange = Math.abs(value);
                        this.currentID = n;
                        this.ignoreTimer[n] = [];
                        this.setHistory(n);
                     }
                  }
               }
               else if(Math.abs(value) > 0.5)
               {
                  this.PauseEnterFrame = this.ButtonsConfigEnterFrame;
                  this.currentID = this.lockID = n;
                  this.saveRange = 0;
                  this.isDownArray[i] = true;
                  this.gamepadConfig.gotoAndStop(89);
                  gotoAndStop(2);
                  this.startover.visible = true;
                  return false;
               }
            }
         }
         if(this.currentID > -1)
         {
            if(this.controlsArray[this.currentID] == undefined)
            {
               this.reset();
               return;
            }
            if(this.ignoreTimer[this.currentID] == undefined)
            {
               this.ignoreTimer[this.currentID] = [];
            }
            this.gotNumbers = [];
            for(i = 0; i < this.controlsArray[this.currentID].length; i++)
            {
               if(workerGamepadInputs[this.currentID][i].substr(0,4) == "AXIS")
               {
                  if(Math.abs(this.controlsArray[this.currentID][i] - this.axisHistory[this.currentID][i]) > 0.1)
                  {
                     this.ignoreTimer[this.currentID][i] = 60;
                     this.axisHistory[this.currentID][i] = this.controlsArray[this.currentID][i];
                  }
                  if(this.ignoreTimer[this.currentID][i] > 0)
                  {
                     if(true || this.status != "circle" && i == this.padY)
                     {
                        --this.ignoreTimer[this.currentID][i];
                     }
                     this.gotNumbers[i] = this.controlsArray[this.currentID][i];
                     this.debug.appendText(i + " " + this.ignoreTimer[this.currentID][i] + " ");
                     if(Math.abs(this.gotNumbers[i]) > this.saveRange)
                     {
                        this.saveRange = Math.abs(this.gotNumbers[i]);
                     }
                  }
                  else
                  {
                     this.gotNumbers[i] = 0;
                  }
               }
            }
            if(this.gotNumbers.length == 0)
            {
               this.gamepadConfig.gotoAndStop(1);
            }
            switch(this.status)
            {
               case "findY":
                  this.padY = -1;
                  biggest = 0;
                  for(i = 0; i < this.gotNumbers.length; i++)
                  {
                     if(Math.abs(this.gotNumbers[i]) > Math.abs(biggest))
                     {
                        biggest = Number(this.gotNumbers[i]);
                        this.padY = i;
                     }
                  }
                  this.debug.text = biggest + " " + this.debug.text;
                  if(this.padY > -1 && this.gotNumbers[this.padY] != undefined)
                  {
                     this.gamepadConfig.gotoAndStop(Math.abs(Math.floor(this.gotNumbers[this.padY] * 10)) + 1);
                     if(Math.abs(biggest) > 0.5)
                     {
                        this.flipY = -biggest / Math.abs(biggest);
                        this.status = "findX";
                     }
                     this.oldBiggest = Math.abs(biggest);
                  }
                  break;
               case "findX":
                  this.padX = -1;
                  secondbiggest = 0;
                  for(i = 0; i < this.gotNumbers.length; i++)
                  {
                     if(i != this.padY)
                     {
                        if(Math.abs(this.gotNumbers[i]) > Math.abs(secondbiggest))
                        {
                           secondbiggest = Number(this.gotNumbers[i]);
                           this.padX = i;
                        }
                     }
                  }
                  if(this.padY == -1)
                  {
                     this.status = "findY";
                  }
                  else if(secondbiggest > -0.1)
                  {
                     this.gamepadConfig.gotoAndStop(Math.abs(Math.floor(this.gotNumbers[this.padY] * 10)) + 1);
                     if(Math.abs(this.gotNumbers[this.padY]) < 0.5)
                     {
                        this.gamepadConfig.gotoAndStop(1);
                        this.status = "findY";
                     }
                  }
                  else
                  {
                     this.status = "circle";
                  }
                  break;
               case "circle":
                  this.circle = -(-Math.atan2(-this.gotNumbers[this.padX],-this.gotNumbers[this.padY] * this.flipY) / (Math.PI / 180));
                  if(this.gamepadConfig.currentFrame > 40 && this.circle < 0)
                  {
                     this.circle += 360;
                  }
                  if(this.gamepadConfig.currentFrame > 70 && (this.circle < 180 || this.circle > 340))
                  {
                     this.saveControls = [this.padX,this.padY * this.flipY];
                     this.gamepadConfig.gotoAndStop(88);
                     this.PauseEnterFrame = this.ButtonsConfigEnterFrame;
                     this.isDownArray[this.padY] = true;
                     gotoAndStop(2);
                     this.startover.visible = true;
                     this.lockID = this.currentID;
                     return false;
                  }
                  if(this.circle < 20 && this.gotNumbers[this.padX] > -0.1)
                  {
                     this.status = "findX";
                  }
                  else if(this.circle > 0)
                  {
                     this.gamepadConfig.gotoAndStop(Math.floor(this.circle / 4.6) + 11);
                  }
                  if(Math.abs(this.gotNumbers[this.padX]) + Math.abs(this.gotNumbers[this.padY]) < 0.5)
                  {
                     this.status = "findY";
                  }
            }
            this.debug.text = this.status + " " + this.debug.text;
         }
      }
      
      private function ButtonsConfigEnterFrame() : *
      {
         var i:int = 0;
         this.debug.text = "";
         for(var n:uint = 0; n < this.controlsArray.length; n++)
         {
            for(i = 0; i < this.controlsArray[n].length; i++)
            {
               if(Math.abs(this.controlsArray[n][i]) > 0.4)
               {
                  this.debug.appendText(i + " " + this.controlsArray[n][i]);
                  if(this.lockID == -1)
                  {
                     this.lockID = n;
                  }
                  else if(n != this.lockID)
                  {
                  }
               }
            }
         }
         if(this.lockID > -1)
         {
            if(this.controlsArray[this.lockID] == undefined)
            {
               this.reset();
               return;
            }
            for(i = 0; i < this.controlsArray[this.lockID].length; i++)
            {
               if(i != this.padX && i != this.padY)
               {
                  if(this.controlsArray[this.lockID][i] < 0.5)
                  {
                     this.isDownArray[i] = false;
                  }
                  if(this.controlsArray[this.lockID][i] > 0.5 && !this.isDownArray[i])
                  {
                     this.isDownArray[i] = true;
                     this.saveControls[currentFrame] = i;
                     if(currentFrame == totalFrames)
                     {
                        trace("save " + Main.stageRoot.workerGamepadName[this.lockID]);
                        Main.shared.data.controllers[Main.stageRoot.workerGamepadName[this.lockID]] = {
                           "controls":this.saveControls,
                           "padRange":this.saveRange
                        };
                        Main.shared.flush();
                        Char.setupAllGamepads(this.lockID);
                        this.killSetupGamepad();
                     }
                     else
                     {
                        nextFrame();
                        if(currentFrame == 6)
                        {
                           this.dpadIcon.gotoAndStop(1);
                        }
                     }
                     break;
                  }
               }
            }
         }
      }
      
      private function clickSkip(e:MouseEvent) : *
      {
         if(currentFrame == 1)
         {
            this.gamepadConfig.gotoAndStop(89);
            this.PauseEnterFrame = this.ButtonsConfigEnterFrame;
            gotoAndStop(2);
            this.startover.visible = true;
            this.skip.visible = false;
         }
         else if(currentFrame < 6)
         {
            this.skippedDpad = true;
            gotoAndStop(6);
            this.dpadIcon.gotoAndStop(2);
         }
      }
      
      private function clickStartOver(e:MouseEvent) : *
      {
         this.reset();
      }
      
      private function reset() : *
      {
         gotoAndStop(1);
         this.skip.visible = true;
         this.startover.visible = false;
         stop();
         this.gamepadConfig.gotoAndStop(1);
         this.PauseEnterFrame = this.AnalogConfigEnterFrame;
         this.skippedAnalog = false;
         this.status = "findY";
         this.lockID = this.currentID = "nothing";
         return false;
      }
      
      public function killSetupGamepad() : *
      {
         Char.CharArray[0].SisDown = true;
         this.skip.removeEventListener(MouseEvent.MOUSE_DOWN,this.clickSkip);
         this.startover.removeEventListener(MouseEvent.MOUSE_DOWN,this.clickStartOver);
         Main.pauseStatus = "Menu";
         Sounds.playSoundSimple("UnPause");
         parent.removeChild(this);
      }
   }
}

