package com.newgrounds
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.system.LoaderContext;
   
   public class BitmapLoader extends APIEventDispatcher
   {
      
      internal static var _cacheSeed:uint = 0;
      
      private static const LOADER_CONTEXT:LoaderContext = new LoaderContext(true);
      
      private var _url:String;
      
      private var _bitmapData:BitmapData;
      
      private var _loaded:Boolean = true;
      
      private var _loader:Loader;
      
      public function BitmapLoader(param1:BitmapData, param2:String)
      {
         super();
         this._bitmapData = param1;
         this._url = param2;
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function set url(param1:String) : void
      {
         this._loaded = false;
         this._url = param1;
      }
      
      public function get bitmapData() : BitmapData
      {
         return this._bitmapData;
      }
      
      public function set bitmapData(param1:BitmapData) : void
      {
         this._bitmapData = param1;
         this._loaded = true;
      }
      
      public function get loaded() : Boolean
      {
         return this._loaded;
      }
      
      private function createLoader() : Loader
      {
         var _loc1_:Loader = new Loader();
         var _loc2_:URLRequest = new URLRequest(this._url);
         _loc2_.method = URLRequestMethod.GET;
         _loc2_.data = _cacheSeed.toString();
         _loc1_.load(_loc2_,LOADER_CONTEXT);
         return _loc1_;
      }
      
      private function disposeLoader() : void
      {
         if(this._loader)
         {
            try
            {
               this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadComplete);
               this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadComplete);
               this._loader.unload();
            }
            catch(error:*)
            {
            }
            this._loader = null;
         }
      }
      
      public function load() : void
      {
         if(!this._url || this._url == "")
         {
            this.onLoadComplete(null);
            return;
         }
         this.disposeLoader();
         this._loader = this.createLoader();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadComplete);
      }
      
      public function attachBitmap(param1:DisplayObjectContainer) : Sprite
      {
         var _loc2_:Sprite = new Sprite();
         if(Boolean(!this._loaded) && Boolean(this._url) && this._url != "")
         {
            if(!this._loader)
            {
               this.load();
            }
            _loc2_.addChild(this.createLoader());
         }
         else
         {
            _loc2_.addChild(new Bitmap(this._bitmapData));
         }
         if(param1)
         {
            param1.addChild(_loc2_);
         }
         return _loc2_;
      }
      
      private function onLoadComplete(param1:Event) : void
      {
         var bitmapData:BitmapData = null;
         var event:Event = param1;
         try
         {
            if(Boolean(event && event.type == Event.COMPLETE) && Boolean(this._loader) && this._loader.content is Bitmap)
            {
               bitmapData = Bitmap(this._loader.content).bitmapData;
               this._bitmapData = bitmapData;
               this._loaded = true;
            }
         }
         catch(error:SecurityError)
         {
            if(bitmapData)
            {
               bitmapData.dispose();
            }
         }
         this.disposeLoader();
         dispatchEvent(new APIEvent(APIEvent.ICON_LOADED,this,this._loaded ? null : APIEvent.ERROR_BAD_FILE));
      }
   }
}

