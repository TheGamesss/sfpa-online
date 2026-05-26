package starling.core
{
   import flash.display.*;
   import flash.display3D.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import starling.animation.Juggler;
   import starling.display.*;
   import starling.events.*;
   import starling.rendering.*;
   import starling.utils.*;
   
   public class Starling extends starling.events.EventDispatcher
   {
      
      private static var sCurrent:Starling;
      
      public static const VERSION:String = "2.2";
      
      private static var sAll:Vector.<Starling> = new Vector.<Starling>(0);
      
      private var _stage:starling.display.Stage;
      
      private var _rootClass:Class;
      
      private var _root:starling.display.DisplayObject;
      
      private var _juggler:Juggler;
      
      private var _painter:Painter;
      
      private var _touchProcessor:TouchProcessor;
      
      private var _antiAliasing:int;
      
      private var _frameTimestamp:Number;
      
      private var _frameID:uint;
      
      private var _leftMouseDown:Boolean;
      
      private var _statsDisplay:StatsDisplay;
      
      private var _started:Boolean;
      
      private var _rendering:Boolean;
      
      private var _supportHighResolutions:Boolean;
      
      private var _skipUnchangedFrames:Boolean;
      
      private var _showStats:Boolean;
      
      private var _viewPort:Rectangle;
      
      private var _previousViewPort:Rectangle;
      
      private var _clippedViewPort:Rectangle;
      
      private var _nativeStage:flash.display.Stage;
      
      private var _nativeStageEmpty:Boolean;
      
      private var _nativeOverlay:flash.display.Sprite;
      
      public function Starling(rootClass:Class, stage:flash.display.Stage, viewPort:Rectangle = null, stage3D:Stage3D = null, renderMode:String = "auto", profile:Object = "auto")
      {
         var runtime:String = null;
         super();
         if(stage == null)
         {
            throw new ArgumentError("Stage must not be null");
         }
         if(viewPort == null)
         {
            viewPort = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
         }
         if(stage3D == null)
         {
            stage3D = stage.stage3Ds[0];
         }
         SystemUtil.initialize();
         sAll.push(this);
         this.makeCurrent();
         this._rootClass = rootClass;
         this._viewPort = viewPort;
         this._previousViewPort = new Rectangle();
         this._stage = new Stage(viewPort.width,viewPort.height,stage.color);
         this._nativeOverlay = new Sprite();
         this._nativeStage = stage;
         this._nativeStage.addChild(this._nativeOverlay);
         this._antiAliasing = 0;
         this._supportHighResolutions = false;
         this._painter = new Painter(stage3D);
         this._frameTimestamp = getTimer() / 1000;
         this._frameID = 1;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated,false,10,true);
         stage3D.addEventListener(ErrorEvent.ERROR,this.onStage3DError,false,10,true);
         var runtimeVersion:int = int(parseInt(SystemUtil.version.split(",").shift()));
         if(runtimeVersion < 19)
         {
            runtime = SystemUtil.isAIR ? "Adobe AIR" : "Flash Player";
            this.stopWithFatalError("Your " + runtime + " installation is outdated. " + "This software requires at least version 19.");
         }
         else if(this._painter.shareContext)
         {
            setTimeout(this.initialize,1);
         }
         else
         {
            this._painter.requestContext3D(renderMode,profile);
         }
      }
      
      public static function get current() : Starling
      {
         return sCurrent;
      }
      
      public static function get all() : Vector.<Starling>
      {
         return sAll;
      }
      
      public static function get context() : Context3D
      {
         return sCurrent ? sCurrent.context : null;
      }
      
      public static function get juggler() : Juggler
      {
         return sCurrent ? sCurrent._juggler : null;
      }
      
      public static function get painter() : Painter
      {
         return sCurrent ? sCurrent._painter : null;
      }
      
      public static function get contentScaleFactor() : Number
      {
         return sCurrent ? Number(sCurrent.contentScaleFactor) : 1;
      }
      
      public static function get multitouchEnabled() : Boolean
      {
         return Multitouch.inputMode == MultitouchInputMode.TOUCH_POINT;
      }
      
      public static function set multitouchEnabled(value:Boolean) : void
      {
         if(sCurrent)
         {
            throw new IllegalOperationError("\'multitouchEnabled\' must be set before Starling instance is created");
         }
         Multitouch.inputMode = value ? MultitouchInputMode.TOUCH_POINT : MultitouchInputMode.NONE;
      }
      
      public static function get frameID() : uint
      {
         return sCurrent ? uint(sCurrent._frameID) : 0;
      }
      
      public function dispose() : void
      {
         var touchEventType:String = null;
         var index:int = 0;
         this.stop(true);
         this._nativeStage.removeChild(this._nativeOverlay);
         this.stage3D.removeEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated,false);
         this.stage3D.removeEventListener(Event.CONTEXT3D_CREATE,this.onContextRestored,false);
         this.stage3D.removeEventListener(ErrorEvent.ERROR,this.onStage3DError,false);
         for each(touchEventType in this.touchEventTypes)
         {
            this._nativeStage.removeEventListener(touchEventType,this.onTouch,false);
         }
         this._touchProcessor.dispose();
         this._stage.dispose();
         this._painter.dispose();
         index = int(sAll.indexOf(this));
         if(index != -1)
         {
            sAll.removeAt(index);
         }
         if(sCurrent == this)
         {
            sCurrent = null;
         }
      }
      
      private function initialize() : void
      {
         this.makeCurrent();
         this.updateViewPort(true);
         dispatchEventWith(Event.CONTEXT3D_CREATE,false,this.context);
         this.initializeRoot();
         this._frameTimestamp = getTimer() / 1000;
      }
      
      private function initializeRoot() : void
      {
         if(this._root == null && this._rootClass != null)
         {
            this._root = new this._rootClass() as DisplayObject;
            if(this._root == null)
            {
               throw new Error("Invalid root class: " + this._rootClass);
            }
            this._stage.addChildAt(this._root,0);
            dispatchEventWith(starling.events.Event.ROOT_CREATED,false,this._root);
         }
      }
      
      public function nextFrame() : void
      {
         var now:Number = getTimer() / 1000;
         var passedTime:Number = now - this._frameTimestamp;
         this._frameTimestamp = now;
         if(passedTime > 1)
         {
            passedTime = 1;
         }
         if(passedTime < 0)
         {
            passedTime = 1 / this._nativeStage.frameRate;
         }
         this.advanceTime(passedTime);
         this.render();
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         if(!this.contextValid)
         {
            return;
         }
         this.makeCurrent();
         this._touchProcessor.advanceTime(passedTime);
         this._stage.advanceTime(passedTime);
         this._juggler.advanceTime(passedTime);
      }
      
      public function render() : void
      {
         var shareContext:Boolean = false;
         var scaleX:Number = NaN;
         var scaleY:Number = NaN;
         var stageColor:uint = 0;
         if(!this.contextValid)
         {
            return;
         }
         this.makeCurrent();
         this.updateViewPort();
         var doRedraw:Boolean = Boolean(this._stage.requiresRedraw) || Boolean(this.mustAlwaysRender);
         if(doRedraw)
         {
            dispatchEventWith(starling.events.Event.RENDER);
            shareContext = Boolean(this._painter.shareContext);
            scaleX = this._viewPort.width / this._stage.stageWidth;
            scaleY = this._viewPort.height / this._stage.stageHeight;
            stageColor = uint(this._stage.color);
            this._painter.nextFrame();
            this._painter.pixelSize = 1 / this.contentScaleFactor;
            this._painter.state.setProjectionMatrix(this._viewPort.x < 0 ? -this._viewPort.x / scaleX : 0,this._viewPort.y < 0 ? -this._viewPort.y / scaleY : 0,this._clippedViewPort.width / scaleX,this._clippedViewPort.height / scaleY,this._stage.stageWidth,this._stage.stageHeight,this._stage.cameraPosition);
            if(!shareContext)
            {
               this._painter.clear(stageColor,Color.getAlpha(stageColor));
            }
            this._stage.render(this._painter);
            this._painter.finishFrame();
            this._painter.frameID = ++this._frameID;
            if(!shareContext)
            {
               this._painter.present();
            }
         }
         if(this._statsDisplay)
         {
            this._statsDisplay.drawCount = this._painter.drawCount;
            if(!doRedraw)
            {
               this._statsDisplay.markFrameAsSkipped();
            }
         }
      }
      
      private function updateViewPort(forceUpdate:Boolean = false) : void
      {
         var contentScaleFactor:Number = NaN;
         if(forceUpdate || !RectangleUtil.compare(this._viewPort,this._previousViewPort))
         {
            this._previousViewPort.setTo(this._viewPort.x,this._viewPort.y,this._viewPort.width,this._viewPort.height);
            this._clippedViewPort = this._viewPort.intersection(new Rectangle(0,0,this._nativeStage.stageWidth,this._nativeStage.stageHeight));
            if(this._clippedViewPort.width < 32)
            {
               this._clippedViewPort.width = 32;
            }
            if(this._clippedViewPort.height < 32)
            {
               this._clippedViewPort.height = 32;
            }
            contentScaleFactor = this._supportHighResolutions ? Number(this._nativeStage.contentsScaleFactor) : 1;
            this._painter.configureBackBuffer(this._clippedViewPort,contentScaleFactor,this._antiAliasing,true);
            this.setRequiresRedraw();
         }
      }
      
      private function updateNativeOverlay() : void
      {
         this._nativeOverlay.x = this._viewPort.x;
         this._nativeOverlay.y = this._viewPort.y;
         this._nativeOverlay.scaleX = this._viewPort.width / this._stage.stageWidth;
         this._nativeOverlay.scaleY = this._viewPort.height / this._stage.stageHeight;
      }
      
      public function stopWithFatalError(message:String) : void
      {
         var background:Shape = null;
         background = new Shape();
         background.graphics.beginFill(0,0.8);
         background.graphics.drawRect(0,0,this._stage.stageWidth,this._stage.stageHeight);
         background.graphics.endFill();
         var textField:TextField = new TextField();
         var textFormat:TextFormat = new TextFormat("Verdana",14,16777215);
         textFormat.align = TextFormatAlign.CENTER;
         textField.defaultTextFormat = textFormat;
         textField.wordWrap = true;
         textField.width = this._stage.stageWidth * 0.75;
         textField.autoSize = TextFieldAutoSize.CENTER;
         textField.text = message;
         textField.x = (this._stage.stageWidth - textField.width) / 2;
         textField.y = (this._stage.stageHeight - textField.height) / 2;
         textField.background = true;
         textField.backgroundColor = 5570560;
         this.updateNativeOverlay();
         this.nativeOverlay.addChild(background);
         this.nativeOverlay.addChild(textField);
         this.stop(true);
         trace("[Starling]",message);
         dispatchEventWith(starling.events.Event.FATAL_ERROR,false,message);
      }
      
      public function makeCurrent() : void
      {
         sCurrent = this;
      }
      
      public function start() : void
      {
         this._started = this._rendering = true;
         this._frameTimestamp = getTimer() / 1000;
         setTimeout(this.setRequiresRedraw,100);
      }
      
      public function stop(suspendRendering:Boolean = false) : void
      {
         this._started = false;
         this._rendering = !suspendRendering;
      }
      
      public function setRequiresRedraw() : void
      {
         this._stage.setRequiresRedraw();
      }
      
      private function onStage3DError(event:ErrorEvent) : void
      {
         var mode:String = null;
         if(event.errorID == 3702)
         {
            mode = Capabilities.playerType == "Desktop" ? "renderMode" : "wmode";
            this.stopWithFatalError("Context3D not available! Possible reasons: wrong " + mode + " or missing device support.");
         }
         else
         {
            this.stopWithFatalError("Stage3D error: " + event.text);
         }
      }
      
      private function onContextCreated(event:flash.events.Event) : void
      {
         this.stage3D.removeEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated);
         this.stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.onContextRestored,false,10,true);
         trace("[Starling] Context ready. Display Driver:",this.context.driverInfo);
         this.initialize();
      }
      
      private function onContextRestored(event:flash.events.Event) : void
      {
         trace("[Starling] Context restored.");
         this.updateViewPort(true);
         dispatchEventWith(Event.CONTEXT3D_CREATE,false,this.context);
      }
      
      private function onEnterFrame(event:flash.events.Event) : void
      {
         if(!this.shareContext)
         {
            if(this._started)
            {
               this.nextFrame();
            }
            else if(this._rendering)
            {
               this.render();
            }
         }
         this.updateNativeOverlay();
      }
      
      private function onKey(event:flash.events.KeyboardEvent) : void
      {
         if(!this._started)
         {
            return;
         }
         var keyEvent:starling.events.KeyboardEvent = new starling.events.KeyboardEvent(event.type,event.charCode,event.keyCode,event.keyLocation,event.ctrlKey,event.altKey,event.shiftKey);
         this.makeCurrent();
         this._stage.dispatchEvent(keyEvent);
         if(keyEvent.isDefaultPrevented())
         {
            event.preventDefault();
         }
      }
      
      private function onResize(event:flash.events.Event) : void
      {
         var stageWidth:int = 0;
         var stageHeight:int = 0;
         var dispatchResizeEvent:* = undefined;
         dispatchResizeEvent = function():void
         {
            makeCurrent();
            removeEventListener(Event.CONTEXT3D_CREATE,dispatchResizeEvent);
            _stage.dispatchEvent(new ResizeEvent(Event.RESIZE,stageWidth,stageHeight));
         };
         stageWidth = int(event.target.stageWidth);
         stageHeight = int(event.target.stageHeight);
         if(this.contextValid)
         {
            dispatchResizeEvent();
         }
         else
         {
            addEventListener(Event.CONTEXT3D_CREATE,dispatchResizeEvent);
         }
      }
      
      private function onMouseLeave(event:flash.events.Event) : void
      {
         this._touchProcessor.enqueueMouseLeftStage();
      }
      
      private function onTouch(event:flash.events.Event) : void
      {
         var globalX:Number = NaN;
         var globalY:Number = NaN;
         var touchID:int = 0;
         var phase:String = null;
         var mouseEvent:MouseEvent = null;
         var touchEvent:flash.events.TouchEvent = null;
         if(!this._started)
         {
            return;
         }
         var pressure:Number = 1;
         var width:Number = 1;
         var height:Number = 1;
         if(event is MouseEvent)
         {
            mouseEvent = event as MouseEvent;
            globalX = mouseEvent.stageX;
            globalY = mouseEvent.stageY;
            touchID = 0;
            if(event.type == MouseEvent.MOUSE_DOWN)
            {
               this._leftMouseDown = true;
            }
            else if(event.type == MouseEvent.MOUSE_UP)
            {
               this._leftMouseDown = false;
            }
         }
         else
         {
            touchEvent = event as TouchEvent;
            if(Boolean(Mouse.supportsCursor) && touchEvent.isPrimaryTouchPoint)
            {
               return;
            }
            globalX = touchEvent.stageX;
            globalY = touchEvent.stageY;
            touchID = touchEvent.touchPointID;
            pressure = touchEvent.pressure;
            width = touchEvent.sizeX;
            height = touchEvent.sizeY;
         }
         switch(event.type)
         {
            case TouchEvent.TOUCH_BEGIN:
               phase = TouchPhase.BEGAN;
               break;
            case TouchEvent.TOUCH_MOVE:
               phase = TouchPhase.MOVED;
               break;
            case TouchEvent.TOUCH_END:
               phase = TouchPhase.ENDED;
               break;
            case MouseEvent.MOUSE_DOWN:
               phase = TouchPhase.BEGAN;
               break;
            case MouseEvent.MOUSE_UP:
               phase = TouchPhase.ENDED;
               break;
            case MouseEvent.MOUSE_MOVE:
               phase = this._leftMouseDown ? TouchPhase.MOVED : TouchPhase.HOVER;
         }
         globalX = this._stage.stageWidth * (globalX - this._viewPort.x) / this._viewPort.width;
         globalY = this._stage.stageHeight * (globalY - this._viewPort.y) / this._viewPort.height;
         this._touchProcessor.enqueue(touchID,phase,globalX,globalY,pressure,width,height);
         if(event.type == MouseEvent.MOUSE_UP && Boolean(Mouse.supportsCursor))
         {
            this._touchProcessor.enqueue(touchID,TouchPhase.HOVER,globalX,globalY);
         }
      }
      
      private function get touchEventTypes() : Array
      {
         var types:Array = [];
         if(multitouchEnabled)
         {
            types.push(TouchEvent.TOUCH_BEGIN,TouchEvent.TOUCH_MOVE,TouchEvent.TOUCH_END);
         }
         if(!multitouchEnabled || Boolean(Mouse.supportsCursor))
         {
            types.push(MouseEvent.MOUSE_DOWN,MouseEvent.MOUSE_MOVE,MouseEvent.MOUSE_UP);
         }
         return types;
      }
      
      private function get mustAlwaysRender() : Boolean
      {
         var nativeStageEmpty:Boolean = false;
         var mustAlwaysRender:Boolean = false;
         if(!this._skipUnchangedFrames || Boolean(this._painter.shareContext))
         {
            return true;
         }
         if(Boolean(SystemUtil.isDesktop) && this.profile != Context3DProfile.BASELINE_CONSTRAINED)
         {
            return false;
         }
         nativeStageEmpty = Boolean(isNativeDisplayObjectEmpty(this._nativeStage));
         mustAlwaysRender = !nativeStageEmpty || !this._nativeStageEmpty;
         this._nativeStageEmpty = nativeStageEmpty;
         return mustAlwaysRender;
      }
      
      public function get isStarted() : Boolean
      {
         return this._started;
      }
      
      public function get juggler() : Juggler
      {
         return this._juggler;
      }
      
      public function get painter() : Painter
      {
         return this._painter;
      }
      
      public function get context() : Context3D
      {
         return this._painter.context;
      }
      
      public function get simulateMultitouch() : Boolean
      {
         return this._touchProcessor.simulateMultitouch;
      }
      
      public function set simulateMultitouch(value:Boolean) : void
      {
         this._touchProcessor.simulateMultitouch = value;
      }
      
      public function get enableErrorChecking() : Boolean
      {
         return this._painter.enableErrorChecking;
      }
      
      public function set enableErrorChecking(value:Boolean) : void
      {
         this._painter.enableErrorChecking = value;
      }
      
      public function get antiAliasing() : int
      {
         return this._antiAliasing;
      }
      
      public function set antiAliasing(value:int) : void
      {
         if(this._antiAliasing != value)
         {
            this._antiAliasing = value;
            if(this.contextValid)
            {
               this.updateViewPort(true);
            }
         }
      }
      
      public function get viewPort() : Rectangle
      {
         return this._viewPort;
      }
      
      public function set viewPort(value:Rectangle) : void
      {
         this._viewPort.copyFrom(value);
      }
      
      public function get contentScaleFactor() : Number
      {
         return this._viewPort.width * this._painter.backBufferScaleFactor / this._stage.stageWidth;
      }
      
      public function get nativeOverlay() : flash.display.Sprite
      {
         return this._nativeOverlay;
      }
      
      public function get showStats() : Boolean
      {
         return this._showStats;
      }
      
      public function set showStats(value:Boolean) : void
      {
         this._showStats = value;
         if(value)
         {
            if(this._statsDisplay)
            {
               this._stage.addChild(this._statsDisplay);
            }
            else
            {
               this.showStatsAt();
            }
         }
         else if(this._statsDisplay)
         {
            this._statsDisplay.removeFromParent();
         }
      }
      
      public function showStatsAt(horizontalAlign:String = "left", verticalAlign:String = "top", scale:Number = 1) : void
      {
         var onRootCreated:* = undefined;
         var stageWidth:int = 0;
         var stageHeight:int = 0;
         onRootCreated = function():void
         {
            if(_showStats)
            {
               showStatsAt(horizontalAlign,verticalAlign,scale);
            }
            removeEventListener(starling.events.Event.ROOT_CREATED,onRootCreated);
         };
         this._showStats = true;
         if(this.context == null)
         {
            addEventListener(starling.events.Event.ROOT_CREATED,onRootCreated);
         }
         else
         {
            stageWidth = int(this._stage.stageWidth);
            stageHeight = int(this._stage.stageHeight);
            if(this._statsDisplay == null)
            {
               this._statsDisplay = new StatsDisplay();
               this._statsDisplay.touchable = false;
            }
            this._stage.addChild(this._statsDisplay);
            this._statsDisplay.scaleX = this._statsDisplay.scaleY = scale;
            if(horizontalAlign == Align.LEFT)
            {
               this._statsDisplay.x = 0;
            }
            else if(horizontalAlign == Align.RIGHT)
            {
               this._statsDisplay.x = stageWidth - this._statsDisplay.width;
            }
            else
            {
               if(horizontalAlign != Align.CENTER)
               {
                  throw new ArgumentError("Invalid horizontal alignment: " + horizontalAlign);
               }
               this._statsDisplay.x = (stageWidth - this._statsDisplay.width) / 2;
            }
            if(verticalAlign == Align.TOP)
            {
               this._statsDisplay.y = 0;
            }
            else if(verticalAlign == Align.BOTTOM)
            {
               this._statsDisplay.y = stageHeight - this._statsDisplay.height;
            }
            else
            {
               if(verticalAlign != Align.CENTER)
               {
                  throw new ArgumentError("Invalid vertical alignment: " + verticalAlign);
               }
               this._statsDisplay.y = (stageHeight - this._statsDisplay.height) / 2;
            }
         }
      }
      
      public function get stage() : starling.display.Stage
      {
         return this._stage;
      }
      
      public function get stage3D() : Stage3D
      {
         return this._painter.stage3D;
      }
      
      public function get nativeStage() : flash.display.Stage
      {
         return this._nativeStage;
      }
      
      public function get root() : starling.display.DisplayObject
      {
         return this._root;
      }
      
      public function get rootClass() : Class
      {
         return this._rootClass;
      }
      
      public function set rootClass(value:Class) : void
      {
         if(this._rootClass != null && this._root != null)
         {
            throw new Error("Root class may not change after root has been instantiated");
         }
         if(this._rootClass == null)
         {
            this._rootClass = value;
            if(this.context)
            {
               this.initializeRoot();
            }
         }
      }
      
      public function get shareContext() : Boolean
      {
         return this._painter.shareContext;
      }
      
      public function set shareContext(value:Boolean) : void
      {
         if(!value)
         {
            this._previousViewPort.setEmpty();
         }
         this._painter.shareContext = value;
      }
      
      public function get profile() : String
      {
         return this._painter.profile;
      }
      
      public function get supportHighResolutions() : Boolean
      {
         return this._supportHighResolutions;
      }
      
      public function set supportHighResolutions(value:Boolean) : void
      {
         if(this._supportHighResolutions != value)
         {
            this._supportHighResolutions = value;
            if(this.contextValid)
            {
               this.updateViewPort(true);
            }
         }
      }
      
      public function get skipUnchangedFrames() : Boolean
      {
         return this._skipUnchangedFrames;
      }
      
      public function set skipUnchangedFrames(value:Boolean) : void
      {
         this._skipUnchangedFrames = value;
         this._nativeStageEmpty = false;
      }
      
      public function get touchProcessor() : TouchProcessor
      {
         return this._touchProcessor;
      }
      
      public function set touchProcessor(value:TouchProcessor) : void
      {
         if(value == null)
         {
            throw new ArgumentError("TouchProcessor must not be null");
         }
         if(value != this._touchProcessor)
         {
            this._touchProcessor.dispose();
            this._touchProcessor = value;
         }
      }
      
      public function get frameID() : uint
      {
         return this._frameID;
      }
      
      public function get contextValid() : Boolean
      {
         return this._painter.contextValid;
      }
   }
}

import flash.display.*;

function isNativeDisplayObjectEmpty(object:flash.display.DisplayObject):Boolean
{
   var container:flash.display.DisplayObjectContainer = null;
   var numChildren:int = 0;
   var i:int = 0;
   if(object == null)
   {
      return true;
   }
   if(object is DisplayObjectContainer)
   {
      container = object as DisplayObjectContainer;
      numChildren = container.numChildren;
      for(i = 0; i < numChildren; i++)
      {
         if(!isNativeDisplayObjectEmpty(container.getChildAt(i)))
         {
            return false;
         }
      }
      return true;
   }
   return !object.visible;
}
