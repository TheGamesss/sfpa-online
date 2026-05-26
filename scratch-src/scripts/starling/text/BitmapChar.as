package starling.text
{
   import flash.utils.*;
   import starling.display.*;
   import starling.textures.Texture;
   
   public class BitmapChar
   {
      
      private var _texture:Texture;
      
      private var _charID:int;
      
      private var _xOffset:Number;
      
      private var _yOffset:Number;
      
      private var _xAdvance:Number;
      
      private var _kernings:Dictionary;
      
      public function BitmapChar(id:int, texture:Texture, xOffset:Number, yOffset:Number, xAdvance:Number)
      {
         super();
         this._charID = id;
         this._texture = texture;
         this._xOffset = xOffset;
         this._yOffset = yOffset;
         this._xAdvance = xAdvance;
         this._kernings = null;
      }
      
      public function addKerning(charID:int, amount:Number) : void
      {
         if(this._kernings == null)
         {
            this._kernings = new Dictionary();
         }
         this._kernings[charID] = amount;
      }
      
      public function getKerning(charID:int) : Number
      {
         if(this._kernings == null || this._kernings[charID] == undefined)
         {
            return 0;
         }
         return this._kernings[charID];
      }
      
      public function createImage() : Image
      {
         return new Image(this._texture);
      }
      
      public function get charID() : int
      {
         return this._charID;
      }
      
      public function get xOffset() : Number
      {
         return this._xOffset;
      }
      
      public function get yOffset() : Number
      {
         return this._yOffset;
      }
      
      public function get xAdvance() : Number
      {
         return this._xAdvance;
      }
      
      public function get texture() : Texture
      {
         return this._texture;
      }
      
      public function get width() : Number
      {
         return this._texture.width;
      }
      
      public function get height() : Number
      {
         return this._texture.height;
      }
   }
}

