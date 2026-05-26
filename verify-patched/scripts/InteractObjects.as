package
{
   public class InteractObjects extends collision
   {
      
      public static var killInteract:Vector.<InteractObjects> = new Vector.<InteractObjects>(0);
      
      public static var InteractArray:Vector.<InteractObjects> = new Vector.<InteractObjects>(0);
      
      public static var canAttackArray:Vector.<InteractObjects> = new Vector.<InteractObjects>(0);
      
      public var interactive:Boolean = true;
      
      public function InteractObjects(rail:int = -20)
      {
         InteractArray.push(this);
         super(rail);
      }
      
      public static function InteractEnterFrames() : void
      {
         for(var i:int = 0; i < InteractArray.length; i++)
         {
            if(InteractArray[i].downTime > 0)
            {
               --InteractArray[i].downTime;
            }
            InteractArray[i].InteractEnterFrame();
         }
      }
      
      public static function InteractsCheckMoving() : void
      {
         for(var i:int = 0; i < InteractArray.length; i++)
         {
            InteractArray[i].CheckMovingStuff();
         }
      }
      
      public static function runCollisions() : void
      {
         for(var i:int = 0; i < InteractArray.length; i++)
         {
            InteractArray[i].EveryCollision();
         }
      }
      
      internal static function clearIceCream() : void
      {
         var temp:Boolean = false;
         var n:int = int(InteractArray.length);
         for(var i:uint = 0; i < n; i++)
         {
            if(InteractArray[i].ItIs == "iceCreamPickup")
            {
               temp = true;
               InteractArray[i].updateStats(Char.CharArray[0]);
            }
         }
         if(temp)
         {
            Sounds.playSoundSimple("success");
         }
      }
      
      internal static function clearAllInteracts() : *
      {
         checkKillInteracts();
         var n:int = int(InteractArray.length);
         for(var i:uint = 0; i < n; i++)
         {
            InteractArray[i].cleanUp();
            if(InteractArray[i].parent != null)
            {
               InteractArray[i].parent.removeChild(InteractArray[i]);
            }
         }
         InteractArray = new Vector.<InteractObjects>(0);
         canAttackArray = new Vector.<InteractObjects>(0);
      }
      
      public static function charCheckObjects(ex:Number, ey:Number, eWide:uint, eTall:uint, rail:int, char:Char) : void
      {
         for(var n:int = 0; n < InteractArray.length; n++)
         {
            if(InteractArray[n].onRail == rail && InteractArray[n].downTime == 0 && Math.abs(ex - InteractArray[n].x) < eWide + InteractArray[n].isWide && Math.abs(ey - InteractArray[n].y) < eTall + InteractArray[n].isTall)
            {
               InteractArray[n].hitChar(ex,ey,char.moveRL,char.moveUD,char);
            }
         }
      }
      
      public static function baddieCheckObjects(ex:Number, ey:Number, eWide:uint, eTall:uint, rail:int, char:Baddies) : *
      {
         for(var n:int = 0; n < InteractArray.length; n++)
         {
            if(InteractArray[n].onRail == rail && Math.abs(ex - InteractArray[n].x) < eWide + InteractArray[n].isWide && Math.abs(ey - InteractArray[n].y) < eTall + InteractArray[n].isTall)
            {
               InteractArray[n].hitBaddie(ex,ey,char.moveRL,char.moveUD,char);
            }
         }
      }
      
      public static function checkAttackables(char:*, rail:*) : Boolean
      {
         for(var i:* = int(canAttackArray.length - 1); i >= 0; i--)
         {
            if(canAttackArray[i].onRail == rail)
            {
               if(!char.CheckAttack(canAttackArray[i]))
               {
               }
            }
         }
         return false;
      }
      
      public static function checkKillInteracts() : *
      {
         var i:int = 0;
         if(killInteract.length > 0)
         {
            for(i = 0; i < killInteract.length; i++)
            {
               InteractArray.splice(InteractArray.indexOf(killInteract[i]),1);
               killInteract[i].cleanUp();
               killInteract[i].parent.removeChild(killInteract[i]);
               if(canAttackArray.indexOf(killInteract[i]) > -1)
               {
                  canAttackArray.splice(canAttackArray.indexOf(killInteract[i]),1);
               }
            }
            killInteract = new Vector.<InteractObjects>(0);
         }
      }
      
      public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
      }
      
      public function hitBaddie(ex:Number, ey:Number, eRL:Number, eUD:Number, baddie:Baddies) : Boolean
      {
      }
      
      public function InteractEnterFrame() : void
      {
      }
      
      public function EveryCollision() : void
      {
         if(BallRes == 0)
         {
            x += moveRL * Main.framin;
            y += moveUD * Main.framin;
         }
         else if(Status == "Walk")
         {
            CheckAllGrounds();
            rotter = (wallRot - rotation) / 3 * Main.framin;
         }
         else if(CheckAllAir())
         {
            rotter = (fakeRL - platRL - wallRL) * rotPerc;
            wallRL = wallUD = platRL = platUD = 0;
         }
         else
         {
            wallRot = 0;
            rotter += (moveRL * 3 - rotter) / 20 * Main.framin;
         }
         rotation += rotter * Main.framin;
      }
      
      public function cleanUp() : void
      {
      }
   }
}

