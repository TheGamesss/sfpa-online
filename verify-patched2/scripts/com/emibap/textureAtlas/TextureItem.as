package com.emibap.textureAtlas
{
   import flash.display.*;
   
   public class TextureItem extends Sprite
   {
      
      private var _graphic:BitmapData;
      
      private var _textureName:String = "";
      
      private var _frameName:String = "";
      
      private var _frameX:int = 0;
      
      private var _frameY:int = 0;
      
      private var _frameWidth:int = 0;
      
      private var _frameHeight:int = 0;
      
      public function TextureItem(graphic:BitmapData, textureName:String, frameName:String, frameX:int = 0, frameY:int = 0, frameWidth:int = 0, frameHeight:int = 0)
      {
         super();
         this._graphic = graphic;
         this._textureName = textureName;
         this._frameName = frameName;
         this._frameWidth = frameWidth;
         this._frameHeight = frameHeight;
         this._frameX = frameX;
         this._frameY = frameY;
         var bm:Bitmap = new Bitmap(graphic,"auto",false);
         addChild(bm);
      }
      
      public function get textureName() : String
      {
         return this._textureName;
      }
      
      public function get frameName() : String
      {
         return this._frameName;
      }
      
      public function get graphic() : BitmapData
      {
         return this._graphic;
      }
      
      public function get frameX() : int
      {
         return this._frameX;
      }
      
      public function get frameY() : int
      {
         return this._frameY;
      }
      
      public function get frameWidth() : int
      {
         return this._frameWidth;
      }
      
      public function get frameHeight() : int
      {
         return this._frameHeight;
      }
   }
}

