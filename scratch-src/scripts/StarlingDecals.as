package
{
   import starling.display.MovieClip;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class StarlingDecals extends MovieClip
   {
      
      public static var framin:Number;
      
      public static var interactsAtlas:TextureAtlas;
      
      private static var doodleGrasTextures:Vector.<Texture>;
      
      public static var InteractArray:Array = [];
      
      public static var staticOnDeckArray:Array = [];
      
      public static var onDeckN:int = -1;
      
      public static var onDeckN2:int = -1;
      
      private static var decalNames:Vector.<String> = new <String>["doodleGrass","spikeDecal","spikeBarDecal","inkBubbleDecal"];
      
      public function cleanUp():*
      {
      }
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
      
      public var ItIs:String;
      
      public var realCurrent:Number = 1;
      
      public function StarlingDecals(itis:*, ex:*, ey:*, rot:*, xsc:*, ysc:*, rail:*, estring:*, enum:*)
      {
         if(rail == undefined || rail == -1)
         {
            rail = 0;
         }
         super(StarlingDecals[itis + "Textures"]);
         this.ItIs = itis;
         x = ex;
         y = ey;
         rotation = rot * (Math.PI / 180);
         scaleX = xsc;
         scaleY = ysc;
         onRail = rail;
         staticOnDeckArray.push({
            "ex":x,
            "ey":y,
            "rot":rotation,
            "ItIs":this.ItIs,
            "clip":this
         });
         StarlingBackgrounds.addObject(this,rail);
         visible = false;
      }
      
      public static function createAtlas(atlas:*) : void
      {
         for(var i:uint = 0; i < decalNames.length; )
         {
            StarlingDecals[decalNames[i] + "Textures"] = atlas.getTextures(decalNames[i]);
            i++;
         }
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
                  staticOnDeckArray[onDeckN].clip.visible = true;
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
                  interact.visible = false;
               }
            }
            if(onDeckN2 < staticOnDeckArray.length - 1)
            {
               while(staticOnDeckArray[onDeckN2 + 1].ex - Main.cameraX < -(Main.stageX + 50))
               {
                  ++onDeckN2;
                  interact = InteractArray.shift();
                  interact.visible = false;
                  if(onDeckN2 == staticOnDeckArray.length - 1)
                  {
                     break;
                  }
               }
            }
            if(onDeckN2 > -1)
            {
               while(staticOnDeckArray[onDeckN2].ex - Main.cameraX > -(Main.stageX + 50))
               {
                  InteractArray.push(staticOnDeckArray[onDeckN2].clip);
                  InteractArray.unshift(InteractArray.pop());
                  staticOnDeckArray[onDeckN2].clip.visible = true;
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
      
      public static function charCheckObjects(ex:Number, ey:Number, eWide:uint, eTall:uint, rail:int, char:Char) : *
      {
         for(var n:int = 0; n < InteractArray.length; n++)
         {
            if(rail == 0 && Math.abs(ex - InteractArray[n].x) < eWide + InteractArray[n].isWide && Math.abs(ey - InteractArray[n].y) < eTall + InteractArray[n].isTall)
            {
               InteractArray[n].hitChar(ex,ey,char.fakeRL,char.moveUD,char);
            }
         }
      }
      
      public static function baddieCheckObjects(ex:Number, ey:Number, eWide:uint, eTall:uint, rail:int, char:Baddies) : *
      {
         for(var n:int = 0; n < InteractArray.length; n++)
         {
            if(rail == 0 && Math.abs(ex - InteractArray[n].x) < eWide + InteractArray[n].isWide && Math.abs(ey - InteractArray[n].y) < eTall + InteractArray[n].isTall)
            {
               InteractArray[n].hitBaddie(ex,ey,char.fakeRL,char.moveUD,char);
            }
         }
      }
      
      public static function shiftAllDecals(ey:Number) : void
      {
         for(var i:* = int(staticOnDeckArray.length - 1); i >= 0; i--)
         {
            staticOnDeckArray[i].ey = ey;
            staticOnDeckArray[i].clip.y = ey;
         }
      }
      
      public static function clearAllInteracts() : *
      {
         onDeckN = onDeckN2 = -1;
         var n:int = int(InteractArray.length);
         for(var i:uint = 0; i < n; i++)
         {
            InteractArray[i].removeFromParent();
            InteractArray[i].dispose();
         }
         n = int(staticOnDeckArray.length);
         for(i = 0; i < n; i++)
         {
            staticOnDeckArray[i].clip.removeFromParent();
            staticOnDeckArray[i].clip.dispose();
            staticOnDeckArray[i].clip = null;
         }
         InteractArray = [];
         staticOnDeckArray = [];
      }
      
      public static function elevate() : *
      {
         for(var i:* = int(staticOnDeckArray.length - 1); i >= 0; i--)
         {
            StarlingBackgrounds.addObject(staticOnDeckArray[i].clip,0);
         }
      }
      
      public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : void
      {
      }
      
      public function hitBaddie(ex:Number, ey:Number, eRL:Number, eUD:Number, baddie:Baddies) : void
      {
      }
      
      public function decalEnterFrame() : void
      {
      }
      
      public function inRange() : *
      {
         return Math.abs(x - Main.cameraX) < Main.stageX + 50 && Math.abs(y - Main.cameraY) < Main.stageY / 2 + 50;
      }
   }
}

