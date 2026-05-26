package com.emibap.textureAtlas;

import flash.display.*;

class TextureItem extends Sprite
{
    public var textureName(get, never) : String;
    public var frameName(get, never) : String;
    public var graphic(get, never) : BitmapData;
    public var frameX(get, never) : Int;
    public var frameY(get, never) : Int;
    public var frameWidth(get, never) : Int;
    public var frameHeight(get, never) : Int;

    
    private var _graphic : BitmapData;
    
    private var _textureName : String = "";
    
    private var _frameName : String = "";
    
    private var _frameX : Int = 0;
    
    private var _frameY : Int = 0;
    
    private var _frameWidth : Int = 0;
    
    private var _frameHeight : Int = 0;
    
    public function new(graphic : BitmapData, textureName : String, frameName : String, frameX : Int = 0, frameY : Int = 0, frameWidth : Int = 0, frameHeight : Int = 0)
    {
        super();
        this._graphic = graphic;
        this._textureName = textureName;
        this._frameName = frameName;
        this._frameWidth = frameWidth;
        this._frameHeight = frameHeight;
        this._frameX = frameX;
        this._frameY = frameY;
        var bm : Bitmap = new Bitmap(graphic, "auto", false);
        addChild(bm);
    }
    
    private function get_textureName() : String
    {
        return this._textureName;
    }
    
    private function get_frameName() : String
    {
        return this._frameName;
    }
    
    private function get_graphic() : BitmapData
    {
        return this._graphic;
    }
    
    private function get_frameX() : Int
    {
        return this._frameX;
    }
    
    private function get_frameY() : Int
    {
        return this._frameY;
    }
    
    private function get_frameWidth() : Int
    {
        return this._frameWidth;
    }
    
    private function get_frameHeight() : Int
    {
        return this._frameHeight;
    }
}


