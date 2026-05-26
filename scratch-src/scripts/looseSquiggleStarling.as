package
{
   public class looseSquiggleStarling extends StarlingInteract
   {
      
      public var myCollision:collision;
      
      public function looseSquiggleStarling(e:*, ex:*, ey:*, rot:*, scale:*, eRL:*, eUD:*, rail:*, id:int = -1)
      {
         super(e,ex,ey,rot,scale,eRL,eUD,rail,id);
         this.myCollision = new collision(rail);
         onRail = rail;
         this.myCollision.ItIs = e;
         this.myCollision.myVisible = this;
         this.myCollision.visible = false;
         this.myCollision.BallRes = 4;
         this.myCollision.isTall = this.myCollision.isWide = 10;
         this.myCollision.bounce = 0.8;
         this.myCollision.bounceThresh = 2;
         this.myCollision.rotPerc = 1 / this.myCollision.isTall;
         this.myCollision.overReach = 10;
         this.myCollision.mass = 5;
         ID = id;
      }
      
      override public function reset() : void
      {
         downTime = 5;
         this.myCollision.resetOnPlatSides();
         this.myCollision.x = x;
         this.myCollision.y = y;
         this.myCollision.rotation = rotation;
         this.myCollision.moveRL = moveRL;
         this.myCollision.moveUD = moveUD;
         this.myCollision.onRail = onRail;
         collision.InteractObjectsArray.push(this.myCollision);
         this.myCollision.setGroundRail();
      }
      
      override public function interactsEnterFrame() : Boolean
      {
         if(moveUD < 30)
         {
            moveUD += 1.5;
         }
         this.myCollision.moveUD = moveUD;
         if(downTime > 0)
         {
            --downTime;
         }
         return this.myCollision.fallOffscreen();
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(downTime == 0)
         {
            ++char.squiggleBuffer;
            char.squiggleBuffer > 0 && StarlingEffect.Spawn("SquigPop",x,y,Math.random() * 3.14,1,moveRL,moveUD,onRail);
            return true;
         }
         return false;
      }
      
      override public function cleanUp() : void
      {
         this.myCollision.interactRemoveFromArray(this.myCollision);
      }
   }
}

