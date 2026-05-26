package com.adobe.serialization.json;


class JSONDecoder
{
    
    private var value : Dynamic;
    
    private var tokenizer : JSONTokenizer;
    
    private var token : JSONToken;
    
    public function new(s : String)
    {
        super();
        this.tokenizer = new JSONTokenizer(s);
        this.nextToken();
        this.value = this.parseValue();
    }
    
    public function getValue() : Dynamic
    {
        return this.value;
    }
    
    private function nextToken() : JSONToken
    {
        return this.token = this.tokenizer.getNextToken();
    }
    
    private function parseArray() : Array<Dynamic>
    {
        var a : Array<Dynamic> = new Array<Dynamic>();
        this.nextToken();
        if (this.token.type == JSONTokenType.RIGHT_BRACKET)
        {
            return a;
        }
        while (true)
        {
            a.push(this.parseValue());
            this.nextToken();
            if (this.token.type == JSONTokenType.RIGHT_BRACKET)
            {
                break;
            }
            if (this.token.type == JSONTokenType.COMMA)
            {
                this.nextToken();
            }
            else
            {
                this.tokenizer.parseError("Expecting ] or , but found " + this.token.value);
            }
        }
        return a;
    }
    
    private function parseObject() : Dynamic
    {
        var key : String = null;
        var o : Dynamic = {};
        this.nextToken();
        if (this.token.type == JSONTokenType.RIGHT_BRACE)
        {
            return o;
        }
        while (true)
        {
            if (this.token.type == JSONTokenType.STRING)
            {
                key = Std.string(this.token.value);
                this.nextToken();
                if (this.token.type == JSONTokenType.COLON)
                {
                    this.nextToken();
                    Reflect.setField(o, key, this.parseValue());
                    this.nextToken();
                    if (this.token.type == JSONTokenType.RIGHT_BRACE)
                    {
                        break;
                    }
                    if (this.token.type == JSONTokenType.COMMA)
                    {
                        this.nextToken();
                    }
                    else
                    {
                        this.tokenizer.parseError("Expecting } or , but found " + this.token.value);
                    }
                }
                else
                {
                    this.tokenizer.parseError("Expecting : but found " + this.token.value);
                }
            }
            else
            {
                this.tokenizer.parseError("Expecting string but found " + this.token.value);
            }
        }
        return o;
    }
    
    private function parseValue() : Dynamic
    {
        var _sw0_ = (this.token.type);        

        switch (_sw0_)
        {
            case JSONTokenType.LEFT_BRACE:
                return this.parseObject();
            case JSONTokenType.LEFT_BRACKET:
                return this.parseArray();
            case JSONTokenType.STRING, JSONTokenType.NUMBER, JSONTokenType.TRUE, JSONTokenType.FALSE, JSONTokenType.NULL:
                return this.token.value;
            default:
                this.tokenizer.parseError("Unexpected " + this.token.value);
                return null;
        }
    }
}


