package starling.filters
{
   import starling.core.*;
   import starling.rendering.FilterEffect;
   import starling.rendering.Painter;
   import starling.textures.Texture;
   
   public class BlurFilter extends FragmentFilter
   {
      
      private var _blurX:Number;
      
      private var _blurY:Number;
      
      public function BlurFilter(blurX:Number = 1, blurY:Number = 1, resolution:Number = 1)
      {
         super();
         this._blurX = Math.abs(blurX);
         this._blurY = Math.abs(blurY);
         this.resolution = resolution;
      }
      
      private static function getNumPasses(blur:Number) : int
      {
         for(var numPasses:int = 1; blur > 1; )
         {
            numPasses += 1;
            blur /= 2;
         }
         return numPasses;
      }
      
      override public function process(painter:Painter, helper:IFilterHelper, input0:Texture = null, input1:Texture = null, input2:Texture = null, input3:Texture = null) : Texture
      {
         var inTexture:Texture = null;
         var effect:BlurEffect = this.effect as BlurEffect;
         if(this._blurX == 0 && this._blurY == 0)
         {
            effect.strength = 0;
            return super.process(painter,helper,input0);
         }
         var outTexture:Texture = input0;
         var strengthX:Number = Number(this.totalBlurX);
         var strengthY:Number = Number(this.totalBlurY);
         effect.direction = BlurEffect.HORIZONTAL;
         while(strengthX > 0)
         {
            effect.strength = strengthX;
            inTexture = outTexture;
            outTexture = super.process(painter,helper,inTexture);
            if(inTexture != input0)
            {
               helper.putTexture(inTexture);
            }
            if(strengthX <= 1)
            {
               break;
            }
            strengthX /= 2;
         }
         effect.direction = BlurEffect.VERTICAL;
         while(strengthY > 0)
         {
            effect.strength = strengthY;
            inTexture = outTexture;
            outTexture = super.process(painter,helper,inTexture);
            if(inTexture != input0)
            {
               helper.putTexture(inTexture);
            }
            if(strengthY <= 1)
            {
               break;
            }
            strengthY /= 2;
         }
         return outTexture;
      }
      
      override protected function createEffect() : FilterEffect
      {
         return new BlurEffect();
      }
      
      override public function set resolution(value:Number) : void
      {
         super.resolution = value;
         this.updatePadding();
      }
      
      private function updatePadding() : void
      {
         var paddingX:Number = this._blurX ? (this.totalBlurX * 3 + 2) / resolution : 0;
         var paddingY:Number = this._blurY ? (this.totalBlurY * 3 + 2) / resolution : 0;
         padding.setTo(paddingX,paddingX,paddingY,paddingY);
      }
      
      override public function get numPasses() : int
      {
         if(this._blurX == 0 && this._blurY == 0)
         {
            return 1;
         }
         return getNumPasses(this.totalBlurX) + getNumPasses(this.totalBlurY);
      }
      
      private function get totalBlurX() : Number
      {
         return this._blurX * Starling.contentScaleFactor;
      }
      
      private function get totalBlurY() : Number
      {
         return this._blurY * Starling.contentScaleFactor;
      }
      
      public function get blurX() : Number
      {
         return this._blurX;
      }
      
      public function set blurX(value:Number) : void
      {
         this._blurX = Math.abs(value);
         this.updatePadding();
      }
      
      public function get blurY() : Number
      {
         return this._blurY;
      }
      
      public function set blurY(value:Number) : void
      {
         this._blurY = Math.abs(value);
         this.updatePadding();
      }
   }
}

import flash.display3D.*;
import starling.rendering.*;

class BlurEffect extends FilterEffect
{
   
   public static const HORIZONTAL:String = "horizontal";
   
   public static const VERTICAL:String = "vertical";
   
   private static const sTmpWeights:Vector.<Number> = new <Number>[0,0,0,0,0];
   
   private static const sWeights:Vector.<Number> = new <Number>[0,0,0,0];
   
   private static const sOffsets:Vector.<Number> = new <Number>[0,0,0,0];
   
   private var _strength:Number;
   
   private var _direction:String;
   
