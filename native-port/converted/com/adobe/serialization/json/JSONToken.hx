package com.adobe.serialization.json;


class JSONToken
{
    public var type(get, set) : Int;
    public var value(get, set) : Dynamic;

    
    private var _type : Int;
    
    private var _value : Dynamic;
    
    public function new(type : Int = -1, value : Dynamic = null)
    {
        super();
        this._type = type;
        this._value = value;
    }
    
    private function get_type() : Int
    {
        return this._type;
    }
    
    private function set_type(value : Int) : Int
    {
        this._type = value;
        return value;
    }
    
    private function get_value() : Dynamic
    {
        return this._value;
    }
    
    private function set_value(v : Dynamic) : Dynamic
    {
        this._value = v;
        return v;
    }
}


