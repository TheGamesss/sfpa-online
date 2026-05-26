package com.miniclip.events
{
   import flash.events.Event;
   
   public class GameManagerEvent extends Event
   {
      
      public static const ADD_CONTEXTMENU:String = "gamemanager_add_contextmenu";
      
      public static const PLAY:String = "gamemanager_play";
      
      public static const READY:String = "gamemanager_ready";
      
      public static const GAME_READY:String = "gamemanager_game_ready";
      
      public static const GAME_ENABLE:String = "gamemanager_game_enable";
      
      public static const GAME_DISABLE:String = "gamemanager_game_disable";
      
      private var _message:String;
      
      public function GameManagerEvent(type:String, message:String = "", bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this._message = message;
      }
      
      public function get message() : String
      {
         return this._message;
      }
      
      override public function clone() : Event
      {
         return new GameManagerEvent(type,this.message,bubbles,cancelable);
      }
   }
}

