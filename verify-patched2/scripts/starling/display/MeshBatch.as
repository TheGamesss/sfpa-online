package starling.display
{
   import flash.geom.Matrix;
   import starling.rendering.*;
   import starling.styles.*;
   import starling.utils.*;
   
   public class MeshBatch extends Mesh
   {
      
      public static const MAX_NUM_VERTICES:int = 65535;
      
      private static var sFullMeshSubset:MeshSubset = new MeshSubset();
      
      private var _effect:MeshEffect;
      
      private var _batchable:Boolean;
      
      private var _vertexSyncRequired:Boolean;
      
      private var _indexSyncRequired:Boolean;
      
      public function MeshBatch()
      {
         var vertexData:VertexData = new VertexData();
         var indexData:IndexData = new IndexData();
         super(vertexData,indexData);
      }
      
      override public function dispose() : void
      {
         if(this._effect)
         {
            this._effect.dispose();
         }
         super.dispose();
      }
      
      override public function setVertexDataChanged() : void
      {
         this._vertexSyncRequired = true;
         super.setVertexDataChanged();
      }
      
      override public function setIndexDataChanged() : void
      {
         this._indexSyncRequired = true;
         super.setIndexDataChanged();
      }
      
      private function setVertexAndIndexDataChanged() : void
      {
         this._vertexSyncRequired = this._indexSyncRequired = true;
      }
      
      private function syncVertexBuffer() : void
      {
         this._effect.uploadVertexData(_vertexData);
         this._vertexSyncRequired = false;
      }
      
      private function syncIndexBuffer() : void
      {
         this._effect.uploadIndexData(_indexData);
         this._indexSyncRequired = false;
      }
      
      public function clear() : void
      {
         if(_parent)
         {
            setRequiresRedraw();
         }
         _vertexData.numVertices = 0;
         _indexData.numIndices = 0;
         this._vertexSyncRequired = true;
         this._indexSyncRequired = true;
      }
      
      public function addMesh(mesh:Mesh, matrix:Matrix = null, alpha:Number = 1, subset:MeshSubset = null, ignoreTransformations:Boolean = false) : void
      {
         if(ignoreTransformations)
         {
            matrix = null;
         }
         else if(matrix == null)
         {
            matrix = mesh.transformationMatrix;
         }
         if(subset == null)
         {
            subset = sFullMeshSubset;
         }
         var targetVertexID:int = _vertexData.numVertices;
         var targetIndexID:int = _indexData.numIndices;
         var meshStyle:MeshStyle = mesh._style;
         if(targetVertexID == 0)
         {
            this.setupFor(mesh);
         }
         meshStyle.batchVertexData(_style,targetVertexID,matrix,subset.vertexID,subset.numVertices);
         meshStyle.batchIndexData(_style,targetIndexID,targetVertexID - subset.vertexID,subset.indexID,subset.numIndices);
         if(alpha != 1)
         {
            _vertexData.scaleAlphas("color",alpha,targetVertexID,subset.numVertices);
         }
         if(_parent)
         {
            setRequiresRedraw();
         }
         this._indexSyncRequired = this._vertexSyncRequired = true;
      }
      
      public function addMeshAt(mesh:Mesh, indexID:int, vertexID:int) : void
      {
         var numIndices:int = mesh.numIndices;
         var numVertices:int = mesh.numVertices;
         var matrix:Matrix = mesh.transformationMatrix;
         var meshStyle:MeshStyle = mesh._style;
         if(_vertexData.numVertices == 0)
         {
            this.setupFor(mesh);
         }
         meshStyle.batchVertexData(_style,vertexID,matrix,0,numVertices);
         meshStyle.batchIndexData(_style,indexID,vertexID,0,numIndices);
         if(alpha != 1)
         {
            _vertexData.scaleAlphas("color",alpha,vertexID,numVertices);
         }
         if(_parent)
         {
            setRequiresRedraw();
         }
         this._indexSyncRequired = this._vertexSyncRequired = true;
      }
      
      private function setupFor(mesh:Mesh) : void
      {
         var newStyle:MeshStyle = null;
         var meshStyle:MeshStyle = mesh._style;
         var meshStyleType:Class = meshStyle.type;
         if(_style.type != meshStyleType)
         {
            newStyle = new meshStyleType() as MeshStyle;
            newStyle.copyFrom(meshStyle);
            this.setStyle(newStyle,false);
         }
         else
         {
            _style.copyFrom(meshStyle);
         }
      }
      
      public function canAddMesh(mesh:Mesh, numVertices:int = -1) : Boolean
      {
         var currentNumVertices:int = _vertexData.numVertices;
         if(currentNumVertices == 0)
         {
            return true;
         }
         if(numVertices < 0)
         {
            numVertices = mesh.numVertices;
         }
         if(numVertices == 0)
         {
            return true;
         }
         if(numVertices + currentNumVertices > MAX_NUM_VERTICES)
         {
            return false;
         }
         return _style.canBatchWith(mesh._style);
      }
      
      override public function render(painter:Painter) : void
      {
         if(_vertexData.numVertices == 0)
         {
            return;
         }
         if(_pixelSnapping)
         {
            MatrixUtil.snapToPixels(painter.state.modelviewMatrix,painter.pixelSize);
         }
         if(this._batchable)
         {
            painter.batchMesh(this);
         }
         else
         {
            painter.finishMeshBatch();
            painter.drawCount += 1;
            painter.prepareToDraw();
            painter.excludeFromCache(this);
            if(this._vertexSyncRequired)
            {
               this.syncVertexBuffer();
            }
            if(this._indexSyncRequired)
            {
               this.syncIndexBuffer();
            }
            _style.updateEffect(this._effect,painter.state);
            this._effect.render(0,_indexData.numTriangles);
         }
      }
      
      override public function setStyle(meshStyle:MeshStyle = null, mergeWithPredecessor:Boolean = true) : void
      {
         super.setStyle(meshStyle,mergeWithPredecessor);
         if(this._effect)
         {
            this._effect.dispose();
         }
         this._effect = style.createEffect();
         this._effect.onRestore = this.setVertexAndIndexDataChanged;
         this.setVertexAndIndexDataChanged();
      }
      
      public function set numVertices(value:int) : void
      {
         if(_vertexData.numVertices != value)
         {
            _vertexData.numVertices = value;
            this._vertexSyncRequired = true;
            setRequiresRedraw();
         }
      }
      
      public function set numIndices(value:int) : void
      {
         if(_indexData.numIndices != value)
         {
            _indexData.numIndices = value;
            this._indexSyncRequired = true;
            setRequiresRedraw();
         }
      }
      
      public function get batchable() : Boolean
      {
         return this._batchable;
      }
      
      public function set batchable(value:Boolean) : void
      {
         if(this._batchable != value)
         {
            this._batchable = value;
            setRequiresRedraw();
         }
      }
   }
}

