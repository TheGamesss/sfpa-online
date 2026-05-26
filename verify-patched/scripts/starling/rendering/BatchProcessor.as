package starling.rendering
{
   import flash.geom.Matrix;
   import starling.display.*;
   import starling.utils.*;
   
   internal class BatchProcessor
   {
      
      private static var sMeshSubset:MeshSubset = new MeshSubset();
      
      private var _batches:Vector.<MeshBatch>;
      
      private var _batchPool:BatchPool;
      
      private var _currentBatch:MeshBatch;
      
      private var _currentStyleType:Class;
      
      private var _onBatchComplete:Function;
      
      private var _cacheToken:BatchToken;
      
      public function BatchProcessor()
      {
         super();
         this._batches = new Vector.<MeshBatch>(0);
         this._batchPool = new BatchPool();
         this._cacheToken = new BatchToken();
      }
      
      public function dispose() : void
      {
         var batch:MeshBatch = null;
         for each(batch in this._batches)
         {
            batch.dispose();
         }
         this._batches.length = 0;
         this._batchPool.purge();
         this._currentBatch = null;
         this._onBatchComplete = null;
      }
      
      public function addMesh(mesh:Mesh, state:RenderState, subset:MeshSubset = null, ignoreTransformations:Boolean = false) : void
      {
         var matrix:Matrix = null;
         var alpha:Number = NaN;
         if(subset == null)
         {
            subset = sMeshSubset;
            subset.vertexID = subset.indexID = 0;
            subset.numVertices = mesh.numVertices;
            subset.numIndices = mesh.numIndices;
         }
         else
         {
            if(subset.numVertices < 0)
            {
               subset.numVertices = mesh.numVertices - subset.vertexID;
            }
            if(subset.numIndices < 0)
            {
               subset.numIndices = mesh.numIndices - subset.indexID;
            }
         }
         if(subset.numVertices > 0)
         {
            if(this._currentBatch == null || !this._currentBatch.canAddMesh(mesh,subset.numVertices))
            {
               this.finishBatch();
               this._currentStyleType = mesh.style.type;
               this._currentBatch = this._batchPool.get(this._currentStyleType);
               this._currentBatch.blendMode = state ? state.blendMode : mesh.blendMode;
               this._cacheToken.setTo(this._batches.length);
               this._batches[this._batches.length] = this._currentBatch;
            }
            matrix = state ? state._modelviewMatrix : null;
            alpha = state ? state._alpha : 1;
            this._currentBatch.addMesh(mesh,matrix,alpha,subset,ignoreTransformations);
            this._cacheToken.vertexID += subset.numVertices;
            this._cacheToken.indexID += subset.numIndices;
         }
      }
      
      public function finishBatch() : void
      {
         var meshBatch:MeshBatch = this._currentBatch;
         if(meshBatch)
         {
            this._currentBatch = null;
            this._currentStyleType = null;
            if(this._onBatchComplete != null)
            {
               this._onBatchComplete(meshBatch);
            }
         }
      }
      
      public function clear() : void
      {
         var numBatches:int = int(this._batches.length);
         for(var i:int = 0; i < numBatches; i++)
         {
            this._batchPool.put(this._batches[i]);
         }
         this._batches.length = 0;
         this._currentBatch = null;
         this._currentStyleType = null;
         this._cacheToken.reset();
      }
      
      public function getBatchAt(batchID:int) : MeshBatch
      {
         return this._batches[batchID];
      }
      
      public function trim() : void
      {
         this._batchPool.purge();
      }
      
      public function fillToken(token:BatchToken) : BatchToken
      {
         token.batchID = this._cacheToken.batchID;
         token.vertexID = this._cacheToken.vertexID;
         token.indexID = this._cacheToken.indexID;
         return token;
      }
      
      public function get numBatches() : int
      {
         return this._batches.length;
      }
      
      public function get onBatchComplete() : Function
      {
         return this._onBatchComplete;
      }
      
      public function set onBatchComplete(value:Function) : void
      {
         this._onBatchComplete = value;
      }
   }
}

import flash.utils.*;
import starling.display.*;

class BatchPool
{
   
   private var _batchLists:Dictionary;
   
   public function BatchPool()
   {
      super();
      this._batchLists = new Dictionary();
   }
   
   public function purge() : void
   {
      var batchList:Array = null;
      var i:int = 0;
      for each(batchList in this._batchLists)
      {
         for(i = 0; i < batchList.length; i++)
         {
            batchList[i].dispose();
         }
         batchList.length = 0;
      }
   }
   
   public function get(styleType:Class) : MeshBatch
   {
      var batchList:Array = this._batchLists[styleType];
      if(batchList == null)
      {
         batchList = [];
         this._batchLists[styleType] = batchList;
      }
      if(batchList.length > 0)
      {
         return batchList.pop();
      }
      return new MeshBatch();
   }
   
   public function put(meshBatch:MeshBatch) : void
   {
      var styleType:Class = meshBatch.style.type;
      var batchList:Array = this._batchLists[styleType];
      if(batchList == null)
      {
         batchList = [];
         this._batchLists[styleType] = batchList;
      }
      meshBatch.clear();
      batchList[batchList.length] = meshBatch;
   }
}
