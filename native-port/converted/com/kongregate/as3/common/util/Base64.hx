package com.kongregate.as3.common.util;

import flash.errors.Error;
import flash.utils.ByteArray;

class Base64
{
    
    private static inline var BASE64_CHARS : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    public static inline var version : String = "1.0.0";
    
    public function new()
    {
        super();
        throw new Error("Base64 class is static container only");
    }
    
    public static function encode(data : String) : String
    {
        var bytes : ByteArray = new ByteArray();
        bytes.writeUTFBytes(data);
        return encodeByteArray(bytes);
    }
    
    public static function encodeByteArray(data : ByteArray) : String
    {
        var dataBuffer : Array<Dynamic> = null;
        var i : Int = 0;
        var j : Int = 0;
        var k : Int = 0;
        var output : String = "";
        var outputBuffer : Array<Dynamic> = new Array<Dynamic>(4);
        data.position = 0;
        while (data.bytesAvailable > 0)
        {
            dataBuffer = new Array<Dynamic>();
            i = 0;
            while (i < 3 && data.bytesAvailable > 0)
            {
                dataBuffer[i] = data.readUnsignedByte();
                i++;
            }
            outputBuffer[0] = (dataBuffer[0] & 0xFC) >> 2;
            outputBuffer[1] = (dataBuffer[0] & 3) << 4 | dataBuffer[1] >> 4;
            outputBuffer[2] = (dataBuffer[1] & 0x0F) << 2 | dataBuffer[2] >> 6;
            outputBuffer[3] = dataBuffer[2] & 0x3F;
            for (j in dataBuffer.length...3)
            {
                outputBuffer[j + 1] = 64;
            }
            for (k in 0...outputBuffer.length)
            {
                output += BASE64_CHARS.charAt(outputBuffer[k]);
            }
        }
        return output;
    }
    
    public static function decode(data : String) : String
    {
        var bytes : ByteArray = decodeToByteArray(data);
        return bytes.readUTFBytes(bytes.length);
    }
    
    public static function decodeToByteArray(data : String) : ByteArray
    {
        var j : Int = 0;
        var k : Int = 0;
        var output : ByteArray = new ByteArray();
        var dataBuffer : Array<Dynamic> = new Array<Dynamic>(4);
        var outputBuffer : Array<Dynamic> = new Array<Dynamic>(3);
        var i : Int = 0;
        while (i < data.length)
        {
            j = 0;
            while (j < 4 && i + j < data.length)
            {
                dataBuffer[j] = BASE64_CHARS.indexOf(data.charAt(i + j));
                j++;
            }
            outputBuffer[0] = (dataBuffer[0] << 2) + ((dataBuffer[1] & 0x30) >> 4);
            outputBuffer[1] = ((dataBuffer[1] & 0x0F) << 4) + ((dataBuffer[2] & 0x3C) >> 2);
            outputBuffer[2] = ((dataBuffer[2] & 3) << 6) + dataBuffer[3];
            for (k in 0...outputBuffer.length)
            {
                if (dataBuffer[k + 1] == 64)
                {
                    break;
                }
                output.writeByte(outputBuffer[k]);
            }
            i += 4;
        }
        output.position = 0;
        return output;
    }
}


