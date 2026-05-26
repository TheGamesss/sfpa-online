package com.amanitadesign.steam;

import flash.events.Event;

class SteamEvent extends Event
{
    public var response(get, never) : Int;
    public var data(get, set) : Dynamic;
    public var req_type(get, never) : Int;

    
    public static var STEAM_RESPONSE : String = "steamResponse";
    
    private var _req_type : Int = -1;
    
    private var _response : Int = -1;
    
    private var _data : Dynamic = null;
    
    public function new(type : String, req_type : Int, response : Int, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
        this._response = response;
        this._req_type = req_type;
    }
    
    private function get_response() : Int
    {
        return this._response;
    }
    
    private function get_data() : Dynamic
    {
        return this._data;
    }
    
    private function set_data(value : Dynamic) : Dynamic
    {
        this._data = value;
        return value;
    }
    
    private function get_req_type() : Int
    {
        return this._req_type;
    }
    
    override public function clone() : Event
    {
        var event : SteamEvent = new SteamEvent(type, this.req_type, this.response, bubbles, cancelable);
        event.data = this.data;
        return event;
    }
}


