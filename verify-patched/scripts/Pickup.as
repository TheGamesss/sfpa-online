package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3704")]
   public class Pickup extends staticInteractObjects
   {
      
      public var check:MovieClip;
      
      public var getit:MovieClip;
      
      public var hats:MovieClip;
      
      public var orb:MovieClip;
      
      public var patterns:pantsTexture;
      
      private var pickupType:String;
      
      private var pickupNum:uint;
      
      private var disabled:Boolean;
      
      private var hasString:String;
      
      private var stopChar:Boolean;
      
      public function Pickup(p:*)
      {
         isWide = 40;
         isTall = 60;
         super("Pickup",p.x,p.y,1,1,p.rail,p.pickup,p.num);
         this.stopChar = Main.DirIt == "World 4";
         Backgrounds.backgroundsArray[p.rail].addChild(this);
         if(p.pickup == "test")
         {
            this.pickupType = Main.getRewardType(Main.LoadIt);
            this.pickupNum = Main.getRewardNumber(Main.LoadIt);
         }
         else
         {
            this.pickupType = p.pickup;
            this.pickupNum = p.num;
         }
         if(this.pickupType == "Hat")
         {
            this.hasString = "hasHatsString";
         }
         else if(this.pickupType == "Pants")
         {
            this.hasString = "hasPantsString";
         }
         else if(this.pickupType == "Pattern")
         {
            this.hasString = "hasPatternsString";
         }
         if(Main.localSettings[this.hasString].substr(this.pickupNum - 1,1) == "y")
         {
            this.check.visible = true;
         }
         else
         {
            this.check.visible = false;
         }
         if(this.pickupType == "nothing")
         {
            gotoAndStop(1);
         }
         else if(this.pickupType == "Hat")
         {
            gotoAndStop(3);
            this.hats.gotoAndStop(this.pickupNum);
         }
         else if(this.pickupType == "Pants")
         {
            gotoAndStop(4);
            this.pickupNum += 3;
            this.orb.gotoAndStop(1);
            this.orb.transform.colorTransform = Main.getColorTransform(this.pickupNum);
         }
         else if(this.pickupType == "Pattern")
         {
            gotoAndStop(5);
            this.patterns.gotoAndStop(this.pickupNum);
         }
         else
         {
            gotoAndStop(1);
         }
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(this.disabled)
         {
            if(this.stopChar)
            {
               if((x - ex) * eRL < 0)
               {
                  if(Math.abs(x - ex) > 40)
                  {
                     char.x = x + char.makeOne(ex - x) * 40;
                     char.moveRL = 0;
                  }
               }
            }
         }
         else if(Math.abs(ex - x) < 40 && Math.abs(ey - y) < 50)
         {
            this.disabled = true;
            if(this.pickupType != "nothing")
            {
               char["change" + this.pickupType](this.pickupNum);
               Main.parse_saveSettings();
               if(this.pickupType == "Pants")
               {
                  if(char.patternN > 0)
                  {
                     char.doChangePatternColor(char.colorN);
                  }
               }
               if(Main.DirIt == "World 4")
               {
                  Main.challengeAchievements();
               }
            }
            char.hitPause = 5;
            visible = false;
            StarlingEffect.Spawn("popEffect",x,y,Math.random() * 3,2,0,0,char.onRail);
            Main.shakeScreen(20,0,true);
            if(this.stopChar)
            {
               char.Still = true;
               char.superStill = true;
               Sounds.fadeOutMusic("nothing",0.2);
               Sounds.playSoundSimple("success");
               Sounds.playOnce("Stinger");
               Main.justSetShifts(x + eRL * 3,y - 50,50);
               Main.lockShiftZ = Main.cameraShiftZ;
               Main.switchScroll("quickScroll");
               rootHUD.HUD.finishChallenge();
               char.disableControls();
               visible = false;
               char.canQuickDrop = true;
               char.FloatUp = 0;
               if(Math.abs(eRL) > 20)
               {
                  char.moveRL = char.makeOne(eRL) * 20;
               }
               if(eUD < -10)
               {
                  char.moveUD = -10;
               }
               char.crossStatus = "Celebrate";
            }
         }
      }
   }
}

