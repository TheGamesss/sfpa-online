package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol3944")]
   public class inkPipe extends staticInteractObjects
   {
      
      private var baddieInterval:uint;
      
      private var b:uint = 0;
      
      private var shootX:int;
      
      private var shootY:int;
      
      private var shootRL:Number;
      
      private var shootUD:Number;
      
      private var lifetime:int;
      
      public function inkPipe(p:*)
      {
         super("inkPipe",p.x,p.y,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         Backgrounds.backgroundsArray[onRail].addChild(this);
         rotation = p.rotation;
         this.baddieInterval = p.interval;
         this.lifetime = p.lifetime;
         InteractEnterFrameArray.push(this);
         angle = rotation * (Math.PI / 180);
         this.shootX = x + -Math.sin(angle) * 10;
         this.shootY = y + Math.cos(angle) * 10;
         this.shootRL = -Math.sin(angle) * 20;
         this.shootUD = Math.cos(angle) * 20;
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(this.b > 0)
         {
            --this.b;
         }
         else
         {
            this.b = this.baddieInterval;
            Sounds.playSound("ExitBox",x,0.5,onRail);
            Sounds.playSound("InkJump",x,1,onRail);
            StarlingInteract.Spawn("inkShotBad",this.shootX,this.shootY,angle,1.8 * scaleY,this.shootRL,this.shootUD,onRail,this.lifetime);
            StarlingEffect.Spawn("Splat",x,y,Math.random() * 6.28,scaleY * 0.3,this.shootRL * 0.5,this.shootUD * 0.5,onRail);
         }
      }
   }
}