   public function BlurEffect()
   {
      super();
      this._strength = 0;
      this._direction = HORIZONTAL;
   }
   
   override protected function createProgram() : Program
   {
      if(this._strength == 0)
      {
         return super.createProgram();
      }
      var vertexShader:String = ["m44 op, va0, vc0      ","mov v0, va1           ","add v1,  va1, vc4.xyww","sub v2,  va1, vc4.xyww","add v3,  va1, vc4.zwxx","sub v4,  va1, vc4.zwxx"].join("\n");
      var fragmentShader:String = [tex("ft0","v0",0,texture),"mul ft5, ft0, fc0.xxxx       ",tex("ft1","v1",0,texture),"mul ft1, ft1, fc0.yyyy       ","add ft5, ft5, ft1            ",tex("ft2","v2",0,texture),"mul ft2, ft2, fc0.yyyy       ","add ft5, ft5, ft2            ",tex("ft3","v3",0,texture),"mul ft3, ft3, fc0.zzzz       ","add ft5, ft5, ft3            ",tex("ft4","v4",0,texture),"mul ft4, ft4, fc0.zzzz       ","add  oc, ft5, ft4            "].join("\n");
      return Program.fromSource(vertexShader,fragmentShader);
   }
   
   override protected function beforeDraw(context:Context3D) : void
   {
      super.beforeDraw(context);
      if(this._strength)
      {
         this.updateParameters();
         context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,sOffsets);
         context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,sWeights);
      }
   }
   
   private function updateParameters() : void
   {
      var offset1:Number = NaN;
      var offset2:Number = NaN;
      var sigma:Number = NaN;
      var twoSigmaSq:Number = NaN;
      var multiplier:Number = NaN;
      var i:int = 0;
      var weightSum:Number = NaN;
      var invWeightSum:Number = NaN;
      var pixelSize:Number = 1 / (this._direction == HORIZONTAL ? texture.root.nativeWidth : texture.root.nativeHeight);
      if(this._strength <= 1)
      {
         sigma = this._strength * 2;
         twoSigmaSq = 2 * sigma * sigma;
         multiplier = 1 / Math.sqrt(twoSigmaSq * Math.PI);
         for(i = 0; i < 5; i++)
         {
            sTmpWeights[i] = multiplier * Math.exp(-i * i / twoSigmaSq);
         }
         sWeights[0] = sTmpWeights[0];
         sWeights[1] = sTmpWeights[1] + sTmpWeights[2];
         sWeights[2] = sTmpWeights[3] + sTmpWeights[4];
         weightSum = sWeights[0] + 2 * sWeights[1] + 2 * sWeights[2];
         invWeightSum = 1 / weightSum;
         sWeights[0] *= invWeightSum;
         sWeights[1] *= invWeightSum;
         sWeights[2] *= invWeightSum;
         offset1 = (sTmpWeights[1] + 2 * sTmpWeights[2]) / sWeights[1];
         offset2 = (3 * sTmpWeights[3] + 4 * sTmpWeights[4]) / sWeights[2];
      }
      else
      {
         sWeights[0] = 0.29412;
         sWeights[1] = 0.23529;
         sWeights[2] = 0.11765;
         offset1 = this._strength * 1.3;
         offset2 = this._strength * 2.3;
      }
      if(this._direction == HORIZONTAL)
      {
         sOffsets[0] = offset1 * pixelSize;
         sOffsets[1] = 0;
         sOffsets[2] = offset2 * pixelSize;
         sOffsets[3] = 0;
      }
      else
      {
         sOffsets[0] = 0;
         sOffsets[1] = offset1 * pixelSize;
         sOffsets[2] = 0;
         sOffsets[3] = offset2 * pixelSize;
      }
   }
   
   override protected function get programVariantName() : uint
   {
      return super.programVariantName | (this._strength ? 1 << 4 : 0);
   }
   
   public function get direction() : String
   {
      return this._direction;
   }
   
   public function set direction(value:String) : void
   {
      this._direction = value;
   }
   
   public function get strength() : Number
   {
      return this._strength;
   }
   
   public function set strength(value:Number) : void
   {
      this._strength = value;
   }
}
