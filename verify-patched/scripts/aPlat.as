package
{
   import flash.display.*;
   import flash.display3D.*;
   import flash.geom.*;
   import flash.media.SoundChannel;
   import starling.display.*;
   import starling.textures.*;
   
   public class aPlat extends starling.display.Sprite
   {
      
      public static var framin:Number;
      
      public static var PlatArray:Array = [];
      
      private var CharsOn:Array;
      
      private var PlatEnterFrame:Function;
      
      private var pointR:Number = 0;
      
      private var pointL:Number = 0;
      
      private var pointRud:Number = 0;
      
      private var pointLud:Number = 0;
      
      private var pointRoriginX:Number;
      
      private var pointRoriginY:Number;
      
      private var pointLoriginX:Number;
      
      private var pointLoriginY:Number;
      
      private var pointRratio:Number;
      
      private var pointLratio:Number;
      
      private var mushyDist:Number;
      
      private var platRL:Number = 0;
      
      private var platUD:Number = 0;
      
      private var wallX:Number;
      
      private var wallY:Number;
      
      private var fakeX:Number;
      
      private var fakeRL:Number = 0;
      
      private var moveRL:Number = 0;
      
      private var moveUD:Number = 0;
      
      private var maxRL:Number = 0;
      
      private var Wait:Boolean;
      
      public var forceStill:Boolean;
      
      private var canWallJump:Boolean;
      
      private var ax:Number;
      
      private var ay:Number;
      
      private var aRL:Number;
      
      private var aUD:Number;
      
      private var squishX:Number;
      
      private var squishY:Number;
      
      private var isTall:uint = 0;
      
      private var mass:uint;
      
      private var doubleSided:Boolean;
      
      private var hideIt:Boolean;
      
      private var wasSide:int;
      
      private var rotAngle:Number;
      
      private var myBitmap:Bitmap;
      
      private var myObject:Object;
      
      private var myObject2:Object;
      
      private var myObject3:Object;
      
      private var propSkew:starling.display.Sprite;
      
      private var state:uint = 0;
      
      private var dontScale:Boolean;
      
      private var smokeLabel:String = "nothing";
      
      private var front:Boolean = true;
      
      private var propSpeed:Number;
      
      public var currentSound:SoundChannel;
      
      public var isWide:Number;
      
      public var onRail:int;
      
      public var moveRot:Number;
      
      public var rotAccel:Number;
      
      public var fakeDist:int;
      
      public var ID:int;
      
      public var springY:Number = 10;
      
      private var spring:int = 300;
      
      public var Status:String;
      
      public var Property:String;
      
      private var pMaster:Object;
      
      private var predictOffsetY:uint = 0;
      
      private var downTime:Number = 0;
      
      private var b:Number = 0;
      
      private var c:uint = 0;
      
      private var RLxCache:Number = 0;
      
      private var RLyCache:Number = 0;
      
      private var bitRes:Number = 1.5;
      
      public function aPlat(p:*)
      {
         var bitmapData:BitmapData = null;
         var bounds:Rectangle = null;
         var scx:Number = NaN;
         var n:int = 0;
         var temp:Number = NaN;
         var tile:Image = null;
         this.CharsOn = new Array();
         this.PlatEnterFrame = function():*
         {
         };
         super();
         if(p.sqX == undefined || p.sqX == -1)
         {
            this.squishX = 1;
         }
         else
         {
            this.squishX = p.sqX;
         }
         if(p.sqY == undefined || p.sqY == -1)
         {
            this.squishY = 1;
         }
         else
         {
            this.squishY = p.sqY;
         }
         if(p.fakeDist == undefined || p.fakeDist == -1)
         {
            p.fakeDist = 0;
         }
         this.fakeDist = p.fakeDist;
         if(p.spring != undefined)
         {
            this.spring = p.spring;
         }
         if(p.doubleSided != undefined)
         {
            this.doubleSided = p.doubleSided;
         }
         if(p.status == "Move")
         {
            p.status = "Rock";
         }
         if(p.smokeLabel != undefined)
         {
            this.smokeLabel = p.smokeLabel;
         }
         if(p.front != undefined)
         {
            this.front = p.front;
         }
         this.hideIt = !(p.hideIt == undefined || !p.hideIt);
         this.Status = p.status;
         this.Property = p.property;
         this.pMaster = p;
         this.wallX = x = p.x;
         this.wallY = y = p.y;
         this.isWide = p.scaleX * 100;
         this.rotAngle = p.rotation * (Math.PI / 180);
         rotation = this.rotAngle;
         if(Math.round(this.rotAngle * 100) == 157)
         {
            this.rotAngle = 1.5707963267948966;
         }
         if(Math.round(this.rotAngle * 100) == -157)
         {
            this.rotAngle = -1.5707963267948966;
         }
         this.moveRot = p.moveRot * (Math.PI / 180);
         this.RLxCache = this.RLx(1);
         this.RLyCache = this.RLy(1);
         this.maxRL = p.maxRL;
         if(this.Status != "OnRide" && this.Status != "Straight")
         {
            this.fakeRL = p.maxRL;
         }
         this.onRail = p.onRail;
         this.mass = 100;
         this.ID = PlatArray.length;
         PlatArray.push(this);
         if(p.property == "Ship")
         {
            if(Main.world4Progress.freePirateShip)
            {
               x += 1500;
               this.wallX = x;
               this.Status = "Invisible";
               this.Property = "notAShip";
            }
            else
            {
               this.PlatEnterFrame = this.ShipEnterFrame;
               this.dontScale = true;
               this.myObject = new shipInteract();
               this.myObject.x = x;
               this.myObject.y = y;
               Backgrounds.backgroundsArray[this.onRail].backContainer.addChild(this.myObject);
               this.myObject.gotoAndStop(1);
               this.myObject.tentacleIntro.gotoAndStop(2);
               this.myObject.capt.stop();
               this.myObject.capt.visible = false;
               this.propSpeed = 3;
               this.myObject.compellerSkew.visible = false;
               this.setupStarlingShip();
            }
         }
         else if(p.property == "Ship2")
         {
            this.PlatEnterFrame = this.Ship2EnterFrame;
            this.dontScale = true;
            this.myObject = new shipInteract();
            this.myObject.x = x;
            this.startLoop();
            if(Main.DoorIt == 0)
            {
               this.myObject.y = y;
            }
            else
            {
               y = this.myObject.y = -1700;
            }
            Backgrounds.backgroundsArray[this.onRail].backContainer.addChild(this.myObject);
            this.myObject.gotoAndStop(1);
            this.myObject.tentacleIntro.gotoAndStop(2);
            this.myObject.capt.gotoAndStop("steer");
            this.myObject.capt.visible = false;
            this.myObject.compellerSkew.visible = false;
            this.myObject2 = StarlingInteract.findByName("inkSpout");
            this.myObject3 = staticInteractObjects.findByName("MapIcon");
            Main.saveProgress("canMapAround",true);
            this.propSpeed = 30;
            if(this.myObject3.getDisabled)
            {
               this.myObject3.patch();
            }
            this.setupStarlingShip();
         }
         else if(p.wait)
         {
            this.Wait = true;
         }
         else if(this.Status != "Invisible")
         {
            this.Wait = false;
            this.PlatEnterFrame = this[this.Status + "EnterFrame"];
         }
         if(p.forcestill)
         {
            this.forceStill = true;
         }
         this.fakeX = 0;
         if(p.hide)
         {
            visible = false;
         }
         if(this.smokeLabel != "nothing")
         {
            pressBlock.gotoAndStop(this.smokeLabel);
         }
         else if(this.Status != "Invisible")
         {
            if(p.property == "Grind")
            {
               pressBlock.gotoAndStop(8);
            }
            else if(p.property == "Hang")
            {
               this.predictOffsetY = 100;
               if(this.isWide > 30)
               {
                  pressBlock.gotoAndStop(11);
               }
               else
               {
                  pressBlock.gotoAndStop(12);
               }
            }
            else if(p.property == "Spikes")
            {
               pressBlock.gotoAndStop(10);
            }
            else if(p.property == "raceWall")
            {
               pressBlock.gotoAndStop("raceWall");
            }
            else if(p.doubleSided)
            {
               pressBlock.gotoAndStop(9);
            }
            else if(Main.DirIt == "World 1")
            {
               if(Main.LoadIt == "Level4")
               {
                  pressBlock.gotoAndStop(4);
               }
               else if(Main.LoadIt == "Bonus5")
               {
                  pressBlock.gotoAndStop(5);
               }
               else if(Main.LoadIt == "Bonus6")
               {
                  pressBlock.gotoAndStop(6);
               }
               else if(Main.LoadIt == "Trans2")
               {
                  pressBlock.gotoAndStop(7);
               }
               else if(Main.LoadIt == "Trans4")
               {
                  pressBlock.gotoAndStop(7);
                  visible = false;
               }
               else
               {
                  pressBlock.gotoAndStop(3);
               }
            }
            else if(p.property == "Ship" || p.property == "Ship2")
            {
               pressBlock.gotoAndStop(13);
            }
            else if(Main.LoadIt == "Level3")
            {
               pressBlock.gotoAndStop(2);
            }
            else if(Main.LoadIt.substr(0,5) == "Bonus")
            {
               pressBlock.gotoAndStop("sketchy0");
            }
            else if(Main.LoadIt.substr(0,6) == "Level2")
            {
               pressBlock.gotoAndStop("pirate0");
            }
            else
            {
               pressBlock.gotoAndStop(1);
            }
         }
         if(this.Status != "Invisible")
         {
            bounds = pressBlock.getBounds(pressBlock);
         }
         this.bitRes = 1;
         this.canWallJump = visible && this.Property != "raceWall";
         if(p.property == "Spikes")
         {
            this.bitRes = 1.5;
            this.isTall = 20 * p.scaleY;
            if(this.isWide < 10)
            {
               this.isWide = 10;
            }
            this.isWide /= 10;
            this.isWide = Math.round(this.isWide);
            this.isWide *= 10;
            bounds.x = -uint(this.isWide);
            bounds.width = uint(this.isWide * 2);
            bounds.y *= p.scaleY;
            bounds.height *= p.scaleY;
            if(StarlingBackgrounds.constrained)
            {
               if(bounds.width * this.bitRes > 2000)
               {
                  this.bitRes = 2000 / bounds.width;
               }
            }
            else if(bounds.width * this.bitRes > 4000)
            {
               this.bitRes = 4000 / bounds.width;
            }
            if(this.doubleSided)
            {
               bitmapData = new BitmapData(bounds.width * this.bitRes,(-bounds.y * 2 + 40) * this.bitRes,true,0);
            }
            else
            {
               bitmapData = new BitmapData(bounds.width * this.bitRes,bounds.height * this.bitRes,true,0);
            }
            scx = 1 * this.bitRes;
            for(n = this.isWide * 2; n > 0; n -= 20)
            {
               if(Math.random() > 0.5)
               {
                  scx *= -1;
               }
               temp = 0.6 + Math.random() * 0.4;
               bitmapData.drawWithQuality(pressBlock,new Matrix(scx,0,0,p.scaleY * temp * this.bitRes,(n - 10) * this.bitRes,(-bounds.y + (22 - 22 * temp) + Math.random() * 5) * this.bitRes),null,null,null,true,StageQuality.HIGH);
            }
            if(this.doubleSided)
            {
               for(n = this.isWide * 2; n > 0; n -= 20)
               {
                  if(Math.random() > 0.5)
                  {
                     scx *= -1;
                  }
                  temp = 0.6 + Math.random() * 0.4;
                  bitmapData.drawWithQuality(pressBlock,new Matrix(scx,0,0,-p.scaleY * temp * this.bitRes,(n - 10) * this.bitRes,(-bounds.y + 40 - (22 - 22 * temp) + Math.random() * 5) * this.bitRes),null,null,null,true,StageQuality.HIGH);
               }
               bounds.y -= 20;
               this.isTall *= 2;
            }
            this.doubleSided = true;
         }
         else if(this.Status == "catFall")
         {
            this.setupCatFall();
         }
         else if(!(this.Status == "Invisible" || !visible))
         {
            if(bounds.height < 4)
            {
               bounds.height = 4;
            }
            if(this.dontScale)
            {
               bitmapData = new BitmapData(bounds.width,bounds.height,true,0);
               bitmapData.drawWithQuality(pressBlock,new Matrix(1,0,0,1,-bounds.x,-bounds.y),null,null,null,true,StageQuality.HIGH);
            }
            else
            {
               if(StarlingBackgrounds.constrained)
               {
                  if(bounds.width * p.scaleX * this.bitRes > 2000)
                  {
                     this.bitRes = 2000 / (bounds.width * p.scaleX);
                  }
               }
               else if(bounds.width * p.scaleX * this.bitRes > 4000)
               {
                  this.bitRes = 4000 / (bounds.width * p.scaleX);
               }
               bounds.x *= p.scaleX * this.bitRes;
               bounds.width *= p.scaleX * this.bitRes;
               bitmapData = new BitmapData(bounds.width * this.bitRes,bounds.height + 10,true,0);
               bitmapData.drawWithQuality(pressBlock,new Matrix(p.scaleX * this.bitRes,0,0,1,-bounds.x * this.bitRes,-bounds.y * this.bitRes),null,null,null,true,StageQuality.HIGH);
            }
         }
         if(bitmapData != null)
         {
            tile = new Image(Texture.fromBitmapData(bitmapData,false,false,1,Context3DTextureFormat.BGRA_PACKED));
            tile.x = bounds.x;
            tile.y = bounds.y;
            tile.scaleX = 1 / this.bitRes;
            tile.scaleY = 1 / this.bitRes;
            if(p.property == "Hang")
            {
               tile.y -= 72;
            }
            addChild(tile);
            tile = null;
            if(this.Property == "Spikes" || Boolean(this.front))
            {
               StarlingBackgrounds.BackgroundObjArray[this.onRail].addChild(this);
            }
            else
            {
               StarlingBackgrounds.BackContainerArray[this.onRail].addChild(this);
            }
         }
         if(this.Status == "Mushy")
         {
            this.pointRoriginX = x + Math.cos(this.rotAngle) * this.isWide;
            this.pointRoriginY = y + Math.sin(this.rotAngle) * this.isWide;
            this.pointLoriginX = x - Math.cos(this.rotAngle) * this.isWide;
            this.pointLoriginY = y - Math.sin(this.rotAngle) * this.isWide;
         }
         else if(this.Status == "Circle")
         {
            x += this.fakeDist * Math.sin(this.moveRot);
            y -= this.fakeDist * Math.cos(this.moveRot);
            this.rotAccel = this.fakeRL / this.fakeDist;
         }
         else if(this.Status == "Spin")
         {
            this.rotAccel = this.fakeRL / this.isWide;
         }
         if(p.pairID > -1)
         {
            staticInteractObjects.findByPairID(p.pairID).myPlat = this;
         }
         var i:int = 0;
         while(i < p.ahead)
         {
            this.PlatEnterFrame();
            i++;
         }
      }
      
      internal static function spawnPlat(ex:*, ey:*, scx:*, rot:*, moveRot:*, status:*) : *
      {
         var plat:aPlat = new aPlat(ex,ey,scx,rot,moveRot,"Move");
      }
      
      internal static function PlatEnterFrames() : *
      {
         for(var i:int = 0; i < PlatArray.length; i++)
         {
            PlatArray[i].PlatStuff();
         }
      }
      
      internal static function CheckPlats(e:*) : *
      {
         var temp:String = null;
         var tempStatus:String = "nothing";
         if(e.aPlatOn == null)
         {
            return false;
         }
         tempStatus = e.aPlatOn.checkThePlat(e);
         if(tempStatus != "nothing")
         {
            e.aPlatOn.CharsOn.push(e);
            return true;
         }
         return false;
      }
      
      internal static function PlatCollision(ex:*, ey:*, eRL:*, eUD:*, e:*, ground:*) : *
      {
         var tempStatus:Boolean = false;
         var temp:String = null;
         for(var i:* = int(PlatArray.length - 1); i >= 0; i--)
         {
            if(e.onRail == PlatArray[i].onRail)
            {
               temp = PlatArray[i].collideThePlat(e.x,e.y,e.moveRL,e.moveUD,e,ground);
               if(temp != "nothing")
               {
                  if(PlatArray[i].Property == "Spikes")
                  {
                     if(e.ItIs != "looseSquiggle")
                     {
                        if(e.ItIs != "Char")
                        {
                           e.hitPause = 7;
                           e.shakeRL = 40;
                           e.moveRL = -Math.sin(PlatArray[i].rotAngle) * 30 * PlatArray[i].wasSide;
                           e.moveUD = Math.cos(PlatArray[i].rotAngle) * 30 * PlatArray[i].wasSide;
                           e.hurtBaddie(200,-Math.sin(PlatArray[i].rotAngle) * 30 * PlatArray[i].wasSide,Math.cos(PlatArray[i].rotAngle) * 30 * PlatArray[i].wasSide);
                           e.rotter = -e.scaleX * 60;
                           e.ChangeFrame("Hit");
                        }
                        else if(e.gotoBuffer != "Hurt")
                        {
                           e.superHurtChar(30,true);
                        }
                     }
                  }
                  else if(temp == "wallLand")
                  {
                     e.Still = false;
                     if(PlatArray[i].wallOnPlat(e,ground))
                     {
                        tempStatus = true;
                     }
                  }
                  else if(e.groundCompY < PlatArray[i].ay)
                  {
                     if(temp == "groundLand")
                     {
                        e.groundCompY = PlatArray[i].ay;
                     }
                     if(temp == "otherLand" || temp == "groundLand")
                     {
                        if(PlatArray[i].landOnPlat(e,ground))
                        {
                           tempStatus = true;
                        }
                     }
                  }
                  else
                  {
                     trace("letgo2 " + PlatArray[i].ID);
                  }
               }
               else
               {
                  e.aPlatSides[PlatArray[i].ID] = PlatArray[i].ay;
               }
            }
         }
         if(tempStatus)
         {
            e.groundCompY = e.ay;
         }
         return tempStatus;
      }
      
      public static function resetplatSides(ex:*, ey:*, e:*) : void
      {
         for(var i:* = int(PlatArray.length - 1); i >= 0; i--)
         {
            e.aPlatSides[PlatArray[i].ID] = Math.cos(PlatArray[i].rotAngle) * (ey - PlatArray[i].y) - Math.sin(PlatArray[i].rotAngle) * (ex - PlatArray[i].x);
            if(Math.abs(Math.cos(PlatArray[i].rotAngle) * (ex - PlatArray[i].x) + Math.sin(PlatArray[i].rotAngle) * (ey - PlatArray[i].y)) < e.isWide + PlatArray[i].isWide)
            {
               if(Math.abs(e.aPlatSides[PlatArray[i].ID] + e.isTall) < 20 && e.moveUD > -5 && e.Jumper < 5)
               {
                  e.aPlatSides[PlatArray[i].ID] = -100;
               }
            }
         }
      }
      
      public static function forceAllWaits(ex:int = 0) : void
      {
         for(var i:* = int(PlatArray.length - 1); i >= 0; i--)
         {
            if(PlatArray[i].Wait)
            {
               PlatArray[i].PlatEnterFrame = PlatArray[i][PlatArray[i].Status + "EnterFrame"];
               PlatArray[i].downTime = 20;
               PlatArray[i].x = PlatArray[i].wallX = ex + PlatArray[i].pMaster.x;
               PlatArray[i].visible = true;
            }
         }
      }
      
      public static function hasRaceWall() : Boolean
      {
         for(var i:* = int(PlatArray.length - 1); i >= 0; i--)
         {
            if(PlatArray[i].Property == "raceWall")
            {
               return true;
            }
         }
         return false;
      }
      
      public static function removeRaceWall() : void
      {
         for(var i:* = int(PlatArray.length - 1); i >= 0; i--)
         {
            if(PlatArray[i].Property == "raceWall")
            {
               PlatArray[i].isWide = -100;
               PlatArray[i].visible = false;
            }
         }
      }
      
      public static function replaceRaceWall() : void
      {
         for(var i:* = int(PlatArray.length - 1); i >= 0; i--)
         {
            if(PlatArray[i].Property == "raceWall")
            {
               PlatArray[i].isWide = PlatArray[i].pMaster.scaleX * 100;
               PlatArray[i].visible = true;
            }
         }
      }
      
      public static function makePressBlock() : void
      {
         pressBlock = new aPlatSmoke();
      }
      
      public static function forgetPressBlock() : void
      {
         pressBlock = null;
      }
      
      internal static function quickCheckPlats(ex:Number, ey:Number, eUD:Number, wide:uint, rail:int, e:*) : Boolean
      {
         for(var i:* = int(PlatArray.length - 1); i >= 0; i--)
         {
            if(rail == PlatArray[i].onRail && Math.abs(PlatArray[i].rotAngle) < 1.5)
            {
               if(Math.abs(PlatArray[i].x - ex) < PlatArray[i].isWide + wide && ey > PlatArray[i].y && ey - eUD * 3 < PlatArray[i].y)
               {
                  e.predictOffsetY = PlatArray[i].predictOffsetY;
                  return true;
               }
            }
         }
         return false;
      }
      
      internal static function resetAllPlats() : *
      {
         var n:int = int(PlatArray.length);
         for(var i:int = 0; i < n; i++)
         {
            PlatArray[i].resetPlatform(true);
         }
      }
      
      internal static function clearAllPlats() : *
      {
         var n:int = int(PlatArray.length);
         for(var i:int = 0; i < n; i++)
         {
            if(PlatArray[i].numChildren > 0)
            {
               PlatArray[i].getChildAt(0).texture.dispose();
               PlatArray[i].getChildAt(0).dispose();
            }
            PlatArray[i].dispose();
            PlatArray[i].removeFromParent();
            if(PlatArray[i].myObject != null)
            {
               if(PlatArray[i].myObject.parent != null)
               {
                  PlatArray[i].myObject.parent.removeChild(PlatArray[i].myObject);
               }
               PlatArray[i].myObject = null;
            }
         }
         PlatArray = [];
      }
      
      internal static function clearAllOns() : *
      {
         for(var i:int = 0; i < PlatArray.length; i++)
         {
            PlatArray[i].CharsOn = [];
         }
      }
      
      public static function aPlatOnClear(char:*) : *
      {
         char.aPlatOn.CharsOn.splice(char.aPlatOn.CharsOn.indexOf(char),1);
         char.aPlatOn = null;
      }
      
      private function RLx(ex:*) : *
      {
         return ex * Math.sin(this.moveRot + 1.5707963267948966);
      }
      
      private function RLy(ey:*) : *
      {
         return -(ey * Math.cos(this.moveRot + 1.5707963267948966));
      }
      
      private function UDx(ex:*) : *
      {
         return ex * Math.sin(this.moveRot + 3.141592653589793);
      }
      
      private function UDy(ey:*) : *
      {
         return -(ey * Math.cos(this.moveRot + 3.141592653589793));
      }
      
      private function setupStarlingShip() : void
      {
         StarlingTemporary.Spawn("captOnShip",x,y,0,1,0);
         myTempN1 = StarlingTemporary.Spawn("compeller",0,0,0,1,-1);
         this.propSkew = new Sprite();
         this.propSkew.y = 470;
         this.propSkew.scaleX = 2;
         this.propSkew.scaleY = 0.16;
         this.propSkew.addChild(StarlingTemporary.justGetWithN(1));
         StarlingBackgrounds.addObject(this.propSkew,0);
         this.propSkew.x = x;
         this.propSkew.y = y - 470;
      }
      
      private function checkThePlat(e:*) : *
      {
         if(Math.abs(this.rotAngle) == 1.5707963267948966 && e.ItIs == "Char")
         {
            return "wallLand";
         }
         if(e.Status != "Roll")
         {
            if(this.rotLand(e))
            {
               return "groundLand";
            }
            return "nothing";
         }
         return "nothing";
      }
      
      private function PlatStuff() : *
      {
         var angle:Number = NaN;
         var e:Object = null;
         var n:int = int(this.CharsOn.length);
         for(var i:int = 0; i < n; i++)
         {
            e = this.CharsOn[i];
            e.distRL = e.x - x;
            e.distUD = e.y - y;
            e.ax = Math.cos(this.rotAngle) * e.distRL + Math.sin(this.rotAngle) * e.distUD;
            if(Math.abs(this.rotAngle) == 1.5707963267948966)
            {
               e.ay = (e.isWide + 1) * (e.aPlatSides[this.ID] / Math.abs(e.aPlatSides[this.ID]));
            }
            else
            {
               e.ay = (this.isTall + e.isTall + 1) * (e.aPlatSides[this.ID] / Math.abs(e.aPlatSides[this.ID]));
            }
         }
         this.PlatEnterFrame();
         n = int(this.CharsOn.length);
         for(i = 0; i < n; i++)
         {
            e = this.CharsOn[i];
            e.x = x + (Math.cos(this.rotAngle) * e.ax - Math.sin(this.rotAngle) * e.ay);
            e.y = y + (Math.cos(this.rotAngle) * e.ay + Math.sin(this.rotAngle) * e.ax);
         }
         if(this.downTime > 0)
         {
            this.downTime -= framin;
         }
      }
      
      private function collideThePlat(ex:*, ey:*, eRL:*, eUD:*, e:*, ground:*) : *
      {
         var distRL:Number = ex - x;
         var distUD:Number = ey - y;
         this.ax = Math.cos(this.rotAngle) * distRL + Math.sin(this.rotAngle) * distUD;
         this.ay = Math.cos(this.rotAngle) * distUD - Math.sin(this.rotAngle) * distRL;
         if(this.downTime > 0)
         {
            e.aPlatSides[this.ID] = this.ay;
            return "nothing";
         }
         if(e.hitPause > 0 && false)
         {
            this.aRL = this.aUD = 0;
         }
         else
         {
            this.aRL = Math.cos(this.rotAngle) * eRL + Math.sin(this.rotAngle) * eUD;
            this.aUD = Math.cos(this.rotAngle) * eUD - Math.sin(this.rotAngle) * eRL;
         }
         this.wasSide = e.aPlatSides[this.ID] / Math.abs(e.aPlatSides[this.ID]);
         if(Math.abs(this.rotAngle) == 1.5707963267948966 && !e.isABall)
         {
            if(this.Property == "Spikes" && e.health > 0)
            {
               if(Math.abs(this.ax) < e.isTall + this.isWide - 20 && Math.abs(this.ay) < e.isWide + this.isTall - 20)
               {
                  return "wallLand";
               }
            }
            else if(Math.abs(this.ax) < e.isTall + this.isWide)
            {
               if(e.aPlatSides[this.ID] * this.wasSide >= this.isTall + e.isWide)
               {
                  if(!(this.wasSide > 0 && !this.doubleSided))
                  {
                     if(Math.abs(this.ay) < e.isWide + 5)
                     {
                        e.onWallPlat = this.rotAngle / Math.abs(this.rotAngle) * this.wasSide;
                     }
                     if(e.aPlatOn == this || (this.ay * this.wasSide - e.isWide - this.isTall - 1) * (e.aPlatSides[this.ID] * this.wasSide - e.isWide - this.isTall) < 0 && Math.abs(this.ax) < e.isTall + this.isWide)
                     {
                        return "wallLand";
                     }
                     if(!this.canWallJump && !ground)
                     {
                        e.onWallPlat = 0;
                     }
                  }
               }
            }
         }
         else if(this.Property == "Spikes" && e.health > 0)
         {
            if(Math.abs(this.ax) < e.isWide + this.isWide - 20 && Math.abs(this.ay) < e.isTall + this.isTall - 20)
            {
               return "otherLand";
            }
         }
         else if(Math.abs(this.ax) < e.isWide + this.isWide)
         {
            if(Math.abs(this.ay) < e.isTall + e.overReach)
            {
               e.almostPlat = true;
            }
            if(Math.abs(this.ay) < e.isTall + e.overReach && !ground && e.gotoBuffer == "Duck")
            {
               ground = true;
               e.aPlatOn = this;
               e.aPlatSides[this.ID] = this.wasSide * 100;
            }
            if(this.Property == "Hang" && this.aUD > -12 && this.isWide <= e.isWide * 2 && this.ay < -e.isTall && this.ay > -e.isTall * 4)
            {
               if(this.ax * (ex - eRL * framin - x) <= 0)
               {
                  e.x = x;
               }
            }
            if(Boolean(ground) && Boolean(e.aPlatOn == this) && Boolean(this.rotLand(e)) && Boolean(e.almostPlat))
            {
               return "groundLand";
            }
            if(!(this.wasSide > 0 && !this.doubleSided))
            {
               if(e.aPlatSides[this.ID] * this.wasSide > this.isTall + e.isTall)
               {
                  if((this.ay * this.wasSide - e.isTall - this.isTall) * (e.aPlatSides[this.ID] * this.wasSide - e.wasTall - this.isTall) < 0.001)
                  {
                     if(!(this.Property == "blockUnlessStill" && Boolean(e.Still)))
                     {
                        if(this.Property != "LoopAssist")
                        {
                           if(Boolean(ground) && Boolean(this.rotLand(e)))
                           {
                              return "groundLand";
                           }
                           return "otherLand";
                        }
                        if(ground)
                        {
                           return "groundLand";
                        }
                     }
                  }
               }
            }
         }
         return "nothing";
      }
      
      private function wallOnPlat(e:*, ground:*) : Boolean
      {
         this.ay = (e.isWide + this.isTall + 1) * this.wasSide;
         e.wallX = x + Math.cos(this.rotAngle) * this.ax;
         e.wallY = y + Math.sin(this.rotAngle) * this.ax;
         e.x = e.wallX + -Math.sin(this.rotAngle) * this.ay;
         e.y = e.wallY + Math.cos(this.rotAngle) * this.ay;
         e.aPlatSides[this.ID] = this.wasSide * 50;
         e.platWall = true;
         this.platRL = Math.cos(this.rotAngle) * this.moveRL + Math.sin(this.rotAngle) * this.moveUD;
         this.platUD = Math.cos(this.rotAngle) * this.moveUD - Math.sin(this.rotAngle) * this.moveRL;
         if(Math.abs(e.moveRL) > 5)
         {
            e.landPuffs(5 + Math.abs(e.moveRL * 0.2),-1.57 * e.onWallPlat,0.5 + Math.abs(e.moveRL * 0.02));
            if(e.bounce > 0)
            {
               Sounds.playSound("BadStomp",e.x,Math.abs(e.moveRL) * 0.03,e.onRail);
            }
         }
         e.landSpeed = e.moveRL;
         e.resetCombo();
         if(!this.canWallJump && !ground)
         {
            e.onWallPlat = 0;
         }
         if(Boolean(ground) || !e.canWallHang())
         {
            e.moveRL = this.platUD * -e.makeOne(this.rotAngle);
            e.platRL = 0;
            e.fakeRL = Math.cos(e.wallRot * (Math.PI / 180)) * e.moveRL;
            return false;
         }
         if(e.aPlatOn != this)
         {
            e.aPlatOn = this;
            this.CharsOn.push(e);
            if(this.Wait)
            {
               this.PlatEnterFrame = this[this.Status + "EnterFrame"];
            }
         }
         e.platRL = this.platUD * -e.makeOne(this.rotAngle);
         e.platUD = this.platRL * e.makeOne(this.rotAngle);
         e.fakeRL = e.moveRL = 0;
         if(this.ax * this.rotAngle + e.moveUD < -(this.isWide + e.isTall))
         {
            e.moveUD -= e.moveUD * 0.4 * framin;
         }
         return true;
      }
      
      private function landOnPlat(e:*, ground:*) : Boolean
      {
         if(Boolean(this.Wait) && !ground && e.isTall > 10)
         {
            this.PlatEnterFrame = this[this.Status + "EnterFrame"];
            this.CharsOn.push(e);
         }
         e.aPlatSides[this.ID] = this.wasSide * 50;
         if(Math.abs(this.isWide - Math.abs(this.ax)) < e.isWide)
         {
            e.onLedge = e.makeOne(this.ax);
         }
         else
         {
            e.onLedge = 0;
         }
         if(this.Status == "Mushy")
         {
            if(!ground)
            {
               e.platUD = this.aUD;
            }
            this.mushyUD(this.aUD,this.ax,e.mass);
         }
         else if(this.Status == "Spin")
         {
            this.platUD = this.rotAccel * this.ax;
         }
         else if(this.Status == "catFall")
         {
            this.ax = 0;
            this.aRL = 0;
            this.platUD = this.moveUD;
            e.rotation = e.wallRot;
            e.rotter = 0;
            e.canStatus = "Hang";
         }
         else
         {
            this.platRL = Math.cos(this.rotAngle) * this.moveRL + Math.sin(this.rotAngle) * this.moveUD;
            this.platUD = Math.cos(this.rotAngle) * this.moveUD - Math.sin(this.rotAngle) * this.moveRL;
         }
         e.landSpeed = (this.aUD - this.platUD) * -this.wasSide;
         if(this.forceStill)
         {
            e.Still = true;
         }
         if(this.Property == "Hang")
         {
            if(e.ItIs != "Char")
            {
               return false;
            }
            if(Boolean(e.DownIsDown()) && Boolean(!this.forceStill) || e.Status == "Hurt")
            {
               e.y += 2;
               e.aPlatSides[this.ID] = this.ay;
               return false;
            }
            if(Math.abs(this.rotAngle) <= 0.2617993877991494)
            {
               if(this.isWide <= e.isWide * 2)
               {
                  this.ax = 0;
                  e.onLedge = e.makeOne(this.aRL);
               }
            }
            e.rotation = e.wallRot;
            e.rotter = 0;
            e.canStatus = "Hang";
         }
         else if(this.Property == "Grind")
         {
            e.canStatus = "Grind";
         }
         e.wallX = x + Math.cos(this.rotAngle) * this.ax;
         e.wallY = y + Math.sin(this.rotAngle) * this.ax;
         if(!ground && e.landSpeed > 5 && e.isWide > 10)
         {
            if(this.Property != "Hang")
            {
               if(this.wasSide < 0)
               {
                  e.landPuffs(this.aUD * -this.wasSide * 0.4,this.rotAngle,e.isTall / 25,-this.platUD * this.wasSide);
               }
               else
               {
                  e.landPuffs(this.aUD * -this.wasSide * 0.4,this.rotAngle + 3.141592653589793,e.isTall / 25,-this.platUD * this.wasSide);
               }
            }
         }
         this.aUD -= this.platUD;
         this.aUD *= -e.bounce;
         this.aUD += this.platUD;
         e.resetCombo();
         if((Boolean(this.aUD * this.wasSide < e.bounceThresh) || Boolean(ground)) && Boolean(this.rotLand(e)))
         {
            this.ay = (this.isTall + e.isTall + 0.5) * this.wasSide;
            if(e.Status != "Roll" && e.aPlatOn != this || this.Property == "Grind")
            {
               e.aPlatOn = this;
               this.CharsOn.push(e);
               this.aRL -= this.platRL * 0.5;
            }
            e.fakeRL = this.aRL * -this.wasSide;
            this.aUD = e.fakeUD = 0;
         }
         else
         {
            this.ay -= (this.isTall + e.isTall + 0.5) * this.wasSide;
            this.ay *= -e.bounce;
            this.ay += (this.isTall + e.isTall + 0.5) * this.wasSide;
            if(e.isWide > 10)
            {
               Sounds.playSound("BadStomp",e.x,e.landSpeed * 0.2,e.onRail);
            }
         }
         e.x = e.wallX + -Math.sin(this.rotAngle) * this.ay;
         e.y = e.wallY + Math.cos(this.rotAngle) * this.ay;
         if(e.hitPause == 0)
         {
            if(e.Status == "Roll")
            {
               e.rotter = (this.aRL - this.platRL) * e.rotPerc;
               this.aRL += (this.platRL - this.aRL) * 0.05;
            }
            e.cheatSpeed = e.moveRL;
            e.moveRL = Math.cos(this.rotAngle) * this.aRL - Math.sin(this.rotAngle) * this.aUD;
            e.moveUD = Math.cos(this.rotAngle) * this.aUD + Math.sin(this.rotAngle) * this.aRL;
            if(this.rotLand(e))
            {
               e.wallAngle = this.rotAngle;
               e.wallRot = this.rotAngle / (Math.PI / 180);
               if(e.wallRot > 90)
               {
                  e.wallAngle -= 3.141592653589793;
                  e.wallRot -= 180;
               }
               else if(e.wallRot < -90)
               {
                  e.wallAngle += 3.141592653589793;
                  e.wallRot += 180;
               }
               if(this.Status != "Mushy")
               {
                  e.platRL = this.platRL * -this.wasSide;
                  e.platUD = this.platUD * -this.wasSide;
               }
               e.fakeRL = this.aRL * -this.wasSide;
               e.fakeUD = this.aUD * -this.wasSide;
               e.lastGround = "aPlat";
               e.platGround = true;
               return true;
            }
            e.fakeRL = Math.cos(e.wallAngle) * e.moveRL + Math.sin(e.wallAngle) * e.moveUD;
            e.fakeUD = 0;
            return false;
         }
         return ground;
      }
      
      private function rotLand(e:*) : *
      {
         if(this.Property == "LoopAssist")
         {
            return true;
         }
         if(e.aPlatSides[this.ID] < 0 && Math.abs(this.rotAngle) < 1.0471975511965976)
         {
            return true;
         }
         if(Boolean(this.doubleSided) && e.aPlatSides[this.ID] > 0 && Math.abs(this.rotAngle) > 2.0943951023931953)
         {
            return true;
         }
         return false;
      }
      
      public function RockEnterFrame() : *
      {
         if(Math.abs(this.fakeX) > this.fakeDist)
         {
            this.fakeRL -= (this.fakeX - this.fakeDist * this.fakeX / Math.abs(this.fakeX)) / this.spring * framin;
         }
         this.fakeX += this.fakeRL * framin;
         if(this.Wait)
         {
            if(this.fakeX < 0)
            {
               this.resetPlatform(false);
               return;
            }
         }
         this.moveRL = this.RLxCache * this.fakeRL;
         this.moveUD = this.RLyCache * this.fakeRL;
         x = this.wallX + this.RLxCache * this.fakeX;
         y = this.wallY + this.RLyCache * this.fakeX;
      }
      
      public function StraightEnterFrame() : void
      {
         this.fakeRL += (this.maxRL - this.fakeRL) / this.spring * framin;
         this.fakeX += this.fakeRL * framin;
         this.moveRL = this.RLxCache * this.fakeRL;
         this.moveUD = this.RLyCache * this.fakeRL;
         x = this.wallX + this.RLxCache * this.fakeX;
         y = this.wallY + this.RLyCache * this.fakeX;
         if(this.fakeX > this.fakeDist)
         {
            if(alpha - 0.05 * framin < 0)
            {
               this.resetPlatform(true);
            }
            else
            {
               alpha -= 0.04 * framin;
            }
         }
      }
      
      public function JumpEnterFrame() : *
      {
         if(this.fakeRL > 0.0005)
         {
            this.fakeRL -= this.fakeRL * (100 / this.spring) * framin;
         }
         else if(this.fakeDist > 0)
         {
            this.fakeDist -= framin;
         }
         else
         {
            this.fakeRL -= 0.25;
         }
         this.fakeX += this.fakeRL * framin;
         if(this.fakeX < 0)
         {
            if(this.Wait)
            {
               this.resetPlatform(true);
            }
            else
            {
               this.fakeRL = this.maxRL;
               this.fakeDist = this.pMaster.fakeDist;
               visible = !this.pMaster.hide;
            }
            return;
         }
         this.moveRL = this.RLxCache * this.fakeRL;
         this.moveUD = this.RLyCache * this.fakeRL;
         x = this.wallX + this.RLxCache * this.fakeX;
         y = this.wallY + this.RLyCache * this.fakeX;
      }
      
      public function OnRideEnterFrame() : *
      {
         if(this.CharsOn.length > 0)
         {
            if(this.fakeRL < this.maxRL)
            {
               this.fakeRL += (this.maxRL - this.fakeRL) * 0.05 * framin;
            }
         }
         else if(this.fakeRL > 1)
         {
            this.fakeRL -= this.fakeRL * 0.1 * framin;
         }
         else if(this.fakeRL > -this.maxRL * 2)
         {
            this.fakeRL -= 0.5 * framin;
         }
         if(this.fakeRL > 0)
         {
            if(this.fakeRL > (this.fakeDist - this.fakeX) * 0.1)
            {
               this.fakeRL = (this.fakeDist - this.fakeX) * 0.1;
            }
         }
         else if(this.fakeRL < -this.fakeX * 0.1)
         {
            this.fakeRL = -this.fakeX * 0.1;
         }
         this.fakeX += this.fakeRL * framin;
         if(this.fakeX < 1 && this.fakeRL < 0)
         {
            this.resetPlatform(false);
            return;
         }
         this.moveRL = this.RLxCache * this.fakeRL;
         this.moveUD = this.RLyCache * this.fakeRL;
         x = this.wallX + this.RLxCache * this.fakeX;
         y = this.wallY + this.RLyCache * this.fakeX;
      }
      
      public function CircleEnterFrame() : *
      {
         this.moveRot += this.rotAccel * framin;
         this.moveRL = this.RLx(this.fakeRL) * this.squishX;
         this.moveUD = this.RLy(this.fakeRL) * this.squishY;
         x = this.wallX + this.fakeDist * Math.sin(this.moveRot) * this.squishX;
         y = this.wallY - this.fakeDist * Math.cos(this.moveRot) * this.squishY;
      }
      
      public function SpinEnterFrame() : *
      {
         this.rotAngle += this.rotAccel * framin;
         rotation = this.rotAngle;
      }
      
      private function FallEnterFrame() : *
      {
         if(this.Wait)
         {
            this.moveUD = 8;
            Main.shakeScreen(10,0,true);
            this.Wait = false;
         }
         if(this.state == 0)
         {
            this.moveUD *= Math.pow(0.8,framin);
            this.moveRot *= 0.85 * Math.pow(0.85,framin);
            if(this.moveUD < 1)
            {
               this.state = 1;
            }
            y += this.moveUD * framin;
         }
         else if(this.state == 1)
         {
            if(this.moveUD < 20)
            {
               this.moveUD *= Math.pow(1.1,framin);
            }
            this.rotAngle -= 0.0035 * framin;
            rotation = this.rotAngle;
            y += this.moveUD * framin;
            if(Main.checkPitY(y,this.onRail))
            {
               this.PlatEnterFrame = function():*
               {
               };
               this.removeMyOns();
               y += 1000;
            }
         }
      }
      
      private function catFallEnterFrame() : *
      {
         var temp:justALoop = null;
         var temp2:justALoop = null;
         if(this.Wait)
         {
            this.moveUD = 15;
            Main.shakeScreen(10,0,true);
            this.Wait = false;
            this.myObject.playing = true;
            Sounds.playSoundSimple("CatTear");
            Main.switchScroll("hangOnCatScroll");
            this.CharsOn[0].zOffset = 30;
         }
         if(this.state == 0)
         {
            this.moveUD -= this.moveUD * 0.2 * framin;
            if(this.moveUD < 0.1)
            {
               this.state = 1;
            }
         }
         else if(this.state == 1)
         {
            if(this.moveUD < 8)
            {
               this.moveUD *= Math.pow(1.05,framin);
            }
            if(y > this.wallY + 200)
            {
               this.state = 2;
            }
         }
         else if(this.state == 2)
         {
            this.CharsOn[0].platUD = 0;
            this.CharsOn[0].moveUD = 3;
            this.CharsOn[0].aPlatSides[this.ID] = 1;
            this.CharsOn[0].changeFrame("FallCat");
            this.CharsOn[0].Status = "FallCat";
            this.CharsOn[0].head.scaleX = this.CharsOn[0].scaleX = -1;
            this.CharsOn[0].FallCatSetupFrame();
            this.CharsOn[0].CharEnterFrame = this.CharsOn[0].FallCatEnterFrame;
            this.CharsOn[0].rotter = -6 * this.CharsOn[0].scaleX;
            this.removeMyOns();
            y -= 2000;
            visible = false;
            Main.gotCatDown();
            this.state = 3;
         }
         else if(this.state == 3)
         {
            this.moveUD -= this.moveUD * 0.4 * framin;
            if(this.moveUD < 0.1)
            {
               this.state = 4;
               this.myObject.cat.gotoAndStop(2);
            }
         }
         else if(this.state == 4)
         {
            if(this.moveUD < 15)
            {
               this.moveUD += framin;
            }
            if(y + this.moveUD * framin > -1100)
            {
               y = -1100;
               this.moveUD = 0;
               this.myObject.cat.gotoAndStop("caught");
               Char.CharArray[0].char.gotoAndStop("c");
               Sounds.playSoundSimple("HangLand_0");
               this.state = 5;
            }
         }
         else if(this.state == 5)
         {
            if(Char.CharArray[0].wantRL != 0 || Char.CharArray[0].JumpIsDown())
            {
               Char.CharArray[0].char.gotoAndStop("d");
               this.moveUD = -15;
               this.myObject.cat.gotoAndStop("toss");
               this.myObject.cat.x += 10;
               Sounds.playSoundSimple("JustCat");
               temp = justALoop.findByWhich("cutieStomp");
               temp2 = new cutieHoldCat();
               Main.saveProgress("catIsDown",true);
               temp2.x = temp.x;
               temp2.y = temp.y;
               temp2.ItIs = "cutieHoldCat";
               temp2.loopRand = 60;
               Backgrounds.backgroundsArray[0].addChild(temp2);
               staticInteractObjects.killInteract.push(temp);
               temp = temp2 = null;
               this.state = 6;
            }
         }
         else if(this.state == 6)
         {
            this.moveUD += 0.5 * framin;
            this.myObject.cat.x += 10 * framin;
            this.myObject.cat.rotation += 20 * framin;
            if(this.moveUD > 0)
            {
               this.state = 7;
               this.myObject.cat.visible = false;
               this.moveRL = this.moveUD = 0;
            }
         }
         y += this.moveUD * framin;
         if(this.state < 3)
         {
            this.myObject.cat.y = y - this.wallY - 72;
         }
         else if(this.state == 6)
         {
            this.myObject.cat.y = y - this.wallY - 72 + 1970;
         }
         else
         {
            this.myObject.cat.y = y - this.wallY - 72 + 2000;
         }
      }
      
      public function MushyEnterFrame() : void
      {
         var tempX:Number = NaN;
         var n:int = int(this.CharsOn.length);
         var totalMass:Number = Number(this.mass);
         var force:Number = this.mass * this.pointLud;
         for(i = 0; i < n; ++i)
         {
            force += this.CharsOn[i].mass * (this.CharsOn[i].platUD + 4 * framin) * (-(this.CharsOn[i].ax - 15 - this.isWide) / ((this.isWide + 15) * 2));
            totalMass += this.CharsOn[i].mass * (-(this.CharsOn[i].ax - 15 - this.isWide) / ((this.isWide + 15) * 2));
         }
         force -= this.pointL * 6 * framin;
         this.pointLud = force / totalMass;
         this.pointL += this.pointLud * framin;
         this.pointLud *= Math.pow(0.92,framin);
         n = int(this.CharsOn.length);
         totalMass = 100;
         force = this.mass * this.pointRud;
         for(i = 0; i < n; ++i)
         {
            force += this.CharsOn[i].mass * (this.CharsOn[i].platUD + 4 * framin) * ((this.CharsOn[i].ax + 15 + this.isWide) / ((this.isWide + 15) * 2));
            totalMass += this.CharsOn[i].mass * ((this.CharsOn[i].ax + 15 + this.isWide) / ((this.isWide + 15) * 2));
         }
         force -= this.pointR * 6 * framin;
         this.pointRud = force / totalMass;
         this.pointR += this.pointRud * framin;
         this.pointRud *= Math.pow(0.92,framin);
         n = int(this.CharsOn.length);
         for(i = 0; i < n; ++i)
         {
            tempX = this.CharsOn[i].ax - 15 - this.isWide;
            this.pointLratio = -tempX / ((this.isWide + 15) * 2);
            tempX = this.CharsOn[i].ax + 15 + this.isWide;
            this.pointRratio = tempX / ((this.isWide + 15) * 2);
            this.CharsOn[i].platUD = this.pointRud * this.pointRratio + this.pointLud * this.pointLratio;
         }
         var prx:Number = this.pointRoriginX - Math.sin(this.rotAngle) * this.pointR;
         var pry:Number = this.pointRoriginY + Math.cos(this.rotAngle) * this.pointR;
         var plx:Number = this.pointLoriginX - Math.sin(this.rotAngle) * this.pointL;
         var ply:Number = this.pointLoriginY + Math.cos(this.rotAngle) * this.pointL;
         this.rotAngle = -Math.atan2(plx - prx,ply - pry) - 1.5707963267948966;
         rotation = this.rotAngle;
         x = (prx + plx) * 0.5;
         y = (pry + ply) * 0.5;
      }
      
      public function startLoop() : void
      {
         this.currentSound = Sounds.superLoop = Sounds.playSoundContinuous("AirshipLoop",x,1,0);
         Sounds.superSound = "AirshipLoop";
         Sounds.superSource = this;
      }
      
      public function ShipEnterFrame() : void
      {
         var i:uint = 0;
         var temp:String = null;
         var n:uint = 0;
         if(Char.CharArray[0].y > y + 250)
         {
            Char.CharArray[0].hurtChar(10,5,0,0,20);
            Char.CharArray[0].x = x;
            Char.CharArray[0].y = y - 200;
            Char.CharArray[0].parent.mask = null;
         }
         if(this.state == 0)
         {
            if(this.CharsOn.length > 0)
            {
               this.state = 1;
            }
         }
         else if(this.state == 1)
         {
            if(staticInteractObjects.textBubbleArray[0].popupText(Char.CharArray[0].UpIsDown()))
            {
               Sounds.fadeOutMusic("Wind_Cave",0.02);
               Sounds.playSoundThenLoop("AirshipStart",this);
               this.state = 2;
               this.b = -40;
               Main.MinY = -1121;
            }
         }
         else if(this.state == 2)
         {
            if(Main.stageRoot.tick)
            {
               this.myObject.captSteer();
               ++this.b;
               if(this.b > 30)
               {
                  if(this.propSpeed < 30)
                  {
                     this.propSpeed += 0.5;
                  }
               }
            }
            if(this.b >= 20)
            {
               if(this.b < 50)
               {
                  Main.shakeScreen((this.b - 20) * 0.2,0,true);
               }
               else if(this.b < 120)
               {
                  Main.shakeScreen(10,0,true);
               }
               else if(Math.abs(this.b - 120) < 1)
               {
                  this.moveUD = -10;
                  this.Status = "Fly";
                  this.b = 121;
               }
               else if(this.b < 200)
               {
                  Main.shakeScreen(8,0,true);
                  y += this.moveUD * framin;
                  this.moveUD -= this.moveUD * 0.05 * framin;
               }
               else if(this.b < 282)
               {
                  Main.shakeScreen(10,0,true);
                  y += this.moveUD * framin;
                  this.moveUD -= 0.1 * framin;
               }
               else if(this.b == 282)
               {
                  Sounds.fadeOutMusic("BossMusic",0.1);
               }
               else
               {
                  if(Main.stageRoot.tick)
                  {
                     temp = this.myObject.tentacleAttack(this.b);
                  }
                  else
                  {
                     temp = "nothing";
                  }
                  if(temp == "d")
                  {
                     this.moveUD = 0;
                  }
                  else if(temp == "e")
                  {
                     this.state = 3;
                     this.b = 400;
                     staticInteractObjects.moveAllAttackablesY(y,this);
                  }
                  if(temp != "d")
                  {
                     y += this.moveUD * framin;
                  }
               }
            }
         }
         else if(this.state == 3 || this.state == 4)
         {
            if(Main.stageRoot.tick)
            {
               n = 0;
               for(i = 0; i < 4; i++)
               {
                  if(this.myObject["ink" + i].disabled)
                  {
                     this.myObject["ink" + i].nextFrame();
                  }
                  if(this.myObject["ink" + i].currentFrame == this.myObject["ink" + i].totalFrames)
                  {
                     n++;
                  }
                  if(this.myObject["ink" + i].currentFrame == 13)
                  {
                     Sounds.playSound("BadStomp",x + this.myObject["ink" + i].x,3.5,0);
                  }
                  else if(this.myObject["ink" + i].currentFrame == 31)
                  {
                     Sounds.playSound("InkJump",x + this.myObject["ink" + i].x,3,0);
                  }
                  if(this.myObject["ink" + i].RedHurt > 0)
                  {
                     this.myObject["ink" + i].visible = true;
                     if(this.myObject["ink" + i].RedHurt == 2)
                     {
                        this.myObject["ink" + i].transform.colorTransform = Main.getTint(1,-0.6,-0.6);
                     }
                     if(this.myObject["ink" + i].RedHurt == 1 || this.myObject["ink" + i].RedHurt == 3)
                     {
                        this.myObject["ink" + i].transform.colorTransform = Main.getTint(0,0,0);
                     }
                     --this.myObject["ink" + i].RedHurt;
                  }
               }
               if(this.state == 4)
               {
                  Main.shakeScreen(8 + Math.random() * 2,0,true);
                  if(this.moveUD < 20)
                  {
                     this.moveUD *= 1.05;
                  }
                  if(n == 4)
                  {
                     this.state = 5;
                     this.moveUD = -1.5;
                     this.b = 200;
                     this.myObject.gotoAndStop(3);
                     this.myObject.ink0.gotoAndStop(2);
                     this.myObject.ink1.gotoAndStop(3);
                  }
               }
               else
               {
                  Main.shakeScreen(2 + Math.random() * 3,0,true);
               }
            }
            y += this.moveUD * framin;
         }
         else if(this.state == 5)
         {
            if(Main.stageRoot.tick)
            {
               Main.shakeScreen(8 + Math.random() * 2,0,true);
               ++this.b;
               if(this.b > 230)
               {
                  this.state = 6;
               }
               if(this.moveUD > -20)
               {
                  this.moveUD *= 1.05;
               }
            }
            y += this.moveUD * framin;
         }
         else if(this.state == 6)
         {
            if(Main.stageRoot.tick)
            {
               if(this.myObject["ink" + 0].currentFrame == 6)
               {
                  Sounds.playSound("InkJump",x,3);
                  Sounds.playSound("InkSplat",x,2);
               }
               else if(this.myObject["ink" + 0].currentFrame == 26)
               {
                  Sounds.playSound("InkJump",x,3);
                  Sounds.playSound("InkSplat",x,1);
               }
               else if(this.myObject["ink" + 0].currentFrame == 31)
               {
                  Sounds.playSound("HeavySwosh",x,2);
               }
               else if(this.myObject["ink" + 0].currentFrame == 36)
               {
                  Sounds.playSound("InkJump",x,1);
                  Sounds.playSound("InkSplat",x,2);
               }
               if(this.myObject["ink" + 0].currentFrame == 31 || this.myObject["ink" + 0].currentFrame == 44 || this.myObject["ink" + 0].currentFrame == 53 || this.myObject["ink" + 0].currentFrame == 56 || this.myObject["ink" + 0].currentFrame == 61 || this.myObject["ink" + 0].currentFrame == 64 || this.myObject["ink" + 0].currentFrame == 66 || this.myObject["ink" + 0].currentFrame == 68)
               {
                  Sounds.playSound("Twirl",x,2);
               }
               i = 0;
               while(i < 2)
               {
                  this.myObject["ink" + i].nextFrame();
                  i++;
               }
               if(this.myObject.ink0.currentFrame == 48)
               {
                  StarlingTemporary.Spawn("inkStretch",x,y,0,2,0);
               }
               if(this.myObject.ink1.currentFrame == 48)
               {
                  StarlingTemporary.Spawn("inkStretch",x,y,0,-2,0);
               }
               if(this.myObject.ink0.currentFrame == 38)
               {
                  Main.shakeScreen(50,0,true);
               }
               else if(this.myObject.ink0.currentFrameLabel == "b")
               {
                  Main.shakeScreen(40,0,true);
                  Sounds.playSound("InkSplat",x,2);
                  Sounds.playSound("InkBoom",x,1);
                  this.state = 7;
                  this.b = 230;
                  this.c = 30;
                  staticInteractObjects.killInteract.push(staticInteractObjects.canAttackArray[3]);
                  staticInteractObjects.killInteract.push(staticInteractObjects.canAttackArray[2]);
                  staticInteractObjects.killInteract.push(staticInteractObjects.canAttackArray[1]);
                  staticInteractObjects.canAttackArray[0].x = x;
                  staticInteractObjects.moveAllAttackablesY(y,this);
                  StarlingTemporary.Spawn("inkStretchSpit",x,y,0,1,0);
                  this.myObject.ink1.gotoAndStop("c");
               }
               if(this.myObject.ink0.currentFrame < 38)
               {
                  if(this.moveUD > -20)
                  {
                     this.moveUD *= 1.05;
                  }
                  Main.shakeScreen(8 + Math.random() * 2,0,true);
               }
               else
               {
                  this.moveUD = 0;
                  Main.shakeScreen(2 + Math.random() * 3,0,true);
               }
            }
            y += this.moveUD * framin;
         }
         else if(this.state == 7)
         {
            Main.shakeScreen(2 + Math.random() * 3,0,true);
            if(this.myObject.ink0.currentFrameLabel == "e")
            {
               this.myObject.ink0.gotoAndStop("b");
            }
            else if(this.myObject.ink0.currentFrame > 75)
            {
               this.myObject.ink0.nextFrame();
            }
            if(this.myObject.ink0.currentFrame > 73)
            {
               StarlingTemporary.setFrame(4,this.myObject.ink0.currentFrame - 73);
            }
            if(Baddies.BaddieArray.length <= 6)
            {
               if(this.b > 200)
               {
                  --this.b;
               }
               else if(this.c > 0)
               {
                  --this.c;
                  new Baddie1({
                     "ItIs":"Baddie1",
                     "x":x,
                     "y":y - 25,
                     "rotation":0,
                     "scaleX":1,
                     "scaleY":0.7 + Math.random() * 0.5,
                     "onRail":0,
                     "hatN":0,
                     "moveRL":5 - 10 * Math.random(),
                     "moveUD":-(20 + 10 * Math.random()),
                     "autopilot":true,
                     "downTime":30,
                     "originX":x,
                     "tether":400
                  });
                  this.b = 205 + Math.random() * 20;
                  this.myObject.ink0.gotoAndStop("d");
               }
               else if(Baddies.BaddieArray.length == 0)
               {
                  this.state = 8;
                  this.myObject.ink0.gotoAndStop("e");
                  this.myObject.ink0.nextFrame();
                  Sounds.fadeOutMusic("Wind_Cave",0.02);
                  StarlingTemporary.setVisible(4,false);
               }
            }
         }
         else if(this.state == 8)
         {
            if(this.myObject.ink0.currentFrameLabel == "f")
            {
               this.state = 9;
               new inkVein({
                  "x":x,
                  "y":y - 20,
                  "scaleX":1,
                  "scaleY":1
               });
               staticInteractObjects.findByName("inkVein").start();
               StarlingTemporary.setVisible(2,false);
               StarlingTemporary.setVisible(3,false);
               this.myObject.ink0.gotoAndStop("g");
               this.myObject.ink1.gotoAndStop("g");
            }
            else
            {
               this.myObject.ink0.nextFrame();
            }
         }
         else if(this.state == 9)
         {
            if(Char.CharArray[0].Status == "PenUpgradeStab")
            {
               if(Main.stageRoot.tick)
               {
                  if(Char.CharArray[0].char.currentFrame > 85)
                  {
                     i = 0;
                     while(i < 2)
                     {
                        this.myObject["ink" + i].nextFrame();
                        i++;
                     }
                  }
               }
               if(Char.CharArray[0].char.currentFrame > 185)
               {
                  this.state = 10;
                  this.moveUD = -2;
                  this.b = 320;
                  staticInteractObjects.findByName("inkVein").visible = false;
                  Main.saveProgress("freePirateShip",true);
               }
            }
            else
            {
               Main.shakeScreen(1,0,true);
            }
         }
         else if(this.state == 10)
         {
            if(this.moveUD > -40)
            {
               this.moveUD *= 1.1;
            }
            y += this.moveUD * framin;
            if(this.b < 200)
            {
               this.state = 11;
               Main.FadeItOut("Level3-a");
            }
            else
            {
               --this.b;
            }
         }
         StarlingTemporary.justGetWithN(1).rotation = StarlingTemporary.justGetWithN(1).rotation + this.propSpeed * (Math.PI / 180) * framin;
         if(this.b < 120)
         {
            this.MushyEnterFrame();
         }
         else
         {
            rotation -= rotation * 0.1 * framin;
            if(this.CharsOn.length > 0)
            {
               this.CharsOn[0].platUD = this.moveUD;
            }
         }
         this.myObject.x = x;
         this.myObject.y = y;
         StarlingTemporary.placeTemp(0,x,y,rotation);
         StarlingTemporary.setFrame(0,this.myObject.capt.currentFrame);
         this.propSkew.y = y - 470;
         this.myObject.rotation = rotation * (180 / Math.PI);
      }
      
      public function Ship2EnterFrame() : void
      {
         this.pointRoriginY += (-370 - this.pointRoriginY) * 0.025 * framin;
         this.pointLoriginY += (-370 - this.pointLoriginY) * 0.025 * framin;
         if(Main.DoorLoaded == 0 && Math.abs(this.pointLoriginY - -370) < 50 && Math.abs(Char.CharArray[0].x - x) < 250)
         {
            staticInteractObjects.textBubbleArray[0].popupText(Char.CharArray[0].UpIsDown());
         }
         if(Main.stageRoot.tick)
         {
            this.myObject.captSteer();
         }
         this.MushyEnterFrame();
         if(this.propSpeed > 10)
         {
            this.propSpeed -= 0.2 * framin;
         }
         StarlingTemporary.justGetWithN(1).rotation = StarlingTemporary.justGetWithN(1).rotation + this.propSpeed * (Math.PI / 180) * framin;
         Sounds.updateSound(this.currentSound,x,1,0);
         if(this.state != 1)
         {
            if(Char.CharArray[0].Status != "Disabled")
            {
               this.state = 1;
            }
            else if(Char.CharArray[0].Status == "Disabled" && (y < 500 && Char.CharArray[0].y > 500 || y > -1000 && Char.CharArray[0].y < -1000))
            {
               Char.CharArray[0].Still = false;
               Char.CharArray[0].alpha = Char.CharArray[0].head.alpha = 1;
               Char.CharArray[0].y = y - Char.CharArray[0].isTall;
               Char.CharArray[0].gotoBuffer = "Idle";
               Char.CharArray[0].coreSwitchAnim();
            }
         }
         this.myObject.x = x;
         this.myObject.y = y;
         StarlingTemporary.placeTemp(0,x,y,rotation * (Math.PI / 180));
         StarlingTemporary.setFrame(0,this.myObject.capt.currentFrame);
         this.propSkew.y = y - 470;
         this.myObject2.x = this.myObject.x = x;
         this.myObject.y = y;
         this.myObject2.y = y - 15;
         this.myObject.rotation = rotation * (180 / Math.PI);
         this.myObject3.y = y - 35;
         this.myObject3.updateCache();
      }
      
      public function fromJustAttack(hitPower:*, a:*) : Boolean
      {
         if(this.state != 7)
         {
            if(!this.myObject["ink" + a].disabled)
            {
               this.myObject["ink" + a].nextFrame();
               this.myObject["ink" + a].nextFrame();
               this.myObject["ink" + a].RedHurt = 4;
               this.myObject["ink" + a].transform.colorTransform = Main.getTint(1,-0.6,-0.6);
               Sounds.playSound("InkExplode",x + this.myObject["ink" + a].x,1,0);
               if(this.myObject["ink" + a].currentFrame > 9)
               {
                  this.myObject["ink" + a].disabled = true;
                  ++this.b;
                  if(this.b == 404)
                  {
                     this.state = 4;
                     this.moveUD = -1;
                  }
                  return true;
               }
            }
         }
         return false;
      }
      
      public function RemoteEnterFrame() : void
      {
         this.moveRL = this.RLxCache * this.fakeRL;
         this.moveUD = this.RLyCache * this.fakeRL;
         x = this.wallX + this.RLxCache * this.fakeX;
         y = this.wallY + this.RLyCache * this.fakeX;
      }
      
      private function mushyUD(ud:*, eax:*, m:*) : Number
      {
      }
      
      public function StillEnterFrame() : *
      {
      }
      
      public function fromRemote(ex:*, eRL:*) : void
      {
         this.fakeX = ex;
         this.fakeRL = eRL;
      }
      
      private function resetPlatform(remove:Boolean = true) : void
      {
         var i:int;
         if(this.Property == "raceWall")
         {
            return;
         }
         if(this.Status == "OnRide" || this.Status == "Straight")
         {
            this.fakeRL = 0;
         }
         else
         {
            this.fakeRL = this.maxRL;
         }
         if(this.pMaster.pairID > -1)
         {
            staticInteractObjects.findByPairID(this.pMaster.pairID).myPlat = this;
         }
         this.state = this.fakeX = 0;
         this.moveRL = this.moveUD = 0;
         x = this.wallX;
         y = this.wallY;
         alpha = scaleX = 1;
         this.rotAngle = this.pMaster.rotation * (Math.PI / 180);
         if(Math.round(this.rotAngle * 100) == 157)
         {
            this.rotAngle = 1.5707963267948966;
         }
         if(Math.round(this.rotAngle * 100) == -157)
         {
            this.rotAngle = -1.5707963267948966;
         }
         rotation = this.rotAngle;
         if(this.pMaster.wait)
         {
            this.Wait = true;
         }
         this.fakeDist = this.pMaster.fakeDist;
         visible = !this.pMaster.hide;
         if(this.pMaster.wait)
         {
            this.PlatEnterFrame = function():*
            {
            };
         }
         if(remove)
         {
            this.removeMyOns();
         }
         i = 0;
         while(i < this.pMaster.ahead)
         {
            this.PlatEnterFrame();
            i++;
         }
         if(this.Status == "catFall")
         {
            this.setupCatFall();
         }
         else if(this.Property == "Ship")
         {
            this.state = 0;
            this.myObject.gotoAndStop(1);
            this.myObject.tentacleIntro.gotoAndStop(2);
            this.myObject.capt.gotoAndStop(1);
            this.propSpeed = 3;
            this.setupStarlingShip();
         }
         else if(this.Property == "Ship2")
         {
            this.myObject.gotoAndStop(1);
            this.myObject.tentacleIntro.gotoAndStop(2);
            this.myObject.capt.gotoAndStop("steer");
            this.propSpeed = 3;
            this.setupStarlingShip();
         }
      }
      
      private function setupCatFall() : void
      {
         var temp3:justALoop = null;
         var temp:WarpBox = null;
         var temp4:justALoop = null;
         for(i in staticInteractObjects.InteractEnterFrameArray)
         {
            if(staticInteractObjects.InteractEnterFrameArray[i].ItIs == "spaceTear")
            {
               this.myObject = staticInteractObjects.InteractEnterFrameArray[i];
            }
         }
         if(Main.world4Progress.catIsDown)
         {
            this.myObject.cat.visible = false;
            this.myObject.playing = true;
            y -= 1000;
            temp3 = justALoop.findByWhich("cutieStomp");
            temp = staticInteractObjects.findByUnique(0);
            if(Char.hasPen)
            {
               temp.y += 2000;
               temp.changeProperties("nothing",1);
               temp.updateCache();
               temp = staticInteractObjects.findByUnique(1);
               temp.y += 2000;
               temp.updateCache();
            }
            else
            {
               temp.x = -2500;
               temp4 = new cutieHoldCat();
               temp4.x = temp3.x;
               temp4.y = temp3.y;
               temp4.ItIs = "cutieHoldCat";
               temp4.loopRand = 60;
               Backgrounds.backgroundsArray[0].addChild(temp4);
               temp4 = null;
               temp.updateCache();
            }
            staticInteractObjects.killInteract.push(temp3);
            temp = temp3 = null;
         }
      }
      
      private function removeMyOns() : *
      {
         for(var i:int = 0; i < this.CharsOn.length; i++)
         {
            this.CharsOn[i].aPlatOn = null;
         }
         this.CharsOn = [];
      }
   }
}

