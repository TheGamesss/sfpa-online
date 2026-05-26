package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol4043")]
   public class inkDripper extends staticInteractObjects
   {
      
      private var groundY:int;
      
      private var myDrop:inkDropStarling;
      
      private var mySmoke:StarlingSmoke;
      
      public function inkDripper(p:*)
      {
         isWide = 2;
         isTall = 100;
         onRail = p.onRail;
         super("inkDripper",p.x,p.y,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         visible = false;
         InteractEnterFrameArray.push(this);
         this.groundY = y;
         for(var i:uint = 0; i < 80; i++)
         {
            if(collision.hitTestAllRaw(x,this.groundY + 24,onRail))
            {
               while(!collision.hitTestAllRaw(x,this.groundY + 15,onRail))
               {
                  ++this.groundY;
               }
               break;
            }
            this.groundY += 10;
         }
         gotoAndStop(Math.floor(Math.random() * 100) + 1);
         this.mySmoke = StarlingSmoke.Spawn("inkDripper",x,y,0,scaleY,0,0,onRail);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(currentFrame < 44 && ey - y < char.isTall + height && char.alpha == 1 && visible)
         {
            char.wallRot = 0;
            char.hurtChar(10,20,5,char.makeOne(ex - x) * 8,20);
            char.downTime = 60;
         }
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         nextFrame();
         isTall = height * 0.5;
         if(currentFrame == 20)
         {
            if(Math.abs(x - Main.cameraX) < 2000)
            {
               Sounds.playSound("InkJump",x,1,onRail);
            }
         }
         if(currentFrameLabel == "a")
         {
            this.dripInk();
         }
         else if(currentFrame == totalFrames)
         {
            gotoAndStop(1);
         }
         this.mySmoke.currentFrame = currentFrame;
      }
      
      private function dripInk() : void
      {
         this.myDrop = StarlingInteract.Spawn("inkDrop",x,y,0,1,0,0,onRail);
         this.myDrop.currentFrame = 1;
         this.myDrop.groundY = this.groundY;
         this.myDrop.spawner = this;
         this.myDrop.y = y + 121;
         this.myDrop.moveUD = 0;
      }
      
      public function inkLand() : void
      {
         if(Math.abs(x - Main.cameraX) < 2000)
         {
            Sounds.playSound("InkLand",x,1,onRail);
         }
      }
   }
}

