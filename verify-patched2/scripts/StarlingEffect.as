package
{
   import starling.display.*;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class StarlingEffect extends MovieClip
   {
      
      public static var framin:Number;
      
      public static var arrayLength:uint;
      
      public static var effectsAtlas:TextureAtlas;
      
      public static var meshBatch:MeshBatch;
      
      public static var smokePuffTextures:Vector.<Texture>;
      
      public static var SquigPopTextures:Vector.<Texture>;
      
      public static var popEffectTextures:Vector.<Texture>;
      
      public static var impactEffectTextures:Vector.<Texture>;
      
      public static var blockPieceTextures:Vector.<Texture>;
      
      public static var inkTrail0Textures:Vector.<Texture>;
      
      public static var inkTrail1Textures:Vector.<Texture>;
      
      public static var inkTrail2Textures:Vector.<Texture>;
      
      public static var inkImpact0Textures:Vector.<Texture>;
      
      public static var inkImpact1Textures:Vector.<Texture>;
      
      public static var inkImpact2Textures:Vector.<Texture>;
      
      public static var inkZipTrail0Textures:Vector.<Texture>;
      
      public static var inkZipTrail1Textures:Vector.<Texture>;
      
      public static var inkZipTrail2Textures:Vector.<Texture>;
      
      public static var inkSplashTextures:Vector.<Texture>;
      
      public static var SplatTextures:Vector.<Texture>;
      
      public static var bubbleTextures:Vector.<Texture>;
      
      public static var fireTextures:Vector.<Texture>;
      
      public static var effectsArray:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      private static var effectColor:uint = 16777215;
      
      private static var effectNames:Vector.<String> = new <String>["smokePuff","SquigPop","popEffect","impactEffect","blockPiece","inkSplash","inkTrail0","inkTrail1","inkTrail2","inkImpact0","inkImpact1","inkImpact2","inkZipTrail0","inkZipTrail1","inkZipTrail2","Splat","bubble","fire"];
      
      public static var smokePuffPool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var SquigPopPool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var popEffectPool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var impactEffectPool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var blockPiecePool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var inkTrail0Pool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var inkTrail1Pool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var inkTrail2Pool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var inkImpact0Pool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var inkImpact1Pool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var inkImpact2Pool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var inkZipTrail0Pool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var inkZipTrail1Pool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var inkZipTrail2Pool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var inkSplashPool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var SplatPool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var bubblePool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public static var firePool:Vector.<StarlingEffect> = new Vector.<StarlingEffect>(0);
      
      public var ItIs:String;
      
      public var moveRL:Number;
      
      public var moveUD:Number;
      
      public var onRail:int;
      
      public var isVector:Boolean;
      
      public function StarlingEffect(e:String, ex:int, ey:int, rot:Number, sca:Number, eRL:Number, eUD:Number, rail:int, lop:Boolean)
      {
         super(StarlingEffect[e + "Textures"]);
         this.ItIs = e;
         x = ex;
         y = ey;
         rotation = rot;
         scaleX = sca;
         scaleY = Math.abs(sca);
         this.moveRL = eRL;
         this.moveUD = eUD;
         this.onRail = rail;
         loop = lop;
      }
      
      public static function createAtlas(atlas:*) : void
      {
         for(var i:* = int(effectNames.length - 1); i >= 0; i--)
         {
            StarlingEffect[effectNames[i] + "Textures"] = atlas.getTextures(effectNames[i]);
         }
         StarlingBackgrounds.inkSplat = new MovieClip(atlas.getTextures("inkSplat"));
      }
      
      public static function Spawn(e:String, ex:int, ey:int, rot:Number, sca:Number, eRL:Number, eUD:Number, rail:int, lop:Boolean = false, type:String = "nothing", frame:uint = 1) : void
      {
         var effect:StarlingEffect = null;
         if(StarlingEffect[e + "Pool"].length > 0)
         {
            effect = StarlingEffect[e + "Pool"].pop();
            effect.setVariables(e,ex,ey,rot,sca,eRL,eUD,rail,lop);
            effect.visible = true;
         }
         else
         {
            if(e == "blockPiece")
            {
               effect = new StarlingShrapnel(e,ex,ey,rot,sca,eRL,eUD,rail,lop);
            }
            else if(e == "bubble")
            {
               effect = new StarlingBubble(e,ex,ey,rot,sca,eRL,eUD,rail,lop);
            }
            else if(e == "fire")
            {
               effect = new StarlingFire(e,ex,ey,rot,sca,eRL,eUD,rail,lop);
            }
            else
            {
               effect = new StarlingEffect(e,ex,ey,rot,sca,eRL,eUD,rail,lop);
            }
            effect.textureSmoothing = "bilinear";
         }
         if(rail > 0)
         {
            StarlingBackgrounds.addObject(effect,rail);
         }
         effect.color = effectColor;
         effect.currentFrame = frame;
         effectsArray[arrayLength] = effect;
         effect.setupEffect();
         ++arrayLength;
         effect = null;
      }
      
      public static function GrabLastEffect() : StarlingEffect
      {
         return effectsArray[arrayLength - 1];
      }
      
      public static function setColor(e:uint) : void
      {
         effectColor = e;
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
            if(effectsArray[i].onRail == 0)
            {
               meshBatch.addMesh(effectsArray[i]);
            }
         }
      }
      
      public static function effectsEnterFrames(f:Number) : void
      {
         framin = f;
         for(var i:* = int(arrayLength - 1); i >= 0; i--)
         {
            effectsArray[i].effectsEnterFrame() && effectsArray[i].killWithInt(i);
         }
      }
      
      public static function clearAllEffects() : *
      {
         for(var i:* = int(arrayLength - 1); i >= 0; i--)
         {
            if(effectsArray[i].parent != null)
            {
               effectsArray[i].parent.addChild(effectsArray[i]);
            }
            effectsArray[i].visible = false;
            StarlingEffect[effectsArray[i].ItIs + "Pool"].push(effectsArray[i]);
         }
         effectsArray = new Vector.<StarlingEffect>(0);
         arrayLength = 0;
         detachPools();
         meshBatch.dispose();
      }
      
      public static function detachPools() : *
      {
         var i:* = 0;
         for(var n:* = int(effectNames.length - 1); n >= 0; n--)
         {
            for(i = int(StarlingEffect[effectNames[n] + "Pool"].length - 1); i >= 0; i--)
            {
               if(StarlingEffect[effectNames[n] + "Pool"][i].parent != null)
               {
                  StarlingEffect[effectNames[n] + "Pool"][i].parent.removeChild(StarlingEffect[effectNames[n] + "Pool"][i]);
               }
            }
         }
      }
      
      public static function elevate() : *
      {
         for(var i:* = int(effectsArray.length - 1); i >= 0; i--)
         {
            if(effectsArray[i])
            {
               StarlingBackgrounds.addObject(effectsArray[i],0);
            }
         }
      }
      
      public function setupEffect() : void
      {
      }
      
      private function setVariables(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, lop:Boolean) : *
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
         loop = lop;
      }
      
      public function effectsEnterFrame() : Boolean
      {
         x += this.moveRL * framin;
         y += this.moveUD * framin;
         this.moveRL -= this.moveRL * 0.22 * framin;
         this.moveUD -= this.moveUD * 0.22 * framin;
         return nextFrameStep(framin);
      }
      
      private function killWithInt(i:uint) : void
      {
         effectsArray.removeAt(i);
         StarlingEffect[this.ItIs + "Pool"].push(this);
         if(this.onRail > 0)
         {
            parent.removeChild(this);
         }
         --arrayLength;
         visible = false;
      }
      
      public function goSwim() : void
      {
         if(effectsArray.indexOf(this) > -1)
         {
            this.killWithInt(effectsArray.indexOf(this));
         }
      }
   }
}

