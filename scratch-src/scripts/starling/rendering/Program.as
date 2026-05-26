package starling.rendering
{
   import com.adobe.utils.*;
   import flash.display3D.*;
   import flash.events.*;
   import flash.utils.ByteArray;
   import starling.core.*;
   import starling.errors.*;
   
   public class Program
   {
      
      private static var sAssembler:AGALMiniAssembler = new AGALMiniAssembler();
      
      private var _vertexShader:ByteArray;
      
      private var _fragmentShader:ByteArray;
      
      private var _program3D:Program3D;
      
      public function Program(vertexShader:ByteArray, fragmentShader:ByteArray)
      {
         super();
         this._vertexShader = vertexShader;
         this._fragmentShader = fragmentShader;
         Starling.current.stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated,false,30,true);
      }
      
      public static function fromSource(vertexShader:String, fragmentShader:String, agalVersion:uint = 1) : Program
      {
         return new Program(sAssembler.assemble(Context3DProgramType.VERTEX,vertexShader,agalVersion),sAssembler.assemble(Context3DProgramType.FRAGMENT,fragmentShader,agalVersion));
      }
      
      public function dispose() : void
      {
         Starling.current.stage3D.removeEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated);
         this.disposeProgram();
      }
      
      public function activate(context:Context3D = null) : void
      {
         if(context == null)
         {
            context = Starling.context;
            if(context == null)
            {
               throw new MissingContextError();
            }
         }
         if(this._program3D == null)
         {
            this._program3D = context.createProgram();
            this._program3D.upload(this._vertexShader,this._fragmentShader);
         }
         context.setProgram(this._program3D);
      }
      
      private function onContextCreated(event:Event) : void
      {
         this.disposeProgram();
      }
      
      private function disposeProgram() : void
      {
         if(this._program3D)
         {
            this._program3D.dispose();
            this._program3D = null;
         }
      }
   }
}

