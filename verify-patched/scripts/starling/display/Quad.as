package starling.display
{
   import flash.geom.*;
   import starling.rendering.*;
   import starling.styles.*;
   import starling.textures.Texture;
   import starling.utils.*;
   
   public class Quad extends Mesh
   {
      
      private static var sPoint3D:Vector3D = new Vector3D();
      
      private static var sMatrix:Matrix = new Matrix();
      
      private static var sMatrix3D:Matrix3D = new Matrix3D();
      
      private var _bounds:Rectangle;
      
      public function Quad(width:Number, height:Number, color:uint = 16777215)
      {
         this._bounds = new Rectangle(0,0,width,height);
         var vertexData:VertexData = new VertexData(MeshStyle.VERTEX_FORMAT,4);
         var indexData:IndexData = new IndexData(6);
         super(vertexData,indexData);
         if(width == 0 || height == 0)
         {
            throw new ArgumentError("Invalid size: width and height must not be zero");
         }
         this.setupVertices();
         this.color = color;
      }
      
      public static function fromTexture(texture:Texture) : Quad
      {
         var quad:Quad = new Quad(100,100);
         quad.texture = texture;
         quad.readjustSize();
         return quad;
      }
      
      protected function setupVertices() : void
      {
         var posAttr:String = "position";
         var texAttr:String = "texCoords";
         var texture:Texture = style.texture;
         var vertexData:VertexData = this.vertexData;
         var indexData:IndexData = this.indexData;
         indexData.numIndices = 0;
         indexData.addQuad(0,1,2,3);
         if(vertexData.numVertices != 4)
         {
            vertexData.numVertices = 4;
            vertexData.trim();
         }
         if(texture)
         {
            texture.setupVertexPositions(vertexData,0,"position",this._bounds);
            texture.setupTextureCoordinates(vertexData,0,texAttr);
         }
         else
         {
            vertexData.setPoint(0,posAttr,this._bounds.left,this._bounds.top);
            vertexData.setPoint(1,posAttr,this._bounds.right,this._bounds.top);
            vertexData.setPoint(2,posAttr,this._bounds.left,this._bounds.bottom);
            vertexData.setPoint(3,posAttr,this._bounds.right,this._bounds.bottom);
            vertexData.setPoint(0,texAttr,0,0);
            vertexData.setPoint(1,texAttr,1,0);
            vertexData.setPoint(2,texAttr,0,1);
            vertexData.setPoint(3,texAttr,1,1);
         }
         setRequiresRedraw();
      }
      
      override public function getBounds(targetSpace:DisplayObject, out:Rectangle = null) : Rectangle
      {
         var scaleX:Number = NaN;
         var scaleY:Number = NaN;
         if(out == null)
         {
            out = new Rectangle();
         }
         if(targetSpace == this)
         {
            out.copyFrom(this._bounds);
         }
         else if(targetSpace == parent && !isRotated)
         {
            scaleX = this.scaleX;
            scaleY = this.scaleY;
            out.setTo(x - pivotX * scaleX,y - pivotY * scaleY,this._bounds.width * scaleX,this._bounds.height * scaleY);
            if(scaleX < 0)
            {
               out.width *= -1;
               out.x -= out.width;
            }
            if(scaleY < 0)
            {
               out.height *= -1;
               out.y -= out.height;
            }
         }
         else if(is3D && Boolean(stage))
         {
            stage.getCameraPosition(targetSpace,sPoint3D);
            getTransformationMatrix3D(targetSpace,sMatrix3D);
            RectangleUtil.getBoundsProjected(this._bounds,sMatrix3D,sPoint3D,out);
         }
         else
         {
            getTransformationMatrix(targetSpace,sMatrix);
            RectangleUtil.getBounds(this._bounds,sMatrix,out);
         }
         return out;
      }
      
      override public function hitTest(localPoint:Point) : DisplayObject
      {
         if(!visible || !touchable || !hitTestMask(localPoint))
         {
            return null;
         }
         if(this._bounds.containsPoint(localPoint))
         {
            return this;
         }
         return null;
      }
      
      public function readjustSize(width:Number = -1, height:Number = -1) : void
      {
         if(width <= 0)
         {
            width = texture ? texture.frameWidth : Number(this._bounds.width);
         }
         if(height <= 0)
         {
            height = texture ? texture.frameHeight : Number(this._bounds.height);
         }
         if(width != this._bounds.width || height != this._bounds.height)
         {
            this._bounds.setTo(0,0,width,height);
            this.setupVertices();
         }
      }
      
      override public function set texture(value:Texture) : void
      {
         if(value != texture)
         {
            super.texture = value;
            this.setupVertices();
         }
      }
   }
}

