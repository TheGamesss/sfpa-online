package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol3735")]
   public class justAttack extends staticInteractObjects
   {
      
      public var downTime:uint = 0;
      
      public var health:uint = 1;
      
      public var myObject:Object = [];
      
      private var canHit:Boolean = true;
      
      public var inky:Boolean = true;
      
      public function justAttack(p:*)
      {
         super("inkPipe",p.x,p.y,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         Backgrounds.backgroundsArray[onRail].addChild(this);
         rotation = p.rotation;
         InteractEnterFrameArray.push(this);
         ID = p.warpDoor;
         scaleY = p.scaleX;
         visible = false;
         canAttackArray.push(this);
         stop();
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(this.downTime > 0)
         {
            --this.downTime;
         }
      }
      
      public function currentGetAttacked(ex:Number, ey:Number, angle:Number, char:collision, hitMove:String, hitPower:Number, pow:Number = 1) : Boolean
      {
         if(Boolean(this.canHit) && this.downTime == 0)
         {
            if(hitPower < 20)
            {
               this.downTime = 5;
            }
            else
            {
               this.downTime = 10;
            }
            char.hitPause = hitPower * 0.1 + 1;
            this.downTime += hitPower * 0.1 + 1;
            char.fakeRL = -2 * char.scaleX;
            char.moveRL = -2 * char.scaleX;
            if(this.myObject.fromJustAttack(hitPower,ID))
            {
               this.canHit = false;
            }
            return true;
         }
         return false;
      }
      
      public function setCanHit(e:Boolean) : void
      {
         this.canHit = e;
      }
      
      public function onKilled() : void
      {
      }
      
      public function smashKnockback(e:Number) : Number
      {
         return e;
      }
   }
}

