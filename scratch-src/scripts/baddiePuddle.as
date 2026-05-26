package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol5128")]
   public class baddiePuddle extends staticInteractObjects
   {
      
      private var releasing:Boolean;
      
      private var baddieArray:Array;
      
      private var baddiesOut:uint;
      
      private var baddiesAtOnce:uint;
      
      private var baddieCount:uint;
      
      private var baddieCountRoot:uint;
      
      private var b:uint = 0;
      
      private var stamp:StarlingSmoke;
      
      public function baddiePuddle(p:*)
      {
         super("baddiePuddle",p.x,p.y,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         scaleX = scaleY = 1;
         rotation = p.rotation;
         if(p.pairGate != undefined)
         {
            pairGate = p.pairGate;
         }
         this.baddieArray = p.badArray;
         this.baddieCountRoot = this.baddieCount = this.baddieArray.length;
         if(p.baddieN < 0)
         {
            this.baddiesAtOnce = this.baddieCount;
         }
         else
         {
            this.baddiesAtOnce = p.baddieN;
         }
         visible = false;
         this.stamp = StarlingSmoke.Spawn("baddiePuddleStamp",x,y,rotation * (Math.PI / 180),scaleX,0,0,onRail);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(!this.releasing)
         {
            this.releasing = true;
            InteractEnterFrameArray.push(this);
         }
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         var eRL:Number = NaN;
         if(this.baddiesOut < this.baddiesAtOnce && this.baddieCount > 0)
         {
            if(this.b > 0)
            {
               --this.b;
            }
            else
            {
               this.b = 2;
               eRL = 10 * Math.random() - 5 + 10 * Math.sin(rotation * (Math.PI / 180));
               StarlingEffect.Spawn("Splat",x,y,Math.random() * 3.14,0.5,eRL,-5,onRail);
               if(this.baddieArray[this.baddieCountRoot - this.baddieCount] == 1)
               {
                  new Baddie1({
                     "ItIs":"Baddie1",
                     "x":x,
                     "y":y - 30,
                     "rotation":0,
                     "scaleX":1,
                     "scaleY":0.5 + Math.random() * 0.3,
                     "onRail":onRail,
                     "hatN":0,
                     "moveRL":eRL,
                     "moveUD":-(15 + Math.random() * 10),
                     "autopilot":true,
                     "lifetimeN":-1,
                     "spawner":this,
                     "tether":100 + Math.random() * 200,
                     "downTime":10
                  });
               }
               else
               {
                  new InkFly({
                     "ItIs":"InkFly",
                     "x":x,
                     "y":y - 30,
                     "rotation":0,
                     "scaleX":1,
                     "scaleY":0.6 + Math.random() * 0.6,
                     "onRail":onRail,
                     "hatN":0,
                     "moveRL":eRL,
                     "moveUD":-(15 + Math.random() * 10),
                     "autopilot":true,
                     "lifetimeN":-1,
                     "spawner":this,
                     "tether":100 + Math.random() * 200,
                     "downTime":10
                  });
               }
               ++this.baddiesOut;
               --this.baddieCount;
               this.stamp.scaleX = this.stamp.scaleY = this.baddieCount / this.baddieCountRoot;
            }
         }
      }
      
      public function onKilled() : void
      {
         --this.baddiesOut;
         if(pairGate > -1)
         {
            if(baddieGate == null)
            {
               trace("null gate " + pairGate);
            }
            if(this.baddieCount + this.baddiesOut == 0 && baddieGate != null)
            {
               baddieGate.inkGateBreak();
            }
         }
      }
      
      override public function cleanUp() : void
      {
         if(this.stamp != null)
         {
            this.stamp.goSwim();
            this.stamp = null;
         }
      }
   }
}

