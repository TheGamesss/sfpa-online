package starling.styles
{
   import flash.geom.*;
   import starling.core.starling_internal;
   import starling.display.Mesh;
   import starling.events.*;
   import starling.rendering.*;
   import starling.textures.*;
   
   use namespace starling_internal;
   
   public class MeshStyle extends EventDispatcher
   {
      
      public static const VERTEX_FORMAT:VertexDataFormat = MeshEffect.VERTEX_FORMAT;
      
      private static var sPoint:Point = new Point();
      
      private var _type:Class;
      
      private var _target:Mesh;
      
      private var _texture:Texture;
      
      private var _textureSmoothing:String;
      
      private var _textureRepeat:Boolean;
      
      private var _textureRoot:ConcreteTexture;
      
      private var _vertexData:VertexData;
      
      private var _indexData:IndexData;
      
      public function MeshStyle()
      {
         super();
         this._textureSmoothing = TextureSmoothing.BILINEAR;
         this._type = Object(this).constructor as Class;
      }
      
      public function copyFrom(meshStyle:MeshStyle) : void
      {
         this._texture = meshStyle._texture;
         this._textureRoot = meshStyle._textureRoot;
         this._textureRepeat = meshStyle._textureRepeat;
         this._textureSmoothing = meshStyle._textureSmoothing;
      }
      
      public function clone() : MeshStyle
      {
         var clone:MeshStyle = new this._type();
         clone.copyFrom(this);
         return clone;
      }
      
      public function createEffect() : MeshEffect
      {
         return new MeshEffect();
      }
      
      public function updateEffect(effect:MeshEffect, state:RenderState) : void
      {
         effect.texture = this._texture;
         effect.textureRepeat = this._textureRepeat;
         effect.textureSmoothing = this._textureSmoothing;
         effect.mvpMatrix3D = state.mvpMatrix3D;
         effect.alpha = state.alpha;
         effect.tinted = this._vertexData.tinted;
      }
      
      public function canBatchWith(meshStyle:MeshStyle) : Boolean
      {
         var newTexture:Texture = null;
         if(this._type == meshStyle._type)
         {
            newTexture = meshStyle._texture;
            if(this._texture == null && newTexture == null)
            {
               return true;
            }
            if(Boolean(this._texture) && Boolean(newTexture))
            {
               return this._textureRoot == meshStyle._textureRoot && this._textureSmoothing == meshStyle._textureSmoothing && this._textureRepeat == meshStyle._textureRepeat;
            }
            return false;
         }
         return false;
      }
      
      public function batchVertexData(targetStyle:MeshStyle, targetVertexID:int = 0, matrix:Matrix = null, vertexID:int = 0, numVertices:int = -1) : void
      {
         this._vertexData.copyTo(targetStyle._vertexData,targetVertexID,matrix,vertexID,numVertices);
      }
      
      public function batchIndexData(targetStyle:MeshStyle, targetIndexID:int = 0, offset:int = 0, indexID:int = 0, numIndices:int = -1) : void
      {
         this._indexData.copyTo(targetStyle._indexData,targetIndexID,offset,indexID,numIndices);
      }
      
      protected function setRequiresRedraw() : void
      {
         if(this._target)
         {
            this._target.setRequiresRedraw();
         }
      }
      
      protected function setVertexDataChanged() : void
      {
         if(this._target)
         {
            this._target.setVertexDataChanged();
         }
      }
      
      protected function setIndexDataChanged() : void
      {
         if(this._target)
         {
            this._target.setIndexDataChanged();
         }
      }
      
      protected function onTargetAssigned(target:Mesh) : void
      {
      }
      
      override public function addEventListener(type:String, listener:Function) : void
      {
         if(type == Event.ENTER_FRAME && Boolean(this._target))
         {
            this._target.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         super.addEventListener(type,listener);
      }
      
      override public function removeEventListener(type:String, listener:Function) : void
      {
         if(type == Event.ENTER_FRAME && Boolean(this._target))
         {
            this._target.removeEventListener(type,this.onEnterFrame);
         }
         super.removeEventListener(type,listener);
      }
      
      private function onEnterFrame(event:Event) : void
      {
         dispatchEvent(event);
      }
      
      starling_internal function setTarget(target:Mesh = null, vertexData:VertexData = null, indexData:IndexData = null) : void
      {
         if(this._target != target)
         {
            if(this._target)
            {
               this._target.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            }
            if(vertexData)
            {
               vertexData.format = this.vertexFormat;
            }
            this._target = target;
            this._vertexData = vertexData;
            this._indexData = indexData;
            if(target)
            {
               if(hasEventListener(Event.ENTER_FRAME))
               {
                  target.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               }
               this.onTargetAssigned(target);
            }
         }
      }
      
      public function getVertexPosition(vertexID:int, out:Point = null) : Point
      {
         return this._vertexData.getPoint(vertexID,"position",out);
      }
      
      public function setVertexPosition(vertexID:int, x:Number, y:Number) : void
      {
         this._vertexData.setPoint(vertexID,"position",x,y);
         this.setVertexDataChanged();
      }
      
      public function getVertexAlpha(vertexID:int) : Number
      {
         return this._vertexData.getAlpha(vertexID);
      }
      
      public function setVertexAlpha(vertexID:int, alpha:Number) : void
      {
         this._vertexData.setAlpha(vertexID,"color",alpha);
         this.setVertexDataChanged();
      }
      
      public function getVertexColor(vertexID:int) : uint
      {
         return this._vertexData.getColor(vertexID);
      }
      
      public function setVertexColor(vertexID:int, color:uint) : void
      {
         this._vertexData.setColor(vertexID,"color",color);
         this.setVertexDataChanged();
      }
      
      public function getTexCoords(vertexID:int, out:Point = null) : Point
      {
         if(this._texture)
         {
            return this._texture.getTexCoords(this._vertexData,vertexID,"texCoords",out);
         }
         return this._vertexData.getPoint(vertexID,"texCoords",out);
      }
      
      public function setTexCoords(vertexID:int, u:Number, v:Number) : void
      {
         if(this._texture)
         {
            this._texture.setTexCoords(this._vertexData,vertexID,"texCoords",u,v);
         }
         else
         {
            this._vertexData.setPoint(vertexID,"texCoords",u,v);
         }
         this.setVertexDataChanged();
      }
      
      protected function get vertexData() : VertexData
      {
         return this._vertexData;
      }
      
      protected function get indexData() : IndexData
      {
         return this._indexData;
      }
      
      public function get type() : Class
      {
         return this._type;
      }
      
      public function get color() : uint
      {
         if(this._vertexData.numVertices > 0)
         {
            return this._vertexData.getColor(0);
         }
         return 0;
      }
      
      public function set color(value:uint) : void
      {
         var i:int = 0;
         var numVertices:int = int(this._vertexData.numVertices);
         for(i = 0; i < numVertices; i++)
         {
            this._vertexData.setColor(i,"color",value);
         }
         if(value == 16777215 && Boolean(this._vertexData.tinted))
         {
            this._vertexData.updateTinted();
         }
         this.setVertexDataChanged();
      }
      
      public function get vertexFormat() : VertexDataFormat
      {
         return VERTEX_FORMAT;
      }
      
      public function get texture() : Texture
      {
         return this._texture;
      }
      
      public function set texture(value:Texture) : void
      {
         var i:int = 0;
         var numVertices:int = 0;
         if(value != this._texture)
         {
            if(value)
            {
               numVertices = this._vertexData ? int(this._vertexData.numVertices) : 0;
               for(i = 0; i < numVertices; i++)
               {
                  this.getTexCoords(i,sPoint);
                  value.setTexCoords(this._vertexData,i,"texCoords",sPoint.x,sPoint.y);
               }
               this.setVertexDataChanged();
            }
            else
            {
               this.setRequiresRedraw();
            }
            this._texture = value;
            this._textureRoot = value ? value.root : null;
         }
      }
      
      public function get textureSmoothing() : String
      {
         return this._textureSmoothing;
      }
      
      public function set textureSmoothing(value:String) : void
      {
         if(value != this._textureSmoothing)
         {
            this._textureSmoothing = value;
            this.setRequiresRedraw();
         }
      }
      
      public function get textureRepeat() : Boolean
      {
         return this._textureRepeat;
      }
      
      public function set textureRepeat(value:Boolean) : void
      {
         this._textureRepeat = value;
      }
      
      public function get target() : Mesh
      {
         return this._target;
      }
   }
}

