package com.kongregate.air.event;

import com.kongregate.air.KongregateAPI;
import flash.events.Event;

class SwrveEvent extends Event
{
    public var action(get, never) : String;

    
    private var mAction : String;
    
    public function new(action : String)
    {
        super(KongregateAPI.SWRVE_BUTTON_EVENT);
        this.mAction = action;
    }
    
    private function get_action() : String
    {
        return this.mAction;
    }
}


