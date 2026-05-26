package
{
   public class inkPipeStarling extends StarlingInteract
   {
      
      private var baddieInterval:uint;
      
      private var b:uint = 0;
      
      private var shootX:int;
      
      private var shootY:int;
      
      private var shootRL:Number;
      
      private var shootUD:Number;
      
      private var lifetime:int;
      
      private var spring:Number;
      
      private var anchorX:int;
      
      private var anchorY:int;
      
      public function inkPipeStarling(e:*, ex:*, ey:*, rot:*, scale:*, eRL:*, eUD:*, rail:*, id:int = -1)
      {
         super(e,ex,ey,rot,scale,eRL,eUD,rail,id);
      }
      
      override public function interactsEnterFrame() : Boolean
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
            StarlingInteract.Spawn("inkShotBad",this.shootX,this.shootY,rotation,1.8 * scaleY,this.shootRL,this.shootUD,onRail,this.lifetime);
            StarlingEffect.Spawn("Splat",x,y,Math.random() * 6.28,scaleY * 0.3,this.shootRL * 0.5,this.shootUD * 0.5,onRail);
            this.spring = 0.25;
         }
         this.spring += (1 - scaleY) * 0.2;
         this.spring *= 0.8;
         scaleY += this.spring;
         scaleX = 1 + 1 - scaleY;
         x = this.anchorX + this.shootRL * scaleY;
         y = this.anchorY + this.shootUD * scaleY;
         return false;
      }
      
      override public function reset() : void
      {
         this.lifetime = Math.floor(ID * 0.001);
         this.baddieInterval = ID - this.lifetime * 1000;
         this.spring = 0;
         this.shootX = x + -Math.sin(rotation) * 10;
         this.shootY = y + Math.cos(rotation) * 10;
         this.shootRL = -Math.sin(rotation) * 20;
         this.shootUD = Math.cos(rotation) * 20;
         this.anchorX = x - this.shootRL;
         this.anchorY = y - this.shootUD;
      }
   }
}

