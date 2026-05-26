package
{
   import flash.display.MovieClip;
   import starling.display.Image;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol766")]
   public class aGround extends MovieClip
   {
      
      internal static var GroundArray:Array = new Array();
      
      private function MoveEnterFrame():void
      {
      }
      private var wallX:int;
      
      private var wallY:int;
      
      private var maxScaleX:Number;
      
      private var maxScaleY:Number;
      
      private var springX:Number = 0;
      
      private var springY:Number = 0;
      
      private var springyX:Number;
      
      private var springyY:Number;
      
      private var stretchCenter:Number = 0.8;
      
      private var fakeUD:Number = 0;
      
      private var moveRL:Number = 0;
      
      private var moveUD:Number = 0;
      
      private var moveRot:Number;
      
      private var maxRot:Number;
      
      private var Wait:Boolean;
      
      private var Fall:Boolean;
      
      private var Tip:Boolean;
      
      private var Status:String;
      
      private var CharsOn:Array = new Array();
      
      public var step:uint = 0;
      
      private var suppressJump:Boolean;
      
      public var onRail:int;
      
      private var pMaster:Object;
      
      private var smokeLabel:String = "nothing";
      
      private var fromTemp:Boolean;
      
      private var smokeFrames:Array = ["approach0","approach1","approach2","approach3","approach4","lava0","lava1","lava2"];
      
      public var smoke:Image;
      
      public function aGround(p:*)
      {
         super();
         this.wallX = x = p.x;
         this.wallY = y = p.y;
         scaleX = this.maxScaleX = p.scaleX;
         scaleY = this.maxScaleY = p.scaleY;
         if(p.springx == undefined || p.springx == 0)
         {
            this.springyX = 0;
         }
         else
         {
            this.springyX = 1 / Math.abs(p.springx);
            if(p.springx < 0)
            {
               scaleX = scx - this.stretchCenter * p.scaleX * 0.5;
            }
         }
         if(p.springy == undefined || p.springy == 0)
         {
            this.springyY = 0;
         }
         else
         {
            this.springyY = 1 / Math.abs(p.springy);
            if(p.springy < 0)
            {
               scaleY = scy - this.stretchCenter * p.scaleY * 0.5;
            }
         }
         rotation = Math.round(p.rotation);
         this.Status = p.status;
         this.onRail = p.rail;
         this.maxRot = p.moveRot;
         decay = p.dec;
         this.Fall = p.fall;
         this.Tip = p.tip;
         if(p.fromTemp != undefined)
         {
            this.fromTemp = p.fromTemp;
         }
         if(p.smokeLabel != undefined)
         {
            this.smokeLabel = p.smokeLabel;
         }
         this.pMaster = p;
         if(p.wait)
         {
            this.Wait = true;
            this.MoveEnterFrame = this.WaitEnterFrame;
            this.moveRot = 0;
         }
         else
         {
            this.Wait = false;
            this.MoveEnterFrame = this[this.Status + "EnterFrame"];
            this.moveRot = this.maxRot;
         }
         Main.AllEverything["ground" + this.onRail].addChild(this);
         GroundArray.push(this);
         gotoAndStop(p.ID + 1);
         if(this.fromTemp)
         {
            this.smoke = StarlingTemporary.justGetWithN(StarlingTemporary.Spawn("aGround" + p.ID,p.x,p.y,0,1,this.onRail,false,0));
         }
         else if(this.smokeLabel != "nothing")
         {
            this.smoke = StarlingBackgrounds.getGroundSmoke(this.smokeFrames.indexOf(this.smokeLabel) + 4,this.onRail);
         }
         else
         {
            this.smoke = StarlingBackgrounds.getGroundSmoke(p.ID,this.onRail);
         }
         this.smoke.textureSmoothing = "trilinear";
         this.smoke.rotation = rotation * (Math.PI / 180);
         this.smoke.x = x;
         this.smoke.y = y;
         this.smoke.scaleX = scaleX;
         this.smoke.scaleY = scaleY;
      }
      
      internal static function clearAllOns() : void
      {
         for(var i:int = 0; i < GroundArray.length; i++)
         {
            GroundArray[i].CharsOn = [];
         }
      }
      
      internal static function GroundEnterFrames(f:Number, tick:Boolean) : void
      {
         for(var i:int = 0; i < GroundArray.length; i++)
         {
            GroundArray[i].GroundEnterFrame(f,tick);
         }
      }
      
      internal static function simpleCheckGrounds(ex:*, ey:*, e:*) : Boolean
      {
         for(var i:int = 0; i < GroundArray.length; i++)
         {
            if(e.onRail == GroundArray[i].onRail)
            {
               if(GroundArray[i].hitTestPoint(ex,ey,true))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      internal static function CheckGrounds(ex:*, ey:*, e:*) : Boolean
      {
         for(var i:int = 0; i < GroundArray.length; i++)
         {
            if(e.onRail == GroundArray[i].onRail)
            {
               if(GroundArray[i].hitTestPoint(ex,ey,true))
               {
                  if(GroundArray[i].CharsOn.indexOf(e) == -1)
                  {
                     GroundArray[i].CharsOn.push(e);
                  }
                  if(GroundArray[i].Status == "Mushy")
                  {
                     if(e.groundUD == 0)
                     {
                        e.groundUD = e.aUD;
                     }
                  }
                  else if(GroundArray[i].Fall)
                  {
                     Main.shakeScreen(10,0,true);
                     GroundArray[i].Fall = false;
                     GroundArray[i].moveUD = e.aUD * 0.6;
                     GroundArray[i].MoveEnterFrame = GroundArray[i].FallEnterFrame;
                  }
                  else if(GroundArray[i].Tip)
                  {
                     Main.shakeScreen(10,0,true);
                     GroundArray[i].Tip = false;
                     GroundArray[i].moveUD = e.aUD * 0.4;
                     GroundArray[i].MoveEnterFrame = GroundArray[i].TipEnterFrame;
                  }
                  if(GroundArray[i].Wait)
                  {
                     GroundArray[i].Wait = false;
                     GroundArray[i].moveRot = GroundArray[i].maxRot;
                     GroundArray[i].MoveEnterFrame = GroundArray[i][GroundArray[i].Status + "EnterFrame"];
                  }
                  return true;
               }
            }
         }
         return false;
      }
      
      internal static function clearAllGrounds() : void
      {
         var i:int = 0;
         var l:int = int(GroundArray.length);
         while(i < l)
         {
            GroundArray[i].smoke.parent.removeChild(GroundArray[i].smoke);
            GroundArray[i].smoke.dispose();
            GroundArray[i].smoke = null;
            GroundArray[i].parent.removeChild(GroundArray[i]);
            i++;
         }
         GroundArray = [];
      }
      
      internal static function resetAllGrounds() : void
      {
         var i:int = 0;
         var l:int = int(GroundArray.length);
         while(i < l)
         {
            GroundArray[i].resetGround();
            i++;
         }
      }
      
      private function resetGround() : void
      {
         this.wallX = x = this.pMaster.x;
         this.wallY = y = this.pMaster.y;
         scaleX = this.maxScaleX = this.pMaster.scaleX;
         scaleY = this.maxScaleY = this.pMaster.scaleY;
         rotation = Math.round(this.pMaster.rotation);
         this.Status = this.pMaster.status;
         this.onRail = this.pMaster.rail;
         this.maxRot = this.pMaster.moveRot;
         decay = this.pMaster.dec;
         this.Fall = this.pMaster.fall;
         this.Tip = this.pMaster.tip;
         this.step = this.moveRL = this.moveUD = 0;
         if(this.pMaster.wait)
         {
            this.Wait = true;
            this.MoveEnterFrame = this.WaitEnterFrame;
            this.moveRot = 0;
         }
         else
         {
            this.Wait = false;
            this.MoveEnterFrame = this[this.Status + "EnterFrame"];
            this.moveRot = this.maxRot;
         }
         this.smoke.x = x;
         this.smoke.y = y;
         this.smoke.scaleX = scaleX;
         this.smoke.scaleY = scaleY;
      }
      
      private function GroundEnterFrame(f:Number, tick:Boolean) : void
      {
         var angle:Number = NaN;
         var e:Object = null;
         var tempRL:Number = NaN;
         var n:int = int(this.CharsOn.length);
         for(i = 0; i < n; ++i)
         {
            e = this.CharsOn[i];
            e.distRL = e.x - x;
            e.distUD = e.y - y;
            angle = rotation * (Math.PI / 180);
            e.ax = Math.cos(angle) * e.distRL + Math.sin(angle) * e.distUD;
            e.ay = Math.cos(angle) * e.distUD - Math.sin(angle) * e.distRL;
            e.ax /= scaleX;
            e.ay = (e.ay + e.isTall) / scaleY - e.isTall;
         }
         if(tick)
         {
            this.MoveEnterFrame();
         }
         x += this.moveRL * f;
         y += this.moveUD * f;
         rotation += this.moveRot * f;
         this.smoke.x = x;
         this.smoke.y = y;
         this.smoke.rotation = rotation * (Math.PI / 180);
         for(i = 0; i < n; ++i)
         {
            e = this.CharsOn[i];
            e.ax *= scaleX;
            e.ay = (e.ay + e.isTall) * scaleY - e.isTall;
            angle = rotation * (Math.PI / 180);
            ex = Math.cos(angle) * e.ax - Math.sin(angle) * e.ay;
            ey = Math.cos(angle) * e.ay + Math.sin(angle) * e.ax;
            if(this.Status != "Mushy")
            {
               tempRL = (x + ex - e.x) / f;
               if(e.Status == "Roll" && e.gotoBuffer == "nothing")
               {
                  e.moveRL += tempRL * 0.05 * f;
                  e.rotter -= tempRL * e.rotPerc;
               }
               else if(e.groundRL == 0 && Math.abs(tempRL) > 2)
               {
                  e.fakeRL -= tempRL;
                  e.moveRL -= tempRL;
               }
               e.groundRL = tempRL;
               e.groundUD = ((y + ey - e.y) / f + e.moveUD) * 0.5;
            }
            if(e.Status != "Roll")
            {
               e.x = x + ex;
               e.y = y + ey;
            }
            e.rotation += this.moveRot * f;
         }
      }
      
      private function WaitEnterFrame() : void
      {
      }
      
      private function RotateEnterFrame() : void
      {
         this.smoke.rotation = rotation;
      }
      
      private function RockEnterFrame() : void
      {
         this.moveRot += -rotation / 500;
      }
      
      private function FallEnterFrame() : void
      {
         if(this.step == 0)
         {
            this.moveUD *= 0.8;
            this.moveRot *= 0.85;
            if(this.moveUD < 0.5)
            {
               this.step = 1;
            }
         }
         else if(this.step == 1)
         {
            if(this.moveUD < 20)
            {
               this.moveUD *= 1.1;
            }
            this.moveRot = this.moveUD * 0.2;
            if(Main.checkPitY(y,this.onRail))
            {
               this.moveRL = this.moveUD = this.moveRot = 0;
               this.step = 2;
            }
         }
      }
      
      private function TipEnterFrame() : void
      {
         if(this.step == 0)
         {
            this.moveUD *= 0.8;
            this.moveRot *= 0.85;
            if(this.moveUD < 0.5)
            {
               this.step = 1;
            }
         }
         else if(this.step == 1)
         {
            if(this.moveUD < 20)
            {
               this.moveUD += 0.05;
            }
            this.moveRot += this.moveUD * 0.02;
            if(Main.checkPitY(y,this.onRail))
            {
               this.moveRL = this.moveUD = this.moveRot = 0;
               this.step = 2;
            }
         }
      }
      
      private function StretchEnterFrame() : void
      {
         if(this.springyX != 0)
         {
            this.springX += (this.stretchCenter * this.maxScaleX - scaleX) * this.springyX;
            scaleX += this.springX;
            this.smoke.scaleX = scaleX;
         }
         if(this.springyY != 0)
         {
            this.springY += (this.stretchCenter * this.maxScaleY - scaleY) * this.springyY;
            scaleY += this.springY;
            this.smoke.scaleY = scaleY;
         }
      }
      
      private function MushyEnterFrame() : void
      {
         var n:int = int(this.CharsOn.length);
         var mass:int = 10;
         var force:Number = mass * this.springY;
         for(i = 0; i < n; ++i)
         {
            force += this.CharsOn[i].isTall * (this.CharsOn[i].groundUD + 2);
            mass += this.CharsOn[i].isTall;
         }
         force -= (this.maxScaleY - scaleY) * 700;
         this.suppressJump = this.springY - force / mass > 2;
         this.springY = force / mass;
         scaleY -= this.springY * 0.01;
         this.springY *= 0.9;
         for(i = 0; i < n; ++i)
         {
            this.CharsOn[i].groundUD = this.springY;
            this.CharsOn[i].suppressJump = this.suppressJump;
         }
         scaleX = this.maxScaleX + (this.maxScaleY - scaleY) * 0.5;
         this.smoke.scaleY = scaleY;
         this.smoke.scaleX = scaleX;
      }
      
      private function pillar1EnterFrame() : void
      {
         if(this.step == 0)
         {
            Main.shakeScreen(5,0,true);
            this.moveRot = 0.02;
            ++this.step;
         }
         else
         {
            if(this.moveRot < 2 && this.moveRot > 0)
            {
               this.moveRot += 0.02;
            }
            if(rotation + this.moveRot < 25)
            {
               this.moveUD = this.moveRot + this.fakeUD;
               if(this.fakeUD > 0)
               {
                  --this.fakeUD;
               }
            }
            else if(rotation == 25)
            {
               if(this.moveUD < 20)
               {
                  this.moveUD += 0.15;
               }
            }
            else
            {
               this.moveRot = 0;
               this.moveUD = 0;
               rotation = 25;
               Main.shakeScreen(20,0,true);
            }
         }
      }
      
      private function pillar2EnterFrame() : void
      {
         if(rotation == 0 && this.moveRot == 0)
         {
            Main.shakeScreen(5,0,true);
            this.fakeUD = 6;
            this.Wait = false;
         }
         if(this.moveRot > -1)
         {
            this.moveRot -= 0.01;
         }
         if(y < this.wallY + 400)
         {
            this.moveUD = this.fakeUD - this.moveRot * 5;
            if(this.fakeUD > 0)
            {
               this.fakeUD -= 2;
            }
         }
         else if(y != this.wallY + 400)
         {
            this.moveRot = 0;
            this.fakeUD = this.moveUD = 0;
            y = this.wallY + 400;
         }
      }
      
      private function pillar3EnterFrame() : void
      {
         if(this.step == 0)
         {
            Main.Overlord.gotoAndStop("eraseBig");
            Main.Overlord.callBack = this;
            ++this.step;
         }
         else if(this.step == 2)
         {
            if(y + this.moveUD < this.wallY + 20)
            {
               if(this.moveUD < 10)
               {
                  this.moveUD += 2;
               }
            }
            else if(y != this.wallY + 20)
            {
               this.moveUD = 0;
               Main.shakeScreen(20,0,true);
               y = this.wallY + 20;
            }
         }
         else if(this.step == 3)
         {
            if(y + this.moveUD < this.wallY + 60)
            {
               if(this.moveUD < 10)
               {
                  this.moveUD += 2;
               }
            }
            else if(y != this.wallY + 60)
            {
               this.moveUD = 0;
               Main.shakeScreen(20,0,true);
               y = this.wallY + 60;
            }
         }
         else if(this.step == 4)
         {
            if(y + this.moveUD < this.wallY + 140)
            {
               if(this.moveUD < 10)
               {
                  this.moveUD += 2;
               }
               this.moveRot = this.moveUD / 10;
            }
            else if(y != this.wallY + 140)
            {
               this.moveRot = 0;
               this.moveUD = 0;
               Main.shakeScreen(20,0,true);
               y = this.wallY + 140;
            }
         }
         else if(this.step == 5)
         {
            if(this.moveUD < 10)
            {
               this.moveUD += 0.5;
            }
         }
      }
      
      private function pillar4EnterFrame() : void
      {
         if(this.moveUD > -20)
         {
            this.moveUD -= 0.25;
         }
      }
      
      private function pillar5EnterFrame() : void
      {
         if(this.step == 0)
         {
            Main.shakeScreen(10,0,true);
            this.Wait = false;
            this.moveRot = -0.01;
            ++this.step;
         }
         else
         {
            if(this.moveRot > -1 && this.moveRot < 0)
            {
               this.moveRot -= 0.01;
            }
            if(rotation + this.moveRot > -45)
            {
               this.moveRL = this.moveRot * 8;
               if(this.moveUD > 0)
               {
                  this.moveUD -= 2;
               }
               Main.MinY -= 5;
               this.smoke.x = x;
            }
            else if(rotation == -45)
            {
               if(this.moveUD < 10)
               {
                  this.moveUD += 0.2;
               }
            }
            else
            {
               this.moveRot = 0;
               this.moveRL = 0;
               this.moveUD = 0;
               rotation = -45;
               Main.shakeScreen(20,0,true);
            }
         }
      }
      
      private function pillar6EnterFrame() : void
      {
         if(this.step == 0)
         {
            Main.shakeScreen(10,0,true);
            this.Wait = false;
            this.moveRot = 0.01;
            ++this.step;
         }
         else if(this.moveRot < 1)
         {
            this.moveRot += 0.01;
         }
      }
      
      private function pillar7EnterFrame() : void
      {
         if(this.step == 0)
         {
            Main.shakeScreen(10,0,true);
            this.Wait = false;
            this.moveUD = this.moveRot = -0.01;
            ++this.step;
         }
         else
         {
            if(this.moveRot > -0.5)
            {
               this.moveRot -= 0.01;
            }
            this.moveUD = this.moveRot;
         }
      }
   }
}

