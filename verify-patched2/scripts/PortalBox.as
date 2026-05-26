package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3690")]
   public class PortalBox extends staticInteractObjects
   {
      
      public var box:MovieClip;
      
      public var Status:String;
      
      public var stringVar:String;
      
      public var numVar:String;
      
      public var spring:Number = 0;
      
      private var springTall:int;
      
      private var springy:int = 3;
      
      public var superID:int = -1;
      
      public var tumble:Boolean;
      
      public var waitN:int = -1;
      
      private var stamp:StarlingSmoke;
      
      private var myChar:Char;
      
      public var stayStraight:Boolean;
      
      public var jumper:uint = 24;
      
      public function PortalBox(p:*)
      {
         var i:String = null;
         for(i in p)
         {
            if(i != "componentInspectorSetting" && i != "status")
            {
               this[i] = p[i];
            }
         }
         super("PortalBox",p.x,p.y,1,1,onRail,this.stringVar,this.numVar);
         rotation = p.rotation;
         this.Status = p.status;
         isTall = 35;
         isWide = 40;
         this.box.stop();
         this.box.color.gotoAndStop(ID + 1);
         this.springTall = isTall * 2;
         visible = false;
         if(Math.abs(rotation) < 12)
         {
            this.stayStraight = true;
         }
         if(this.Status == "door")
         {
            DoorArray[ID] = this;
            if(this.stringVar == "nothing")
            {
               disabled = true;
            }
         }
         angle = rotation * (Math.PI / 180);
         this.stamp = StarlingSmoke.Spawn("PortalBoxStamp",x,y,angle,scaleX,0,0,onRail);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         var i:int = 0;
         ex -= x;
         ey -= y;
         ax = Math.cos(angle) * ex + Math.sin(angle) * ey;
         ay = Math.cos(angle) * ey - Math.sin(angle) * ex;
         aRL = Math.cos(angle) * eRL + Math.sin(angle) * eUD;
         aUD = Math.cos(angle) * eUD - Math.sin(angle) * eRL;
         if(Math.abs(ax) < isWide)
         {
            if(char.Status != "enterBox" && char.Status != "Hurt")
            {
               if(ay + char.isTall > -isTall && ay + char.isTall - aUD < -isTall)
               {
                  char.ax = ax;
                  char.ay = ay;
                  char.aRL = aRL;
                  char.aUD = aUD;
                  char.angle = angle;
                  this.spring = -20;
                  if(InteractEnterFrameArray.indexOf(this) == -1)
                  {
                     InteractEnterFrameArray.push(this);
                  }
                  this.setChar(char);
                  if(this.Status == "door")
                  {
                     char.enterBox(this,this);
                  }
                  else if(this.Status == "vase")
                  {
                     char.enterBox(this,this);
                  }
                  else
                  {
                     for(i = 0; i < InteractArray.length; i++)
                     {
                        if(InteractArray[i].ItIs == "PortalBox")
                        {
                           if(this != InteractArray[i] && ID == InteractArray[i].ID)
                           {
                              char.enterBox(this,InteractArray[i]);
                           }
                        }
                     }
                  }
               }
            }
         }
         else
         {
            char.parent.mask = null;
         }
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         this.spring += (isTall * 2 - this.springTall) / this.springy;
         this.spring *= 0.8;
         this.springTall += this.spring;
         this.stamp.scaleY = this.springTall / (isTall * 2);
         this.stamp.scaleX = 1 - this.stamp.scaleY + 1;
         ax = -Math.sin(angle) * (15 - 15 * this.stamp.scaleY);
         ay = Math.cos(angle) * (15 - 15 * this.stamp.scaleY);
         this.stamp.x = x + ax;
         this.stamp.y = y + ay;
         ax = -Math.sin(angle) * (15 - 30 * this.stamp.scaleY);
         ay = Math.cos(angle) * (15 - 30 * this.stamp.scaleY);
         if(this.myChar != null)
         {
            this.myChar.updateMask(x + ax,y + ay);
         }
         if(Math.abs(this.spring + (isTall * 2 - this.springTall) / this.springy) < 0.01)
         {
            this.spring = 0;
            this.springTall = isTall * 2;
            return true;
         }
      }
      
      public function setChar(char:Char) : void
      {
         this.myChar = char;
         ax = -Math.sin(angle) * (15 - 30 * this.stamp.scaleY);
         ay = Math.cos(angle) * (15 - 30 * this.stamp.scaleY);
         char.setMask(x + ax,y + ay,rotation,scaleX,scaleY);
      }
      
      public function clearChar() : void
      {
         this.myChar = null;
      }
      
      override public function cleanUp() : void
      {
         if(this.stamp != null)
         {
            this.stamp.goSwim();
            this.stamp = null;
         }
         if(this.myChar != null)
         {
            this.myChar = null;
         }
      }
   }
}

