package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol2553")]
   public class SquigglePop extends staticInteractObjects
   {
      
      private var canPop:Boolean = true;
      
      private var levelloaded:String;
      
      public function SquigglePop(p:*)
      {
         super("SquigglePop",p.x,p.y,1,1,p.onRail,"nothing",-1);
         isTall = 25;
         isWide = 25;
         ID = p.ID;
         cameraCollideArray.push(this);
         canAttackArray.push(this);
         predictOffsetY = 100;
         this.levelloaded = Main.LoadIt;
         Backgrounds.backgroundsArray[onRail].addChild(this);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         distRL = x - ex;
         distUD = y - ey;
         tempRot = -Math.atan2(distRL,distUD) / (Math.PI / 180);
         angle = tempRot * Math.PI / 180;
         ax = Math.cos(angle) * distRL + Math.sin(angle) * distUD;
         ay = Math.cos(angle) * distUD - Math.sin(angle) * distRL;
         if(-ay < isTall + char.isTall)
         {
            tempRL = Math.cos(angle) * eRL + Math.sin(angle) * eUD;
            tempUD = Math.cos(angle) * eUD - Math.sin(angle) * eRL;
            if(tempUD < 0)
            {
               return;
            }
            tempUD = -15;
            ay = -(char.isTall + isTall);
            char.x = x + (Math.cos(angle) * ax - Math.sin(angle) * ay);
            char.y = y + (Math.cos(angle) * ay + Math.sin(angle) * ax);
            if(this.canPop)
            {
               this.pop(char);
            }
            if(char.Status == "Jump" || char.Status == "Roll")
            {
               if(Math.abs(tempRot) < 60)
               {
                  angle = tempRot * 0.5 * Math.PI / 180;
               }
               if(eUD > 0)
               {
                  char.FloatUp = 6;
               }
               else
               {
                  char.FloatUp = 0;
               }
               char.moveRL = Math.cos(angle) * (tempRL / 2) - Math.sin(angle) * (tempUD / 2);
               char.moveUD = Math.cos(angle) * tempUD + Math.sin(angle) * (tempRL / 2);
               if(char.Status == "Jump")
               {
                  char.rotter = 0;
               }
               if(char.moveUD > 2)
               {
                  char.moveUD = 2;
               }
               else if(char.moveUD < -18)
               {
                  char.moveUD = -18;
               }
               char.fliprot = char.moveRL * 1.3;
               if(Math.abs(char.fliprot) > 15)
               {
                  char.fliprot = char.makeOne(char.fliprot) * 15;
               }
               char.resetPencil();
               if(char.JumpIsDown() && char.moveUD < 0)
               {
                  char.char.gotoAndStop("normal");
                  char.char.char.gotoAndStop(3);
               }
               else
               {
                  char.char.gotoAndStop("dropJump");
                  char.char.char.gotoAndStop(4);
               }
               char.rotter = char.moveRL;
               char.placeHead(char.char.char);
            }
         }
      }
      
      override public function hitBaddie(ex:Number, ey:Number, eRL:Number, eUD:Number, baddie:Baddies) : Boolean
      {
         distRL = x - ex;
         distUD = y - ey;
         tempRot = -Math.atan2(distRL,distUD) / (Math.PI / 180);
         angle = tempRot * Math.PI / 180;
         ax = Math.cos(angle) * distRL + Math.sin(angle) * distUD;
         ay = Math.cos(angle) * distUD - Math.sin(angle) * distRL;
         if(-ay < isTall + baddie.isTall)
         {
            tempRL = Math.cos(angle) * eRL + Math.sin(angle) * eUD;
            tempUD = -20;
            ay = -(baddie.isTall + isTall);
            baddie.spring = -10;
            baddie.x = x + (Math.cos(angle) * ax - Math.sin(angle) * ay);
            baddie.y = y + (Math.cos(angle) * ay + Math.sin(angle) * ax);
            baddie.moveRL = Math.cos(angle) * (tempRL / 2) - Math.sin(angle) * (tempUD / 2);
            baddie.moveUD = Math.cos(angle) * tempUD + Math.sin(angle) * (tempRL / 2);
            if(this.canPop)
            {
               this.pop(baddie);
            }
         }
      }
      
      public function currentGetAttacked(ex:*, ey:*, ang:*, char:*, hitMove:*, hitPower:*) : Boolean
      {
         angle = ang - 3.14;
         this.pop();
         return true;
      }
      
      public function pop(e:*) : *
      {
         if(!dontCheat[this.levelloaded][ID])
         {
            if(Math.cos(angle) > 0)
            {
               new looseSquiggle(x - 10 + -Math.sin(angle - 0.1) * 15,y,-Math.sin(angle - 0.1) * 6,0,onRail);
               new looseSquiggle(x + -Math.sin(angle) * 20,y + 20,-Math.sin(angle) * 7,0,onRail);
               new looseSquiggle(x + 10 + -Math.sin(angle + 0.1) * 18,y + 10,-Math.sin(angle + 0.1) * 6.5,0,onRail);
            }
            else
            {
               new looseSquiggle(x - 10 + -Math.sin(angle - 0.1) * 15,y + Math.cos(angle - 0.1) * 15,-Math.sin(angle - 0.1) * 6,Math.cos(angle - 0.1) * 15,onRail);
               new looseSquiggle(x + -Math.sin(angle) * 20,y + Math.cos(angle) * 20,-Math.sin(angle) * 7,Math.cos(angle) * 20,onRail);
               new looseSquiggle(x + 10 + -Math.sin(angle + 0.1) * 18,y + Math.cos(angle + 0.1) * 18,-Math.sin(angle + 0.1) * 6.5,Math.cos(angle + 0.1) * 18,onRail);
            }
         }
         Sounds.playSound("Popper",x,1.5,onRail);
         cachedEffects.spawnCachedEffect("SquigPop",x,y,Math.random() * 360,1,0,0,onRail,e.parent);
         cachedEffects.spawnCachedEffect("Pop",x,y,Math.random() * 360,1,0,0,onRail,e.parent);
         dontCheat[Main.LevelLoaded][ID] = true;
         this.canPop = false;
         killInteract.push(this);
      }
   }
}

