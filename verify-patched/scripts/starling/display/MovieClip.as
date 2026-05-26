package starling.display
{
   import flash.errors.*;
   import flash.media.Sound;
   import flash.media.SoundTransform;
   import starling.animation.*;
   import starling.events.*;
   import starling.textures.Texture;
   
   public class MovieClip extends Image implements IAnimatable
   {
      
      private var _frames:Vector.<MovieClipFrame>;
      
      private var _defaultFrameDuration:Number;
      
      private var _currentTime:Number;
      
      private var _currentFrameID:int;
      
      private var _loop:Boolean;
      
      private var _playing:Boolean;
      
      private var _muted:Boolean;
      
      private var _wasStopped:Boolean;
      
      private var _soundTransform:SoundTransform;
      
      public function MovieClip(textures:Vector.<Texture>, fps:Number = 12)
      {
         if(textures.length > 0)
         {
            super(textures[0]);
            this.init(textures,fps);
            return;
         }
         throw new ArgumentError("Empty texture array");
      }
      
      private function init(textures:Vector.<Texture>, fps:Number) : void
      {
         if(fps <= 0)
         {
            throw new ArgumentError("Invalid fps: " + fps);
         }
         var numFrames:int = int(textures.length);
         this._defaultFrameDuration = 1 / fps;
         this._loop = true;
         this._playing = true;
         this._currentTime = 0;
         this._currentFrameID = 0;
         this._wasStopped = true;
         this._frames = new Vector.<MovieClipFrame>(0);
         for(var i:int = 0; i < numFrames; i++)
         {
            this._frames[i] = new MovieClipFrame(textures[i],this._defaultFrameDuration,this._defaultFrameDuration * i);
         }
      }
      
      public function addFrame(texture:Texture, sound:Sound = null, duration:Number = -1) : void
      {
         this.addFrameAt(this.numFrames,texture,sound,duration);
      }
      
      public function addFrameAt(frameID:int, texture:Texture, sound:Sound = null, duration:Number = -1) : void
      {
         var prevStartTime:Number = NaN;
         var prevDuration:Number = NaN;
         if(frameID < 0 || frameID > this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         if(duration < 0)
         {
            duration = Number(this._defaultFrameDuration);
         }
         var frame:MovieClipFrame = new MovieClipFrame(texture,duration);
         frame.sound = sound;
         this._frames.insertAt(frameID,frame);
         if(frameID == this.numFrames)
         {
            prevStartTime = frameID > 0 ? Number(this._frames[frameID - 1].startTime) : 0;
            prevDuration = frameID > 0 ? Number(this._frames[frameID - 1].duration) : 0;
            frame.startTime = prevStartTime + prevDuration;
         }
         else
         {
            this.updateStartTimes();
         }
      }
      
      public function removeFrameAt(frameID:int) : void
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         if(this.numFrames == 1)
         {
            throw new IllegalOperationError("Movie clip must not be empty");
         }
         this._frames.removeAt(frameID);
         if(frameID != this.numFrames)
         {
            this.updateStartTimes();
         }
      }
      
      public function getFrameTexture(frameID:int) : Texture
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         return this._frames[frameID].texture;
      }
      
      public function setFrameTexture(frameID:int, texture:Texture) : void
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         this._frames[frameID].texture = texture;
      }
      
      public function getFrameSound(frameID:int) : Sound
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         return this._frames[frameID].sound;
      }
      
      public function setFrameSound(frameID:int, sound:Sound) : void
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         this._frames[frameID].sound = sound;
      }
      
      public function getFrameAction(frameID:int) : Function
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         return this._frames[frameID].action;
      }
      
      public function setFrameAction(frameID:int, action:Function) : void
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         this._frames[frameID].action = action;
      }
      
      public function getFrameDuration(frameID:int) : Number
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         return this._frames[frameID].duration;
      }
      
      public function setFrameDuration(frameID:int, duration:Number) : void
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         this._frames[frameID].duration = duration;
         this.updateStartTimes();
      }
      
      public function reverseFrames() : void
      {
         this._frames.reverse();
         this._currentTime = this.totalTime - this._currentTime;
         this._currentFrameID = this.numFrames - this._currentFrameID - 1;
         this.updateStartTimes();
      }
      
      public function play() : void
      {
         this._playing = true;
      }
      
      public function pause() : void
      {
         this._playing = false;
      }
      
      public function stop() : void
      {
         this._playing = false;
         this._wasStopped = true;
         this.currentFrame = 0;
      }
      
      private function updateStartTimes() : void
      {
         var numFrames:int = this.numFrames;
         var prevFrame:MovieClipFrame = this._frames[0];
         prevFrame.startTime = 0;
         for(var i:int = 1; i < numFrames; i++)
         {
            this._frames[i].startTime = prevFrame.startTime + prevFrame.duration;
            prevFrame = this._frames[i];
         }
      }
      
      public function nextFrameStep(frames:Number) : Boolean
      {
         this._currentTime += frames;
         if(this._currentTime >= 1)
         {
            ++this._currentFrameID;
            if(this._currentFrameID < this.numFrames)
            {
               --this._currentTime;
               frame = this._frames[this._currentFrameID];
               texture = frame.texture;
               return false;
            }
            if(this._loop)
            {
               this._currentFrameID = 0;
               --this._currentTime;
               frame = this._frames[this._currentFrameID];
               texture = frame.texture;
               return false;
            }
            return true;
         }
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         var changedFrame:Boolean = false;
         if(!this._playing)
         {
            return;
         }
         var frame:MovieClipFrame = this._frames[this._currentFrameID];
         if(this._wasStopped)
         {
            this._wasStopped = false;
            frame.playSound(this._soundTransform);
            if(frame.action != null)
            {
               frame.executeAction(this,this._currentFrameID);
               this.advanceTime(passedTime);
               return;
            }
         }
         if(this._currentTime == this.totalTime)
         {
            if(!this._loop)
            {
               return;
            }
            this._currentTime = 0;
            this._currentFrameID = 0;
            frame = this._frames[0];
            frame.playSound(this._soundTransform);
            texture = frame.texture;
            if(frame.action != null)
            {
               frame.executeAction(this,this._currentFrameID);
               this.advanceTime(passedTime);
               return;
            }
         }
         var finalFrameID:int = this._frames.length - 1;
         var restTimeInFrame:Number = frame.duration - this._currentTime + frame.startTime;
         var dispatchCompleteEvent:Boolean = false;
         var frameAction:Function = null;
         var previousFrameID:int = int(this._currentFrameID);
         while(passedTime >= restTimeInFrame)
         {
            changedFrame = false;
            passedTime -= restTimeInFrame;
            this._currentTime = frame.startTime + frame.duration;
            if(this._currentFrameID == finalFrameID)
            {
               if(hasEventListener(Event.COMPLETE))
               {
                  dispatchCompleteEvent = true;
               }
               else
               {
                  if(!this._loop)
                  {
                     return;
                  }
                  this._currentTime = 0;
                  this._currentFrameID = 0;
                  changedFrame = true;
               }
            }
            else
            {
               this._currentFrameID += 1;
               changedFrame = true;
            }
            frame = this._frames[this._currentFrameID];
            frameAction = frame.action;
            if(changedFrame)
            {
               frame.playSound(this._soundTransform);
            }
            if(dispatchCompleteEvent)
            {
               texture = frame.texture;
               dispatchEventWith(Event.COMPLETE);
               this.advanceTime(passedTime);
               return;
            }
            if(frameAction != null)
            {
               texture = frame.texture;
               frame.executeAction(this,this._currentFrameID);
               this.advanceTime(passedTime);
               return;
            }
            restTimeInFrame = frame.duration;
            if(passedTime + 0.0001 > restTimeInFrame && passedTime - 0.0001 < restTimeInFrame)
            {
               passedTime = restTimeInFrame;
            }
         }
         if(previousFrameID != this._currentFrameID)
         {
            texture = this._frames[this._currentFrameID].texture;
         }
         this._currentTime += passedTime;
      }
      
      public function get numFrames() : int
      {
         return this._frames.length;
      }
      
      public function get totalTime() : Number
      {
         var lastFrame:MovieClipFrame = this._frames[this._frames.length - 1];
         return lastFrame.startTime + lastFrame.duration;
      }
      
      public function get currentTime() : Number
      {
         return this._currentTime;
      }
      
      public function set currentTime(value:Number) : void
      {
         if(value < 0 || value > this.totalTime)
         {
            throw new ArgumentError("Invalid time: " + value);
         }
         var lastFrameID:int = this._frames.length - 1;
         this._currentTime = value;
         this._currentFrameID = 0;
         while(this._currentFrameID < lastFrameID && this._frames[this._currentFrameID + 1].startTime <= value)
         {
            ++this._currentFrameID;
         }
         var frame:MovieClipFrame = this._frames[this._currentFrameID];
         texture = frame.texture;
      }
      
      public function get loop() : Boolean
      {
         return this._loop;
      }
      
      public function set loop(value:Boolean) : void
      {
         this._loop = value;
      }
      
      public function get muted() : Boolean
      {
         return this._muted;
      }
      
      public function set muted(value:Boolean) : void
      {
         this._muted = value;
      }
      
      public function get soundTransform() : SoundTransform
      {
         return this._soundTransform;
      }
      
      public function set soundTransform(value:SoundTransform) : void
      {
         this._soundTransform = value;
      }
      
      public function get currentFrame() : int
      {
         return this._currentFrameID + 1;
      }
      
      public function set currentFrame(value:int) : void
      {
         if(value < 0 || value - 1 >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         this.currentTime = this._frames[value - 1].startTime;
      }
      
      public function get fps() : Number
      {
         return 1 / this._defaultFrameDuration;
      }
      
      public function set fps(value:Number) : void
      {
         if(value <= 0)
         {
            throw new ArgumentError("Invalid fps: " + value);
         }
         var newFrameDuration:Number = 1 / value;
         var acceleration:Number = newFrameDuration / this._defaultFrameDuration;
         this._currentTime *= acceleration;
         this._defaultFrameDuration = newFrameDuration;
         for(var i:int = 0; i < this.numFrames; i++)
         {
            this._frames[i].duration *= acceleration;
         }
         this.updateStartTimes();
      }
      
      public function get isPlaying() : Boolean
      {
         if(this._playing)
         {
            return Boolean(this._loop) || this._currentTime < this.totalTime;
         }
         return false;
      }
      
      public function get isComplete() : Boolean
      {
         return !this._loop && this._currentTime >= this.totalTime;
      }
   }
}

import flash.media.Sound;
import flash.media.SoundTransform;
import starling.textures.Texture;

class MovieClipFrame
{
   
   public var texture:Texture;
   
   public var sound:Sound;
   
   public var duration:Number;
   
   public var startTime:Number;
   
   public var action:Function;
   
   public function MovieClipFrame(texture:Texture, duration:Number = 0.1, startTime:Number = 0)
   {
      super();
      this.texture = texture;
      this.duration = duration;
      this.startTime = startTime;
   }
   
   public function playSound(transform:SoundTransform) : void
   {
      if(this.sound)
      {
         this.sound.play(0,0,transform);
      }
   }
   
   public function executeAction(movie:MovieClip, frameID:int) : void
   {
      var numArgs:int = 0;
      if(this.action != null)
      {
         numArgs = int(this.action.length);
         if(numArgs == 0)
         {
            this.action();
         }
         else if(numArgs == 1)
         {
            this.action(movie);
         }
         else
         {
            if(numArgs != 2)
            {
               throw new Error("Frame actions support zero, one or two parameters: " + "movie:MovieClip, frameID:int");
            }
            this.action(movie,frameID);
         }
      }
   }
}
