package com.kongregate.as3.common.util
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   
   public class BetterURLLoader extends URLLoader
   {
      
      private static const TIMEOUT:uint = 30000;
      
      private var mTimer:Timer;
      
      private var mUrlRequest:URLRequest;
      
      public function BetterURLLoader(request:URLRequest = null, timeout:uint = 30000)
      {
         super(request);
         this.mUrlRequest = request;
         this.mTimer = new Timer(timeout,1);
      }
      
      override public function load(request:URLRequest) : void
      {
         this.mTimer.addEventListener(TimerEvent.TIMER,this.handleTimeout);
         this.mUrlRequest = request;
         addEventListener(IOErrorEvent.IO_ERROR,this.handleLoadActivity);
         addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleLoadActivity);
         addEventListener(Event.COMPLETE,this.handleLoadActivity);
         addEventListener(ProgressEvent.PROGRESS,this.handleLoadActivity);
         addEventListener(Event.OPEN,this.handleLoadActivity);
         super.load(request);
         this.mTimer.start();
      }
      
      override public function close() : void
      {
         try
         {
            this.killTimer();
            super.close();
            Log.warn("URL closed: " + this.mUrlRequest.url);
            dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
         }
         catch(e:Error)
         {
            Log.warn("Error closing URL: " + e.toString());
         }
      }
      
      private function handleLoadActivity(event:Event) : void
      {
         this.killTimer();
      }
      
      private function killTimer() : void
      {
         removeEventListener(IOErrorEvent.IO_ERROR,this.handleLoadActivity);
         removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleLoadActivity);
         removeEventListener(Event.COMPLETE,this.handleLoadActivity);
         removeEventListener(ProgressEvent.PROGRESS,this.handleLoadActivity);
         removeEventListener(Event.OPEN,this.handleLoadActivity);
         this.mTimer.stop();
         this.mTimer.removeEventListener(TimerEvent.TIMER,this.handleTimeout);
      }
      
      private function handleTimeout(event:TimerEvent) : void
      {
         Log.warn("URL timed out: " + this.mUrlRequest.url);
         this.close();
      }
   }
}

