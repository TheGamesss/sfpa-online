package
{
   import flash.display.*;
   import flash.geom.*;
   import flash.utils.getDefinitionByName;
   
   public class cachedEffects extends MovieClip
   {
      
      public static var arrayLength:uint;
      
      private static var effect:cachedEffects;
      
      private static var ImpactFrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var ImpactBitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var ImpactBitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var SplatFrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var SplatBitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var SplatBitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var Slash1FrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var Slash1BitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var Slash1BitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var Slash2FrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var Slash2BitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var Slash2BitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var Slash3FrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var Slash3BitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var Slash3BitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var Slash4FrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var Slash4BitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var Slash4BitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var SlashMedium1FrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var SlashMedium1BitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var SlashMedium1BitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var SlashMedium2FrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var SlashMedium2BitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var SlashMedium2BitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var SlashRisingFrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var SlashRisingBitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var SlashRisingBitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var SlashHeavy1FrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var SlashHeavy1BitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var SlashHeavy1BitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var BuzzSawFrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var BuzzSawBitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var BuzzSawBitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var HeavyUpFrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var HeavyUpBitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var HeavyUpBitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var SwipeUpFrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var SwipeUpBitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var SwipeUpBitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var PokeDownFrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var PokeDownBitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var PokeDownBitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var HeavyDownFrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var HeavyDownBitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var HeavyDownBitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var PopFrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var PopBitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var PopBitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var SquigPopFrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var SquigPopBitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var SquigPopBitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var SmokePuffFrameCache:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      private static var SmokePuffBitmapXs:Vector.<int> = new Vector.<int>(0);
      
      private static var SmokePuffBitmapYs:Vector.<int> = new Vector.<int>(0);
      
      private static var effectsArray:Vector.<cachedEffects> = new Vector.<cachedEffects>(0);
      
      private static var effectsPool:Vector.<cachedEffects> = new Vector.<cachedEffects>(0);
      
      public var frame:uint = 0;
      
      public var totalBitmaps:uint;
      
      private var ItIs:String;
      
      private var myBitmapData:BitmapData;
      
      public var myBitmap:Bitmap;
      
      public var onRail:int;
      
      private var moveRL:Number;
      
      private var moveUD:Number;
      
      private var animate:Boolean = true;
      
      public var isVector:Boolean = true;
      
      public function cachedEffects(itis:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, par:Sprite, anim:Boolean)
      {
         super();
         this.ItIs = itis;
         x = ex;
         y = ey;
         this.onRail = rail;
         this.moveRL = eRL;
         this.moveUD = eUD;
         scaleX = scale;
         scaleY = Math.abs(scale);
         rotation = rot * (180 / Math.PI);
         this.myBitmapData = cachedEffects[itis + "FrameCache"][0];
         this.myBitmap = new Bitmap(this.myBitmapData);
         this.myBitmap.smoothing = false;
         this.addChild(this.myBitmap);
         this.myBitmap.x = cachedEffects[itis + "BitmapXs"][0];
         this.myBitmap.y = cachedEffects[itis + "BitmapYs"][0];
         this.totalBitmaps = cachedEffects[itis + "FrameCache"].length;
         this.animate = anim;
      }
      
      public static function spawnCachedEffect(e:String, ex:int, ey:int, rot:Number, scale:Number, eRL:Number, eUD:Number, rail:int, par:Sprite = null, anim:Boolean = true) : cachedEffects
      {
         if(effectsPool.length > 0)
         {
            effect = effectsPool.pop();
            effect.moveRL = eRL;
            effect.moveUD = eUD;
            effect.x = ex;
            effect.y = ey;
            effect.scaleX = scale;
            effect.scaleY = Math.abs(scale);
            effect.rotation = rot * (180 / Math.PI);
            effect.visible = true;
            effect.ItIs = e;
            effect.frame = 0;
            effect.myBitmap.bitmapData = cachedEffects[e + "FrameCache"][0];
            effect.myBitmap.x = cachedEffects[e + "BitmapXs"][0];
            effect.myBitmap.y = cachedEffects[e + "BitmapYs"][0];
            effect.totalBitmaps = cachedEffects[e + "FrameCache"].length;
         }
         else
         {
            effect = new cachedEffects(e,ex,ey,rot,scale,eRL,eUD,rail,par,anim);
         }
         if(par == null)
         {
            Backgrounds.backgroundsArray[rail].addChild(effect);
         }
         else
         {
            par.addChild(effect);
         }
         if(anim)
         {
            effectsArray[arrayLength] = effect;
            ++arrayLength;
         }
         return effect;
      }
      
      public static function EffectEnterFrames(f:Number) : void
      {
         for(var i:* = int(arrayLength - 1); i >= 0; i--)
         {
            effectsArray[i].EffectEnterFrame() && effectsArray[i].killWithInt(i);
         }
      }
      
      public static function cacheMe(itis:*) : void
      {
         var bounds:Rectangle = null;
         var bmpData:BitmapData = null;
         var effectClass:Class = getDefinitionByName("effect" + itis) as Class;
         var effect:MovieClip = new effectClass();
         for(var i:uint = 0; i < effect.totalFrames; i++)
         {
            effect.gotoAndStop(i + 1);
            if(effect.effect != undefined)
            {
               effect.effect.gotoAndStop(i + 1);
            }
            if(effect.effect2 != undefined)
            {
               effect.effect2.gotoAndStop(i + 1);
            }
            bounds = effect.getBounds(effect);
            bounds.x -= 5;
            bounds.y -= 5;
            bounds.height += 10;
            bounds.width += 10;
            if(bounds.width < 35)
            {
               bounds.width = 35;
            }
            cachedEffects[itis + "BitmapXs"][i] = bounds.x;
            cachedEffects[itis + "BitmapYs"][i] = bounds.y;
            bmpData = new BitmapData(Math.floor(bounds.width),Math.floor(bounds.height),true,16777215);
            bmpData.lock();
            bmpData.drawWithQuality(effect,new Matrix(1,0,0,1,-bounds.x,-bounds.y),null,null,null,true,StageQuality.HIGH);
            cachedEffects[itis + "FrameCache"][i] = bmpData;
         }
         bmpData = null;
         bounds = null;
         effectClass = null;
         effect = null;
      }
      
      public function EffectEnterFrame() : Boolean
      {
         x += this.moveRL;
         y += this.moveUD;
         this.moveRL *= 0.8;
         this.moveUD *= 0.8;
         ++this.frame;
         if(this.frame < this.totalBitmaps)
         {
            this.myBitmap.bitmapData = cachedEffects[this.ItIs + "FrameCache"][this.frame];
            this.myBitmap.x = cachedEffects[this.ItIs + "BitmapXs"][this.frame];
            this.myBitmap.y = cachedEffects[this.ItIs + "BitmapYs"][this.frame];
            return false;
         }
         return true;
      }
      
      public function changeFrame(f:uint) : void
      {
         this.frame = f;
         this.myBitmap.bitmapData = cachedEffects[this.ItIs + "FrameCache"][this.frame];
         this.myBitmap.x = cachedEffects[this.ItIs + "BitmapXs"][this.frame];
         this.myBitmap.y = cachedEffects[this.ItIs + "BitmapYs"][this.frame];
      }
      
      private function killWithInt(i:uint) : void
      {
         if(arrayLength == 1)
         {
            effectsArray = new Vector.<cachedEffects>(0);
         }
         else if(i < arrayLength - 1)
         {
            effectsArray[i] = effectsArray.pop();
         }
         else
         {
            effectsArray.pop();
         }
         effectsPool.push(this);
         --arrayLength;
         visible = false;
      }
      
      public function goSwim() : void
      {
         effectsPool.push(this);
         visible = false;
      }
   }
}

