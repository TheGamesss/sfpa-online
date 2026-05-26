package
{
   import flash.display.*;
   
   public class staticInteractObjects extends MovieClip
   {
      
      public static var backgroundsN:int;
      
      public static var myPayWall:Object;
      
      public static var framin:Number;
      
      public static var killInteract:Vector.<MovieClip> = new Vector.<MovieClip>(0);
      
      public static var InteractArray:Vector.<MovieClip> = new Vector.<MovieClip>(0);
      
      public static var InteractEnterFrameArray:Vector.<MovieClip> = new Vector.<MovieClip>(0);
      
      public static var HalfInteractEnterFrameArray:Vector.<MovieClip> = new Vector.<MovieClip>(0);
      
      public static var cameraCollideArray:Vector.<MovieClip> = new Vector.<MovieClip>(0);
      
      public static var canAttackArray:Vector.<staticInteractObjects> = new Vector.<staticInteractObjects>(0);
      
      public static var inkCollideArray:Vector.<staticInteractObjects> = new Vector.<staticInteractObjects>(0);
      
      private static var cacheX:Vector.<int> = new Vector.<int>(0);
      
      private static var cacheY:Vector.<int> = new Vector.<int>(0);
      
      private static var cacheWide:Vector.<int> = new Vector.<int>(0);
      
      private static var cacheTall:Vector.<int> = new Vector.<int>(0);
      
      private static var cacheRail:Vector.<int> = new Vector.<int>(0);
      
      public static var DoorArray:Array = [];
      
      public static var textBubbleArray:Array = [];
      
      public static var dontCheat:Object = {};
      
      public static var uniqueCounter:uint = 0;
      
      public var interactive:Boolean = true;
      
      public var predictOffsetY:int = 0;
      
      public var onRail:int = 0;
      
      public var isWide:int = 0;
      
      public var isTall:int = 0;
      
      public var ItIs:String;
      
      public var warpLevel:String;
      
      public var warpDoor:int;
      
      public var ID:int = 0;
      
      public var removeID:int = -1;
      
      public var pairGate:int = -1;
      
      public var baddieGate:aWall;
      
      public var pairID:int = -1;
      
      public var uniqueID:int = -1;
      
      public var anchorX:int;
      
      public var anchorY:int;
      
      public var angle:Number;
      
      public var backEffect:Boolean = false;
      
      public function staticInteractObjects(itis:*, ex:*, ey:*, xsc:*, ysc:*, rail:*, estring:String = "nothing", enum:Number = -1)
      {
         super();
         this.ItIs = itis;
         this.anchorX = x = ex;
         this.anchorY = y = ey;
         scaleX = xsc;
         scaleY = ysc;
         this.onRail = rail;
         if(this.isWide == 0)
         {
            this.isWide = xsc * 50;
         }
         if(this.isTall == 0)
         {
            this.isTall = ysc * 50;
         }
         InteractArray.push(this);
         this.buildCache();
      }
      
      public static function InteractEnterFrames() : void
      {
         for(var i:* = int(InteractEnterFrameArray.length - 1); i >= 0; i--)
         {
            InteractEnterFrameArray[i].InteractEnterFrame() && spliceEnterByInt(i);
         }
      }
      
      public static function HalfInteractEnterFrames() : void
      {
         for(var i:int = 0; i < HalfInteractEnterFrameArray.length; i++)
         {
            HalfInteractEnterFrameArray[i].HalfInteractEnterFrame();
         }
      }
      
      internal static function clearAllInteractsOnRail(rail:*) : *
      {
         for(var i:* = int(InteractArray.length - 1); i >= 0; i--)
         {
            if(cacheRail[i] == rail)
            {
               InteractArray[i].parent.removeChild(InteractArray[i]);
               InteractArray[i].cleanUp();
               spliceAll(i);
            }
         }
         for(i = int(cameraCollideArray.length - 1); i >= 0; i--)
         {
            if(cameraCollideArray[i].onRail == rail)
            {
               cameraCollideArray.splice(i,1);
            }
         }
         for(i = int(InteractEnterFrameArray.length - 1); i >= 0; i--)
         {
            if(InteractEnterFrameArray[i].onRail == rail)
            {
               if(InteractEnterFrameArray[i].parent != null)
               {
                  InteractEnterFrameArray[i].parent.removeChild(InteractEnterFrameArray[i]);
               }
               InteractEnterFrameArray.splice(i,1);
            }
         }
      }
      
      internal static function clearAllInteracts(clearAll:Boolean) : *
      {
         checkKillInteracts();
         if(myPayWall != null)
         {
            if(myPayWall.parent != null)
            {
               myPayWall.parent.removeChild(myPayWall);
            }
            myPayWall = null;
         }
         for(var i:* = int(InteractArray.length - 1); i >= 0; i--)
         {
            if(clearAll || InteractArray[i].ItIs != "inkBoard")
            {
               if(InteractArray[i].parent != null)
               {
                  InteractArray[i].parent.removeChild(InteractArray[i]);
               }
               if(InteractEnterFrameArray.indexOf(InteractArray[i]) > -1)
               {
                  InteractEnterFrameArray.splice(InteractEnterFrameArray.indexOf(InteractArray[i]),1);
               }
               InteractArray[i].cleanUp();
               if(InteractArray.indexOf(InteractArray[i]) > -1)
               {
                  InteractArray.splice(InteractArray.indexOf(InteractArray[i]),1);
               }
            }
         }
         canAttackArray = new Vector.<staticInteractObjects>(0);
         inkCollideArray = new Vector.<staticInteractObjects>(0);
         cacheX = new Vector.<int>(0);
         cacheY = new Vector.<int>(0);
         cacheWide = new Vector.<int>(0);
         cacheTall = new Vector.<int>(0);
         cacheRail = new Vector.<int>(0);
         textBubbleArray = [];
         uniqueCounter = 0;
         n = InteractEnterFrameArray.length;
         for(i = 0; i < n; i++)
         {
            if(InteractEnterFrameArray[0].parent != null)
            {
               InteractEnterFrameArray[0].parent.removeChild(InteractEnterFrameArray[0]);
            }
            InteractEnterFrameArray.shift();
         }
         HalfInteractEnterFrameArray = new Vector.<MovieClip>(0);
         cameraCollideArray = new Vector.<MovieClip>(0);
         DoorArray = [];
         Checkpoint.resetCheckpoints();
         if(!clearAll)
         {
            for(i = 0; i < InteractArray.length; i++)
            {
               InteractArray[i].buildCache();
            }
         }
      }
      
      public static function clearByName(e:String) : void
      {
         for(var i:* = int(InteractArray.length - 1); i >= 0; i--)
         {
            if(InteractArray[i].ItIs == e)
            {
               if(InteractArray[i].parent != null)
               {
                  InteractArray[i].parent.removeChild(InteractArray[i]);
               }
               spliceAll(i);
            }
         }
         for(i = int(cameraCollideArray.length - 1); i >= 0; i--)
         {
            if(cameraCollideArray[i].ItIs == e)
            {
               cameraCollideArray.splice(i,1);
               i--;
            }
         }
         for(i = int(InteractEnterFrameArray.length - 1); i >= 0; i--)
         {
            if(InteractEnterFrameArray[i].ItIs == e)
            {
               if(InteractEnterFrameArray[i].parent != null)
               {
                  InteractEnterFrameArray[i].parent.removeChild(InteractEnterFrameArray[i]);
               }
               InteractEnterFrameArray.splice(i,1);
            }
         }
      }
      
      public static function clearByID(e:uint) : void
      {
         var i:uint = 0;
         var l:uint = InteractArray.length;
         while(i < l)
         {
            if(InteractArray[i].removeID == e)
            {
               killInteract.push(InteractArray[i]);
            }
            i++;
         }
      }
      
      public static function findByName(e:*) : staticInteractObjects
      {
         var i:uint = 0;
         var l:uint = InteractArray.length;
         while(i < l)
         {
            if(InteractArray[i].ItIs == e)
            {
               return InteractArray[i];
            }
            i++;
         }
      }
      
      public static function findByPairID(e:*) : staticInteractObjects
      {
         var i:uint = 0;
         var l:uint = InteractArray.length;
         while(i < l)
         {
            if(InteractArray[i].pairID == e)
            {
               return InteractArray[i];
            }
            i++;
         }
      }
      
      public static function findByUnique(e:*) : staticInteractObjects
      {
         var i:uint = 0;
         var l:uint = InteractArray.length;
         while(i < l)
         {
            if(InteractArray[i].uniqueID == e)
            {
               return InteractArray[i];
            }
            i++;
         }
      }
      
      public static function moveAllAttackablesY(ey:*, e:*) : void
      {
         for(var i:* = int(canAttackArray.length - 1); i >= 0; i--)
         {
            canAttackArray[i].y = ey;
            canAttackArray[i].myObject = e;
         }
      }
      
      public static function charCheckObjects(ex:Number, ey:Number, eWide:uint, eTall:uint, rail:int, char:collision) : Boolean
      {
         var n:uint = 0;
         var l:uint = InteractArray.length;
         while(n < l)
         {
            if(cacheRail[n] == rail && Math.abs(ex - cacheX[n]) < eWide + cacheWide[n] + 10 && Math.abs(ey - cacheY[n]) < eTall + cacheTall[n] + 10)
            {
               InteractArray[n].hitChar(ex,ey,char.moveRL,char.moveUD,char);
            }
            n++;
         }
      }
      
      public static function charCheckForCamera(ex:Number, ey:Number, eWide:uint, eTall:uint, rail:int, char:collision) : Boolean
      {
         var n:uint = 0;
         var l:uint = InteractArray.length;
         while(n < l)
         {
            if(cacheRail[n] == rail && InteractArray[n].ItIs != "WarpBox")
            {
               if(Math.abs(ex - cacheX[n]) < eWide + cacheWide[n] + 10 && Math.abs(ey - cacheY[n]) < eTall + cacheTall[n] + 10)
               {
                  InteractArray[n].hitChar(ex,ey,char.moveRL,char.moveUD,char);
               }
            }
            n++;
         }
      }
      
      public static function checkAttackables(char:*, rail:*) : Boolean
      {
         for(var i:* = int(canAttackArray.length - 1); i >= 0; i--)
         {
            if(canAttackArray[i].onRail == rail)
            {
               char.CheckAttack(canAttackArray[i]);
            }
         }
         return false;
      }
      
      internal static function findClosestCast(ex:*, ey:*, angle:*, rail:*) : Number
      {
         var distX:int = 0;
         var distY:int = 0;
         var angleDist:Number = NaN;
         var returnAngle:Number = angle;
         var dist:uint = 600;
         var i:uint = 0;
         var l:uint = inkCollideArray.length;
         while(i < l)
         {
            if(rail == inkCollideArray[i].onRail)
            {
               distX = inkCollideArray[i].x - ex;
               distY = inkCollideArray[i].y - ey;
               if(Math.abs(distX) < dist)
               {
                  angleDist = Math.abs(-Math.atan2(distX,distY) - angle);
                  if(angleDist < 0.2)
                  {
                     dist = Math.abs(distX);
                     returnAngle = -Math.atan2(distX,distY);
                  }
               }
            }
            i++;
         }
         return returnAngle;
      }
      
      public static function checkInk(ex:*, ey:*, eRL:*, wide:*, tall:*, rail:*, ink:*) : Boolean
      {
         for(var i:* = int(inkCollideArray.length - 1); i >= 0; i--)
         {
            if(inkCollideArray[i].quickCheckDist(ex,ey,wide + Math.abs(eRL * 0.5),tall,rail))
            {
               return inkCollideArray[i].hitInk(ex,ey,eRL,ink);
            }
         }
         return false;
      }
      
      public static function cameraCheckObjects(ex:Number, ey:Number, wide:uint, tall:uint, rail:int, char:collision) : Boolean
      {
         var n:uint = 0;
         var l:uint = cameraCollideArray.length;
         while(n < l)
         {
            if(cameraCollideArray[n].quickCheckDist(ex,ey,wide,tall,rail))
            {
               char.predictOffsetY = cameraCollideArray[n].predictOffsetY;
               return true;
            }
            n++;
         }
         return false;
      }
      
      public static function baddieCheckObjects(ex:Number, ey:Number, wide:uint, tall:uint, rail:int, char:collision) : *
      {
         for(var n:int = 0; n < InteractArray.length; n++)
         {
            if(cacheRail[n] == rail)
            {
               if(Math.abs(ex - cacheX[n]) < wide + cacheWide[n] && Math.abs(ey - cacheY[n]) < tall + cacheTall[n])
               {
                  InteractArray[n].hitBaddie(ex,ey,char.moveRL,char.moveUD,char);
               }
            }
         }
      }
      
      public static function checkKillInteracts() : *
      {
         var i:int = 0;
         var tempN:uint = 0;
         var n:int = 0;
         if(killInteract.length > 0)
         {
            for(i = 0; i < killInteract.length; i++)
            {
               tempN = InteractArray.indexOf(killInteract[i]);
               if(tempN > -1)
               {
                  spliceAll(tempN);
               }
               if(InteractEnterFrameArray.indexOf(killInteract[i]) > -1)
               {
                  InteractEnterFrameArray.splice(InteractEnterFrameArray.indexOf(killInteract[i]),1);
               }
               if(HalfInteractEnterFrameArray.indexOf(killInteract[i]) > -1)
               {
                  HalfInteractEnterFrameArray.splice(HalfInteractEnterFrameArray.indexOf(killInteract[i]),1);
               }
               if(canAttackArray.indexOf(killInteract[i]) > -1)
               {
                  canAttackArray.splice(canAttackArray.indexOf(killInteract[i]),1);
               }
               if(cameraCollideArray.indexOf(killInteract[i]) > -1)
               {
                  cameraCollideArray.splice(cameraCollideArray.indexOf(killInteract[i]),1);
               }
               if(inkCollideArray.indexOf(killInteract[i]) > -1)
               {
                  inkCollideArray.splice(inkCollideArray.indexOf(killInteract[i]),1);
               }
               if(killInteract[i].onRail >= Main.backgroundsN)
               {
                  for(n = 0; n < Main.AllBoxObjects.length; n++)
                  {
                     if(killInteract[i].x == Main.AllBoxObjects[n][1] && killInteract[i].y == Main.AllBoxObjects[n][2])
                     {
                        Main.AllBoxObjects.splice(n,1);
                        break;
                     }
                  }
               }
               if(killInteract[i].parent != null)
               {
                  killInteract[i].parent.removeChild(killInteract[i]);
               }
            }
            killInteract = new Vector.<MovieClip>(0);
         }
      }
      
      private static function spliceAll(i:*) : void
      {
         InteractArray.splice(i,1);
         cacheX.splice(i,1);
         cacheY.splice(i,1);
         cacheWide.splice(i,1);
         cacheTall.splice(i,1);
         cacheRail.splice(i,1);
      }
      
      private static function spliceEnterByInt(i:*) : void
      {
         InteractEnterFrameArray.splice(i,1);
      }
      
      public static function pairMyGate(n:*, gate:*) : void
      {
         for(var i:int = 0; i < InteractArray.length; i++)
         {
            if(InteractArray[i].pairGate == n)
            {
               InteractArray[i].baddieGate = gate;
            }
         }
      }
      
      public static function findLevelDoor(level:*) : int
      {
         var i:int = 0;
         var l:int = int(DoorArray.length);
         while(i < l)
         {
            if(DoorArray[i].warpLevel == level)
            {
               return i;
            }
            i++;
         }
         return 0;
      }
      
      public static function swapTextBubbles(lang:*) : void
      {
         textBubbles.spawnTextStamp();
         var i:uint = 0;
         var l:uint = textBubbleArray.length;
         while(i < l)
         {
            if(textBubbleArray[i] != undefined && Boolean(textBubbleArray[i].out))
            {
               textBubbleArray[i].setupLanguage();
            }
            i++;
         }
      }
      
      public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
      }
      
      public function hitBaddie(ex:Number, ey:Number, eRL:Number, eUD:Number, baddie:Baddies) : Boolean
      {
      }
      
      public function InteractEnterFrame() : Boolean
      {
      }
      
      public function HalfInteractEnterFrame() : void
      {
      }
      
      public function cleanUp() : void
      {
      }
      
      private function buildCache() : void
      {
         cacheX.push(x);
         cacheY.push(y);
         cacheWide.push(this.isWide);
         cacheTall.push(this.isTall);
         cacheRail.push(this.onRail);
      }
      
      public function updateCache() : void
      {
         var i:int = InteractArray.indexOf(this);
         if(i > -1)
         {
            cacheX[i] = x;
            cacheY[i] = y;
            cacheWide[i] = this.isWide;
            cacheTall[i] = this.isTall;
            cacheRail[i] = this.onRail;
         }
      }
      
      public function spliceEnterFrames() : void
      {
         if(InteractEnterFrameArray.indexOf(this) > -1)
         {
            InteractEnterFrameArray.splice(InteractEnterFrameArray.indexOf(this),1);
         }
         if(HalfInteractEnterFrameArray.indexOf(this) > -1)
         {
            HalfInteractEnterFrameArray.splice(HalfInteractEnterFrameArray.indexOf(this),1);
         }
      }
      
      public function quickCheckDist(ex:*, ey:*, wide:*, tall:*, rail:*) : Boolean
      {
         return rail == this.onRail && Math.abs(ex - x) < wide + this.isWide && Math.abs(ey - y) < tall + this.isTall;
      }
   }
}

