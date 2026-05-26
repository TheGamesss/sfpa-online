package starling.rendering
{
   import flash.display3D.Context3D;
   import starling.textures.*;
   import starling.utils.*;
   
   public class FilterEffect extends Effect
   {
      
      public static const VERTEX_FORMAT:VertexDataFormat = Effect.VERTEX_FORMAT.extend("texCoords:float2");
      
      public static const STD_VERTEX_SHADER:String = "m44 op, va0, vc0 \n" + "mov v0, va1";
      
      private var _texture:Texture;
      
      private var _textureSmoothing:String;
      
      private var _textureRepeat:Boolean;
      
      public function FilterEffect()
      {
         super();
         this._textureSmoothing = TextureSmoothing.BILINEAR;
      }
      
      protected static function tex(resultReg:String, uvReg:String, sampler:int, texture:Texture, convertToPmaIfRequired:Boolean = true) : String
      {
         return RenderUtil.createAGALTexOperation(resultReg,uvReg,sampler,texture,convertToPmaIfRequired);
      }
      
      override protected function get programVariantName() : uint
      {
         return RenderUtil.getTextureVariantBits(this._texture);
      }
      
      override protected function createProgram() : Program
      {
         var vertexShader:String = null;
         var fragmentShader:String = null;
         if(this._texture)
         {
            vertexShader = STD_VERTEX_SHADER;
            fragmentShader = tex("oc","v0",0,this._texture);
            return Program.fromSource(vertexShader,fragmentShader);
         }
         return super.createProgram();
      }
      
      override protected function beforeDraw(context:Context3D) : void
      {
         var repeat:Boolean = false;
         super.beforeDraw(context);
         if(this._texture)
         {
            repeat = Boolean(this._textureRepeat) && Boolean(this._texture.root.isPotTexture);
            RenderUtil.setSamplerStateAt(0,this._texture.mipMapping,this._textureSmoothing,repeat);
            context.setTextureAt(0,this._texture.base);
            this.vertexFormat.setVertexBufferAt(1,vertexBuffer,"texCoords");
         }
      }
      
      override protected function afterDraw(context:Context3D) : void
      {
         if(this._texture)
         {
            context.setTextureAt(0,null);
            context.setVertexBufferAt(1,null);
         }
         super.afterDraw(context);
      }
      
      override public function get vertexFormat() : VertexDataFormat
      {
         return VERTEX_FORMAT;
      }
      
      public function get texture() : Texture
      {
         return this._texture;
      }
      
      public function set texture(value:Texture) : void
      {
         this._texture = value;
      }
      
      public function get textureSmoothing() : String
      {
         return this._textureSmoothing;
      }
      
      public function set textureSmoothing(value:String) : void
      {
         this._textureSmoothing = value;
      }
      
      public function get textureRepeat() : Boolean
      {
         return this._textureRepeat;
      }
      
      public function set textureRepeat(value:Boolean) : void
      {
         this._textureRepeat = value;
      }
   }
}

