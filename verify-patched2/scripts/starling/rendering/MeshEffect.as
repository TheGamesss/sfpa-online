package starling.rendering
{
   import flash.display3D.*;
   import flash.utils.*;
   
   public class MeshEffect extends FilterEffect
   {
      
      public static const VERTEX_FORMAT:VertexDataFormat = FilterEffect.VERTEX_FORMAT.extend("color:bytes4");
      
      private static var sRenderAlpha:Vector.<Number> = new Vector.<Number>(4,true);
      
      private var _alpha:Number;
      
      private var _tinted:Boolean;
      
      private var _optimizeIfNotTinted:Boolean;
      
      public function MeshEffect()
      {
         super();
         this._alpha = 1;
         this._optimizeIfNotTinted = getQualifiedClassName(this) == "starling.rendering::MeshEffect";
      }
      
      override protected function get programVariantName() : uint
      {
         var noTinting:uint = uint(this._optimizeIfNotTinted && !this._tinted && this._alpha == 1);
         return super.programVariantName | noTinting << 3;
      }
      
      override protected function createProgram() : Program
      {
         var vertexShader:String = null;
         var fragmentShader:String = null;
         if(texture)
         {
            if(Boolean(this._optimizeIfNotTinted) && !this._tinted && this._alpha == 1)
            {
               return super.createProgram();
            }
            vertexShader = "m44 op, va0, vc0 \n" + "mov v0, va1      \n" + "mul v1, va2, vc4 \n";
            fragmentShader = tex("ft0","v0",0,texture) + "mul oc, ft0, v1  \n";
         }
         else
         {
            vertexShader = "m44 op, va0, vc0 \n" + "mul v0, va2, vc4 \n";
            fragmentShader = "mov oc, v0       \n";
         }
         return Program.fromSource(vertexShader,fragmentShader);
      }
      
      override protected function beforeDraw(context:Context3D) : void
      {
         super.beforeDraw(context);
         sRenderAlpha[0] = sRenderAlpha[1] = sRenderAlpha[2] = sRenderAlpha[3] = this._alpha;
         context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,sRenderAlpha);
         if(Boolean(this._tinted) || this._alpha != 1 || !this._optimizeIfNotTinted || texture == null)
         {
            this.vertexFormat.setVertexBufferAt(2,vertexBuffer,"color");
         }
      }
      
      override protected function afterDraw(context:Context3D) : void
      {
         context.setVertexBufferAt(2,null);
         super.afterDraw(context);
      }
      
      override public function get vertexFormat() : VertexDataFormat
      {
         return VERTEX_FORMAT;
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(value:Number) : void
      {
         this._alpha = value;
      }
      
      public function get tinted() : Boolean
      {
         return this._tinted;
      }
      
      public function set tinted(value:Boolean) : void
      {
         this._tinted = value;
      }
   }
}

