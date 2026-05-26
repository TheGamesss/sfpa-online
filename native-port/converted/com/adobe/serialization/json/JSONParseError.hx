package com.adobe.serialization.json;

import flash.errors.Error;

class JSONParseError extends Error
{
    public var location(get, never) : Int;
    public var text(get, never) : String;

    
    private var _location : Int;
    
    private var _text : String;
    
    public function new(message : String = "", location : Int = 0, text : String = "")
    {
        super(message);
        this._location = location;
        this._text = text;
    }
    
    private function get_location() : Int
    {
        return this._location;
    }
    
    private function get_text() : String
    {
        return this._text;
    }
}


