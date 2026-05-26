package com.miniclip.gamemanager.ui
{
   import com.miniclip.IDisposable;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class VendorIcon extends Sprite implements IDisposable
   {
      
      private var _url:String;
      
      private var _w:Number;
      
      private var _h:Number;
      
      private var loader:Loader;
      
      private var _bytes:ByteArray;
      
      private var _urlLoader:URLLoader;
      
      private var _rootIcon:VendorIcon;
      
      private var _isDisposed:Boolean = false;
      
      public function VendorIcon(url:String, w:Number, h:Number, rootIcon:VendorIcon = null)
      {
         super();
         this._url = url;
         this._w = w;
         this._h = h;
         this._rootIcon = rootIcon;
         this.draw(w,h);
      }
      
      public function get isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function init() : void
      {
         this.load();
      }
      
      public function get bytes() : ByteArray
      {
         return this._bytes;
      }
      
      private function load(e:* = null) : void
      {
         if(this._bytes)
         {
            this._loadFromBytes(this._bytes);
         }
         else if(this._rootIcon)
         {
            if(this._rootIcon.bytes)
            {
               this._rootIcon.removeEventListener(Event.COMPLETE,this.load);
               this._rootIcon.addEventListener(ErrorEvent.ERROR,this._onError);
               this._loadFromBytes(this._rootIcon.bytes);
            }
            else
            {
               this._rootIcon.addEventListener(Event.COMPLETE,this.load,false,0,true);
               this._rootIcon.addEventListener(ErrorEvent.ERROR,this._onError,false,0,true);
            }
         }
         else
         {
            this._urlLoader = new URLLoader();
            this._urlLoader.addEventListener(Event.COMPLETE,this._onBytesComplete,false,0,true);
            this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this._onError,false,0,true);
            this._urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this._onError,false,0,true);
            this._urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
            this._urlLoader.load(new URLRequest(this._url));
         }
      }
      
      private function _loadFromBytes(src:ByteArray) : void
      {
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this._onComplete);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this._onError);
         this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this._onError);
         addChild(this.loader);
         this.loader.loadBytes(src,new LoaderContext(false,ApplicationDomain.currentDomain));
      }
      
      private function _onBytesComplete(e:Event) : void
      {
         this._bytes = this._urlLoader.data as ByteArray;
         if(this._bytes)
         {
            this.load();
         }
         else
         {
            this._onError();
         }
      }
      
      private function _onComplete(e:Event) : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
         if(this._rootIcon)
         {
            this._rootIcon.removeEventListener(Event.COMPLETE,this.load);
            this._rootIcon.addEventListener(ErrorEvent.ERROR,this._onError);
            this._rootIcon = null;
         }
      }
      
      private function _onError(e:Event = null) : void
      {
         if(this.hasEventListener(ErrorEvent.ERROR))
         {
            dispatchEvent(new ErrorEvent(ErrorEvent.ERROR,false,false," Icon not loaded"));
         }
      }
      
      private function draw(w:Number, h:Number) : void
      {
         this.graphics.lineStyle(1,0,0);
         if(this._url != "")
         {
            this.graphics.beginFill(16711680,0);
         }
         else
         {
            this.graphics.beginFill(65280,0.5);
         }
         this.graphics.drawRect(0,0,w,h);
         this.graphics.endFill();
      }
      
      public function dispose() : void
      {
         if(this.loader)
         {
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this._onComplete);
            this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this._onError);
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this._onError);
            this.loader.unloadAndStop();
            this.loader = null;
         }
         if(this._urlLoader)
         {
            this._urlLoader.removeEventListener(Event.COMPLETE,this._onBytesComplete);
            this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this._onError);
            this._urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this._onError);
            this._urlLoader = null;
         }
         if(this._rootIcon)
         {
            this._rootIcon.removeEventListener(Event.COMPLETE,this.load);
            this._rootIcon.removeEventListener(ErrorEvent.ERROR,this._onError);
            this._rootIcon = null;
         }
         if(this._bytes)
         {
            this._bytes = null;
         }
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         this._isDisposed = true;
      }
   }
}

