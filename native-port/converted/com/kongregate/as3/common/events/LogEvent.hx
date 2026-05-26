package com.kongregate.as3.common.events;

import flash.events.Event;

class LogEvent extends Event
{
    public var text(get, never) : Dynamic;

    
    public static inline var ERROR : String = "Error";
    
    public static inline var INFO : String = "Info";
    
    public static inline var WARN : String = "Warn";
    
    public static inline var DEBUG : String = "Debug";
    
    public static inline var SPAM : String = "Spam";
    
    public static inline var TYPE_ALL : String = "All";
    
    private var _text : Dynamic;
    
    public function new(type : String, text : Dynamic)
    {
        super(type);
        this._text = text;
    }
    
    private function get_text() : Dynamic
    {
        return this._text;
    }
}


