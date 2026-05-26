package
{
   public class fadeInHelpStarling extends StarlingInteract
   {
      
      internal var spring:Number = 0;
      
      internal var hitting:Boolean;
      
      public function fadeInHelpStarling(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, id:int)
      {
         super(e,ex,ey,rot,scale,0,0,rail);
         skipMesh = true;
      }
      
      override public function interactsEnterFrame() : Boolean
      {
         if(this.hitting)
         {
            this.spring = (1 - alpha) * 0.1;
         }
         else
         {
            this.spring = -0.2;
         }
         return this.halfEnterFrame();
      }
      
      override public function halfEnterFrame() : Boolean
      {
         alpha += this.spring * framin;
         this.hitting = false;
         return false;
      }
      
      override public function reset() : void
      {
         halfArray.push(this);
         isWide = 200;
         isTall = 200;
         alpha = 0;
         currentFrame = ["English","Spanish","French","Italian","Portuguese","German","Russian"].indexOf(Main.localSettings.language) + 1;
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(Char.hasPen)
         {
            this.hitting = true;
         }
      }
   }
}

