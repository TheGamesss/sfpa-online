package starling.rendering
{
   import starling.utils.*;
   
   public class BatchToken
   {
      
      public var batchID:int;
      
      public var vertexID:int;
      
      public var indexID:int;
      
      public function BatchToken(batchID:int = 0, vertexID:int = 0, indexID:int = 0)
      {
         super();
         this.setTo(batchID,vertexID,indexID);
      }
      
      public function copyFrom(token:BatchToken) : void
      {
         this.batchID = token.batchID;
         this.vertexID = token.vertexID;
         this.indexID = token.indexID;
      }
      
      public function setTo(batchID:int = 0, vertexID:int = 0, indexID:int = 0) : void
      {
         this.batchID = batchID;
         this.vertexID = vertexID;
         this.indexID = indexID;
      }
      
      public function reset() : void
      {
         this.batchID = this.vertexID = this.indexID = 0;
      }
      
      public function equals(other:BatchToken) : Boolean
      {
         return this.batchID == other.batchID && this.vertexID == other.vertexID && this.indexID == other.indexID;
      }
      
      public function toString() : String
      {
         return StringUtil.format("[BatchToken batchID={0} vertexID={1} indexID={2}]",this.batchID,this.vertexID,this.indexID);
      }
   }
}

