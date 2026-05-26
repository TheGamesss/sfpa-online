package
{
   import flash.display.*;
   import flash.utils.*;
   
   public class Backgrounds extends Sprite
   {
      
      public static var backgroundsN:int;
      
      public static var backgroundsArray:Array = new Array();
      
      public static var AllBitmaps:Array = new Array();
      
      public var container:Object;
      
      public var backContainer:Object;
      
      public function Backgrounds(toFront:*)
      {
         super();
         this.container = new Sprite();
         addChild(this.container);
         this.backContainer = new Sprite();
         addChild(this.backContainer);
         if(toFront)
         {
            backgroundsArray.unshift(this);
         }
         else
         {
            backgroundsArray.push(this);
         }
      }
      
      public static function flushOne(i:*) : *
      {
         var b:int = int(backgroundsArray[i].numChildren);
         for(n = 0; n < b; ++n)
         {
            if(backgroundsArray[i].parent != null)
            {
               backgroundsArray[i].removeChildAt(0);
            }
         }
         backgroundsArray[i].parent.removeChild(backgroundsArray[i]);
      }
      
      public static function flushBackgrounds() : *
      {
         var b:int = 0;
         for(var i:int = 0; i < backgroundsN; i++)
         {
            b = int(backgroundsArray[i].numChildren);
            for(n = 0; n < b; ++n)
            {
               if(backgroundsArray[i].parent != null)
               {
                  backgroundsArray[i].removeChildAt(0);
               }
            }
            backgroundsArray[i].parent.removeChild(backgroundsArray[i]);
         }
         for(i = 0; i < AllBitmaps.length; i++)
         {
            AllBitmaps[i].dispose();
         }
         backgroundsArray = [];
         AllBitmaps = [];
      }
      
      public static function flushStranglers() : *
      {
         var b:* = 0;
         for(var i:int = 0; i < backgroundsN; i++)
         {
            b = int(backgroundsArray[i].numChildren);
            for(n = 0; n < b; ++n)
            {
               if(getQualifiedClassName(backgroundsArray[i].getChildAt(n)) != "flash.display::Sprite" && getQualifiedClassName(backgroundsArray[i].getChildAt(n)) != "flash.display::MovieClip")
               {
                  backgroundsArray[i].removeChildAt(n);
                  --n;
                  b--;
               }
            }
         }
      }
   }
}

