package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol886")]
   public class tutorialIcon extends staticInteractObjects
   {
      
      private var disabled:Boolean;
      
      private var b:uint;
      
      private var frame:int;
      
      private var stamp:StarlingSmoke;
      
      public function tutorialIcon(p:*)
      {
         isWide = 20;
         isTall = 20;
         onRail = p.onRail;
         this.frame = p.frame;
         super("tutorialIcon",p.x,p.y,p.scaleX,p.scaleY,p.onRail);
         visible = false;
         if(p.hide)
         {
            this.disabled = true;
            isWide = 0;
         }
         else
         {
            this.stamp = StarlingSmoke.Spawn("tutorialIconStamp",x,y,0,scaleX,0,0,onRail);
         }
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(!this.disabled)
         {
            this.disabled = true;
            Main.TutorialGame(true,this.frame);
            InteractEnterFrameArray.push(this);
         }
         if(isWide > 0)
         {
            this.stamp.alpha = 0.5;
         }
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         this.stamp.alpha += 0.02;
         if(this.stamp.alpha > 0.9)
         {
            this.stamp.alpha = 1;
            InteractEnterFrameArray.splice(InteractEnterFrameArray.indexOf(this),1);
            this.disabled = false;
         }
      }
      
      public function enable(e:Boolean) : void
      {
         if(this.disabled)
         {
            this.stamp = StarlingSmoke.Spawn("tutorialIconStamp",x,y,0,scaleX,0,0,onRail);
         }
         this.disabled = !e;
         isWide = 20;
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

