package
{
   import flash.display.Sprite;
   import starling.display.MovieClip;
   
   public class aWall extends Sprite
   {
      
      private static var tempStatus:String;
      
      private static var tempWall:aWall;
      
      public static var WallArray:Array = new Array();
      
      private static var breakableArray:Vector.<aWall> = new Vector.<aWall>(0);
      
      private static var outlineArray:Vector.<aWall> = new Vector.<aWall>(0);
      
      private static var messageOutline:Boolean = true;
      
      private static var superID:uint = 0;
      
      private var MoveEnterFrame:Function;
      
      private var ItIs:String;
      
      private var wallX:int;
      
      private var wallY:int;
      
      private var maxScaleX:Number;
      
      private var maxScaleY:Number;
      
      public var isWide:Number;
      
      public var isTall:Number;
      
      public var springTall:Number;
      
      private var scalex:Number;
      
      private var scaley:Number;
      
      public var scale:uint = 1;
      
      private var springX:Number = 0;
      
      public var springY:Number = 0;
      
      private var springyX:Number;
      
      private var springyY:Number;
      
      private var spring:Number;
      
      private var fakeX:Number = 0;
      
      private var fakeRL:Number = 0;
      
      private var fakeUD:Number = 0;
      
      private var moveRL:Number = 0;
      
      private var moveUD:Number = 0;
      
      private var moveRot:Number;
      
      private var Wait:Boolean;
      
      private var Outline:Boolean;
      
      private var Pause:int;
      
      private var maxPause:int;
      
      private var maxDist:int;
      
      private var Cruise:int;
      
      private var Status:String;
      
      private var hurt:Boolean;
      
      private var pressBlock:MovieClip;
      
      private var ID:int;
      
      private var hide:Boolean;
      
      private var removeID:int = -1;
      
      private var pair:int;
      
      private var dir:int;
      
      private var CharsOn:Array;
      
      private var blockBuddies:*;
      
      public var inky:Boolean = false;
      
      public var step:int = 0;
      
      public var mass:int;
      
      public var force:Number;
      
      private var suppressJump:Boolean;
      
      public var health:int = -20;
      
      public var downTime:Number = 0;
      
      private var shakeRL:Number = 0;
      
      private var attachBack:Boolean;
      
      private var mySuperID:uint = 0;
      
      public var backEffect:Boolean = true;
      
      private var smokeLabel:String = "nothing";
      
      private var pairID:int = -1;
      
      private var fromTemp:Boolean;
      
      public var onRail:int;
      
      private var blockNames:Array;
      
      public function aWall(p:*)
      {
         var n:int = 0;
         this.MoveEnterFrame = function():*
         {
         };
         this.CharsOn = new Array();
         this.blockBuddies = new Array();
         this.blockNames = ["squiggle0","villa0","lava0","lava1"];
         super();
         this.wallX = x = p.x;
         this.wallY = y = p.y;
         this.moveRot = p.moveRot;
         this.scalex = this.maxScaleX = p.scaleX;
         this.scaley = this.maxScaleY = p.scaleY;
         this.isWide = this.scalex * 50;
         this.springTall = this.isTall = this.scaley * 50;
         this.mass = 1;
         this.Status = p.status;
         this.ID = p.ID;
         this.onRail = p.rail;
         this.pair = p.pair;
         this.Pause = this.maxPause = p.pause;
         this.Cruise = p.cruise;
         this.hurt = p.hurt;
         if(p.wait)
         {
            this.Wait = true;
         }
         else
         {
            this.Wait = false;
            this.MoveEnterFrame = this[p.status + "EnterFrame"];
         }
         if(p.hide)
         {
            this.hide = true;
         }
         if(p.outline)
         {
            outlineArray.push(this);
            this.Outline = true;
            this.downTime = 1;
         }
         if(p.removeID != undefined)
         {
            this.removeID = p.removeID;
         }
         if(p.max < 0)
         {
            p.max = 0;
         }
         if(p.status == "Push")
         {
            this.fakeRL = 0;
            if(p.max == 0)
            {
               this.maxDist = 10000;
            }
            else
            {
               this.maxDist = p.max;
            }
         }
         else
         {
            this.fakeRL = this.dir = p.max;
         }
         if(p.status == "Breakable")
         {
            breakableArray.push(this);
         }
         if(p.attachBack != undefined)
         {
            this.attachBack = p.attachBack;
         }
         if(p.smokeLabel != undefined)
         {
            this.smokeLabel = p.smokeLabel;
         }
         if(p.pairID != undefined)
         {
            this.pairID = p.pairID;
         }
         if(p.fromTemp != undefined)
         {
            this.fromTemp = p.fromTemp;
         }
         if(p.springY == undefined)
         {
            this.springyY = 300;
         }
         else
         {
            this.springyY = p.springY;
         }
         walls = Main.AllEverything["walls" + this.onRail];
         WallArray.push(this);
         this.inky = this.ID == 2;
         if(this.Status == "Breakable")
         {
            n = uint(Math.random() * 3) - 1;
         }
         else
         {
            n = 0;
         }
         if(this.fromTemp)
         {
            this.pressBlock = StarlingTemporary.justGetWithN(StarlingTemporary.Spawn("aWallStamp",p.x,p.y,n * 1.57,1,this.onRail,false,0,this.attachBack));
         }
         else
         {
            this.pressBlock = StarlingSmoke.Spawn("aWallStamp",p.x,p.y,n * 1.57,1,0,0,this.onRail,this.attachBack);
         }
         if(!this.fromTemp)
         {
            if(Math.abs(n) == 1)
            {
               this.pressBlock.scaleX = p.scaleY;
               this.pressBlock.scaleY = p.scaleX;
            }
            else
            {
               this.pressBlock.scaleX = p.scaleX;
               this.pressBlock.scaleY = p.scaleY;
            }
         }
         var i:int = 0;
         while(i < p.ahead)
         {
            this.MoveEnterFrame();
            i++;
         }
         visible = false;
      }
      
      internal static function pairBlocks() : *
      {
         for(var i:uint = 0; i < WallArray.length; i++)
         {
            WallArray[i].pairBlock(i);
         }
      }
      
      internal static function clearAllWalls() : void
      {
         var i:int = 0;
         var l:int = int(WallArray.length);
         while(i < l)
         {
            if(WallArray[i].fromTemp)
            {
               WallArray[i].pressBlock.cleanUp();
            }
            else
            {
               WallArray[i].pressBlock.goSwim();
            }
            WallArray[i].pressBlock = null;
            if(WallArray[i].parent != null)
            {
               WallArray[i].parent.removeChild(WallArray[i]);
            }
            i++;
         }
         WallArray = [];
         breakableArray = new Vector.<aWall>(0);
         outlineArray = new Vector.<aWall>(0);
      }
      
      internal static function clearAllOns() : void
      {
         for(var i:int = 0; i < WallArray.length; i++)
         {
            WallArray[i].CharsOn = [];
         }
      }
      
      public static function aWallOnClear(char:*) : void
      {
         char.aWallOn.CharsOn.splice(char.aWallOn.CharsOn.indexOf(char),1);
         char.aWallOn = null;
      }
      
      public static function clearByID(e:uint) : void
      {
         for(var i:* = int(WallArray.length - 1); i >= 0; i--)
         {
            if(WallArray[i].removeID == e)
            {
               WallArray[i].removeWall();
            }
         }
      }
      
      public static function findByType(e:String) : aWall
      {
         for(var i:* = int(WallArray.length - 1); i >= 0; i--)
         {
            if(WallArray[i].Status == e)
            {
               return WallArray[i];
            }
         }
      }
      
      public static function checkBreakables(char:*) : Boolean
      {
         var temp:Boolean = false;
         for(var i:int = 0; i < breakableArray.length; i++)
         {
            if(breakableArray[i].onRail == char.onRail && breakableArray[i].downTime == 0 && breakableArray[i].CharsOn.indexOf(char) == -1 && Boolean(char.CheckAttack(breakableArray[i])))
            {
               temp = true;
            }
         }
         return temp;
      }
      
      internal static function findClosestCast(ex:*, ey:*, angle:*, rail:*) : Number
      {
         var distX:int = 0;
         var distY:int = 0;
         var angleDist:Number = NaN;
         var returnAngle:Number = angle;
         var dist:uint = 600;
         var i:uint = 0;
         var l:uint = uint(outlineArray.length);
         while(i < l)
         {
            if(rail == outlineArray[i].onRail)
            {
               distX = outlineArray[i].x - ex;
               distY = outlineArray[i].y - ey;
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
      
      public static function checkOutlines(ex:int, ey:int, wide:int, tall:int, rail:int) : Boolean
      {
         var temp:Boolean = false;
         for(var i:* = int(outlineArray.length - 1); i >= 0; i--)
         {
            if(outlineArray[i].checkOutline(ex,ey,wide,tall,rail,i))
            {
               temp = true;
            }
         }
         return temp;
      }
      
      public static function checkAttackFromBad(ex:Number, ey:Number, distX:Number, distY:Number, facing:int, angle:Number, power:Number) : Boolean
      {
         var dist:int = 0;
         for(var i:uint = 0; i < breakableArray.length; i++)
         {
            dist = breakableArray[i].x - ex;
            if(dist * facing > 0)
            {
               if(Math.abs(dist) < distX && Math.abs(breakableArray[i].y - ey) < distY + breakableArray[i].isTall)
               {
                  StarlingEffect.Spawn("impactEffect",breakableArray[i].x,breakableArray[i].y,120 * facing,1,0,0,breakableArray[i].onRail);
                  StarlingEffect.Spawn("popEffect",breakableArray[i].x,breakableArray[i].y,Math.random() * 3,1,0,0,Backgrounds.backgroundsArray[breakableArray[i].onRail]);
                  breakableArray[i].springyX = ex;
                  breakableArray[i].springyY = ey;
                  breakableArray[i].shakeRL = power * 2;
                  return true;
               }
            }
         }
         return false;
      }
      
      internal static function WallEnterFrames() : *
      {
         var i:int = 0;
         while(i < WallArray.length)
         {
            WallArray[i].WallEnterFrames();
            i++;
         }
      }
      
      internal static function CheckWalls(e:*) : *
      {
         if(e.aWallOn != null && e.Status != "Roll")
         {
            e.aWallOn.CharsOn.push(e);
         }
      }
      
      internal static function quickCheckWalls(ex:Number, ey:Number, wide:uint, rail:int) : Boolean
      {
         for(var i:* = int(WallArray.length - 1); i >= 0; i--)
         {
            if(rail == WallArray[i].onRail)
            {
               if(Math.abs(WallArray[i].x - ex) < WallArray[i].isWide + wide && Math.abs(WallArray[i].y - ey) < WallArray[i].isTall)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      internal static function WallCollision(ex:*, ey:*, eRL:*, eUD:*, e:*, ground:*) : Boolean
      {
         var status:String = null;
         tempStatus = "nothing";
         for(var i:int = 0; i < WallArray.length; i++)
         {
            status = WallArray[i].wallCheckCollision(e.x,e.y,e.moveRL,e.moveUD,e,ground,"nothing");
            if(status != "nothing")
            {
               if(!(tempStatus == "ground" && status == "wall"))
               {
                  tempWall = WallArray[i];
                  tempStatus = status;
               }
            }
         }
         if(tempStatus == "ground")
         {
            e.tempWallX = e.x;
            e.tempWallY = tempWall.y - (tempWall.isTall + 1);
            if(e.aWallOn != tempWall)
            {
               if(e.Status != "Roll")
               {
                  e.moveRL -= tempWall.moveRL;
                  e.aWallOn = tempWall;
                  tempWall.CharsOn.push(e);
               }
            }
            if(tempWall.Status == "Mushy")
            {
               if(eUD > 1)
               {
                  e.wallUD = eUD;
               }
            }
            else
            {
               e.wallRL = tempWall.moveRL;
               e.wallUD = tempWall.moveUD;
            }
            if(!e.cheapLandAngleStuff(ground))
            {
               e.moveRL += tempWall.moveRL * 0.25;
            }
            if(tempWall.Status == "Mushy")
            {
               if(e.moveUD > 0 && e.wallUD == 0)
               {
                  return false;
               }
            }
            if(!tempWall.hurt)
            {
               if(Math.abs(e.x - tempWall.x) > tempWall.isWide - e.isWide)
               {
                  e.onLedge = e.makeOne(e.x - tempWall.x);
               }
               e.wallGround = true;
               e.lastGround = "aWall";
               return true;
            }
            if(e.gotoBuffer != "Hurt" && e.Status != "Hurt")
            {
               e.superHurtChar(10,true);
            }
         }
         else
         {
            if(tempStatus != "wall")
            {
               if(tempStatus == "ledgeHang")
               {
                  if(tempWall.Status != "Mushy")
                  {
                     e.wallRL = tempWall.moveRL;
                     e.wallUD = tempWall.moveUD;
                  }
                  return true;
               }
               return false;
            }
            if(ey - 30 < tempWall.y - tempWall.isTall && e.Status == "Jump")
            {
               e.platWall = false;
               if(tempWall.moveRL * e.onWallPlat < 0)
               {
                  e.moveRL = tempWall.moveRL * 0.95;
               }
               if(e.aWallOn == tempWall)
               {
                  aWallOnClear(e);
               }
            }
            else if(e.onWallPlat * e.wantRL < 0.5 || e.lastGround != "nothing")
            {
               e.platWall = true;
               if(!(e.Status == "Roll" || e.bounce != 0))
               {
                  if(tempWall.Status == "Mushy")
                  {
                     e.moveRL = -tempWall.springY * e.onWallPlat;
                  }
                  else if(tempWall.Status != "Push")
                  {
                     e.moveRL = tempWall.moveRL * 0.95;
                  }
               }
               e.wallRL = 0;
               e.fakeRL = Math.cos(e.wallRot * (Math.PI / 180)) * e.moveRL;
               if(e.aWallOn == tempWall)
               {
                  aWallOnClear(e);
               }
            }
            else
            {
               e.platWall = true;
               if(tempWall.Status == "Mushy")
               {
                  e.wallRL = -tempWall.springY * e.onWallPlat;
               }
               else
               {
                  e.wallRL = tempWall.moveRL * 0.95;
               }
               e.wallUD = tempWall.moveUD;
               e.fakeRL = e.moveRL = 0;
               if(e.aWallOn != tempWall)
               {
                  e.aWallOn = tempWall;
                  tempWall.CharsOn.push(e);
               }
            }
            if(!tempWall.hurt)
            {
               return true;
            }
            if(e.gotoBuffer != "Hurt" && e.Status != "Hurt")
            {
               e.superHurtChar(10,true);
            }
         }
      }
      
      internal static function clearAllPlats() : *
      {
         var n:int = int(PlatArray.length);
         for(var i:int = 0; i < n; i++)
         {
            PlatArray[i].parent.removeChild(PlatArray[i]);
         }
         PlatArray = [];
      }
      
      private function RLx(ex:*) : *
      {
         return ex * Math.sin((this.moveRot + 90) * (Math.PI / 180));
      }
      
      private function RLy(ey:*) : *
      {
         return -(ey * Math.cos((this.moveRot + 90) * (Math.PI / 180)));
      }
      
      private function UDx(ex:*) : *
      {
         return ex * Math.sin((this.moveRot + 180) * (Math.PI / 180));
      }
      
      private function UDy(ey:*) : *
      {
         return -(ey * Math.cos((this.moveRot + 180) * (Math.PI / 180)));
      }
      
      private function pairBlock(i:uint) : *
      {
         var n:int = 0;
         if(this.fromTemp)
         {
            this.pressBlock.currentFrame = this.ID + 1;
         }
         else if(this.smokeLabel != "nothing")
         {
            this.pressBlock.currentFrame = this.blockNames.indexOf(this.smokeLabel) + 19;
         }
         else if(this.hide)
         {
            this.pressBlock.currentFrame = 18;
         }
         else if(this.Outline)
         {
            this.pressBlock.currentFrame = 9;
         }
         else if(this.Status == "Breakable")
         {
            this.pressBlock.currentFrame = this.ID + 1;
         }
         else if(this.Status == "Gate")
         {
            this.pressBlock.currentFrame = 11;
         }
         else if(this.Status == "Mushy")
         {
            if(Main.LoadIt.substr(0,5) == "Bonus")
            {
               this.pressBlock.currentFrame = 17;
            }
            else
            {
               this.pressBlock.currentFrame = 15;
            }
         }
         else if(Main.DirIt == "World 1")
         {
            this.pressBlock.currentFrame = this.ID + 1;
         }
         else
         {
            this.pressBlock.currentFrame = this.ID + 12;
         }
         if(this.pairID > -1)
         {
            for(n = 0; n < WallArray.length; n++)
            {
               if(n != i)
               {
                  if(this.pairID == WallArray[n].pairID)
                  {
                     this.blockBuddies.push(WallArray[n]);
                  }
               }
            }
         }
         if(this.Status == "Gate")
         {
            staticInteractObjects.pairMyGate(this.pair,this);
         }
         this.mySuperID = superID;
         ++superID;
         this.MoveEnterFrame();
      }
      
      public function removeWall() : void
      {
         this.pressBlock.goSwim();
         this.pressBlock = null;
         WallArray.splice(WallArray.indexOf(this),1);
         breakableArray.splice(breakableArray.indexOf(this),1);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      public function smashKnockback(e:Number) : Number
      {
         return e;
      }
      
      private function checkOutline(ex:int, ey:int, wide:int, tall:int, rail:int, i:uint) : Boolean
      {
         var temp:Object = null;
         if(this.onRail == rail && Math.abs(ex - x) < this.isWide + wide && Math.abs(ey - y) < this.isTall + tall)
         {
            if(this.Outline)
            {
               if(this.pressBlock.currentFrame == 9)
               {
                  ++this.pressBlock.currentFrame;
               }
               else
               {
                  if(messageOutline)
                  {
                     messageOutline = false;
                     temp = staticInteractObjects.findByUnique(28);
                     if(temp != null)
                     {
                        temp.changeProperties("nothing",0,0);
                     }
                     Main.saveProgress("messageOutline",true);
                  }
                  this.downTime = 0;
                  this.pressBlock.currentFrame = 14;
                  Sounds.playSound("InkExplode",x,this.scale * 1.2,this.onRail);
                  StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,(this.scaley - 0.5) * 0.4 + 1,0,0,this.onRail);
                  this.Outline = false;
                  outlineArray.removeAt(i);
               }
               return true;
            }
         }
         return false;
      }
      
      public function getStatus() : String
      {
         return this.Status;
      }
      
      private function WallEnterFrames() : *
      {
         var angle:Number = NaN;
         var n:int = int(this.CharsOn.length);
         var i:uint = 0;
         while(i < n)
         {
            this.moveCharsOnPre(this.CharsOn[i]);
            i++;
         }
         this.MoveEnterFrame();
         i = 0;
         while(i < n)
         {
            this.moveCharsOnPost(this.CharsOn[i]);
            i++;
         }
      }
      
      private function moveCharsOnPre(e:*) : *
      {
         e.distRL = e.x - x;
         e.distUD = e.y - y;
         e.ex = e.makeOne(e.distRL);
         e.ey = e.makeOne(e.distUD);
         e.distRL = (e.distRL - e.isWide * e.ex) / this.scalex + e.isWide * e.ex;
         e.distUD = (e.distUD - e.isTall * e.ey) / this.scaley + e.isTall * e.ey;
      }
      
      private function moveCharsOnPost(e:*) : *
      {
         var distRL:Number = e.x - e.moveRL * 2 - x;
         var distUD:Number = e.y - e.moveUD * 2 - y;
         distRL = (distRL - e.isWide * e.makeOne(distRL)) / this.scalex;
         distUD = (distUD - e.isTall * e.makeOne(distUD)) / this.scaley;
         e.distRL = (e.distRL - e.isWide * e.ex) * this.scalex + e.isWide * e.ex;
         e.x = x + e.distRL;
         e.distUD = (e.distUD - e.isTall * e.ey) * this.scaley + e.isTall * e.ey;
         e.y = y + e.distUD;
         if(e.Status == "LedgeHang" && this.Status != "Mushy")
         {
            e.wallRL = this.moveRL;
            e.wallUD = this.moveUD;
         }
      }
      
      private function wallCheckCollision(ex:*, ey:*, eRL:*, eUD:*, e:*, ground:*, status:*) : String
      {
         var distX:int = 0;
         var distY:int = 0;
         var ratioX:Number = NaN;
         var ratioY:Number = NaN;
         var n:uint = 0;
         if(this.downTime > 0)
         {
            return "nothing";
         }
         if(e.onRail == this.onRail)
         {
            if(Math.abs(x - ex) < this.isWide + e.isWide && Math.abs(y - ey) < this.isTall + e.isTall + 2)
            {
               if(Boolean(ground) || true)
               {
                  distX = ex - x;
                  distY = ey - y;
               }
               else
               {
                  distX = ex - eRL * 2 - x;
                  distY = ey - eUD * 2 - y;
               }
               if(Math.abs(distX) < this.isWide)
               {
                  ratioX = 0;
               }
               else
               {
                  ratioX = (distX - this.isWide * e.makeOne(distX)) / e.isWide;
               }
               if(Math.abs(distY) < this.isTall)
               {
                  ratioY = 0;
               }
               else
               {
                  ratioY = (distY - this.isTall * e.makeOne(distY)) / e.isTall;
               }
               if(e.groundCompY > ey - (y - this.isTall))
               {
                  return "nothing";
               }
               if(Math.abs(ratioY) > Math.abs(ratioX))
               {
                  if(Math.abs(x - ex) > this.isWide + e.isWide - 2)
                  {
                     return "nothing";
                  }
                  if(e.lastY < y - this.moveUD)
                  {
                     if(!ground && eUD - this.moveUD < -0.02)
                     {
                        return "nothing";
                     }
                     e.resetCombo();
                     status = "ground";
                     e.groundCompY = ey - (y - this.isTall);
                     this.checkBallBreak(e.moveRL * 0.25,e.moveUD,e);
                  }
                  else
                  {
                     e.wallX = e.x;
                     e.wallY = y + this.isTall;
                     e.ay = ey - e.wallY;
                     e.ay -= e.isTall + 2;
                     e.ay *= -e.bounce;
                     e.ay += e.isTall + 2;
                     e.y = e.wallY + e.ay;
                     e.resetCombo();
                     if(e.groundHitTest(e.x,e.y))
                     {
                        e.y -= this.isTall + e.isTall * 2;
                     }
                     e.moveUD -= this.moveUD;
                     e.landSpeed = -e.moveUD;
                     e.moveUD *= -e.bounce;
                     e.moveUD += this.moveUD;
                     if(e.Status == "Roll")
                     {
                        e.rotter = e.moveRL * e.rotPerc;
                     }
                     else if(e.ItIs == "Char")
                     {
                        if(e.landSpeed > 2)
                        {
                           Main.shakeRL = 1;
                           Sounds.playSound("BadStomp",x,e.landSpeed * 0.2,this.onRail);
                        }
                     }
                     if(e.landSpeed > 5 && e.isWide > 10)
                     {
                        e.landPuffs(e.landSpeed * 0.2,3.14,e.isTall / 25);
                     }
                     if(Math.abs(this.fakeRL) * 0.5 > Math.abs(e.moveRL) || e.moveRL * this.fakeRL < 0)
                     {
                        e.moveRL += this.fakeRL * 0.25;
                        e.fakeRL = e.moveRL;
                     }
                     this.checkBallBreak(e.moveRL * 0.25,e.moveUD,e);
                     if(e.isWide > 10)
                     {
                        if(e.isABall)
                        {
                           Sounds.playSound("BadStomp",e.x,e.landSpeed * 0.03,e.onRail);
                        }
                     }
                     if(e.lastGround != "nothing" && this.moveUD > 1)
                     {
                        e.squish();
                     }
                     else
                     {
                        e.groundCompY = 0;
                     }
                  }
               }
               else
               {
                  e.onWallPlat = -e.makeOne(ex - x);
                  e.wallX = x - this.isWide * e.onWallPlat;
                  e.wallY = e.y;
                  this.checkBallBreak(e.moveRL,e.moveUD * 0.25,e);
                  e.resetCombo();
                  if(e.onWallPlat * e.wantRL < 0.5 && e.aWallOn != this)
                  {
                     if(tempStatus == "ground")
                     {
                        if(e.onWallPlat * (eRL + tempWall.moveRL - this.moveRL) < -0.001)
                        {
                           e.onWallPlat = 0;
                           return "nothing";
                        }
                     }
                     else if(e.onWallPlat * (eRL - this.moveRL) < -0.001)
                     {
                        e.onWallPlat = 0;
                        return "nothing";
                     }
                  }
                  if(this.Status == "Rock" && e.onWall * e.onWallPlat < 0 && this.Status != "Push")
                  {
                     e.squish();
                     return "nothing";
                  }
                  if(e.Status == "Roll")
                  {
                     e.ax = ex - e.wallX;
                     e.ax += e.isWide * e.onWallPlat;
                     e.ax *= -e.bounce;
                     e.ax -= e.isWide * e.onWallPlat;
                     e.x = e.wallX + e.ax;
                  }
                  else
                  {
                     e.x = x + (this.isWide + e.isWide - 0.5) * -e.onWallPlat;
                  }
                  if(status == "nothing")
                  {
                     status = "wall";
                  }
                  if(this.Status == "Push")
                  {
                     if((e.x - x) * (e.fakeRL - this.fakeRL) < 0)
                     {
                        if((e.x - x) * e.wantRL)
                        {
                           e.moveRL = e.fakeRL = (e.fakeRL + this.fakeRL * 3) / 4;
                           this.fakeRL = e.moveRL;
                        }
                        else
                        {
                           e.moveRL = e.fakeRL = this.fakeRL;
                        }
                        for(n = 0; n < this.blockBuddies.length; n++)
                        {
                           this.blockBuddies[n].fakeRL = this.fakeRL;
                        }
                     }
                  }
                  else
                  {
                     e.moveRL -= this.moveRL - e.wallRL;
                     e.landSpeed = Math.abs(e.moveRL);
                     e.moveRL *= -e.bounce;
                     e.moveRL += this.moveRL - e.wallRL;
                     if(e.isWide > 10)
                     {
                        if(e.isABall)
                        {
                           Sounds.playSound("BadStomp",e.x,e.landSpeed * 0.03,e.onRail);
                        }
                     }
                  }
               }
            }
            if(Math.abs(x - ex) < this.isWide + e.isWide + 20)
            {
               if(e.ItIs == "Char" && !e.DownIsDown() && e.health > 0)
               {
                  if(e.Status == "LedgeHang")
                  {
                     if(e.aWallOn == this)
                     {
                        e.onWallPlat = -e.makeOne(ex - x);
                        e.x = x - (this.isWide + e.isWide) * e.onWallPlat;
                        e.y = y - this.isTall + 30;
                        return "ledgeHang";
                     }
                  }
                  else if(e.Status == "Jump")
                  {
                     if(!(aWall.quickCheckWalls(ex,ey - e.isTall - 10,e.isWide - 5,this.onRail) || Boolean(e.wallsHitTest(ex,ey - e.isTall - 10))))
                     {
                        if(e.lastY - 30 < y - this.isTall + Math.abs(this.moveUD) && ey - 25 > y - this.isTall)
                        {
                           e.onWallPlat = -e.makeOne(ex - x);
                           e.x = x - (this.isWide + e.isWide) * e.onWallPlat;
                           e.y = y - this.isTall + 30;
                           e.aWallOn = this;
                           this.CharsOn.push(e);
                           e.ledgeHangIt();
                           return "ledgeHang";
                        }
                     }
                  }
               }
            }
         }
         return status;
      }
      
      private function checkBallBreak(eRL:*, eUD:*, e:*) : Boolean
      {
         if(e.ItIs == "Char" || this.Status != "Breakable")
         {
            return false;
         }
         if(Boolean(e.canAggressor) && (Math.abs(eRL) > 10 || Math.abs(eUD) > 10))
         {
            this.shakeRL = Math.abs(eRL) + Math.abs(eUD);
            this.springX = eRL;
            this.springY = eUD;
            Main.shakeScreen(this.shakeRL * 0.5,0,true);
            if(this.shakeRL > 20)
            {
               e.hitPause = 2;
               this.downTime = 7;
            }
            return true;
         }
         return false;
      }
      
      private function PushEnterFrame() : *
      {
         if(this.fakeRL != 0)
         {
            if(Math.abs(this.fakeRL) > 0.2)
            {
               this.fakeRL -= this.fakeRL / Math.abs(this.fakeRL) * 0.1 * Main.framin;
            }
            else
            {
               this.fakeRL = 0;
            }
         }
         this.moveRL = this.fakeRL;
         x += this.fakeRL * Main.framin;
         if(walls.hitTestPoint(x + this.isWide + 2,y + (this.isTall - 10),true))
         {
            while(walls.hitTestPoint(x + this.isWide + 2,y + (this.isTall - 10),true))
            {
               --x;
            }
            this.fakeRL *= -0.5;
            i = 0;
            while(i < this.blockBuddies.length)
            {
               this.blockBuddies[i].x = x;
               this.blockBuddies[i].fakeRL = this.fakeRL;
               ++i;
            }
            if(Math.abs(this.fakeRL) > Math.abs(Main.shakeRL))
            {
               Main.shakeRL = this.fakeRL;
            }
         }
         else if(walls.hitTestPoint(x - this.isWide - 2,y + (this.isTall - 10),true))
         {
            while(walls.hitTestPoint(x - this.isWide - 2,y + (this.isTall - 10),true))
            {
               ++x;
            }
            this.fakeRL *= -0.5;
            i = 0;
            while(i < this.blockBuddies.length)
            {
               this.blockBuddies[i].x = x;
               this.blockBuddies[i].fakeRL = this.fakeRL;
               ++i;
            }
            if(Math.abs(this.fakeRL) > Math.abs(Main.shakeRL))
            {
               Main.shakeRL = this.fakeRL;
            }
         }
         else if(Math.abs(this.wallX - x) > this.maxDist)
         {
            this.fakeRL *= -0.5;
            x = this.wallX + this.makeOne(x - this.wallX) * this.maxDist;
         }
         this.pressBlock.x = x;
      }
      
      private function RockEnterFrame() : *
      {
         if(this.dir * this.fakeRL > 0)
         {
            if(Math.abs(this.fakeX) > this.Cruise)
            {
               this.fakeRL += -(this.fakeX - this.makeOne(this.fakeX) * this.Cruise) / this.springyY * Main.framin;
            }
            this.fakeX += this.fakeRL * Main.framin;
            this.moveRL = this.RLx(this.fakeRL);
            this.moveUD = this.RLy(this.fakeRL);
            x = this.wallX + this.RLx(this.fakeX);
            y = this.wallY + this.RLy(this.fakeX);
            this.pressBlock.x = x;
            this.pressBlock.y = y;
         }
         else if(this.Pause > 0)
         {
            this.Pause -= 1 * Main.framin;
         }
         else
         {
            this.Pause = this.maxPause;
            this.dir *= -1;
         }
      }
      
      private function MushyEnterFrame() : *
      {
         var n:int = int(this.CharsOn.length);
         this.mass = 50;
         this.force = this.mass * this.springY;
         for(var i:uint = 0; i < n; i++)
         {
            this.force += this.CharsOn[i].isTall * (this.CharsOn[i].wallUD + 10);
            this.mass += this.CharsOn[i].isTall;
         }
         this.force -= (this.springTall - this.isTall) * this.springyY;
         this.springY = this.force / this.mass;
         this.isTall -= this.springY * Main.framin;
         if(n == 0 || Math.abs(this.springY) > 3)
         {
            this.springY -= this.springY * 0.15 * Main.framin;
         }
         for(i = 0; i < n; i++)
         {
            if(this.CharsOn[i].gotoBuffer == "Jump")
            {
               this.CharsOn[i].wallUD = -(8 + this.maxScaleY * 4);
            }
            else
            {
               this.CharsOn[i].wallUD = this.springY;
            }
         }
         scaleY = this.scaley = this.isTall / 50;
         scaleX = this.scalex = this.maxScaleX + (this.maxScaleY - this.scaley) * 0.5;
         this.isWide = this.scalex * 50;
         this.pressBlock.scaleX = scaleX;
         this.pressBlock.scaleY = scaleY;
      }
      
      private function BreakableEnterFrame() : *
      {
         if(this.downTime > 5)
         {
            this.downTime -= Main.framin;
            x = this.wallX + Math.sin(this.downTime * 2.5) * this.shakeRL * 0.5;
            y = this.wallY + Math.sin(this.downTime * 2.5) * this.shakeRL * 0.5;
         }
         else if(this.shakeRL != 0)
         {
            x = this.wallX;
            y = this.wallY;
            Sounds.playSound("BreakBlock",x,1,this.onRail);
            if(this.inky)
            {
               StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,this.maxScaleX,0,0,this.onRail);
            }
            this.spawnAllShrapnel(this.springX,this.springY,this.ID);
            this.removeWall();
         }
      }
      
      private function GateEnterFrame() : void
      {
      }
      
      public function currentGetAttacked(ex:Number, ey:Number, angle:Number, char:collision, hitMove:String, hitPower:Number, pow:Number = 1) : Boolean
      {
         this.downTime = 4;
         Main.shakeRL = hitPower * 0.2;
         this.shakeRL = hitPower;
         if(Boolean(char.justAttackHit) || Boolean(char.justAttackQuick))
         {
            char.hitPause = hitPower * 0.02 + 2;
         }
         else
         {
            char.hitPause = hitPower * 0.1 + 1;
         }
         if(hitMove == "PokeDown")
         {
            char.hitPause = 2;
         }
         this.downTime += char.hitPause;
         this.health = 0;
         StarlingEffect.Spawn("popEffect",x,y,Math.random() * 3,1,0,0,this.onRail);
         if(hitPower < 20)
         {
            hitPower = 20;
         }
         if(hitPower > 50)
         {
            hitPower = 50;
         }
         this.springX = Math.sin(angle) * hitPower;
         this.springY = -Math.cos(angle) * hitPower;
         return true;
      }
      
      public function inkGateBreak() : void
      {
         Sounds.playSound("InkJump",x,3,this.onRail);
         var gate:inkGateMelt = new inkGateMelt();
         gate.x = x;
         gate.y = y;
         gate.scaleX = this.scalex;
         gate.scaleY = this.scaley;
         Backgrounds.backgroundsArray[0].addChild(gate);
         this.removeWall();
      }
      
      private function spawnAllShrapnel(eRL:*, eUD:*, n:*) : void
      {
         this.spawnShrapnel(-1,-1,eRL,eUD,n);
         this.spawnShrapnel(0,-1,eRL,eUD,n);
         this.spawnShrapnel(1,-1,eRL,eUD,n);
         this.spawnShrapnel(-1,0,eRL,eUD,n);
         this.spawnShrapnel(0,0,eRL,eUD,n);
         this.spawnShrapnel(1,0,eRL,eUD,n);
         this.spawnShrapnel(-1,1,eRL,eUD,n);
         this.spawnShrapnel(0,1,eRL,eUD,n);
         this.spawnShrapnel(1,1,eRL,eUD,n);
      }
      
      private function spawnShrapnel(ex:*, ey:*, eRL:*, eUD:*, n:*) : void
      {
         ex *= Math.random() * 0.5 + 0.3;
         ey *= Math.random() * 0.5 + 0.3;
         ex *= this.isWide;
         ey *= this.isTall;
         ex += x;
         ey += y;
         eRL += Math.random() * 8 - 4;
         eUD += Math.random() * 8 - 4;
         if(!collision.staticGroundHitTest(ex,ey,this.onRail))
         {
            if(Math.random() < 0.2)
            {
               StarlingInteract.Spawn("looseSquiggle",ex,ey,0,1,eRL * 1.2,eUD * 1.2,this.onRail);
               return;
            }
            if(n == 2 && Math.random() < 0.1)
            {
               new Baddie1({
                  "ItIs":"Baddie1",
                  "x":ex,
                  "y":ey,
                  "rotation":0,
                  "scaleX":1,
                  "scaleY":0.7 + Math.random() * 0.2,
                  "onRail":0,
                  "hatN":0,
                  "moveRL":eRL,
                  "moveUD":eUD,
                  "autopilot":true,
                  "tether":600,
                  "downTime":30
               });
               return;
            }
         }
         StarlingEffect.Spawn("blockPiece",ex,ey,1 / 0.35,(this.maxScaleX + this.maxScaleY) * 0.5,eRL,eUD,this.onRail,false,"blockPiece",n * 4 + Math.floor(Math.random() * 4) + 1);
      }
      
      private function makeOne(e:*) : *
      {
         if(e == 0)
         {
            return 0;
         }
         return e / Math.abs(e);
      }
   }
}

