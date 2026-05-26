package
{
   import flash.display.Sprite;
   import starling.display.MovieClip;
   
   public class levelDecals extends Sprite
   {
      
      public static var InteractArray:Array = [];
      
      public static var staticOnDeckArray:Array = [];
      
      public static var onDeckN:int = -1;
      
      public static var onDeckN2:int = -1;
      
      public var hitChar:Function;
      
      public var cleanUp:Function;
      
      public var hitBaddie:Function;
      
      public var decalEnterFrame:Function;
      
      public var isTall:int = 0;
      
      public var isWide:int = 0;
      
      public var distRL:Number = 0;
      
      public var distUD:Number = 0;
      
      public var tempRot:Number = 0;
      
      public var angle:Number;
      
      public var ex:Number = 0;
      
      public var ey:Number = 0;
      
      public var ax:Number = 0;
      
      public var ay:Number = 0;
      
      public var tempRL:Number = 0;
      
      public var tempUD:Number = 0;
      
      private var obj:Sprite;
      
      public var ItIs:String;
      
      public var myStarlingClip:MovieClip;
      
      public var hasStarling:Boolean;
      
      public function levelDecals(itis:*, ex:*, ey:*, rot:*, xsc:*, ysc:*, rail:*, estring:*, enum:*)
      {
         this.cleanUp = function():*
         {
         };
         super();
         this.ItIs = itis;
         x = ex;
         y = ey;
         rotation = rot;
         scaleX = xsc;
         scaleY = ysc;
         onRail = rail;
         this.myStarlingClip = StarlingBackgrounds.addEffect(itis,x,y,rotation,1,0,0,true,false);
         staticOnDeckArray.push({
            "ex":x,
            "ey":y,
            "rot":rotation,
            "ItIs":this.ItIs,
            "clip":this
         });
         this.myStarlingClip.stop();
         this.myStarlingClip.visible = false;
         this.hitChar = function(ex:*, ey:*, eRL:*, eUD:*, baddie:*):*
         {
            return null;
         };
         this.hitBaddie = function(ex:*, ey:*, eRL:*, eUD:*, baddie:*):*
         {
            return null;
         };
         if(!Main.isScaleForm)
         {
            visible = false;
            this.hasStarling = true;
         }
         this.decalEnterFrame = function():*
         {
         };
      }
      
      internal static function staticOnDeckOverlord() : *
      {
         var interact:Object = null;
         if(staticOnDeckArray.length > 0)
         {
            if(onDeckN < staticOnDeckArray.length - 1)
            {
               while(staticOnDeckArray[onDeckN + 1].ex - Main.cameraX < Main.stageX + 50)
               {
                  ++onDeckN;
                  InteractArray.push(staticOnDeckArray[onDeckN].clip);
                  staticOnDeckArray[onDeckN].clip.myStarlingClip.visible = true;
                  if(onDeckN == staticOnDeckArray.length - 1)
                  {
                     break;
                  }
               }
            }
            if(onDeckN > 0)
            {
               while(staticOnDeckArray[onDeckN].ex - Main.cameraX > Main.stageX + 50 && onDeckN > 0)
               {
                  --onDeckN;
                  interact = InteractArray.pop();
                  interact.myStarlingClip.visible = false;
               }
            }
            if(onDeckN2 < staticOnDeckArray.length - 1)
            {
               while(staticOnDeckArray[onDeckN2 + 1].ex < Main.cameraX - (Main.stageX + 50))
               {
                  interact = InteractArray.shift();
                  ++onDeckN2;
                  interact.myStarlingClip.visible = false;
                  if(onDeckN2 == staticOnDeckArray.length - 1)
                  {
                     break;
                  }
               }
            }
            if(onDeckN2 > -1)
            {
               while(staticOnDeckArray[onDeckN2].ex > Main.cameraX - (Main.stageX + 50))
               {
                  InteractArray.push(staticOnDeckArray[onDeckN2].clip);
                  InteractArray.unshift(InteractArray.pop());
                  staticOnDeckArray[onDeckN2].clip.myStarlingClip.visible = true;
                  --onDeckN2;
                  if(onDeckN2 < 0)
                  {
                     break;
                  }
               }
            }
         }
      }
      
      public static function InteractEnterFrames() : *
      {
         for(var n:int = 0; n < InteractArray.length; n++)
         {
            InteractArray[n].decalEnterFrame();
         }
      }
      
      public static function charCheckObjects(ex:*, ey:*, eWide:*, eTall:*, char:*) : *
      {
         for(var n:int = 0; n < InteractArray.length; n++)
         {
            if(Math.abs(ex - InteractArray[n].x) < eWide + InteractArray[n].isWide && Math.abs(ey - InteractArray[n].y) < eTall + InteractArray[n].isTall)
            {
               InteractArray[n].hitChar(ex,ey,char.fakeRL,char.moveUD,char);
            }
         }
      }
      
      public static function baddieCheckObjects(ex:*, ey:*, eWide:*, eTall:*, char:*) : *
      {
         for(var n:int = 0; n < InteractArray.length; n++)
         {
            if(Math.abs(ex - InteractArray[n].x) < eWide + InteractArray[n].isWide && Math.abs(ey - InteractArray[n].y) < eTall + InteractArray[n].isTall)
            {
               InteractArray[n].hitBaddie(ex,ey,char.fakeRL,char.moveUD,char);
            }
         }
      }
      
      public static function clearAllInteracts() : *
      {
         staticOnDeckArray = [];
         onDeckN = onDeckN2 = -1;
         var n:int = int(InteractArray.length);
         for(var i:int = 0; i < n; i++)
         {
            InteractArray[0].cleanUp();
            if(InteractArray[0].parent != null)
            {
               InteractArray[0].parent.removeChild(InteractArray[0]);
            }
            InteractArray.shift();
         }
      }
      
      public function inRange() : *
      {
         return Math.abs(x - Main.cameraX) < Main.stageX + 50 && Math.abs(y - Main.cameraY) < Main.stageY / 2 + 50;
      }
   }
}

