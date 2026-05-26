package com.newgrounds.components
{
   import adobe.utils.*;
   import com.newgrounds.API;
   import com.newgrounds.APIEvent;
   import com.newgrounds.Medal;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol8754")]
   public dynamic class MedalPopup extends MovieClip
   {
      
      public var medalPointsText:TextField;
      
      public var medalIcon:MovieClip;
      
      public var _unlockedMedal:Medal;
      
      public var medalNameClip:MovieClip;
      
      public var alwaysOnTop:String;
      
      public var _alwaysOnTop:Boolean;
      
      public var _medalScrollRect:Rectangle;
      
      public var _medalQueue:Array;
      
      public function MedalPopup()
      {
         super();
         addFrameScript(0,frame1,14,frame15,22,frame23,83,frame84,104,frame105);
      }
      
      public function medalPopupEnterFrame(param1:Event) : void
      {
         var topIndex:uint = 0;
         var event:Event = param1;
         if(_alwaysOnTop)
         {
            try
            {
               if(parent)
               {
                  topIndex = parent.numChildren - 1;
                  if(parent.getChildIndex(this) != topIndex)
                  {
                     parent.setChildIndex(this,topIndex);
                  }
               }
            }
            catch(error:*)
            {
               removeEventListener(Event.ENTER_FRAME,medalPopupEnterFrame);
            }
         }
         if(_medalScrollRect)
         {
            _medalScrollRect.offset(2,0);
            medalNameClip.scrollRect = _medalScrollRect;
            if(_medalScrollRect.left >= medalNameClip.textField.textWidth + 10)
            {
               _medalScrollRect = null;
               play();
            }
         }
      }
      
      internal function frame15() : *
      {
         if(_unlockedMedal)
         {
            if(Boolean(medalNameClip) && Boolean(medalNameClip.textField))
            {
               medalNameClip.textField.text = _unlockedMedal.name;
            }
            if(medalPointsText)
            {
               medalPointsText.text = _unlockedMedal.value.toString();
            }
            if(medalNameClip.textField.textWidth > medalNameClip.width)
            {
               _medalScrollRect = new Rectangle(-medalNameClip.width,0,medalNameClip.width,medalNameClip.height);
               medalNameClip.textField.width = 1000;
               medalNameClip.scrollRect = _medalScrollRect;
            }
            addEventListener(Event.ENTER_FRAME,medalPopupEnterFrame);
         }
      }
      
      public function onMedalUnlocked(param1:APIEvent) : void
      {
         if(param1.success)
         {
            _medalQueue.push(param1.data);
            showNextUnlock();
         }
      }
      
      internal function frame84() : *
      {
         if(_medalScrollRect)
         {
            stop();
         }
      }
      
      internal function frame1() : *
      {
         gotoAndStop("hidden");
         API.addEventListener(APIEvent.MEDAL_UNLOCKED,onMedalUnlocked);
         x = int(x);
         y = int(y);
         _medalQueue = [];
         _alwaysOnTop = true;
         if(alwaysOnTop)
         {
            _alwaysOnTop = alwaysOnTop == "true";
         }
      }
      
      internal function frame23() : *
      {
         if(Boolean(_unlockedMedal) && Boolean(medalIcon))
         {
            _unlockedMedal.attachIcon(medalIcon);
         }
      }
      
      public function showNextUnlock() : void
      {
         if(_unlockedMedal)
         {
            return;
         }
         if(!_medalQueue.length)
         {
            gotoAndStop("hidden");
            removeEventListener(Event.ENTER_FRAME,medalPopupEnterFrame);
            return;
         }
         _unlockedMedal = Medal(_medalQueue.shift());
         gotoAndPlay("medalUnlocked");
      }
      
      internal function frame105() : *
      {
         stop();
         _unlockedMedal = null;
         showNextUnlock();
      }
   }
}

