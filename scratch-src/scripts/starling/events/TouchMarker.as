package starling.events
{
   import flash.display.*;
   import flash.geom.*;
   import starling.core.*;
   import starling.display.*;
   import starling.textures.*;
   
   internal class TouchMarker extends starling.display.Sprite
   {
      
      private var _center:Point;
      
      private var _texture:Texture;
      
      public function TouchMarker()
      {
         var marker:Image = null;
         super();
         this._center = new Point();
         this._texture = this.createTexture();
         for(var i:int = 0; i < 2; i++)
         {
            marker = new Image(this._texture);
            marker.pivotX = this._texture.width / 2;
            marker.pivotY = this._texture.height / 2;
            marker.touchable = false;
            addChild(marker);
         }
      }
      
      override public function dispose() : void
      {
         this._texture.dispose();
         super.dispose();
      }
      
      public function moveMarker(x:Number, y:Number, withCenter:Boolean = false) : void
      {
         if(withCenter)
         {
            this._center.x += x - this.realMarker.x;
            this._center.y += y - this.realMarker.y;
         }
         this.realMarker.x = x;
         this.realMarker.y = y;
         this.mockMarker.x = 2 * this._center.x - x;
         this.mockMarker.y = 2 * this._center.y - y;
      }
      
      public function moveCenter(x:Number, y:Number) : void
      {
         this._center.x = x;
         this._center.y = y;
         this.moveMarker(this.realX,this.realY);
      }
      
      private function createTexture() : Texture
      {
         var scale:Number = Number(Starling.contentScaleFactor);
         var radius:Number = 12 * scale;
         var width:int = 32 * scale;
         var height:int = 32 * scale;
         var thickness:Number = 1.5 * scale;
         var shape:Shape = new Shape();
         shape.graphics.lineStyle(thickness,0,0.3);
         shape.graphics.drawCircle(width / 2,height / 2,radius + thickness);
         shape.graphics.beginFill(16777215,0.4);
         shape.graphics.lineStyle(thickness,16777215);
         shape.graphics.drawCircle(width / 2,height / 2,radius);
         shape.graphics.endFill();
         var bmpData:BitmapData = new BitmapData(width,height,true,0);
         bmpData.draw(shape);
         return Texture.fromBitmapData(bmpData,false,false,scale);
      }
      
      private function get realMarker() : Image
      {
         return getChildAt(0) as Image;
      }
      
      private function get mockMarker() : Image
      {
         return getChildAt(1) as Image;
      }
      
      public function get realX() : Number
      {
         return this.realMarker.x;
      }
      
      public function get realY() : Number
      {
         return this.realMarker.y;
      }
      
      public function get mockX() : Number
      {
         return this.mockMarker.x;
      }
      
      public function get mockY() : Number
      {
         return this.mockMarker.y;
      }
   }
}

