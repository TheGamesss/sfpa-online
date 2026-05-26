package starling.rendering
{
   import flash.display3D.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import starling.core.*;
   import starling.errors.*;
   import starling.utils.*;
   
   public class Effect
   {
      
      public static const VERTEX_FORMAT:VertexDataFormat = VertexDataFormat.fromString("position:float2");
      
      private static var sProgramNameCache:Dictionary = new Dictionary();
      
      private var _vertexBuffer:VertexBuffer3D;
      
      private var _vertexBufferSize:int;
      
      private var _indexBuffer:IndexBuffer3D;
      
      private var _indexBufferSize:int;
      
      private var _indexBufferUsesQuadLayout:Boolean;
      
      private var _mvpMatrix3D:Matrix3D;
      
      private var _onRestore:Function;
      
      private var _programBaseName:String;
      
      public function Effect()
      {
         super();
         this._mvpMatrix3D = new Matrix3D();
         this._programBaseName = getQualifiedClassName(this);
         Starling.current.stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated,false,20,true);
      }
      
      public function dispose() : void
      {
         Starling.current.stage3D.removeEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated);
         this.purgeBuffers();
      }
      
      private function onContextCreated(event:Event) : void
      {
         this.purgeBuffers();
         execute(this._onRestore,this);
      }
      
      public function purgeBuffers(vertexBuffer:Boolean = true, indexBuffer:Boolean = true) : void
      {
         if(Boolean(this._vertexBuffer) && vertexBuffer)
         {
            try
            {
               this._vertexBuffer.dispose();
            }
            catch(e:Error)
            {
            }
            this._vertexBuffer = null;
         }
         if(Boolean(this._indexBuffer) && indexBuffer)
         {
            try
            {
               this._indexBuffer.dispose();
            }
            catch(e:Error)
            {
            }
            this._indexBuffer = null;
         }
      }
      
      public function uploadIndexData(indexData:IndexData, bufferUsage:String = "staticDraw") : void
      {
         var numIndices:int = indexData.numIndices;
         var isQuadLayout:Boolean = indexData.useQuadLayout;
         var wasQuadLayout:Boolean = Boolean(this._indexBufferUsesQuadLayout);
         if(this._indexBuffer)
         {
            if(numIndices <= this._indexBufferSize)
            {
               if(!isQuadLayout || !wasQuadLayout)
               {
                  indexData.uploadToIndexBuffer(this._indexBuffer);
                  this._indexBufferUsesQuadLayout = isQuadLayout && numIndices == this._indexBufferSize;
               }
            }
            else
            {
               this.purgeBuffers(false,true);
            }
         }
         if(this._indexBuffer == null)
         {
            this._indexBuffer = indexData.createIndexBuffer(true,bufferUsage);
            this._indexBufferSize = numIndices;
            this._indexBufferUsesQuadLayout = isQuadLayout;
         }
      }
      
      public function uploadVertexData(vertexData:VertexData, bufferUsage:String = "staticDraw") : void
      {
         if(this._vertexBuffer)
         {
            if(vertexData.size <= this._vertexBufferSize)
            {
               vertexData.uploadToVertexBuffer(this._vertexBuffer);
            }
            else
            {
               this.purgeBuffers(true,false);
            }
         }
         if(this._vertexBuffer == null)
         {
            this._vertexBuffer = vertexData.createVertexBuffer(true,bufferUsage);
            this._vertexBufferSize = vertexData.size;
         }
      }
      
      public function render(firstIndex:int = 0, numTriangles:int = -1) : void
      {
         if(numTriangles < 0)
         {
            numTriangles = this._indexBufferSize / 3;
         }
         if(numTriangles == 0)
         {
            return;
         }
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         this.beforeDraw(context);
         context.drawTriangles(this.indexBuffer,firstIndex,numTriangles);
         this.afterDraw(context);
      }
      
      protected function beforeDraw(context:Context3D) : void
      {
         this.program.activate(context);
         this.vertexFormat.setVertexBufferAt(0,this.vertexBuffer,"position");
         context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,this.mvpMatrix3D,true);
      }
      
      protected function afterDraw(context:Context3D) : void
      {
         context.setVertexBufferAt(0,null);
      }
      
      protected function createProgram() : Program
      {
         var vertexShader:String = ["m44 op, va0, vc0","seq v0, va0, va0"].join("\n");
         var fragmentShader:String = "mov oc, v0";
         return Program.fromSource(vertexShader,fragmentShader);
      }
      
      protected function get programVariantName() : uint
      {
         return 0;
      }
      
      protected function get programBaseName() : String
      {
         return this._programBaseName;
      }
      
      protected function set programBaseName(value:String) : void
      {
         this._programBaseName = value;
      }
      
      protected function get programName() : String
      {
         var baseName:String = this.programBaseName;
         var variantName:uint = this.programVariantName;
         var nameCache:Dictionary = sProgramNameCache[baseName];
         if(nameCache == null)
         {
            nameCache = new Dictionary();
            sProgramNameCache[baseName] = nameCache;
         }
         var name:String = nameCache[variantName];
         if(name == null)
         {
            if(variantName)
            {
               name = baseName + "#" + variantName.toString(16);
            }
            else
            {
               name = baseName;
            }
            nameCache[variantName] = name;
         }
         return name;
      }
      
      protected function get program() : Program
      {
         var name:String = this.programName;
         var painter:Painter = Starling.painter;
         var program:Program = painter.getProgram(name);
         if(program == null)
         {
            program = this.createProgram();
            painter.registerProgram(name,program);
         }
         return program;
      }
      
      public function get onRestore() : Function
      {
         return this._onRestore;
      }
      
      public function set onRestore(value:Function) : void
      {
         this._onRestore = value;
      }
      
      public function get vertexFormat() : VertexDataFormat
      {
         return VERTEX_FORMAT;
      }
      
      public function get mvpMatrix3D() : Matrix3D
      {
         return this._mvpMatrix3D;
      }
      
      public function set mvpMatrix3D(value:Matrix3D) : void
      {
         this._mvpMatrix3D.copyFrom(value);
      }
      
      protected function get indexBuffer() : IndexBuffer3D
      {
         return this._indexBuffer;
      }
      
      protected function get indexBufferSize() : int
      {
         return this._indexBufferSize;
      }
      
      protected function get vertexBuffer() : VertexBuffer3D
      {
         return this._vertexBuffer;
      }
      
      protected function get vertexBufferSize() : int
      {
         return this._vertexBufferSize;
      }
   }
}

