package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.TextField;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1216")]
   public class PauseMenu extends MovieClip
   {
      
      public static var pausemenu:PauseMenu;
      
      public static var gamepadmenu:Object;
      
      public static var bubble:Object;
      
      public var Handed:MovieClip;
      
      public var Text:TextField;
      
      public var combosList:MovieClip;
      
      public var confirm:MovieClip;
      
      public var controlsSelector:MovieClip;
      
      public var creditsButton:MovieClip;
      
      public var debugSelect:MovieClip;
      
      public var goFullscreen:MovieClip;
      
      public var hideUI:MovieClip;
      
      public var language:TextField;
      
      public var languageButton:MovieClip;
      
      public var mapIcon:SimpleButton;
      
      public var musicSlider:MovieClip;
      
      public var quitButton:MovieClip;
      
      public var quitToMenu:MovieClip;
      
      public var setupGamepadButton:MovieClip;
      
      public var timesList:MovieClip;
      
      public var tutorial:SimpleButton;
      
      public var volumeSlider:MovieClip;
      
      public var __setPropDict:Dictionary = new Dictionary(true);
      
      private var currentKnob:Object;
      
      public var IconArray:Array;
      
      private var pantsIconArray:Array = [];
      
      private var hatIconArray:Array = [];
      
      private var patternIconArray:Array = [];
      
      private var colorIconArray:Array = [];
      
      private var hasPantsArray:Array = [];
      
      private var hasHatsArray:Array = [];
      
      private var hasPatternsArray:Array = [];
      
      private var hasHatsN:uint;
      
      private var hasPantsN:uint;
      
      private var hasPatternsN:uint;
      
      private var pantsScrollRL:Number = 0;
      
      private var pantsScrollX:Number = 0;
      
      private var oPantsScrollX:Number = 0;
      
      private var hatScrollRL:Number = 0;
      
      private var hatScrollX:Number = 0;
      
      private var oHatScrollX:Number = 0;
      
      public var pantsN:int = -1;
      
      public var hatN:int = -1;
      
      public var patternN:int = -1;
      
      public var colorN:int = -1;
      
      public var scrollPantsOffset:Number;
      
      public var scrollHatsOffset:Number;
      
      public var forChar:Char;
      
      private var iconPixels:uint;
      
      private var iconRatio:Number;
      
      private var shine:Boolean;
      
      private var menuKeyThresh:Number;
      
      public var selectorPos:Object = {};
      
      public var selectorCatN:int = 0;
      
      public var selectorCat:String;
      
      public var selectorCatArray:Vector.<String>;
      
      public var canClick:Boolean;
      
      public var mouseDownX:int;
      
      private var keySwitch:Boolean;
      
      public var myLanguageSelector:languageSelector;
      
      public var myCredits:CreditsScreen;
      
      public function PauseMenu()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3);
         pausemenu = this;
         pausemenu.Text.text = "";
         if(Main.isTouchScreen || Main.isScaleForm)
         {
            pausemenu.gotoAndStop(3);
         }
         else if(Main.onSite == "MiniClip" || Main.onSite == "Kizi")
         {
            pausemenu.gotoAndStop(2);
            pausemenu.AddictingGames.visible = false;
         }
         else
         {
            pausemenu.gotoAndStop(1);
         }
         this.musicSlider.knob.y = -(Math.acos(1 - Main.localSettings.musicVol) / 1.57) * 100;
         this.volumeSlider.knob.y = -(Math.acos(1 - Main.localSettings.sfxVol) / 1.57) * 100;
         this.debugSelect.visible = Main.debug;
         stop();
         this.__setProp_timesList_PauseMenu_buttons_0();
         this.__setProp_combosList_PauseMenu_buttons_0();
         this.__setProp_hideUI_PauseMenu_buttons_0();
         this.__setProp_goFullscreen_PauseMenu_buttons_0();
         this.__setProp_quitToMenu_PauseMenu_buttons_0();
      }
      
      public static function showPause(n:*) : *
      {
         if(Main.debug)
         {
            rootHUD.HUD.centerText.text = Main.LevelLoaded + "      x: " + Math.floor(Main.cameraX) + "      y: " + Math.floor(Main.cameraY) + " 1.3b";
         }
         if(pausemenu == null)
         {
            pausemenu = new PauseMenu();
         }
         pausemenu.forChar = Char.CharArray[n];
         pausemenu.visible = true;
         Main.stageRoot.addChild(pausemenu);
         pausemenu.setupIcons();
      }
      
      public static function giveColors() : *
      {
         if(Main.localSettings.patternN == 0)
         {
            pausemenu.forChar.changePattern(2);
         }
         bubble = new bigSpeechBubble(5,7,addColors);
      }
      
      private static function addColors() : *
      {
         bubble = null;
         Main.stageRoot.stage.addEventListener(MouseEvent.MOUSE_DOWN,Main.stageRoot.mouseDown);
         Main.stageRoot.stage.addEventListener(KeyboardEvent.KEY_DOWN,Main.stageRoot.getKeysUnPause);
      }
      
      private static function cosCurve(e:Number) : Number
      {
         return 1 - Math.cos(e * 1.57);
      }
      
      public static function destroy() : *
      {
         if(bubble != null)
         {
            bubble.parent.removeChild(bubble);
            bubble = null;
         }
         pausemenu.volumeSlider.knob.removeEventListener(MouseEvent.MOUSE_DOWN,pausemenu.volumeKnobStart);
         pausemenu.musicSlider.knob.removeEventListener(MouseEvent.MOUSE_DOWN,pausemenu.volumeKnobStart);
         pausemenu.visible = false;
         rootHUD.HUD.centerText.text = "";
      }
      
      private function setupIcons() : *
      {
         var icon:PauseIconCache = null;
         this.shine = true;
         scaleX = Main.originalStageX * 2 / 800;
         scaleY = Main.originalStageY * 2 / 500;
         alpha = 0;
         this.confirm.visible = false;
         this.language.mouseEnabled = false;
         this.language.text = Main.localSettings.language;
         this.volumeSlider.knob.addEventListener(MouseEvent.MOUSE_DOWN,this.volumeKnobStart,false,0,true);
         this.musicSlider.knob.addEventListener(MouseEvent.MOUSE_DOWN,this.volumeKnobStart,false,0,true);
         i = 0;
         while(i < Main.localSettings.hasPantsString.length)
         {
            this.hasPantsArray[i] = Main.localSettings.hasPantsString.substr(i,1) == "y";
            ++i;
         }
         i = 0;
         while(i < Main.localSettings.hasHatsString.length)
         {
            this.hasHatsArray[i] = Main.localSettings.hasHatsString.substr(i,1) == "y";
            ++i;
         }
         i = 0;
         while(i < Main.localSettings.hasPatternsString.length)
         {
            this.hasPatternsArray[i] = Main.localSettings.hasPatternsString.substr(i,1) == "y";
            ++i;
         }
         this.mapIcon.visible = Main.world4Progress.canMapAround;
         if(this.controlsSelector != null)
         {
            if(Main.localSettings.oneHanded)
            {
               this.controlsSelector.gotoAndStop(2);
            }
            else
            {
               this.controlsSelector.gotoAndStop(1);
            }
         }
         this.IconArray = [];
         this.selectorCatArray = new Vector.<String>();
         PauseIconCache.stamp.gotoAndStop(1);
         PauseIconCache.stamp.pattern.stop();
         PauseIconCache.stamp.pattern.visible = false;
         this.hasHatsN = 0;
         if(this.hasHatsArray.indexOf(true) > -1)
         {
            this.selectorPos.hatStart = 0;
            this.selectorCatArray.push("hat");
            this.findRatio(this.hasHatsArray);
            PauseIconCache.grabDt = true;
            for(i = 0; i < this.hasHatsArray.length + 1; ++i)
            {
               if(this.forChar.hatN == i)
               {
                  this.selectorPos.hat = this.IconArray.length;
               }
               if(this.hatIconArray[i] != undefined)
               {
                  this.hatIconArray[i].PauseIconReset(this.hasHatsN,140,this.iconRatio,this.hasHatsN * 2,this.forChar.hatN == i,this.hatScrollX,i == 0 || this.hasHatsArray[i - 1]);
                  this.IconArray.push(this.hatIconArray[i]);
                  ++this.hasHatsN;
               }
               else
               {
                  icon = new PauseIconCache(900,140,this.hasHatsN,140,this.iconRatio,this.hasHatsN * 2,"hat",i,this.forChar.hatN == i,-1,i == 0 || Boolean(this.hasHatsArray[i - 1]));
                  this.hatIconArray[i] = icon;
                  addChild(icon);
                  this.IconArray.push(icon);
                  ++this.hasHatsN;
               }
            }
            this.selectorPos.hatEnd = this.IconArray.length - 1;
         }
         this.findRatio(this.hasPantsArray);
         this.selectorPos.pantsStart = this.IconArray.length;
         this.selectorCatArray.push("pants");
         this.hasPantsN = 0;
         PauseIconCache.grabDt = true;
         for(i = 0; i < this.hasPantsArray.length + 4; ++i)
         {
            if(this.forChar.pantsN == i)
            {
               this.selectorPos.pants = this.IconArray.length;
            }
            if(this.pantsIconArray[i] != undefined)
            {
               this.pantsIconArray[i].PauseIconReset(this.hasPantsN,220,this.iconRatio,this.hasPantsN * 2 + 2,this.forChar.pantsN == i,this.pantsScrollX,i < 4 || this.hasPantsArray[i - 4]);
               this.IconArray.push(this.pantsIconArray[i]);
               ++this.hasPantsN;
            }
            else
            {
               icon = new PauseIconCache(900,220,this.hasPantsN,220,this.iconRatio,this.hasPantsN * 2 + 2,"pants",i,this.forChar.pantsN == i,-1,i < 4 || Boolean(this.hasPantsArray[i - 4]));
               this.pantsIconArray[i] = icon;
               addChild(icon);
               this.IconArray.push(icon);
               ++this.hasPantsN;
            }
         }
         this.selectorPos.pantsEnd = this.IconArray.length - 1;
         this.hasPatternsN = 0;
         if(this.hasPatternsArray.indexOf(true) > -1)
         {
            this.selectorPos.patternStart = this.IconArray.length;
            this.selectorCatArray.push("pattern");
            PauseIconCache.stamp.gotoAndStop(1);
            PauseIconCache.stamp.pattern.gotoAndStop(1);
            PauseIconCache.stamp.pattern.transform.colorTransform = new ColorTransform();
            for(i = 1; i < this.hasPatternsArray.length + 1; ++i)
            {
               if(this.forChar.patternN == i)
               {
                  this.selectorPos.pattern = this.IconArray.length;
               }
               if(this.patternIconArray[i] != undefined)
               {
                  this.patternIconArray[i].PauseIconReset(this.hasPantsN + this.hasPatternsN,220,this.iconRatio,(this.hasPatternsN + this.hasPantsN) * 2 + 2,this.forChar.patternN == i,this.pantsScrollX,this.hasPatternsArray[i - 1]);
                  this.IconArray.push(this.patternIconArray[i]);
               }
               else
               {
                  icon = new PauseIconCache(900,220,this.hasPantsN + this.hasPatternsN,220,this.iconRatio,(this.hasPatternsN + this.hasPantsN) * 2 + 2,"pattern",i,this.forChar.patternN == i,-1,this.hasPatternsArray[i - 1]);
                  this.patternIconArray[i] = icon;
                  addChild(icon);
                  this.IconArray.push(icon);
               }
               ++this.hasPatternsN;
            }
            this.selectorPos.patternEnd = this.IconArray.length - 1;
         }
         if(Main.localSettings.canColor)
         {
            this.displayColors();
         }
         this.pantsN = this.forChar.pantsN;
         this.hatN = this.forChar.hatN;
         this.patternN = this.forChar.patternN;
         this.colorN = this.forChar.colorN;
         this.selectorCat = this.selectorCatArray[0];
         if(this.selectorCat == "pants" && this.patternN > 0)
         {
            this.selectorCat = "pattern";
         }
      }
      
      public function displayColors() : *
      {
         PauseIconCache.stamp.gotoAndStop(1);
         PauseIconCache.stamp.pattern.gotoAndStop(this.forChar.patternN);
         PauseIconCache.stamp.pattern.visible = true;
         this.selectorPos.colorStart = this.IconArray.length;
         this.findRatio(this.hasPantsArray);
         var hasColorN:uint = 0;
         for(i = 0; i < this.hasPantsArray.length + 4; ++i)
         {
            if(this.forChar.colorN == i)
            {
               this.selectorPos.color = this.IconArray.length;
            }
            if(this.colorIconArray[i] != undefined)
            {
               this.colorIconArray[i].PauseIconReset(hasColorN,380,this.iconRatio,hasColorN * 2 + 6,this.forChar.colorN == i);
               hasColorN++;
               if(this.forChar.colorN != this.colorN)
               {
                  this.colorIconArray[i].drawCurrentStamp("color",i,this.forChar.colorN == i,this.forChar.pantsN);
               }
               if(this.forChar.patternN > 0 && this.IconArray.indexOf(icon) == -1)
               {
                  this.IconArray.push(this.colorIconArray[i]);
               }
            }
            else
            {
               if(i < 4 || Boolean(this.hasPantsArray[i - 4]))
               {
                  icon = new PauseIconCache(900,380,hasColorN,380,this.iconRatio,hasColorN * 2 + 6,"color",i,this.forChar.colorN == i,this.forChar.pantsN);
               }
               else
               {
                  icon = new PauseIconCache(900,380,hasColorN,380,this.iconRatio,hasColorN * 2 + 6,"color",i,this.forChar.colorN == i,this.forChar.pantsN);
               }
               this.colorIconArray[i] = icon;
               addChild(icon);
               hasColorN++;
               if(this.forChar.patternN > 0 && this.IconArray.indexOf(icon) == -1)
               {
                  this.IconArray.push(icon);
               }
            }
         }
         this.selectorPos.colorEnd = this.IconArray.length - 1;
      }
      
      private function findRatio(array:*) : void
      {
         this.iconRatio = 0.8;
      }
      
      public function PauseEnterFrame() : void
      {
         if(alpha < 1)
         {
            alpha += 0.5 * Main.framin;
         }
         if(alpha > 1)
         {
            alpha = 1;
         }
         if(Boolean(this.keySwitch) && this.selectorCat != "Map")
         {
            if(this.IconArray[this.selectorPos[this.selectorCat]].x > 760)
            {
               if(this.selectorCat == "hat")
               {
                  this.hatScrollRL = -30;
               }
               if(this.selectorCat == "pants" || this.selectorCat == "pattern")
               {
                  this.pantsScrollRL = -30;
               }
            }
            else if(this.IconArray[this.selectorPos[this.selectorCat]].x < 40)
            {
               if(this.selectorCat == "hat")
               {
                  this.hatScrollRL = 30;
               }
               if(this.selectorCat == "pants" || this.selectorCat == "pattern")
               {
                  this.pantsScrollRL = 30;
               }
            }
         }
         if(!Main.isTouchScreen)
         {
            if(mouseX > 720)
            {
               if(Math.abs(mouseY - 220) < 40)
               {
                  this.pantsScrollRL = (720 - mouseX) * 0.3;
               }
               else if(Math.abs(mouseY - 140) < 40)
               {
                  this.hatScrollRL = (720 - mouseX) * 0.3;
               }
            }
            else if(mouseX < 80)
            {
               if(Math.abs(mouseY - 220) < 40)
               {
                  this.pantsScrollRL = (80 - mouseX) * 0.3;
               }
               else if(Math.abs(mouseY - 140) < 40)
               {
                  this.hatScrollRL = (80 - mouseX) * 0.3;
               }
            }
         }
         this.forChar.pauseStuff();
         this.menuKeys(this.forChar.wantRL,this.forChar.wantUD);
         if(this.selectorCat == "Map")
         {
            this.mapIcon.scaleX += (1.1 - this.mapIcon.scaleX) * 0.4;
            this.mapIcon.scaleY = this.mapIcon.scaleX;
         }
         else
         {
            this.mapIcon.scaleX += (1 - this.mapIcon.scaleX) * 0.4;
            this.mapIcon.scaleY = this.mapIcon.scaleX;
         }
         this.pantsScrollX += this.pantsScrollRL;
         this.pantsScrollRL *= 0.9;
         var temp:Number = -80 * (this.hasPantsN + this.hasPatternsN) * 0.8 + 720;
         if(this.pantsScrollX < temp)
         {
            this.pantsScrollX = temp;
            pantScrollRL = 0;
         }
         if(this.pantsScrollX > 0)
         {
            this.pantsScrollX = this.pantsScrollRL = 0;
         }
         this.hatScrollX += this.hatScrollRL;
         this.hatScrollRL *= 0.9;
         temp = -80 * this.hasHatsN * 0.8 + 720;
         if(this.hatScrollX < temp)
         {
            this.hatScrollX = temp;
            this.hatScrollRL = 0;
         }
         if(this.hatScrollX > 0)
         {
            this.hatScrollX = this.hatScrollRL = 0;
         }
         for(var i:uint = 0; i < this.IconArray.length; i++)
         {
            if(this.IconArray[i].downtime > 0)
            {
               this.IconArray[i].downtime -= Main.framin;
            }
            else
            {
               if(false && (this.IconArray[i].anchorX - this.IconArray[i].x) * 0.75 < -200)
               {
                  this.IconArray[i].x -= 200 * Main.framin;
               }
               else if(this.IconArray[i].type == "pants" || this.IconArray[i].type == "pattern")
               {
                  this.IconArray[i].x += (this.IconArray[i].anchorX + this.pantsScrollX - this.IconArray[i].x) * 0.75 * Main.framin;
               }
               else if(this.IconArray[i].type == "hat")
               {
                  this.IconArray[i].x += (this.IconArray[i].anchorX + this.hatScrollX - this.IconArray[i].x) * 0.75 * Main.framin;
               }
               else
               {
                  this.IconArray[i].x += (this.IconArray[i].anchorX - this.IconArray[i].x) * 0.75 * Main.framin;
               }
               if(!Main.isTouchScreen && Math.abs(mouseX - this.IconArray[i].x) < 40 * this.IconArray[i].ratio && Math.abs(mouseY - this.IconArray[i].y) < 40 * this.IconArray[i].ratio)
               {
                  if(this.IconArray[i].unlocked)
                  {
                     this.IconArray[i].scaleX += (1.13 * this.IconArray[i].ratio - this.IconArray[i].scaleX) * 0.6 * Main.framin;
                  }
                  else
                  {
                     this.IconArray[i].scaleX += (1.03 * this.IconArray[i].ratio - this.IconArray[i].scaleX) * 0.6 * Main.framin;
                  }
                  this.IconArray[i].scaleY = this.IconArray[i].scaleX;
               }
               else
               {
                  this.IconArray[i].scaleX += (this.IconArray[i].ratio - this.IconArray[i].scaleX) * 0.6 * Main.framin;
                  if(this.IconArray[i].scaleX < 0.01)
                  {
                     this.IconArray[i].scaleX = this.IconArray[i].scaleY = 0;
                     this.IconArray.splice(i,1);
                     i--;
                  }
                  else
                  {
                     this.IconArray[i].scaleY = this.IconArray[i].scaleX;
                  }
               }
            }
         }
         if(bubble != null)
         {
            bubble.InteractEnterFrame();
         }
      }
      
      public function scrollCustomsEnterFrame() : void
      {
         for(var i:uint = 0; i < this.IconArray.length; i++)
         {
            if(this.canClick && Math.abs(mouseX - this.IconArray[i].x) < 40 * this.IconArray[i].ratio && Math.abs(mouseY - this.IconArray[i].y) < 40 * this.IconArray[i].ratio)
            {
               if(this.IconArray[i].unlocked)
               {
                  this.IconArray[i].scaleX += (0.8 * this.IconArray[i].ratio - this.IconArray[i].scaleX) * 0.6 * Main.framin;
               }
               else
               {
                  this.IconArray[i].scaleX += (0.96 * this.IconArray[i].ratio - this.IconArray[i].scaleX) * 0.6 * Main.framin;
               }
               this.IconArray[i].scaleY = this.IconArray[i].scaleX;
            }
            else
            {
               this.IconArray[i].scaleX += (this.IconArray[i].ratio - this.IconArray[i].scaleX) * 0.6 * Main.framin;
               this.IconArray[i].scaleY = this.IconArray[i].scaleX;
            }
         }
      }
      
      public function setScrollPantsOffset(ex:Number) : void
      {
         this.mouseDownX = ex;
         this.scrollPantsOffset = this.pantsScrollX - ex;
         this.keySwitch = false;
      }
      
      public function scrollPants(ex:Number) : void
      {
         this.pantsScrollX = ex + this.scrollPantsOffset;
         this.pantsScrollRL = this.pantsScrollX - this.oPantsScrollX;
         this.oPantsScrollX = this.pantsScrollX;
         if(Math.abs(ex - this.mouseDownX) > 5)
         {
            this.canClick = false;
         }
         for(var i:uint = 0; i < this.IconArray.length; i++)
         {
            if(this.IconArray[i].type == "pants" || this.IconArray[i].type == "pattern")
            {
               if(this.IconArray[i].downtime <= 0)
               {
                  this.IconArray[i].x = this.IconArray[i].anchorX + this.pantsScrollX;
               }
            }
         }
      }
      
      public function setScrollHatsOffset(ex:Number) : void
      {
         this.mouseDownX = ex;
         this.scrollHatsOffset = this.hatScrollX - ex;
         this.keySwitch = false;
      }
      
      public function scrollHats(ex:Number) : void
      {
         this.hatScrollX = ex + this.scrollHatsOffset;
         this.hatScrollRL = this.hatScrollX - this.oHatScrollX;
         this.oHatScrollX = this.hatScrollX;
         if(Math.abs(ex - this.mouseDownX) > 5)
         {
            this.canClick = false;
         }
         for(var i:uint = 0; i < this.IconArray.length; i++)
         {
            if(this.IconArray[i].type == "hat")
            {
               if(this.IconArray[i].downtime <= 0)
               {
                  this.IconArray[i].x = this.IconArray[i].anchorX + this.hatScrollX;
               }
            }
         }
      }
      
      private function menuKeys(ex:Number, ey:Number) : void
      {
         if(Math.abs(ey) > 0.3)
         {
            this.menuKeyThresh -= Math.abs(ey);
         }
         else if(Math.abs(ex) > 0.3)
         {
            this.menuKeyThresh -= Math.abs(ex);
         }
         else
         {
            this.menuKeyThresh = 0;
         }
         if(this.menuKeyThresh <= 0)
         {
            if(Math.abs(ey) > 0.3)
            {
               this.menuKeyThresh = 20;
               if(this.selectorCat != "Map")
               {
                  this.IconArray[this.selectorPos[this.selectorCat]].drawOutline(2);
               }
               if(this.selectorCat == "pants" || this.selectorCat == "pattern")
               {
                  if(ey > 0)
                  {
                     if(this.selectorCatArray.indexOf("pattern") == -1)
                     {
                        this.selectorCatN = this.selectorCatArray.indexOf("pants") + 1;
                     }
                     else
                     {
                        this.selectorCatN = this.selectorCatArray.indexOf("pattern") + 1;
                     }
                  }
                  else
                  {
                     this.selectorCatN = this.selectorCatArray.indexOf("pants") - 1;
                  }
               }
               else
               {
                  this.selectorCatN += ey / Math.abs(ey);
               }
               if(this.selectorCatN > this.selectorCatArray.length)
               {
                  this.selectorCatN = 0;
               }
               else if(this.selectorCatN < 0)
               {
                  if(this.mapIcon.visible)
                  {
                     this.selectorCat = "Map";
                     this.selectorCatN = this.selectorCatArray.length;
                     return;
                  }
                  this.selectorCatN = this.selectorCatArray.length - 1;
               }
               else if(this.selectorCatN == this.selectorCatArray.length)
               {
                  if(this.mapIcon.visible)
                  {
                     this.selectorCat = "Map";
                     return;
                  }
                  this.selectorCatN = 0;
               }
               this.keySwitch = true;
               this.selectorCat = this.selectorCatArray[this.selectorCatN];
               if(this.selectorCat == "pants" || this.selectorCat == "pattern")
               {
                  if(this.pantsN == -1)
                  {
                     this.selectorCat = "pattern";
                  }
                  else
                  {
                     this.selectorCat = "pants";
                  }
                  this.selectorCatN = this.selectorCatArray.indexOf(this.selectorCat);
               }
               this.IconArray[this.selectorPos[this.selectorCat]].drawOutline(3);
            }
            else if(Math.abs(ex) > 0.3)
            {
               this.menuKeyThresh = 10;
               if(this.selectorCat == "Map")
               {
                  return;
               }
               this.selectorPos[this.selectorCat] += ex / Math.abs(ex);
               if(this.selectorPos[this.selectorCat] < this.selectorPos[this.selectorCat + "Start"])
               {
                  if(this.selectorCat == "pattern")
                  {
                     this.selectorCat = "pants";
                  }
                  else if(this.selectorCat == "pants" && this.hasPatternsN > 0)
                  {
                     this.selectorCat = "pattern";
                  }
                  this.selectorPos[this.selectorCat] = this.selectorPos[this.selectorCat + "End"];
                  if(this.selectorCat == "hat")
                  {
                     this.hatScrollX = -80 * this.hasHatsN * 0.8 + 720;
                  }
               }
               if(this.selectorPos[this.selectorCat] > this.selectorPos[this.selectorCat + "End"])
               {
                  if(this.selectorCat == "pants" && this.hasPatternsN > 0)
                  {
                     this.selectorCat = "pattern";
                  }
                  else if(this.selectorCat == "pattern")
                  {
                     this.selectorCat = "pants";
                  }
                  this.selectorPos[this.selectorCat] = this.selectorPos[this.selectorCat + "Start"];
                  if(this.selectorCat == "hat")
                  {
                     this.hatScrollX = 0;
                  }
               }
               this.canClick = true;
               this.keySwitch = true;
               while(this.clickSomething(this.IconArray[this.selectorPos[this.selectorCat]],true))
               {
                  this.selectorPos[this.selectorCat] += ex / Math.abs(ex);
                  if(this.selectorPos[this.selectorCat] < this.selectorPos[this.selectorCat + "Start"])
                  {
                     if(this.selectorCat == "pattern")
                     {
                        this.selectorCat = "pants";
                     }
                     this.selectorPos[this.selectorCat] = this.selectorPos[this.selectorCat + "End"];
                     if(this.selectorCat == "hat")
                     {
                        this.hatScrollX = -80 * this.hasHatsN * 0.8 + 720;
                     }
                  }
                  if(this.selectorPos[this.selectorCat] > this.selectorPos[this.selectorCat + "End"])
                  {
                     if(this.selectorCat == "pants" && this.hasPatternsN > 0)
                     {
                        this.selectorCat = "pattern";
                     }
                     this.selectorPos[this.selectorCat] = this.selectorPos[this.selectorCat + "Start"];
                     if(this.selectorCat == "hat")
                     {
                        this.hatScrollX = 0;
                     }
                  }
               }
            }
         }
      }
      
      public function clickSomething(e:*, keys:Boolean = false) : Boolean
      {
         var o:int = 0;
         if(!this.canClick || !e.unlocked)
         {
            return true;
         }
         if(this[e.type + "N"] != e.ID)
         {
            o = int(this[e.type + "N"]);
            if(e.type == "pattern" && this.pantsN > -1)
            {
               this["pantsIconArray"][this.pantsN].ratio *= 1.25;
               this["pantsIconArray"][this.pantsN].drawOutline(1);
               this["pantsIconArray"][this.pantsN].selected = false;
               this.pantsN = -1;
            }
            else if(e.type == "pants" && this.patternN > 0)
            {
               this["patternIconArray"][this.patternN].ratio *= 1.25;
               this["patternIconArray"][this.patternN].drawOutline(1);
               this["patternIconArray"][this.patternN].selected = false;
               this.patternN = 0;
            }
            else if(o > -1)
            {
               this[e.type + "IconArray"][o].ratio *= 1.25;
               this[e.type + "IconArray"][o].drawOutline(1);
               this[e.type + "IconArray"][o].selected = false;
            }
            if(keys)
            {
               e.drawOutline(3);
            }
            else
            {
               if(this.selectorPos[this.selectorCat] > -1 && this.selectorCat != e.type)
               {
                  this.IconArray[this.selectorPos[this.selectorCat]].drawOutline(1);
                  this.selectorCat = e.type;
                  this.selectorCatN = this.selectorCatArray.indexOf(e.type);
               }
               this.selectorPos[this.selectorCat] = this.IconArray.indexOf(e);
               e.drawOutline(2);
            }
            e.selected = true;
            this[e.type + "N"] = e.ID;
            e.ratio *= 0.8;
            if(e.type == "pants")
            {
               this.forChar.doChangePants(e.ID,this.shine);
               this.shine = false;
            }
            else if(e.type == "hat")
            {
               this.forChar.doChangeHat(e.ID,this.shine);
               this.shine = false;
            }
            else if(e.type == "pattern")
            {
               this.forChar.doChangePattern(e.ID,this.shine);
               this.shine = false;
               if(Main.localSettings.canColor)
               {
                  this.redrawColors();
                  if(o == 0 && this.patternN > 0)
                  {
                     this.displayColors();
                  }
                  else if(o > 0 && this.patternN == 0)
                  {
                     this.selectorCatArray.splice(this.selectorCatArray.indexOf("color"),1);
                  }
               }
            }
            else if(e.type == "color")
            {
               this.redrawPatterns();
               this.forChar.doChangePatternColor(e.ID);
            }
         }
         e.scaleX = e.scaleY = e.ratio * 0.6;
         return false;
      }
      
      private function redrawPatterns() : void
      {
         if(this.hasPatternsArray.indexOf(true) > -1)
         {
            PauseIconCache.stamp.gotoAndStop(1);
            PauseIconCache.stamp.pattern.gotoAndStop(1);
            PauseIconCache.stamp.pants.transform.colorTransform = Main.getColorTransform(this.pantsN);
            if(Main.localSettings.canColor)
            {
               if(this.colorN == this.pantsN)
               {
                  PauseIconCache.stamp.pattern.transform.colorTransform = new ColorTransform();
               }
               else
               {
                  PauseIconCache.stamp.pattern.transform.colorTransform = Main.getColorTransform(this.colorN);
               }
            }
            for(i = 0; i < this.hasPatternsArray.length + 1; ++i)
            {
               if(this.patternIconArray[i] != undefined)
               {
                  this.patternIconArray[i].drawCurrentStamp("pattern",i,i == this.patternN);
                  this.patternIconArray[i].scaleX = this.patternIconArray[i].scaleY = this.patternIconArray[i].ratio * 0.8;
               }
            }
         }
      }
      
      private function redrawColors() : void
      {
         PauseIconCache.stamp.gotoAndStop(1);
         PauseIconCache.stamp.pattern.gotoAndStop(this.patternN);
         PauseIconCache.stamp.pants.transform.colorTransform = Main.getColorTransform(this.pantsN);
         for(i = 0; i < this.hasPantsArray.length + 4; ++i)
         {
            if(this.colorIconArray[i] != undefined)
            {
               if(this.patternN == 0)
               {
                  this.colorIconArray[i].ratio = 0;
               }
               else
               {
                  this.colorIconArray[i].drawCurrentStamp("color",i,i == this.colorN,this.forChar.pantsN);
                  this.colorIconArray[i].scaleX = this.colorIconArray[i].scaleY = this.colorIconArray[i].ratio * 0.8;
               }
            }
         }
      }
      
      public function settings() : void
      {
         this.forChar.saveCustom();
      }
      
      public function clickSetupGamepad() : void
      {
         Main.pauseStatus = "Gamepad";
         gamepadmenu = addChild(new setupGamepad());
         Sounds.playSoundSimple("Pause");
      }
      
      public function clickLanguage() : void
      {
         if(this.myLanguageSelector == null)
         {
            this.myLanguageSelector = new languageSelector();
            this.myLanguageSelector.x = 800 - 60;
            this.myLanguageSelector.y = 250 - 20;
            addChild(this.myLanguageSelector);
            Sounds.playSoundSimple("Pause");
            Main.pauseStatus = "Language";
         }
      }
      
      public function selectLanguage(e:MouseEvent) : void
      {
         if(e.target.parent != null && e.target.parent.parent == this.myLanguageSelector)
         {
            this.myLanguageSelector.levelClicked(e);
            Sounds.playSoundSimple("Pause");
         }
         else
         {
            Sounds.playSoundSimple("UnPause");
         }
         this.removeLanguageSelector();
      }
      
      public function removeLanguageSelector() : void
      {
         this.language.text = Main.localSettings.language;
         removeChild(this.myLanguageSelector);
         this.myLanguageSelector = null;
         Main.pauseStatus = "Menu";
         this.language.text = Main.localSettings.language;
      }
      
      public function clickCredits() : void
      {
         if(this.myCredits == null)
         {
            this.myCredits = new CreditsScreen();
            this.myCredits.x = Main.relativeStageX;
            this.myCredits.y = Main.relativeStageY;
            addChild(this.myCredits);
            Sounds.playSoundSimple("Pause");
            Main.pauseStatus = "Credits";
         }
      }
      
      public function removeCredits() : void
      {
         removeChild(this.myCredits);
         this.myCredits = null;
         Sounds.playSoundSimple("UnPause");
         Main.pauseStatus = "Menu";
      }
      
      private function showCombosList(e:MouseEvent) : *
      {
         Main.parse_orderAScore("maxCombo",true,15,function(e:*):*
         {
            var i:int = 0;
            var n:int = 0;
            Text.text = "\n\n";
            for(i in e)
            {
               Text.appendText(e[i][0].slice(0,e[i][0].length - 3));
               for(n = e[i][0].length - 3; n < 20; n++)
               {
                  Text.appendText(".");
               }
               for(n = int(e[i][1].toString().length); n < 10; n++)
               {
                  Text.appendText(".");
               }
               Text.appendText(e[i][1] + "\n");
            }
         });
      }
      
      private function showTimesList(e:MouseEvent) : *
      {
         Main.stageRoot.MiniclipAPI.services.showHighscores();
      }
      
      private function hideTheUI(e:MouseEvent) : *
      {
         visible = false;
         rootHUD.HUD.visible = false;
         Main.pauseStatus = "hideUI";
      }
      
      private function volumeKnobStart(e:MouseEvent) : *
      {
         this.currentKnob = e.target;
         e.target.removeEventListener(MouseEvent.MOUSE_DOWN,this.volumeKnobStart);
         addEventListener(MouseEvent.MOUSE_UP,this.volumeKnobEnd,false,0,true);
         addEventListener(MouseEvent.MOUSE_MOVE,this.volumeKnobDrag,false,0,true);
         addEventListener(MouseEvent.RELEASE_OUTSIDE,this.volumeKnobEnd,false,0,true);
         if(e.target.parent.name == "musicSlider")
         {
            if(Sounds.musicPlaying != "nothing")
            {
               Sounds.resumeMusic();
            }
         }
      }
      
      private function volumeKnobDrag(e:MouseEvent) : *
      {
         this.currentKnob.y = -(e.stageX / scaleX - this.currentKnob.parent.x);
         if(this.currentKnob.y < -150)
         {
            this.currentKnob.y = -150;
         }
         if(this.currentKnob.y > 0)
         {
            this.currentKnob.y = 0;
         }
         if(Math.abs(this.currentKnob.y + 100) < 5)
         {
            this.currentKnob.y = -100;
         }
         if(this.currentKnob.y > -5)
         {
            this.currentKnob.y = 0;
         }
         if(this.currentKnob.parent.name == "volumeSlider")
         {
            Sounds.setVolume(cosCurve(-this.currentKnob.y * 0.01));
         }
         else
         {
            Sounds.setMusic(cosCurve(-this.currentKnob.y * 0.01));
         }
      }
      
      private function volumeKnobEnd(e:MouseEvent) : *
      {
         removeEventListener(MouseEvent.MOUSE_UP,this.volumeKnobEnd);
         removeEventListener(MouseEvent.MOUSE_MOVE,this.volumeKnobDrag);
         removeEventListener(MouseEvent.RELEASE_OUTSIDE,this.volumeKnobEnd);
         this.currentKnob.addEventListener(MouseEvent.MOUSE_DOWN,this.volumeKnobStart,false,0,true);
         Main.parse_saveSettings();
         if(this.currentKnob.parent.name == "musicSlider")
         {
            if(Sounds.musicPlaying != "nothing")
            {
               Sounds.pauseMusic();
            }
         }
         this.currentKnob = null;
      }
      
      private function selectHat(event:MouseEvent) : *
      {
         this.forChar.changeHat(int(event.target.parent.name.substring(3)));
         Main.unPauseGame();
      }
      
      private function selectPants(e:MouseEvent) : *
      {
         this.forChar.changePants(int(e.currentTarget.name.substring(5)));
         Main.unPauseGame();
      }
      
      private function selectColor(e:MouseEvent) : *
      {
         this.forChar.changePatternColor(int(e.currentTarget.name.substring(5)));
         Main.unPauseGame();
      }
      
      private function selectPattern(e:MouseEvent) : *
      {
         this.forChar.changePattern(int(e.currentTarget.name.substring(7)));
         Main.unPauseGame();
      }
      
      internal function __setProp_timesList_PauseMenu_buttons_0() : *
      {
         try
         {
            this.timesList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.timesList.dir = "World 4";
         this.timesList.ID = "Dared3";
         this.timesList.door = -1;
         try
         {
            this.timesList["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_combosList_PauseMenu_buttons_0() : *
      {
         try
         {
            this.combosList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.combosList.dir = "World 4";
         this.combosList.ID = "Dared3";
         this.combosList.door = -1;
         try
         {
            this.combosList["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_hideUI_PauseMenu_buttons_0() : *
      {
         try
         {
            this.hideUI["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.hideUI.dir = "";
         this.hideUI.ID = "";
         this.hideUI.door = -1;
         try
         {
            this.hideUI["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_goFullscreen_PauseMenu_buttons_0() : *
      {
         try
         {
            this.goFullscreen["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.goFullscreen.dir = "";
         this.goFullscreen.ID = "";
         this.goFullscreen.door = -1;
         try
         {
            this.goFullscreen["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_quitToMenu_PauseMenu_buttons_0() : *
      {
         try
         {
            this.quitToMenu["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.quitToMenu.dir = "";
         this.quitToMenu.ID = "";
         this.quitToMenu.door = -1;
         try
         {
            this.quitToMenu["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_setupGamepadButton_PauseMenu_buttons_0() : *
      {
         if(this.__setPropDict[this.setupGamepadButton] == undefined || int(this.__setPropDict[this.setupGamepadButton]) != 1)
         {
            this.__setPropDict[this.setupGamepadButton] = 1;
            try
            {
               this.setupGamepadButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.setupGamepadButton.dir = "";
            this.setupGamepadButton.ID = "";
            this.setupGamepadButton.door = -1;
            try
            {
               this.setupGamepadButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_debugSelect_PauseMenu_buttons_0() : *
      {
         if(this.__setPropDict[this.debugSelect] == undefined || int(this.__setPropDict[this.debugSelect]) != 1)
         {
            this.__setPropDict[this.debugSelect] = 1;
            try
            {
               this.debugSelect["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.debugSelect.dir = "";
            this.debugSelect.ID = "";
            this.debugSelect.door = -1;
            try
            {
               this.debugSelect["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_quitButton_PauseMenu_buttons_0() : *
      {
         if(this.__setPropDict[this.quitButton] == undefined || int(this.__setPropDict[this.quitButton]) != 1)
         {
            this.__setPropDict[this.quitButton] = 1;
            try
            {
               this.quitButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.quitButton.dir = "";
            this.quitButton.ID = "";
            this.quitButton.door = -1;
            try
            {
               this.quitButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_creditsButton_PauseMenu_buttons_0() : *
      {
         if(this.__setPropDict[this.creditsButton] == undefined || int(this.__setPropDict[this.creditsButton]) != 1)
         {
            this.__setPropDict[this.creditsButton] = 1;
            try
            {
               this.creditsButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.creditsButton.dir = "";
            this.creditsButton.ID = "";
            this.creditsButton.door = -1;
            try
            {
               this.creditsButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_languageButton_PauseMenu_buttons_0() : *
      {
         if(this.__setPropDict[this.languageButton] == undefined || int(this.__setPropDict[this.languageButton]) != 1)
         {
            this.__setPropDict[this.languageButton] = 1;
            try
            {
               this.languageButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.languageButton.dir = "";
            this.languageButton.ID = "";
            this.languageButton.door = -1;
            try
            {
               this.languageButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_setupGamepadButton_PauseMenu_buttons_2() : *
      {
         if(this.__setPropDict[this.setupGamepadButton] == undefined || int(this.__setPropDict[this.setupGamepadButton]) != 3)
         {
            this.__setPropDict[this.setupGamepadButton] = 3;
            try
            {
               this.setupGamepadButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.setupGamepadButton.dir = "";
            this.setupGamepadButton.ID = "";
            this.setupGamepadButton.door = -1;
            try
            {
               this.setupGamepadButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_debugSelect_PauseMenu_buttons_2() : *
      {
         if(this.__setPropDict[this.debugSelect] == undefined || int(this.__setPropDict[this.debugSelect]) != 3)
         {
            this.__setPropDict[this.debugSelect] = 3;
            try
            {
               this.debugSelect["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.debugSelect.dir = "";
            this.debugSelect.ID = "";
            this.debugSelect.door = -1;
            try
            {
               this.debugSelect["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_quitButton_PauseMenu_buttons_2() : *
      {
         if(this.__setPropDict[this.quitButton] == undefined || int(this.__setPropDict[this.quitButton]) != 3)
         {
            this.__setPropDict[this.quitButton] = 3;
            try
            {
               this.quitButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.quitButton.dir = "";
            this.quitButton.ID = "";
            this.quitButton.door = -1;
            try
            {
               this.quitButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_creditsButton_PauseMenu_buttons_2() : *
      {
         if(this.__setPropDict[this.creditsButton] == undefined || int(this.__setPropDict[this.creditsButton]) != 3)
         {
            this.__setPropDict[this.creditsButton] = 3;
            try
            {
               this.creditsButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.creditsButton.dir = "";
            this.creditsButton.ID = "";
            this.creditsButton.door = -1;
            try
            {
               this.creditsButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_languageButton_PauseMenu_buttons_2() : *
      {
         if(this.__setPropDict[this.languageButton] == undefined || int(this.__setPropDict[this.languageButton]) != 3)
         {
            this.__setPropDict[this.languageButton] = 3;
            try
            {
               this.languageButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.languageButton.dir = "";
            this.languageButton.ID = "";
            this.languageButton.door = -1;
            try
            {
               this.languageButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function frame1() : *
      {
         this.__setProp_languageButton_PauseMenu_buttons_0();
         this.__setProp_creditsButton_PauseMenu_buttons_0();
         this.__setProp_quitButton_PauseMenu_buttons_0();
         this.__setProp_debugSelect_PauseMenu_buttons_0();
         this.__setProp_setupGamepadButton_PauseMenu_buttons_0();
      }
      
      internal function frame3() : *
      {
         this.__setProp_languageButton_PauseMenu_buttons_2();
         this.__setProp_creditsButton_PauseMenu_buttons_2();
         this.__setProp_quitButton_PauseMenu_buttons_2();
         this.__setProp_debugSelect_PauseMenu_buttons_2();
         this.__setProp_setupGamepadButton_PauseMenu_buttons_2();
      }
   }
}

