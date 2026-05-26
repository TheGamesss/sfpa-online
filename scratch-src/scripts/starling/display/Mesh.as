package starling.display
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.starling_internal;
   import starling.geom.Polygon;
   import starling.rendering.*;
   import starling.styles.*;
   import starling.textures.Texture;
   import starling.utils.*;
   
   use namespace starling_internal;
   
   public class Mesh extends DisplayObject
   {
      
      private static var sDefaultStyle:Class = MeshStyle;
      
      private static var sDefaultStyleFactory:Function = null;
      
      internal var _style:MeshStyle;
      
      internal var _vertexData:VertexData;
      
      internal var _indexData:IndexData;
      
      internal var _pixelSnapping:Boolean;
      
      public function Mesh(vertexData:VertexData, indexData:IndexData, style:MeshStyle = null)
      {
         super();
         if(vertexData == null)
         {
            throw new ArgumentError("VertexData must not be null");
         }
         if(indexData == null)
         {
            throw new ArgumentError("IndexData must not be null");
         }
         this._vertexData = vertexData;
         this._indexData = indexData;
         this.setStyle(style,false);
      }
      
      public static function get defaultStyle() : Class
      {
         return sDefaultStyle;
      }
      
      public static function set defaultStyle(value:Class) : void
      {
         sDefaultStyle = value;
      }
      
      public static function get defaultStyleFactory() : Function
      {
         return sDefaultStyleFactory;
      }
      
      public static function set defaultStyleFactory(value:Function) : void
      {
         sDefaultStyleFactory = value;
      }
      
      public static function fromPolygon(polygon:Polygon, style:MeshStyle = null) : Mesh
      {
         var vertexData:VertexData = new VertexData(null,polygon.numVertices);
         var indexData:IndexData = new IndexData(polygon.numTriangles);
         polygon.copyToVertexData(vertexData);
         polygon.triangulate(indexData);
         return new Mesh(vertexData,indexData,style);
      }
      
      override public function dispose() : void
      {
         this._vertexData.clear();
         this._indexData.clear();
         super.dispose();
      }
      
      override public function hitTest(localPoint:Point) : DisplayObject
      {
         if(!visible || !touchable || !hitTestMask(localPoint))
         {
            return null;
         }
         return MeshUtil.containsPoint(this._vertexData,this._indexData,localPoint) ? this : null;
      }
      
      override public function getBounds(targetSpace:DisplayObject, out:Rectangle = null) : Rectangle
      {
         return MeshUtil.calculateBounds(this._vertexData,this,targetSpace,out);
      }
      
      override public function render(painter:Painter) : void
      {
         if(this._pixelSnapping)
         {
            MatrixUtil.snapToPixels(painter.state.modelviewMatrix,painter.pixelSize);
         }
         painter.batchMesh(this);
      }
      
      public function setStyle(meshStyle:MeshStyle = null, mergeWithPredecessor:Boolean = true) : void
      {
         if(meshStyle == null)
         {
            meshStyle = this.createDefaultMeshStyle();
         }
         else
         {
            if(meshStyle == this._style)
            {
               return;
            }
            if(meshStyle.target)
            {
               meshStyle.target.setStyle();
            }
         }
         if(this._style)
         {
            if(mergeWithPredecessor)
            {
               meshStyle.copyFrom(this._style);
            }
            this._style.setTarget();
         }
         this._style = meshStyle;
         this._style.setTarget(this,this._vertexData,this._indexData);
         setRequiresRedraw();
      }
      
      private function createDefaultMeshStyle() : MeshStyle
      {
         var meshStyle:MeshStyle = null;
         if(sDefaultStyleFactory != null)
         {
            if(sDefaultStyleFactory.length == 0)
            {
               meshStyle = sDefaultStyleFactory();
            }
            else
            {
               meshStyle = sDefaultStyleFactory(this);
            }
         }
         if(meshStyle == null)
         {
            meshStyle = new sDefaultStyle() as MeshStyle;
         }
         return meshStyle;
      }
      
      public function setVertexDataChanged() : void
      {
         setRequiresRedraw();
      }
      
      public function setIndexDataChanged() : void
      {
         setRequiresRedraw();
      }
      
      public function getVertexPosition(vertexID:int, out:Point = null) : Point
      {
         return this._style.getVertexPosition(vertexID,out);
      }
      
      public function setVertexPosition(vertexID:int, x:Number, y:Number) : void
      {
         this._style.setVertexPosition(vertexID,x,y);
      }
      
      public function getVertexAlpha(vertexID:int) : Number
      {
         return this._style.getVertexAlpha(vertexID);
      }
      
      public function setVertexAlpha(vertexID:int, alpha:Number) : void
      {
         this._style.setVertexAlpha(vertexID,alpha);
      }
      
      public function getVertexColor(vertexID:int) : uint
      {
         return this._style.getVertexColor(vertexID);
      }
      
      public function setVertexColor(vertexID:int, color:uint) : void
      {
         this._style.setVertexColor(vertexID,color);
      }
      
      public function getTexCoords(vertexID:int, out:Point = null) : Point
      {
         return this._style.getTexCoords(vertexID,out);
      }
      
      public function setTexCoords(vertexID:int, u:Number, v:Number) : void
      {
         this._style.setTexCoords(vertexID,u,v);
      }
      
      protected function get vertexData() : VertexData
      {
         return this._vertexData;
      }
      
      protected function get indexData() : IndexData
      {
         return this._indexData;
      }
      
      public function get style() : MeshStyle
      {
         return this._style;
      }
      
      public function set style(value:MeshStyle) : void
      {
         this.setStyle(value);
      }
      
      public function get texture() : Texture
      {
         return this._style.texture;
      }
      
      public function set texture(value:Texture) : void
      {
         this._style.texture = value;
      }
      
      public function get color() : uint
      {
         return this._style.color;
      }
      
      public function set color(value:uint) : void
      {
         this._style.color = value;
      }
      
      public function get textureSmoothing() : String
      {
         return this._style.textureSmoothing;
      }
      
      public function set textureSmoothing(value:String) : void
      {
         this._style.textureSmoothing = value;
      }
      
      public function get textureRepeat() : Boolean
      {
         return this._style.textureRepeat;
      }
      
      public function set textureRepeat(value:Boolean) : void
      {
         this._style.textureRepeat = value;
      }
      
      public function get pixelSnapping() : Boolean
      {
         return this._pixelSnapping;
      }
      
      public function set pixelSnapping(value:Boolean) : void
      {
         this._pixelSnapping = value;
      }
      
      public function get numVertices() : int
      {
         return this._vertexData.numVertices;
      }
      
      public function get numIndices() : int
      {
         return this._indexData.numIndices;
      }
      
      public function get numTriangles() : int
      {
         return this._indexData.numTriangles;
      }
      
      public function get vertexFormat() : VertexDataFormat
      {
         return this._style.vertexFormat;
      }
   }
}

