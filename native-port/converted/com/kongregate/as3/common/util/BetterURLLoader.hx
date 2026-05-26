package com.kongregate.as3.common.util;

import flash.errors.Error;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.events.TimerEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.Timer;

class BetterURLLoader extends URLLoader
{
    
    private static inline var TIMEOUT : Int = 30000;
    
    private var mTimer : Timer;
    
    private var mUrlRequest : URLRequest;
    
    public function new(request : URLRequest = null, timeout : Int = 30000)
    {
        super(request);
        this.mUrlRequest = request;
        this.mTimer = new Timer(timeout, 1);
    }
    
    override public function load(request : URLRequest) : Void
    {
        this.mTimer.addEventListener(TimerEvent.TIMER, this.handleTimeout);
        this.mUrlRequest = request;
        addEventListener(IOErrorEvent.IO_ERROR, this.handleLoadActivity);
        addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleLoadActivity);
        addEventListener(Event.COMPLETE, this.handleLoadActivity);
        addEventListener(ProgressEvent.PROGRESS, this.handleLoadActivity);
        addEventListener(Event.OPEN, this.handleLoadActivity);
        super.load(request);
        this.mTimer.start();
    }
    
    override public function close() : Void
    {
        try
        {
            this.killTimer();
            super.close();
            Log.warn("URL closed: " + this.mUrlRequest.url);
            dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
        }
        catch (e : Error)
        {
            Log.warn("Error closing URL: " + Std.string(e));
        }
    }
    
    private function handleLoadActivity(event : Event) : Void
    {
        this.killTimer();
    }
    
    private function killTimer() : Void
    {
        removeEventListener(IOErrorEvent.IO_ERROR, this.handleLoadActivity);
        removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleLoadActivity);
        removeEventListener(Event.COMPLETE, this.handleLoadActivity);
        removeEventListener(ProgressEvent.PROGRESS, this.handleLoadActivity);
        removeEventListener(Event.OPEN, this.handleLoadActivity);
        this.mTimer.stop();
        this.mTimer.removeEventListener(TimerEvent.TIMER, this.handleTimeout);
    }
    
    private function handleTimeout(event : TimerEvent) : Void
    {
        Log.warn("URL timed out: " + this.mUrlRequest.url);
        this.close();
    }
}


