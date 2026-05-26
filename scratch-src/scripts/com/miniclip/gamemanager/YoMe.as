package com.miniclip.gamemanager
{
   import com.miniclip.events.AvatarEvent;
   import com.miniclip.gamemanager.avatars.AvatarConfigData;
   import com.miniclip.gamemanager.avatars.AvatarRegistration;
   import com.miniclip.logger;
   import flash.display.Graphics;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.LoaderContext;
   
   public class YoMe extends Sprite implements GameAvatar
   {
      
      private var _configData:AvatarConfigData;
      
      private var _context:LoaderContext;
      
      private var _loader:Loader;
      
      private var _loaded:Boolean;
      
      private var _ready:Boolean;
      
      private var _avatar:Sprite;
      
      private var _container:*;
      
      private var _debugMarker:Boolean;
      
      private var _RPmarker:Sprite;
      
      private var _ORImarker:Sprite;
      
      public function YoMe(configData:AvatarConfigData, context:LoaderContext = null)
      {
         super();
         this._configData = configData;
         this._context = context;
         this._debugMarker = configData.debugMarker;
         this._loaded = false;
         this._ready = false;
         if(this._debugMarker)
         {
            this._RPmarker = this._createDebugMarker();
            this._ORImarker = this._createDebugMarker(16711680);
         }
         this.init();
      }
      
      private function init() : void
      {
         this._loader = new Loader();
         addChild(this._loader);
         this._hookEvents();
         this.load();
      }
      
      private function _createDebugMarker(color:Number = 16763904, alpha:Number = 1) : Sprite
      {
         var marker:Sprite = new Sprite();
         var g:Graphics = marker.graphics;
         g.clear();
         g.beginFill(color,alpha);
         g.drawRect(-5,-5,10,10);
         g.endFill();
         g.lineStyle(1,0);
         g.moveTo(0,-12);
         g.lineTo(0,12);
         g.moveTo(-12,0);
         g.lineTo(12,0);
         g.endFill();
         return marker;
      }
      
      private function _updateDebugMarker() : void
      {
         if(this._ORImarker)
         {
            this._ORImarker.x = this._loader.x;
            this._ORImarker.y = this._loader.y;
            if(!contains(this._ORImarker))
            {
               addChild(this._ORImarker);
            }
         }
         if(this._RPmarker)
         {
            this._RPmarker.x = 0;
            this._RPmarker.y = 0;
            addChild(this._RPmarker);
         }
      }
      
      private function _hookEvents() : void
      {
         this._loader.contentLoaderInfo.addEventListener(Event.INIT,this.onComplete);
         this._loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHTTPStatus);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._loader.contentLoaderInfo.addEventListener(Event.OPEN,this.onOpen);
         this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this._loader.contentLoaderInfo.addEventListener(Event.UNLOAD,this.onUnload);
      }
      
      private function _unhookEvents() : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.INIT,this.onComplete);
         this._loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHTTPStatus);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._loader.contentLoaderInfo.removeEventListener(Event.OPEN,this.onOpen);
         this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this._loader.contentLoaderInfo.removeEventListener(Event.UNLOAD,this.onUnload);
      }
      
      private function load() : void
      {
         dispatchEvent(new AvatarEvent(AvatarEvent.READY,this));
         if(this._context)
         {
            this._loader.load(this.createRequest(),this._context);
         }
         else
         {
            this._loader.load(this.createRequest());
         }
      }
      
      private function createRequest() : URLRequest
      {
         var req:URLRequest = new URLRequest(this._configData.url);
         var vars:URLVariables = new URLVariables();
         vars["glow"] = int(this._configData.showGlowEffect);
         vars["loader"] = int(this._configData.showLoader);
         vars["userid"] = this._configData.userID;
         if(this._configData.cacheURL)
         {
            vars["rnd"] = int(Math.random() * 10000);
         }
         req.data = vars;
         return req;
      }
      
      private function onComplete(event:Event) : void
      {
         this._avatar = this._loader.content as Sprite;
         if(this._avatar)
         {
            this._avatar.addEventListener(Event.COMPLETE,this.onAvatarComplete);
            this._avatar.addEventListener(AvatarEvent.ERROR,this.onAvatarError);
            this._loaded = true;
         }
         else
         {
            dispatchEvent(new AvatarEvent(AvatarEvent.ERROR));
         }
      }
      
      private function onAddedToStage(event:Event = null) : void
      {
      }
      
      private function onHTTPStatus(event:HTTPStatusEvent) : void
      {
         logger.debug("YoMe.onHTTPStatus()");
         logger.info("Dispatched when a network request is made over HTTP and an HTTP status code can be detected.");
      }
      
      private function onInit(event:Event) : void
      {
         logger.debug("YoMe.onInit()");
         logger.info("Dispatched when the properties and methods of a loaded SWF file are accessible and ready for use.");
      }
      
      private function onIOError(event:IOErrorEvent) : void
      {
         logger.debug("YoMe.onIOError()");
         logger.info("Dispatched when an input or output error occurs that causes a load operation to fail.");
      }
      
      private function onOpen(event:Event) : void
      {
         logger.debug("YoMe.onOpen()");
         logger.info("Dispatched when a load operation starts.");
      }
      
      private function onProgress(event:ProgressEvent) : void
      {
         logger.debug("YoMe.onProgress()");
         logger.info("Dispatched when data is received as the download operation progresses.");
      }
      
      private function onUnload(event:Event) : void
      {
         logger.debug("YoMe.onUnload()");
         logger.info("Dispatched by a LoaderInfo object whenever a loaded object is removed by using the unload() method of the Loader object, or when a second load is performed by the same Loader object and the original content is removed prior to the load beginning.");
      }
      
      private function onAvatarError(event:AvatarEvent) : void
      {
         logger.debug("YoMe.onAvatarError( " + event + " )");
         logger.error(event.data);
         dispatchEvent(event);
      }
      
      private function onAvatarComplete(event:Event) : void
      {
         logger.debug("YoMe.onAvatarComplete()");
         this._avatar.removeEventListener(Event.COMPLETE,this.onAvatarComplete);
         this._avatar.removeEventListener(AvatarEvent.ERROR,this.onAvatarError);
         this._unhookEvents();
         if(this._debugMarker)
         {
            this._updateDebugMarker();
         }
         this._ready = true;
         dispatchEvent(new AvatarEvent(AvatarEvent.READY,this));
      }
      
      public function get skeleton() : *
      {
         if(Boolean(this._loader) && Boolean(this._loader.content) && Boolean(this._loader.content["skeleton"]))
         {
            return this._loader.content["skeleton"];
         }
         return null;
      }
      
      public function get id() : uint
      {
         return this._configData.userID;
      }
      
      public function get ready() : Boolean
      {
         return this._ready;
      }
      
      public function get version() : String
      {
         if(!this._avatar)
         {
            return "";
         }
         return this._avatar["version"] as String;
      }
      
      public function get registration() : Point
      {
         return new Point(this._loader.x,this._loader.y);
      }
      
      override public function get width() : Number
      {
         if(!this._avatar)
         {
            return NaN;
         }
         return this._avatar.width;
      }
      
      override public function set width(value:Number) : void
      {
         if(!this._avatar)
         {
            return;
         }
         this._avatar.width = value;
      }
      
      override public function get height() : Number
      {
         if(!this._avatar)
         {
            return NaN;
         }
         return this._avatar.height;
      }
      
      override public function set height(value:Number) : void
      {
         if(!this._avatar)
         {
            return;
         }
         this._avatar.height = value;
      }
      
      public function get background() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["background"] as Sprite;
         }
         return null;
      }
      
      public function get bottom() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["bottom"] as Sprite;
         }
         return null;
      }
      
      public function get skin() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["skin"] as Sprite;
         }
         return null;
      }
      
      public function get top() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["top"] as Sprite;
         }
         return null;
      }
      
      public function get shoes() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["shoes"] as Sprite;
         }
         return null;
      }
      
      public function get eyes() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["eyes"] as Sprite;
         }
         return null;
      }
      
      public function get mouth() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["mouth"] as Sprite;
         }
         return null;
      }
      
      public function get hair() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["hair"] as Sprite;
         }
         return null;
      }
      
      public function get glasses() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["glasses"] as Sprite;
         }
         return null;
      }
      
      public function get extra1() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["extra1"] as Sprite;
         }
         return null;
      }
      
      public function get extra2() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["extra2"] as Sprite;
         }
         return null;
      }
      
      public function get extra3() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["extra3"] as Sprite;
         }
         return null;
      }
      
      public function get extra4() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["extra4"] as Sprite;
         }
         return null;
      }
      
      public function get extra5() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["extra5"] as Sprite;
         }
         return null;
      }
      
      public function get pet() : Sprite
      {
         if(this._avatar)
         {
            return this._avatar["pet"] as Sprite;
         }
         return null;
      }
      
      public function getExtra(index:uint) : Sprite
      {
         if(Boolean(this._avatar) && this._avatar["getExtra"] is Function)
         {
            this._avatar["getExtra"](index) as Sprite;
         }
         return null;
      }
      
      public function hide(... parts) : void
      {
         if(Boolean(this._avatar) && this._avatar["hide"] is Function)
         {
            this._avatar["hide"]["apply"](this._avatar,parts);
         }
      }
      
      public function show(... parts) : void
      {
         if(Boolean(this._avatar) && this._avatar["show"] is Function)
         {
            this._avatar["show"]["apply"](this._avatar,parts);
         }
      }
      
      public function setPosition(x:Number, y:Number) : void
      {
         this.x = x;
         this.y = y;
      }
      
      public function setSize(new_width:Number, new_height:Number) : void
      {
         if(Boolean(this._avatar) && this._avatar["setSize"] is Function)
         {
            this._avatar["setSize"]["call"](this._avatar,new_width,new_height);
         }
      }
      
      public function setRegistration(a:*, b:* = null) : void
      {
         var p:Point = null;
         if(a is AvatarRegistration)
         {
            p = new Point(a.x,a.y);
         }
         else if(a is Point)
         {
            p = a;
         }
         else
         {
            if(!(a is Number && b is Number))
            {
               return;
            }
            p = new Point(a,b);
         }
         this._loader.x = -p.x;
         this._loader.y = -p.y;
         if(this._debugMarker)
         {
            this._updateDebugMarker();
         }
      }
      
      public function destroy() : void
      {
         this._ready = false;
         if(this._avatar)
         {
            this._avatar["destroy"]();
         }
         this._avatar = null;
         if(this._loader.hasOwnProperty("unloadAndStop"))
         {
            this._loader["unloadAndStop"]();
         }
         else
         {
            this._loader.unload();
         }
         if(Boolean(this._ORImarker) && contains(this._ORImarker))
         {
            removeChild(this._ORImarker);
         }
         if(Boolean(this._RPmarker) && contains(this._RPmarker))
         {
            removeChild(this._RPmarker);
         }
         if(this.contains(this._loader))
         {
            removeChild(this._loader);
         }
         this._loader = null;
         this._ORImarker = null;
         this._RPmarker = null;
      }
   }
}

