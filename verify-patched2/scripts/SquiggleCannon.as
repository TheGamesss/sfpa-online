package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol2555")]
   public class SquiggleCannon extends staticInteractObjects
   {
      
      private var eRL:Number;
      
      private var eUD:Number;
      
      private var max:uint = 0;
      
      private var speed:uint = 0;
      
      private var b:uint = 0;
      
      private var interval:uint = 0;
      
      public function SquiggleCannon(p:*)
      {
         super("SquiggleCannon",p.x,p.y,1,1,p.onRail,"nothing",-1);
         if(p.max != undefined)
         {
            this.max = p.max;
         }
         if(p.max != undefined)
         {
            this.speed = p.speed;
         }
         rotation = p.rotation;
         this.interval = p.interval;
         Backgrounds.backgroundsArray[onRail].addChild(this);
         angle = rotation * (Math.PI / 180);
         this.eRL = Math.sin(angle) * this.speed;
         this.eUD = -Math.cos(angle) * this.speed;
         InteractEnterFrameArray.push(this);
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(this.b > 0)
         {
            --this.b;
         }
         else
         {
            this.b = this.interval;
            if(StarlingInteract.arrayLength < this.max)
            {
               StarlingInteract.Spawn("looseSquiggle",x,y,0,1,this.eRL + Math.random() * 2,this.eUD + Math.random() * 2,onRail);
            }
         }
      }
   }
}

