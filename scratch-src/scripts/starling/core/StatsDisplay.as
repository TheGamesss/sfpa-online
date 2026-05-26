package starling.core
{
   import flash.system.*;
   import starling.display.*;
   import starling.events.*;
   import starling.rendering.Painter;
   import starling.styles.*;
   import starling.text.*;
   import starling.utils.*;
   
   internal class StatsDisplay extends Sprite
   {
      
      private static const UPDATE_INTERVAL:Number = 0.5;
      
      private static const B_TO_MB:Number = 1 / (1024 * 1024);
      
      private var _background:Quad;
      
      private var _labels:TextField;
      
      private var _values:TextField;
      
      private var _frameCount:int = 0;
      
      private var _totalTime:Number = 0;
      
      private var _fps:Number = 0;
      
      private var _memory:Number = 0;
      
      private var _gpuMemory:Number = 0;
      
      private var _drawCount:int = 0;
      
      private var _skipCount:int = 0;
      
      public function StatsDisplay()
      {
         var width:Number = NaN;
         super();
         var fontName:String = BitmapFont.MINI;
         var fontSize:Number = Number(BitmapFont.NATIVE_SIZE);
         var fontColor:uint = 16777215;
         width = 90;
         var height:Number = this.supportsGpuMem ? 35 : 27;
         var gpuLabel:String = this.supportsGpuMem ? "\ngpu memory:" : "";
         var labels:String = "frames/sec:\nstd memory:" + gpuLabel + "\ndraw calls:";
         this._labels = new TextField(width,height,labels);
         this._labels.format.setTo(fontName,fontSize,fontColor,Align.LEFT);
         this._labels.batchable = true;
         this._labels.x = 2;
         this._values = new TextField(width - 1,height,"");
         this._values.format.setTo(fontName,fontSize,fontColor,Align.RIGHT);
         this._values.batchable = true;
         this._background = new Quad(width,height,0);
         if(this._background.style.type != MeshStyle)
         {
            this._background.style = new MeshStyle();
         }
         if(this._labels.style.type != MeshStyle)
         {
            this._labels.style = new MeshStyle();
         }
         if(this._values.style.type != MeshStyle)
         {
            this._values.style = new MeshStyle();
         }
         addChild(this._background);
         addChild(this._labels);
         addChild(this._values);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function onAddedToStage() : void
      {
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._totalTime = this._frameCount = this._skipCount = 0;
         this.update();
      }
      
      private function onRemovedFromStage() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(event:EnterFrameEvent) : void
      {
         this._totalTime += event.passedTime;
         ++this._frameCount;
         if(this._totalTime > UPDATE_INTERVAL)
         {
            this.update();
            this._frameCount = this._skipCount = this._totalTime = 0;
         }
      }
      
      public function update() : void
      {
         this._background.color = this._skipCount > this._frameCount / 2 ? 16128 : 0;
         this._fps = this._totalTime > 0 ? this._frameCount / this._totalTime : 0;
         this._memory = System.totalMemory * B_TO_MB;
         this._gpuMemory = this.supportsGpuMem ? Starling.context["totalGPUMemory"] * B_TO_MB : -1;
         var fpsText:String = this._fps.toFixed(this._fps < 100 ? 1 : 0);
         var memText:String = this._memory.toFixed(this._memory < 100 ? 1 : 0);
         var gpuMemText:String = this._gpuMemory.toFixed(this._gpuMemory < 100 ? 1 : 0);
         var drwText:String = (this._totalTime > 0 ? this._drawCount - 2 : this._drawCount).toString();
         this._values.text = fpsText + "\n" + memText + "\n" + (this._gpuMemory >= 0 ? gpuMemText + "\n" : "") + drwText;
      }
      
      public function markFrameAsSkipped() : void
      {
         this._skipCount += 1;
      }
      
      override public function render(painter:Painter) : void
      {
         painter.excludeFromCache(this);
         painter.finishMeshBatch();
         super.render(painter);
      }
      
      private function get supportsGpuMem() : Boolean
      {
         return "totalGPUMemory" in Starling.context;
      }
      
      public function get drawCount() : int
      {
         return this._drawCount;
      }
      
      public function set drawCount(value:int) : void
      {
         this._drawCount = value;
      }
      
      public function get fps() : Number
      {
         return this._fps;
      }
      
      public function set fps(value:Number) : void
      {
         this._fps = value;
      }
      
      public function get memory() : Number
      {
         return this._memory;
      }
      
      public function set memory(value:Number) : void
      {
         this._memory = value;
      }
      
      public function get gpuMemory() : Number
      {
         return this._gpuMemory;
      }
      
      public function set gpuMemory(value:Number) : void
      {
         this._gpuMemory = value;
      }
   }
}

