package com.miniclip.gamemanager
{
   import com.miniclip.events.AvatarEvent;
   import com.miniclip.gamemanager.avatars.AvatarBitmapType;
   import com.miniclip.gamemanager.avatars.AvatarConfigData;
   import com.miniclip.logger;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.geom.Matrix;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class YoMeBitmap extends Sprite
   {
      
      private static var prixyUtils:Object;
      
      private static var instances:Dictionary;
      
      private var _configData:AvatarConfigData;
      
      private var _urlLoader:URLLoader;
      
      private var _loader:Loader;
      
      private var _bData:BitmapData;
      
      private var _request:URLRequest;
      
      private var _id:uint;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _type:AvatarBitmapType;
      
      private var _loaded:Boolean;
      
      private var _ready:Boolean;
      
      private var _bmp:Bitmap;
      
      private var bArray:ByteArray;
      
      private var _youMeSO:SharedObject;
      
      private var failSafeUsed:Boolean = false;
      
      public function YoMeBitmap(configData:AvatarConfigData, width:Number = 200, height:Number = 200, type:AvatarBitmapType = null)
      {
         super();
         this._configData = configData;
         this._width = width;
         this._height = height;
         this._type = !type ? AvatarBitmapType.cropped : type;
         this.failSafeUsed = false;
         if(!YoMeBitmap.instances)
         {
            YoMeBitmap.instances = new Dictionary(true);
            YoMeBitmap.instances["length"] = 0;
         }
         YoMeBitmap.instances[this] = {"index":YoMeBitmap.instances["length"]++};
         this.init();
      }
      
      public static function avatarDataHandler(data:*) : void
      {
         var current:Object = null;
         var i:Number = NaN;
         for(current in YoMeBitmap.instances)
         {
            if(current is YoMeBitmap)
            {
               i = Number(YoMeBitmap.instances[current]["index"]);
               if(data != null)
               {
                  if(Boolean(current._configData) && current._configData.userID == data["uid"])
                  {
                     current._avatarDataHandler(data);
                  }
               }
               else
               {
                  current._avatarDataHandler(null);
               }
            }
         }
      }
      
      private function init() : void
      {
         var getFunction:Function = null;
         var addCallback:Function = null;
         var fn:Function = null;
         if(this._configData.avatarData)
         {
            this.onAvatarData(this._configData.avatarData);
         }
         else
         {
            if(!YoMeBitmap.prixyUtils)
            {
               if(!ApplicationDomain.currentDomain.hasDefinition("com.miniclip.gamemanager.utils.ProxyUtil"))
               {
                  this.onAvatarData(null);
                  return;
               }
               prixyUtils = ApplicationDomain.currentDomain.getDefinition("com.miniclip.gamemanager.utils.ProxyUtil");
            }
            getFunction = prixyUtils["getFunction"] as Function;
            addCallback = prixyUtils["addCallback"] as Function;
            addCallback("avatar_data",YoMeBitmap.avatarDataHandler);
            if(getFunction != null)
            {
               fn = getFunction("player.getAvatarData");
               if(fn != null)
               {
                  fn({
                     "userID":this._configData.userID,
                     "w":this._width
                  });
                  return;
               }
            }
            this.onAvatarData(null);
         }
      }
      
      public function _avatarDataHandler(data:*) : void
      {
         if(Boolean(data) && Boolean(data["result"]) && Boolean(data["result"]["url_string"]))
         {
            this.onAvatarData(data["result"]);
         }
         else
         {
            this.onAvatarData(null);
         }
      }
      
      public function onAvatarData(data:Object) : void
      {
         var imageSize:RegExp = null;
         var cdnURL:String = null;
         this._urlLoader = new URLLoader();
         this._urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         this._loaded = false;
         this._ready = false;
         this._hookEvents();
         if(data)
         {
            imageSize = new RegExp("(?<=" + String(this._configData.userID) + "-)[0-9]*([0-9](?=.))");
            data["url_string"] = data["url_string"].replace(imageSize,String(this._width));
            cdnURL = data["url_string"] + "?e=" + data["etag"] + (data["datetime"] != null ? "&datetime=" + data["datetime"] : "");
            this._urlLoader.load(new URLRequest(cdnURL));
         }
         else
         {
            this._urlLoader.load(this.createRequest());
         }
      }
      
      private function _hookEvents() : void
      {
         if(this._urlLoader)
         {
            this._urlLoader.addEventListener(Event.COMPLETE,this._onComplete);
            this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this._onIOError);
            this._urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this._onSecurityError);
         }
      }
      
      private function _unhookEvents() : void
      {
         if(this._urlLoader)
         {
            this._urlLoader.removeEventListener(Event.COMPLETE,this._onComplete);
            this._urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this._onIOError);
            this._urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this._onSecurityError);
         }
      }
      
      private function createRequest() : URLRequest
      {
         var req:URLRequest = new URLRequest(this._configData.url);
         var vars:URLVariables = new URLVariables();
         vars["uid"] = this._configData.userID;
         vars["w"] = this._width;
         vars["h"] = this._height;
         vars["type"] = this._type.value;
         if(this._configData.cacheURL)
         {
            vars["rnd"] = int(Math.random() * 10000);
         }
         req.data = vars;
         return req;
      }
      
      private function _onComplete(event:Event = null) : void
      {
         this._loaded = true;
         this._unhookEvents();
         if(event)
         {
            this.bArray = this._urlLoader.data as ByteArray;
            this._onComplete();
         }
         else if(!this.bArray)
         {
            return;
         }
         if(Boolean(this.bArray) && this.bArray.length > 1)
         {
            this._bData = new BitmapData(this._width,this._height,true,16777215);
            this._bmp = new Bitmap(this._bData);
            addChild(this._bmp);
            try
            {
               this._loader = new Loader();
               this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadBytes);
               this._loader.loadBytes(this.bArray);
            }
            catch(er:Error)
            {
               dispatchEvent(new AvatarEvent(AvatarEvent.ERROR,this));
               inactive();
            }
         }
         else
         {
            dispatchEvent(new AvatarEvent(AvatarEvent.ERROR,this));
            this.inactive();
         }
      }
      
      private function inactive() : void
      {
         if(YoMeBitmap.instances)
         {
            if(YoMeBitmap.instances[this])
            {
               delete YoMeBitmap.instances[this];
               --YoMeBitmap.instances["length"];
            }
         }
      }
      
      private function onLoadBytes(e:Event) : void
      {
         var mat:Matrix = null;
         var wScale:Number = NaN;
         var hScale:Number = NaN;
         var scale:Number = NaN;
         var tx:Number = NaN;
         var ty:Number = NaN;
         var t:EventDispatcher = e.target as EventDispatcher;
         if(t)
         {
            t.removeEventListener(Event.COMPLETE,this.onLoadBytes);
         }
         if(!this._loader || this._loader.width < 1 || this._loader.height < 1)
         {
            dispatchEvent(new AvatarEvent(AvatarEvent.ERROR,this));
         }
         else
         {
            if(this._width != this._loader.width || this._height != this._loader.height)
            {
               wScale = this._width / this._loader.width;
               hScale = this._height / this._loader.height;
               scale = wScale > hScale ? hScale : wScale;
               tx = (this._width - scale * this._loader.width) / 2;
               ty = (this._height - scale * this._loader.height) / 2;
               mat = new Matrix(scale,0,0,scale,tx,ty);
               logger.log(" YoMeBitmap size transform matrix ");
               logger.log("wScale " + wScale);
               logger.log("hScale " + hScale);
               logger.log("scale " + scale);
               logger.log("tx " + tx);
               logger.log("ty " + ty);
               logger.log(" =============== ");
            }
            else
            {
               logger.log(" YoMeBitmap the size is correnct - transform not applied ");
               mat = new Matrix(1,0,0,1,0,0);
            }
            this._bData.draw(this._loader,mat,null,null,null,true);
            try
            {
               this._loader.unload();
               this._loader = null;
            }
            catch(er:Error)
            {
               trace("unload error ",er);
            }
            dispatchEvent(new AvatarEvent(AvatarEvent.READY,this));
            this.inactive();
         }
      }
      
      private function _onSecurityError(e:SecurityErrorEvent) : void
      {
         logger.error("Could not load " + this._request);
         this.tryResizePhp(e);
      }
      
      private function _onIOError(e:IOErrorEvent) : void
      {
         logger.error("Could not load " + this._request);
         this.tryResizePhp(e);
      }
      
      private function tryResizePhp(e:ErrorEvent) : void
      {
         var msg:String = null;
         if(this.failSafeUsed == false)
         {
            this.failSafeUsed = true;
            msg = e.text;
            if(msg.indexOf(this._configData.url) == -1)
            {
               this.onAvatarData(null);
            }
         }
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get ready() : Boolean
      {
         return this._ready;
      }
      
      public function get bitmap() : Bitmap
      {
         if(this._bData)
         {
            return new Bitmap(this._bData.clone());
         }
         return null;
      }
   }
}

