package
{
   import flash.display.MovieClip;
   import flash.utils.*;
   
   public class justALoop extends MovieClip
   {
      
      public var catBody:MovieClip;
      
      public var catTail:MovieClip;
      
      public var head:MovieClip;
      
      public var item:MovieClip;
      
      internal var ItIs:String;
      
      internal var which:String;
      
      internal var loopRand:uint = 0;
      
      internal var rand:uint = 0;
      
      internal var nested:Array = [];
      
      public function justALoop()
      {
         super();
         staticInteractObjects.InteractEnterFrameArray.push(this);
         gotoAndStop(Math.floor(Math.random() * totalFrames) + 1);
         for(var i:uint = 0; i < this.numChildren; i++)
         {
            if(getQualifiedClassName(this.getChildAt(i)) == "flash.display::MovieClip")
            {
               this.nested.push(this.getChildAt(i).name);
            }
         }
      }
      
      public static function findByWhich(e:*) : justALoop
      {
         var i:uint = 0;
         var l:uint = staticInteractObjects.InteractEnterFrameArray.length;
         while(i < l)
         {
            if(staticInteractObjects.InteractEnterFrameArray[i].ItIs == e)
            {
               return staticInteractObjects.InteractEnterFrameArray[i];
            }
            i++;
         }
      }
      
      public function InteractEnterFrame() : *
      {
         if(this.rand > 0)
         {
            --this.rand;
         }
         else if(currentFrame == totalFrames)
         {
            gotoAndStop(1);
            this.rand = Math.random() * this.loopRand;
         }
         else
         {
            nextFrame();
         }
         for(var i:uint = 0; i < this.nested.length; i++)
         {
            if(this[this.nested[i]].currentFrame == this[this.nested[i]].totalFrames)
            {
               this[this.nested[i]].gotoAndStop(1);
            }
            else
            {
               this[this.nested[i]].nextFrame();
            }
         }
      }
   }
}

