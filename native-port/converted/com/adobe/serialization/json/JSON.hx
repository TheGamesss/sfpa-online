package com.adobe.serialization.json;


class JSON
{
    
    public function new()
    {
        super();
    }
    
    public static function encode(o : Dynamic) : String
    {
        var encoder : JSONEncoder = new JSONEncoder(o);
        return encoder.getString();
    }
    
    public static function decode(s : String) : Dynamic
    {
        var decoder : JSONDecoder = new JSONDecoder(s);
        return decoder.getValue();
    }
}


