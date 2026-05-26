package com.adobe.utils;


class IntUtil
{
    
    private static var hexChars : String = "0123456789abcdef";
    
    public function new()
    {
        super();
    }
    
    public static function rol(x : Int, n : Int) : Int
    {
        return as3hx.Compat.parseInt(x << n | x >>> 32 - n);
    }
    
    public static function ror(x : Int, n : Int) : Int
    {
        var nn : Int = as3hx.Compat.parseInt(32 - n);
        return as3hx.Compat.parseInt(x << nn | x >>> 32 - nn);
    }
    
    public static function toHex(n : Int, bigEndian : Bool = false) : String
    {
        var i : Int = 0;
        var x : Int = 0;
        var s : String = "";
        if (bigEndian)
        {
            for (i in 0...4)
            {
                s += hexChars.charAt(as3hx.Compat.parseInt(n >> (3 - i) * 8 + 4) & 0x0F) + hexChars.charAt(as3hx.Compat.parseInt(n >> (3 - i) * 8) & 0x0F);
            }
        }
        else
        {
            for (x in 0...4)
            {
                s += hexChars.charAt(as3hx.Compat.parseInt(n >> x * 8 + 4) & 0x0F) + hexChars.charAt(as3hx.Compat.parseInt(n >> x * 8) & 0x0F);
            }
        }
        return s;
    }
}


