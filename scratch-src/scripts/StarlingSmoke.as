package
{
   import starling.display.*;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class StarlingSmoke extends MovieClip
   {
      
      public static var framin:Number;
      
      public static var backgroundsN:int;
      
      public static var localSquiggles:uint;
      
      public static var arrayLength:uint;
      
      public static var smokesAtlas:TextureAtlas;
      
      public static var meshBatch:MeshBatch;
      
      public static var Slash1Textures:Vector.<Texture>;
      
      public static var Slash2Textures:Vector.<Texture>;
      
      public static var Slash3Textures:Vector.<Texture>;
      
      public static var Slash4Textures:Vector.<Texture>;
      
      public static var SlashMedium1Textures:Vector.<Texture>;
      
      public static var SlashMedium2Textures:Vector.<Texture>;
      
      public static var SlashHeavy1Textures:Vector.<Texture>;
      
      public static var BuzzSawTextures:Vector.<Texture>;
      
      public static var SwipeUpTextures:Vector.<Texture>;
      
      public static var HeavyUpTextures:Vector.<Texture>;
      
      public static var HeavyDownTextures:Vector.<Texture>;
      
      public static var PokeDownTextures:Vector.<Texture>;
      
      public static var SlashRisingTextures:Vector.<Texture>;
      
      private static var Baddie1SmokeTextures:Vector.<Texture>;
      
      private static var InkFlySmokeTextures:Vector.<Texture>;
      
      private static var InkFloatSmokeTextures:Vector.<Texture>;
      
      private static var SpiderSmokeTextures:Vector.<Texture>;
      
      private static var MouseSmokeTextures:Vector.<Texture>;
      
      private static var NinjaSmokeTextures:Vector.<Texture>;
      
      private static var BatSmokeTextures:Vector.<Texture>;
      
      private static var SnailShellSmokeTextures:Vector.<Texture>;
      
      private static var InkBallSmokeTextures:Vector.<Texture>;
      
      private static var inkDripperTextures:Vector.<Texture>;
      
      private static var doorStampTextures:Vector.<Texture>;
      
      private static var surfaceStampTextures:Vector.<Texture>;
      
      private static var springStampTextures:Vector.<Texture>;
      
      private static var tearStampTextures:Vector.<Texture>;
      
      private static var aWallStampTextures:Vector.<Texture>;
      
      private static var tutorialIconStampTextures:Vector.<Texture>;
      
      private static var SpinnerStampTextures:Vector.<Texture>;
      
      private static var baddiePuddleStampTextures:Vector.<Texture>;
      
      private static var PortalBoxStampTextures:Vector.<Texture>;
      
      private static var inkSpoutStampTextures:Vector.<Texture>;
      
      private static var healthBarTextures:Vector.<Texture>;
      
      private static var doorPromptTextures:Vector.<Texture>;
      
      private static var blackBlockTextures:Vector.<Texture>;
      
      public static var dontCheat:Object = {};
      
      public static var smokesArray:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var smokeColor:uint = 16777215;
      
      private static var smokeNames:Vector.<String> = new <String>["aWallStamp","Baddie1Smoke","InkFlySmoke","InkBallSmoke","InkFloatSmoke","SpiderSmoke","MouseSmoke","NinjaSmoke","BatSmoke","SnailShellSmoke","inkDripper","doorStamp","surfaceStamp","springStamp","tearStamp","Slash1","Slash2","Slash3","Slash4","SlashMedium1","SlashMedium2","SlashHeavy1","BuzzSaw","SwipeUp","HeavyUp","HeavyDown","PokeDown","SlashRising","tutorialIconStamp","SpinnerStamp","baddiePuddleStamp","PortalBoxStamp","inkSpoutStamp","healthBar","doorPrompt","blackBlock"];
      
      public static var Slash1Pool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var Slash2Pool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var Slash3Pool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var Slash4Pool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var SlashMedium1Pool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var SlashMedium2Pool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var SlashHeavy1Pool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var BuzzSawPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var SwipeUpPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var HeavyUpPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var HeavyDownPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var PokeDownPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public static var SlashRisingPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var Baddie1SmokePool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var InkFlySmokePool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var InkFloatSmokePool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var SpiderSmokePool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var MouseSmokePool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var NinjaSmokePool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var BatSmokePool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var SnailShellSmokePool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var InkBallSmokePool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var inkDripperPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var doorStampPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var surfaceStampPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var springStampPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var tearStampPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var aWallStampPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var tutorialIconStampPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var SpinnerStampPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var baddiePuddleStampPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var PortalBoxStampPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var inkSpoutStampPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var healthBarPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var doorPromptPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      private static var blackBlockPool:Vector.<StarlingSmoke> = new Vector.<StarlingSmoke>(0);
      
      public var ItIs:String;
      
      public var isWide:uint = 15;
      
      public var isTall:uint = 15;
      
      public var moveRL:Number;
      
      public var moveUD:Number;
      
      public var onRail:int;
      
      public var ID:int;
      
      public var predictOffsetY:int = 0;
      
      public var downTime:uint = 0;
      
      public var health:int = 0;
      
      public var isVector:Boolean = false;
      
      public function StarlingSmoke(e:*, ex:*, ey:*, rot:*, scale:*, eRL:*, eUD:*, rail:*)
      {
         super(StarlingSmoke[e + "Textures"]);
         this.setVariables(e,ex,ey,rot,scale,eRL,eUD,rail);
      }
      
      public static function createAtlas(atlas:*) : void
      {
         for(var i:uint = 0; i < smokeNames.length; )
         {
            StarlingSmoke[smokeNames[i] + "Textures"] = atlas.getTextures(smokeNames[i]);
            i++;
         }
      }
      
      public static function Spawn(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, attachBack:Boolean = false) : StarlingSmoke
      {
         var smoke:StarlingSmoke = null;
         if(StarlingSmoke[e + "Pool"].length > 0)
         {
            smoke = StarlingSmoke[e + "Pool"].pop();
            smoke.setVariables(e,ex,ey,rot,scale,eRL,eUD,rail);
            smoke.currentFrame = 1;
         }
         else
         {
            smoke = new StarlingSmoke(e,ex,ey,rot,scale,eRL,eUD,rail);
            smoke.textureSmoothing = "bilinear";
         }
         smoke.reset();
         smoke.returnToMesh(rail,attachBack);
         smoke.color = smokeColor;
         return smoke;
      }
      
      public static function SpawnSlash(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, attachBack:Boolean = false) : StarlingSmoke
      {
         var smoke:StarlingSmoke = null;
         if(StarlingSmoke[e + "Pool"].length > 0)
         {
            smoke = StarlingSmoke[e + "Pool"].pop();
            smoke.setVariables(e,ex,ey,rot,scale,eRL,eUD,rail);
            smoke.currentFrame = 1;
         }
         else
         {
            smoke = new StarlingSmoke(e,ex,ey,rot,scale,eRL,eUD,rail);
            smoke.textureSmoothing = "bilinear";
         }
         smoke.reset();
         smoke.visible = true;
         StarlingBackgrounds.placeSlash(smoke);
         smoke.color = smokeColor;
         return smoke;
      }
      
      public static function setColor(e:uint) : void
      {
         smokeColor = e;
      }
      
      public static function checkByName(e:String, ex:int, ey:int, wide:uint, tall:uint, rail:int) : StarlingSmoke
      {
         for(var i:* = int(arrayLength - 1); i >= 0; i--)
         {
            if(smokesArray[i].ItIs == e && smokesArray[i].onRail == rail)
            {
               if(Math.abs(ex - smokesArray[i].x) < wide + smokesArray[i].isWide && Math.abs(ey - smokesArray[i].y) < tall + smokesArray[i].isTall)
               {
                  return smokesArray[i];
               }
            }
         }
      }
      
      public static function meshCache(background:*) : void
      {
         meshBatch = new MeshBatch();
         background.addChild(meshBatch);
      }
      
      public static function pressMeshes() : void
      {
         meshBatch.clear();
         for(var i:int = 0; i < arrayLength; i++)
         {
            meshBatch.addMesh(smokesArray[i]);
         }
      }
      
      public static function clearAllSmokes() : *
      {
         for(var i:* = int(arrayLength - 1); i >= 0; i--)
         {
            if(smokesArray[i].parent != null)
            {
               smokesArray[i].parent.removeChild(smokesArray[i]);
            }
            smokesArray[i].visible = false;
            StarlingSmoke[smokesArray[i].ItIs + "Pool"].push(smokesArray[i]);
         }
         smokesArray = new Vector.<StarlingSmoke>(0);
         arrayLength = 0;
         detachPools();
         meshBatch.dispose();
      }
      
      public static function detachPools() : *
      {
         var i:* = 0;
         for(var n:* = int(smokeNames.length - 1); n >= 0; n--)
         {
            for(i = int(StarlingSmoke[smokeNames[n] + "Pool"].length - 1); i >= 0; i--)
            {
               if(StarlingSmoke[smokeNames[n] + "Pool"][i].parent != null)
               {
                  StarlingSmoke[smokeNames[n] + "Pool"][i].parent.removeChild(StarlingSmoke[smokeNames[n] + "Pool"][i]);
               }
            }
         }
      }
      
      public static function elevate() : *
      {
         for(var i:* = int(smokesArray.length - 1); i >= 0; i--)
         {
            if(smokesArray[i])
            {
               StarlingBackgrounds.addObject(smokesArray[i],smokesArray[i].onRail);
            }
         }
      }
      
      private function setVariables(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int) : *
      {
         this.ItIs = e;
         x = ex;
         y = ey;
         rotation = rot;
         this.onRail = rail;
         scaleX = scale;
         scaleY = Math.abs(scale);
      }
      
      public function reset() : void
      {
      }
      
      private function killWithInt(i:uint) : void
      {
         smokesArray.removeAt(i);
         visible = false;
         --arrayLength;
      }
      
      private function killWithoutInt() : void
      {
         var temp:int = 0;
         StarlingSmoke[this.ItIs + "Pool"].push(this);
         temp = smokesArray.indexOf(this);
         if(temp > -1)
         {
            --arrayLength;
            smokesArray.removeAt(temp);
         }
         else if(parent != null)
         {
            parent.removeChild(this);
         }
         visible = false;
      }
      
      public function returnToMesh(rail:int, attachBack:Boolean) : void
      {
         visible = true;
         if(attachBack)
         {
            StarlingBackgrounds.addObjectBack(this,rail);
         }
         else if(rail > 0)
         {
            StarlingBackgrounds.addObject(this,rail);
         }
         else
         {
            smokesArray[arrayLength] = this;
            ++arrayLength;
         }
      }
      
      public function goSwim() : void
      {
         this.killWithoutInt();
      }
      
      public function hideFromMesh() : void
      {
         var temp:int = 0;
         temp = smokesArray.indexOf(this);
         if(temp > -1)
         {
            --arrayLength;
            smokesArray.removeAt(temp);
         }
         else
         {
            visible = false;
         }
      }
   }
}

