package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol3681")]
   public class PortalTear extends staticInteractObjects
   {
      
      public var Status:String;
      
      public var stringVar:String;
      
      public var numVar:String;
      
      public var spring:Number = 0;
      
      private var springTall:int;
      
      private var springy:int = 3;
      
      private var disabled:Boolean;
      
      public var tumble:Boolean;
      
      public var waitN:int = -1;
      
      private var hide:Boolean;
      
      public var stayStraight:Boolean;
      
      public var jumper:uint = 24;
      
      private var tearSmoke:StarlingSmoke;
      
      public function PortalTear(p:*)
      {
         var i:String = null;
         for(i in p)
         {
            if(i != "componentInspectorSetting")
            {
               this[i] = p[i];
            }
         }
         isWide = 200;
         isTall = 200;
         super("PortalTear",p.x,p.y,p.scaleX,p.scaleY,onRail,this.stringVar,this.numVar);
         rotation = p.rotation;
         angle = rotation * (Math.PI / 180);
         isTall = 10;
         isWide = 40 * p.scaleX;
         this.springTall = isTall * 2;
         if(this.Status == "door")
         {
            DoorArray[ID] = this;
            if(this.stringVar == "nothing")
            {
               this.disabled = true;
            }
         }
         if(!this.hide)
         {
            this.tearSmoke = StarlingSmoke.Spawn("tearStamp",x,y,rotation * (Math.PI / 180),scaleX * 0.6666,0,0,onRail);
            visible = false;
         }
         visible = false;
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         var i:int = 0;
         if(this.disabled)
         {
            return false;
         }
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
               ax = 0;
               if(aUD > -5 && ay + char.isTall > -isTall * 2 && ay + char.isTall - aUD < -isTall + 20)
               {
                  char.ax = ax;
                  char.ay = ay;
                  char.aRL = aRL;
                  char.aUD = aUD;
                  char.angle = angle;
                  this.setChar(char);
                  if(this.Status == "door" || this.Status == "trigger")
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
                        if(InteractArray[i].ItIs == "PortalTear")
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
      
      public function setChar(char:Char) : void
      {
         ax = -Math.sin(angle) * 9 * scaleX;
         ay = Math.cos(angle) * 9 * scaleX;
         char.setMask(x + ax,y + ay,rotation,scaleX * 0.6,scaleX);
      }
      
      public function clearChar() : void
      {
      }
      
      override public function cleanUp() : void
      {
         if(!this.hide)
         {
            this.tearSmoke.goSwim();
            this.tearSmoke = null;
         }
      }
   }
}

