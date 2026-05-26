package starling.display
{
   import flash.geom.*;
   import flash.utils.*;
   import starling.rendering.IndexData;
   import starling.rendering.VertexData;
   import starling.textures.Texture;
   import starling.utils.*;
   
   public class Image extends Quad
   {
      
      private static var sSetupFunctions:Dictionary = new Dictionary(true);
      
      private static var sPadding:Padding = new Padding();
      
      private static var sBounds:Rectangle = new Rectangle();
      
      private static var sBasCols:Vector.<Number> = new Vector.<Number>(3,true);
      
      private static var sBasRows:Vector.<Number> = new Vector.<Number>(3,true);
      
      private static var sPosCols:Vector.<Number> = new Vector.<Number>(3,true);
      
      private static var sPosRows:Vector.<Number> = new Vector.<Number>(3,true);
      
      private static var sTexCols:Vector.<Number> = new Vector.<Number>(3,true);
      
      private static var sTexRows:Vector.<Number> = new Vector.<Number>(3,true);
      
      private var _scale9Grid:Rectangle;
      
      private var _tileGrid:Rectangle;
      
      public function Image(texture:Texture)
      {
         super(100,100);
         this.texture = texture;
         readjustSize();
      }
      
      public static function automateSetupForTexture(texture:Texture, onAssign:Function, onRelease:Function = null) : void
      {
         if(texture == null)
         {
            return;
         }
         if(onAssign == null && onRelease == null)
         {
            delete sSetupFunctions[texture];
         }
         else
         {
            sSetupFunctions[texture] = [onAssign,onRelease];
         }
      }
      
      public static function resetSetupForTexture(texture:Texture) : void
      {
         automateSetupForTexture(texture,null,null);
      }
      
      public static function bindScale9GridToTexture(texture:Texture, scale9Grid:Rectangle) : void
      {
         automateSetupForTexture(texture,function(image:Image):void
         {
            image.scale9Grid = scale9Grid;
         },function(image:Image):void
         {
            image.scale9Grid = null;
         });
      }
      
      public static function bindPivotPointToTexture(texture:Texture, pivotX:Number, pivotY:Number) : void
      {
         automateSetupForTexture(texture,function(image:Image):void
         {
            image.pivotX = pivotX;
            image.pivotY = pivotY;
         },function(image:Image):void
         {
            image.pivotX = image.pivotY = 0;
         });
      }
      
      public function get scale9Grid() : Rectangle
      {
         return this._scale9Grid;
      }
      
      public function set scale9Grid(value:Rectangle) : void
      {
         if(value)
         {
            if(this._scale9Grid == null)
            {
               this._scale9Grid = value.clone();
            }
            else
            {
               this._scale9Grid.copyFrom(value);
            }
            readjustSize();
            this._tileGrid = null;
         }
         else
         {
            this._scale9Grid = null;
         }
         this.setupVertices();
      }
      
      public function get tileGrid() : Rectangle
      {
         return this._tileGrid;
      }
      
      public function set tileGrid(value:Rectangle) : void
      {
         if(value)
         {
            if(this._tileGrid == null)
            {
               this._tileGrid = value.clone();
            }
            else
            {
               this._tileGrid.copyFrom(value);
            }
            this._scale9Grid = null;
         }
         else
         {
            this._tileGrid = null;
         }
         this.setupVertices();
      }
      
      override protected function setupVertices() : void
      {
         if(Boolean(texture) && Boolean(this._scale9Grid))
         {
            this.setupScale9Grid();
         }
         else if(Boolean(texture) && Boolean(this._tileGrid))
         {
            this.setupTileGrid();
         }
         else
         {
            super.setupVertices();
         }
      }
      
      override public function set scaleX(value:Number) : void
      {
         super.scaleX = value;
         if(Boolean(texture) && (Boolean(this._scale9Grid) || Boolean(this._tileGrid)))
         {
            this.setupVertices();
         }
      }
      
      override public function set scaleY(value:Number) : void
      {
         super.scaleY = value;
         if(Boolean(texture) && (Boolean(this._scale9Grid) || Boolean(this._tileGrid)))
         {
            this.setupVertices();
         }
      }
      
      override public function set texture(value:Texture) : void
      {
         if(value != texture)
         {
            if(Boolean(texture) && Boolean(sSetupFunctions[texture]))
            {
               execute(sSetupFunctions[texture][1],this);
            }
            super.texture = value;
            if(Boolean(value) && Boolean(sSetupFunctions[value]))
            {
               execute(sSetupFunctions[value][0],this);
            }
            else if(Boolean(this._scale9Grid) && Boolean(value))
            {
               readjustSize();
            }
         }
      }
      
      private function setupScale9Grid() : void
      {
         var numVertices:int = 0;
         var numQuads:int = 0;
         var correction:Number = NaN;
         var color:uint = 0;
         var alpha:Number = NaN;
         var texture:Texture = this.texture;
         var frame:Rectangle = texture.frame;
         var absScaleX:Number = scaleX > 0 ? scaleX : -scaleX;
         var absScaleY:Number = scaleY > 0 ? scaleY : -scaleY;
         if(MathUtil.isEquivalent(this._scale9Grid.width,texture.frameWidth))
         {
            absScaleY /= absScaleX;
         }
         else if(MathUtil.isEquivalent(this._scale9Grid.height,texture.frameHeight))
         {
            absScaleX /= absScaleY;
         }
         var invScaleX:Number = 1 / absScaleX;
         var invScaleY:Number = 1 / absScaleY;
         var vertexData:VertexData = this.vertexData;
         var indexData:IndexData = this.indexData;
         var prevNumVertices:int = vertexData.numVertices;
         var gridCenter:Rectangle = Pool.getRectangle();
         var textureBounds:Rectangle = Pool.getRectangle();
         var pixelBounds:Rectangle = Pool.getRectangle();
         var intersection:Rectangle = Pool.getRectangle();
         gridCenter.copyFrom(this._scale9Grid);
         textureBounds.setTo(0,0,texture.frameWidth,texture.frameHeight);
         if(frame)
         {
            pixelBounds.setTo(-frame.x,-frame.y,texture.width,texture.height);
         }
         else
         {
            pixelBounds.copyFrom(textureBounds);
         }
         RectangleUtil.intersect(gridCenter,pixelBounds,intersection);
         sBasCols[0] = sBasCols[2] = 0;
         sBasRows[0] = sBasRows[2] = 0;
         sBasCols[1] = intersection.width;
         sBasRows[1] = intersection.height;
         if(pixelBounds.x < gridCenter.x)
         {
            sBasCols[0] = gridCenter.x - pixelBounds.x;
         }
         if(pixelBounds.y < gridCenter.y)
         {
            sBasRows[0] = gridCenter.y - pixelBounds.y;
         }
         if(pixelBounds.right > gridCenter.right)
         {
            sBasCols[2] = pixelBounds.right - gridCenter.right;
         }
         if(pixelBounds.bottom > gridCenter.bottom)
         {
            sBasRows[2] = pixelBounds.bottom - gridCenter.bottom;
         }
         if(pixelBounds.x < gridCenter.x)
         {
            sPadding.left = pixelBounds.x * invScaleX;
         }
         else
         {
            sPadding.left = gridCenter.x * invScaleX + pixelBounds.x - gridCenter.x;
         }
         if(pixelBounds.right > gridCenter.right)
         {
            sPadding.right = (textureBounds.width - pixelBounds.right) * invScaleX;
         }
         else
         {
            sPadding.right = (textureBounds.width - gridCenter.right) * invScaleX + gridCenter.right - pixelBounds.right;
         }
         if(pixelBounds.y < gridCenter.y)
         {
            sPadding.top = pixelBounds.y * invScaleY;
         }
         else
         {
            sPadding.top = gridCenter.y * invScaleY + pixelBounds.y - gridCenter.y;
         }
         if(pixelBounds.bottom > gridCenter.bottom)
         {
            sPadding.bottom = (textureBounds.height - pixelBounds.bottom) * invScaleY;
         }
         else
         {
            sPadding.bottom = (textureBounds.height - gridCenter.bottom) * invScaleY + gridCenter.bottom - pixelBounds.bottom;
         }
         sPosCols[0] = sBasCols[0] * invScaleX;
         sPosCols[2] = sBasCols[2] * invScaleX;
         sPosCols[1] = textureBounds.width - sPadding.left - sPadding.right - sPosCols[0] - sPosCols[2];
         sPosRows[0] = sBasRows[0] * invScaleY;
         sPosRows[2] = sBasRows[2] * invScaleY;
         sPosRows[1] = textureBounds.height - sPadding.top - sPadding.bottom - sPosRows[0] - sPosRows[2];
         if(sPosCols[1] <= 0)
         {
            correction = textureBounds.width / (textureBounds.width - gridCenter.width) * absScaleX;
            sPadding.left *= correction;
            sPosCols[0] *= correction;
            sPosCols[1] = 0;
            sPosCols[2] *= correction;
         }
         if(sPosRows[1] <= 0)
         {
            correction = textureBounds.height / (textureBounds.height - gridCenter.height) * absScaleY;
            sPadding.top *= correction;
            sPosRows[0] *= correction;
            sPosRows[1] = 0;
            sPosRows[2] *= correction;
         }
         sTexCols[0] = sBasCols[0] / pixelBounds.width;
         sTexCols[2] = sBasCols[2] / pixelBounds.width;
         sTexCols[1] = 1 - sTexCols[0] - sTexCols[2];
         sTexRows[0] = sBasRows[0] / pixelBounds.height;
         sTexRows[2] = sBasRows[2] / pixelBounds.height;
         sTexRows[1] = 1 - sTexRows[0] - sTexRows[2];
         numVertices = int(this.setupScale9GridAttributes(sPadding.left,sPadding.top,sPosCols,sPosRows,sTexCols,sTexRows));
         numQuads = numVertices / 4;
         vertexData.numVertices = numVertices;
         indexData.numIndices = 0;
         for(var i:int = 0; i < numQuads; i++)
         {
            indexData.addQuad(i * 4,i * 4 + 1,i * 4 + 2,i * 4 + 3);
         }
         if(numVertices != prevNumVertices)
         {
            color = prevNumVertices ? vertexData.getColor(0) : 16777215;
            alpha = prevNumVertices ? vertexData.getAlpha(0) : 1;
            vertexData.colorize("color",color,alpha);
         }
         Pool.putRectangle(textureBounds);
         Pool.putRectangle(pixelBounds);
         Pool.putRectangle(gridCenter);
         Pool.putRectangle(intersection);
         setRequiresRedraw();
      }
      
      private function setupScale9GridAttributes(startX:Number, startY:Number, posCols:Vector.<Number>, posRows:Vector.<Number>, texCols:Vector.<Number>, texRows:Vector.<Number>) : int
      {
         var row:int = 0;
         var col:int = 0;
         var colWidthPos:Number = NaN;
         var rowHeightPos:Number = NaN;
         var colWidthTex:Number = NaN;
         var rowHeightTex:Number = NaN;
         var posAttr:String = "position";
         var texAttr:String = "texCoords";
         var vertexData:VertexData = this.vertexData;
         var texture:Texture = this.texture;
         var currentX:Number = startX;
         var currentY:Number = startY;
         var currentU:Number = 0;
         var currentV:Number = 0;
         var vertexID:int = 0;
         for(row = 0; row < 3; row++)
         {
            rowHeightPos = posRows[row];
            rowHeightTex = texRows[row];
            if(rowHeightPos > 0)
            {
               for(col = 0; col < 3; col++)
               {
                  colWidthPos = posCols[col];
                  colWidthTex = texCols[col];
                  if(colWidthPos > 0)
                  {
                     vertexData.setPoint(vertexID,posAttr,currentX,currentY);
                     texture.setTexCoords(vertexData,vertexID,texAttr,currentU,currentV);
                     vertexID++;
                     vertexData.setPoint(vertexID,posAttr,currentX + colWidthPos,currentY);
                     texture.setTexCoords(vertexData,vertexID,texAttr,currentU + colWidthTex,currentV);
                     vertexID++;
                     vertexData.setPoint(vertexID,posAttr,currentX,currentY + rowHeightPos);
                     texture.setTexCoords(vertexData,vertexID,texAttr,currentU,currentV + rowHeightTex);
                     vertexID++;
                     vertexData.setPoint(vertexID,posAttr,currentX + colWidthPos,currentY + rowHeightPos);
                     texture.setTexCoords(vertexData,vertexID,texAttr,currentU + colWidthTex,currentV + rowHeightTex);
                     vertexID++;
                     currentX += colWidthPos;
                  }
                  currentU += colWidthTex;
               }
               currentY += rowHeightPos;
            }
            currentX = startX;
            currentU = 0;
            currentV += rowHeightTex;
         }
         return vertexID;
      }
      
      private function setupTileGrid() : void
      {
         var posLeft:Number = NaN;
         var posRight:Number = NaN;
         var posTop:Number = NaN;
         var posBottom:Number = NaN;
         var texLeft:Number = NaN;
         var texRight:Number = NaN;
         var texTop:Number = NaN;
         var texBottom:Number = NaN;
         var currentX:Number = NaN;
         var texture:Texture = this.texture;
         var frame:Rectangle = texture.frame;
         var vertexData:VertexData = this.vertexData;
         var indexData:IndexData = this.indexData;
         var bounds:Rectangle = getBounds(this,sBounds);
         var prevNumVertices:int = vertexData.numVertices;
         var color:uint = prevNumVertices ? vertexData.getColor(0) : 16777215;
         var alpha:Number = prevNumVertices ? vertexData.getAlpha(0) : 1;
         var invScaleX:Number = scaleX > 0 ? 1 / scaleX : -1 / scaleX;
         var invScaleY:Number = scaleY > 0 ? 1 / scaleY : -1 / scaleY;
         var frameWidth:Number = this._tileGrid.width > 0 ? Number(this._tileGrid.width) : texture.frameWidth;
         var frameHeight:Number = this._tileGrid.height > 0 ? Number(this._tileGrid.height) : texture.frameHeight;
         frameWidth *= invScaleX;
         frameHeight *= invScaleY;
         var tileX:Number = frame ? -frame.x * (frameWidth / frame.width) : 0;
         var tileY:Number = frame ? -frame.y * (frameHeight / frame.height) : 0;
         var tileWidth:Number = texture.width * (frameWidth / texture.frameWidth);
         var tileHeight:Number = texture.height * (frameHeight / texture.frameHeight);
         var modX:Number = this._tileGrid.x * invScaleX % frameWidth;
         var modY:Number = this._tileGrid.y * invScaleY % frameHeight;
         if(modX < 0)
         {
            modX += frameWidth;
         }
         if(modY < 0)
         {
            modY += frameHeight;
         }
         var startX:Number = modX + tileX;
         var startY:Number = modY + tileY;
         if(startX > frameWidth - tileWidth)
         {
            startX -= frameWidth;
         }
         if(startY > frameHeight - tileHeight)
         {
            startY -= frameHeight;
         }
         var posAttrName:String = "position";
         var texAttrName:String = "texCoords";
         var currentY:Number = startY;
         var vertexID:int = 0;
         indexData.numIndices = 0;
         while(currentY < bounds.height)
         {
            currentX = startX;
            while(currentX < bounds.width)
            {
               indexData.addQuad(vertexID,vertexID + 1,vertexID + 2,vertexID + 3);
               posLeft = currentX < 0 ? 0 : currentX;
               posTop = currentY < 0 ? 0 : currentY;
               posRight = currentX + tileWidth > bounds.width ? bounds.width : currentX + tileWidth;
               posBottom = currentY + tileHeight > bounds.height ? bounds.height : currentY + tileHeight;
               vertexData.setPoint(vertexID,posAttrName,posLeft,posTop);
               vertexData.setPoint(vertexID + 1,posAttrName,posRight,posTop);
               vertexData.setPoint(vertexID + 2,posAttrName,posLeft,posBottom);
               vertexData.setPoint(vertexID + 3,posAttrName,posRight,posBottom);
               texLeft = (posLeft - currentX) / tileWidth;
               texTop = (posTop - currentY) / tileHeight;
               texRight = (posRight - currentX) / tileWidth;
               texBottom = (posBottom - currentY) / tileHeight;
               texture.setTexCoords(vertexData,vertexID,texAttrName,texLeft,texTop);
               texture.setTexCoords(vertexData,vertexID + 1,texAttrName,texRight,texTop);
               texture.setTexCoords(vertexData,vertexID + 2,texAttrName,texLeft,texBottom);
               texture.setTexCoords(vertexData,vertexID + 3,texAttrName,texRight,texBottom);
               currentX += frameWidth;
               vertexID += 4;
            }
            currentY += frameHeight;
         }
         vertexData.numVertices = vertexID;
         for(var i:int = prevNumVertices; i < vertexID; i++)
         {
            vertexData.setColor(i,"color",color);
            vertexData.setAlpha(i,"color",alpha);
         }
         setRequiresRedraw();
      }
   }
}

