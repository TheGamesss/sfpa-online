package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4055")]
   public class iceCreamCart extends staticInteractObjects
   {
      
      public var thumbL:MovieClip;
      
      public var thumbR:MovieClip;
      
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
      
      public var superID:int;
      
      private var thumbFrame:uint = 1;
      
      private var message:Boolean = false;
      
      public var stayStraight:Boolean;
      
      public function iceCreamCart(p:*)
      {
         isWide = 200;
         isTall = 200;
         super("PortalBox",p.x,p.y,p.scaleX,1,0);
         rotation = p.rotation;
         angle = rotation * (Math.PI / 180);
         if(p.hide != undefined)
         {
            this.hide = p.hide;
         }
         if(!this.hide)
         {
            Backgrounds.backgroundsArray[0].addChild(this);
         }
         isTall = 10;
         isWide = 40;
         this.springTall = isTall * 2;
         this.Status = "vase";
         this.superID = 0;
         this.message = p.message;
         InteractEnterFrameArray.push(this);
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(Math.random() < 0.1)
         {
            if(this.thumbFrame == 1)
            {
               this.thumbFrame = 2;
            }
            else
            {
               this.thumbFrame = 1;
            }
            this.thumbL.gotoAndStop(this.thumbFrame);
         }
         if(Math.random() < 0.1)
         {
            if(this.thumbFrame == 1)
            {
               this.thumbFrame = 2;
            }
            else
            {
               this.thumbFrame = 1;
            }
            this.thumbR.gotoAndStop(this.thumbFrame);
         }
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
               if(aUD > -5 && ay + char.isTall > -isTall * 2 && ay + char.isTall - aUD < -isTall + 20)
               {
                  char.ax = ax;
                  char.ay = ay;
                  char.aRL = aRL;
                  char.aUD = aUD;
                  char.angle = angle;
                  this.setChar(char);
                  if(InteractEnterFrameArray.indexOf(this) == -1)
                  {
                     InteractEnterFrameArray.push(this);
                  }
                  if(this.Status == "door" || this.Status == "trigger")
                  {
                     char.enterBox(this,this);
                  }
                  else if(this.Status == "vase")
                  {
                     if(this.message)
                     {
                        staticInteractObjects.findByUnique(0).changeProperties("nothing",0,30,-1,"nothing");
                     }
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
         char.setMask(x,y - 15,rotation,scaleX,scaleY);
      }
      
      public function clearChar() : void
      {
      }
   }
}

