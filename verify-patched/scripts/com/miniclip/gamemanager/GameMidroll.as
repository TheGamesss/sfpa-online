package com.miniclip.gamemanager
{
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   
   public class GameMidroll extends EventDispatcher
   {
      
      public function GameMidroll()
      {
         super(null);
      }
      
      public function requestVideo(target:Sprite) : IMiniclipMediaPlayer
      {
         return null;
      }
      
      public function get infoText() : String
      {
         return "";
      }
   }
}

