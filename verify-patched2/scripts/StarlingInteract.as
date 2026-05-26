package
{
   import flash.utils.*;
   import starling.display.*;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class StarlingInteract extends MovieClip
   {
      
      public static var framin:Number;
      
      public static var backgroundsN:int;
      
      public static var localSquiggles:uint;
      
      public static var arrayLength:uint;
      
      public static var interactsAtlas:TextureAtlas;
      
      public static var meshBatch:MeshBatch;
      
      private static var looseSquiggleTextures:Vector.<Texture>;
      
      private static var SquiggleTextures:Vector.<Texture>;
      
      private static var shadowSquiggleTextures:Vector.<Texture>;
      
      private static var SquigglePopTextures:Vector.<Texture>;
      
      private static var grassPopTextures:Vector.<Texture>;
      
      private static var inkShotTextures:Vector.<Texture>;
      
      private static var inkShotBadTextures:Vector.<Texture>;
      
      private static var inkDropTextures:Vector.<Texture>;
      
      private static var fadeInHelpTextures:Vector.<Texture>;
      
      private static var paySquiggleTextures:Vector.<Texture>;
      
      private static var inkSpoutTextures:Vector.<Texture>;
      
      private static var ScratchTextures:Vector.<Texture>;
      
      private static var inkPipeTextures:Vector.<Texture>;
      
      private static var aScratchTextures:Vector.<Texture>;
      
      public static var dontCheat:Object = {};
      
      public static var interactsArray:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      public static var halfArray:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      public static var cameraCollideArray:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      public static var canAttackArray:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      public static var meshArray:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var interactNames:Vector.<String> = new <String>["looseSquiggle","Squiggle","shadowSquiggle","SquigglePop","grassPop","inkShot","inkShotBad","inkDrop","fadeInHelp","paySquiggle","inkSpout","Scratch","inkPipe","aScratch"];
      
      private static var looseSquigglePool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var SquigglePool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var shadowSquigglePool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var SquigglePopPool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var grassPopPool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var inkShotPool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var inkShotBadPool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var inkDropPool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var fadeInHelpPool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var paySquigglePool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var inkSpoutPool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var ScratchPool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var inkPipePool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
      private static var aScratchPool:Vector.<StarlingInteract> = new Vector.<StarlingInteract>(0);
      
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
      
      public var skipMesh:Boolean;
      
      public var backEffect:Boolean = true;
      
      public var killOnAttack:Boolean = true;
      
      public function StarlingInteract(e:*, ex:*, ey:*, rot:*, scale:*, eRL:*, eUD:*, rail:*, id:int = -1)
      {
         super(StarlingInteract[e + "Textures"]);
         this.setVariables(e,ex,ey,rot,scale,eRL,eUD,rail,id);
      }
      
      public static function createAtlas(atlas:*) : void
      {
         for(var i:uint = 0; i < interactNames.length; )
         {
            StarlingInteract[interactNames[i] + "Textures"] = atlas.getTextures(interactNames[i]);
            i++;
         }
      }
      
      public static function Spawn(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, id:int = -1) : StarlingInteract
      {
         var interact:StarlingInteract = null;
         var classTemp:Class = null;
         if(StarlingInteract[e + "Pool"].length > 0)
         {
            interact = StarlingInteract[e + "Pool"].pop();
            interact.setVariables(e,ex,ey,rot,scale,eRL,eUD,rail,id);
            interactsArray[arrayLength] = interact;
            interact.visible = true;
            interact.currentFrame = 1;
         }
         else
         {
            classTemp = getDefinitionByName(e + "Starling") as Class;
            interact = new classTemp(e,ex,ey,rot,scale,eRL,eUD,rail,id);
            interact.textureSmoothing = "bilinear";
         }
         interact.reset();
         if(rail > 0 || interact.skipMesh)
         {
            StarlingBackgrounds.addObject(interact,rail);
         }
         else
         {
            meshArray.push(interact);
         }
         interactsArray[arrayLength] = interact;
         ++arrayLength;
         return interact;
      }
      
      public static function meshCache(background:*) : void
      {
         meshBatch = new MeshBatch();
         background.addChild(meshBatch);
      }
      
      public static function pressMeshes() : void
      {
         meshBatch.clear();
         var i:uint = 0;
         var l:uint = meshArray.length;
         while(i < l)
         {
            meshBatch.addMesh(meshArray[i]);
            i++;
         }
      }
      
      public static function InteractPopulate(p:Object) : void
      {
         Spawn(p.ItIs,p.x,p.y,p.rotation * (Math.PI / 180),p.scaleX,0,0,p.onRail,p.ID);
      }
      
      public static function InkPipePopulate(p:Object) : void
      {
         Spawn(p.ItIs,p.x,p.y,p.rotation * (Math.PI / 180),p.scaleX,0,0,p.onRail,p.lifetime * 1000 + p.interval);
      }
      
      public static function interactsEnterFrames(f:Number) : void
      {
         framin = f;
         for(var i:* = int(arrayLength - 1); i >= 0; i--)
         {
            interactsArray[i].interactsEnterFrame() && interactsArray[i].killWithInt(i);
         }
      }
      
      public static function halfEnterFrames(f:Number) : void
      {
         framin = f;
         for(var i:* = int(halfArray.length - 1); i >= 0; i--)
         {
            halfArray[i].halfEnterFrame() && interactsArray[i].killWithInt(i);
         }
      }
      
      public static function charCheckObjects(ex:Number, ey:Number, eWide:uint, eTall:uint, rail:int, char:Char) : void
      {
         for(var i:* = int(arrayLength - 1); i >= 0; i--)
         {
            if(interactsArray[i].onRail == rail && Math.abs(ex - interactsArray[i].x) < eWide + interactsArray[i].isWide + 10 && Math.abs(ey - interactsArray[i].y) < eTall + interactsArray[i].isTall + 10)
            {
               interactsArray[i].hitChar(ex,ey,char.moveRL,char.moveUD,char) && interactsArray[i].killWithInt(i);
            }
         }
      }
      
      public static function baddieCheckObjects(ex:Number, ey:Number, eWide:uint, eTall:uint, rail:int, char:Baddies) : void
      {
         for(var i:* = int(arrayLength - 1); i >= 0; i--)
         {
            if(interactsArray[i].onRail == char.onRail)
            {
               if(Math.abs(ex - interactsArray[i].x) < eWide + interactsArray[i].isWide + 10 && Math.abs(ey - interactsArray[i].y) < eTall + interactsArray[i].isTall + 10)
               {
                  interactsArray[i].hitBaddie(ex,ey,char.moveRL,char.moveUD,char) && interactsArray[i].killWithInt(i);
               }
            }
         }
      }
      
      public static function cameraCheckObjects(ex:Number, ey:Number, eWide:uint, eTall:uint, rail:int, char:Char) : Boolean
      {
         for(var n:uint = 0; n < cameraCollideArray.length; n++)
         {
            if(cameraCollideArray[n].onRail == rail)
            {
               if(Math.abs(ex - cameraCollideArray[n].x) < eWide + cameraCollideArray[n].isWide && Math.abs(ey - cameraCollideArray[n].y) < eTall + cameraCollideArray[n].isTall)
               {
                  char.predictOffsetY = cameraCollideArray[n].predictOffsetY;
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function checkAttackables(char:*, rail:*) : Boolean
      {
         var temp:uint = 0;
         for(var i:* = int(canAttackArray.length - 1); i >= 0; i--)
         {
            if(canAttackArray[i].onRail == rail)
            {
               if(Boolean(char.CheckAttack(canAttackArray[i])) && canAttackArray[i].killOnAttack)
               {
                  temp = interactsArray.indexOf(canAttackArray[i]);
                  canAttackArray[i].killWithInt(temp);
               }
            }
         }
         return false;
      }
      
      public static function checkByName(e:String, ex:int, ey:int, wide:uint, tall:uint, rail:int) : StarlingInteract
      {
         for(var i:* = int(arrayLength - 1); i >= 0; i--)
         {
            if(interactsArray[i].ItIs == e && interactsArray[i].onRail == rail)
            {
               if(Math.abs(ex - interactsArray[i].x) < wide + interactsArray[i].isWide && Math.abs(ey - interactsArray[i].y) < tall + interactsArray[i].isTall)
               {
                  return interactsArray[i];
               }
            }
         }
      }
      
      public static function findByName(e:*) : StarlingInteract
      {
         for(var i:* = int(arrayLength - 1); i >= 0; i--)
         {
            if(interactsArray[i].ItIs == e)
            {
               return interactsArray[i];
            }
         }
      }
      
      public static function clearAllInteracts() : *
      {
         for(var i:* = int(arrayLength - 1); i >= 0; i--)
         {
            if(interactsArray[i].parent != null)
            {
               interactsArray[i].parent.removeChild(interactsArray[i]);
            }
            interactsArray[i].visible = false;
            interactsArray[i].cleanUp();
            StarlingInteract[interactsArray[i].ItIs + "Pool"].push(interactsArray[i]);
         }
         interactsArray = new Vector.<StarlingInteract>(0);
         halfArray = new Vector.<StarlingInteract>(0);
         cameraCollideArray = new Vector.<StarlingInteract>(0);
         canAttackArray = new Vector.<StarlingInteract>(0);
         meshArray = new Vector.<StarlingInteract>(0);
         arrayLength = 0;
         detachPools();
         meshBatch.dispose();
      }
      
      public static function detachPools() : *
      {
         var i:* = 0;
         for(var n:* = int(interactNames.length - 1); n >= 0; n--)
         {
            for(i = int(StarlingInteract[interactNames[n] + "Pool"].length - 1); i >= 0; i--)
            {
               if(StarlingInteract[interactNames[n] + "Pool"][i].parent != null)
               {
                  StarlingInteract[interactNames[n] + "Pool"][i].parent.removeChild(StarlingInteract[interactNames[n] + "Pool"][i]);
               }
            }
         }
      }
      
      public static function elevate() : *
      {
         for(var i:* = int(interactsArray.length - 1); i >= 0; i--)
         {
            if(interactsArray[i])
            {
               StarlingBackgrounds.addObject(interactsArray[i],0);
            }
         }
      }
      
      private function setVariables(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, id:int) : *
      {
         this.ItIs = e;
         x = ex;
         y = ey;
         this.moveRL = eRL;
         this.moveUD = eUD;
         rotation = rot;
         this.onRail = rail;
         scaleX = scale;
         scaleY = Math.abs(scale);
         this.ID = id;
      }
      
      public function makeOne(e:*) : int
      {
         if(e == 0)
         {
            return 0;
         }
         return e / Math.abs(e);
      }
      
      public function interactsEnterFrame() : Boolean
      {
      }
      
      public function halfEnterFrame() : Boolean
      {
      }
      
      public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
      }
      
      public function hitBaddie(ex:Number, ey:Number, eRL:Number, eUD:Number, bad:Baddies) : Boolean
      {
      }
      
      public function reset() : void
      {
      }
      
      public function cleanUp() : void
      {
      }
      
      private function killWithInt(i:uint) : void
      {
         var temp:int = 0;
         interactsArray.removeAt(i);
         StarlingInteract[this.ItIs + "Pool"].push(this);
         temp = halfArray.indexOf(this);
         if(temp > -1)
         {
            halfArray.removeAt(temp);
         }
         temp = cameraCollideArray.indexOf(this);
         if(temp > -1)
         {
            cameraCollideArray.removeAt(temp);
         }
         temp = canAttackArray.indexOf(this);
         if(temp > -1)
         {
            canAttackArray.removeAt(temp);
         }
         temp = meshArray.indexOf(this);
         if(temp > -1)
         {
            meshArray.removeAt(temp);
         }
         if(this.onRail > 0)
         {
            parent.removeChild(this);
         }
         visible = false;
         this.cleanUp();
         --arrayLength;
      }
   }
}

