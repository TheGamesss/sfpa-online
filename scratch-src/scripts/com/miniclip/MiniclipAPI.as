package com.miniclip
{
   import com.miniclip.gamemanager.GameAvatars;
   import com.miniclip.gamemanager.GameChat;
   import com.miniclip.gamemanager.GameCredits;
   import com.miniclip.gamemanager.GameCurrencies;
   import com.miniclip.gamemanager.GameLeaderboards;
   import com.miniclip.gamemanager.GameLobby;
   import com.miniclip.gamemanager.GameMidroll;
   import com.miniclip.gamemanager.GamePlayer;
   import com.miniclip.gamemanager.GameServices;
   import com.miniclip.gamemanager.GameSharedGUI;
   import com.miniclip.gamemanager.GameSocialAPI;
   import com.miniclip.gamemanager.GameSponsorship;
   import com.miniclip.gamemanager.GameStorage;
   import com.miniclip.gamemanager.GameTracking;
   import com.miniclip.gamemanager.Utils;
   import flash.display.DisplayObjectContainer;
   
   public class MiniclipAPI
   {
      
      public function MiniclipAPI()
      {
         super();
      }
      
      public static function init(display:DisplayObjectContainer) : void
      {
         MiniclipGameManager.init(display);
      }
      
      public static function get ready() : Boolean
      {
         return MiniclipGameManager.ready;
      }
      
      public static function get info() : String
      {
         return MiniclipGameManager.info;
      }
      
      public static function get version() : String
      {
         return MiniclipGameManager.version;
      }
      
      public static function get services() : GameServices
      {
         return MiniclipGameManager.services;
      }
      
      public static function get player() : GamePlayer
      {
         return MiniclipGameManager.player;
      }
      
      public static function get avatars() : GameAvatars
      {
         return MiniclipGameManager.avatars;
      }
      
      public static function get credits() : GameCredits
      {
         return MiniclipGameManager.credits;
      }
      
      public static function get lobby() : GameLobby
      {
         return MiniclipGameManager.lobby;
      }
      
      public static function get tracking() : GameTracking
      {
         return MiniclipGameManager.tracking;
      }
      
      public static function get midRoll() : GameMidroll
      {
         return MiniclipGameManager.midRoll;
      }
      
      public static function get chat() : GameChat
      {
         return MiniclipGameManager.chat;
      }
      
      public static function get sponsorship() : GameSponsorship
      {
         return MiniclipGameManager.sponsorship;
      }
      
      public static function get currencies() : GameCurrencies
      {
         return MiniclipGameManager.currencies;
      }
      
      public static function get sharedGui() : GameSharedGUI
      {
         return MiniclipGameManager.sharedGui;
      }
      
      public static function get storage() : GameStorage
      {
         return MiniclipGameManager.storage;
      }
      
      public static function get utils() : Utils
      {
         return MiniclipGameManager.utils;
      }
      
      public static function get gameCustomParameters() : Object
      {
         return MiniclipGameManager.gameCustomParameters;
      }
      
      public static function get AMFGateway() : String
      {
         return MiniclipGameManager.AMFGateway;
      }
      
      public static function get socialAPI() : GameSocialAPI
      {
         return MiniclipGameManager.socialAPI;
      }
      
      public static function get leaderboards() : GameLeaderboards
      {
         return MiniclipGameManager.leaderboards;
      }
      
      public static function addEventListener(type:String, listener:Function) : void
      {
         MiniclipGameManager.addEventListener(type,listener,false,0,true);
      }
      
      public static function removeEventListener(type:String, listener:Function) : void
      {
         MiniclipGameManager.removeEventListener(type,listener);
      }
      
      public static function hasEventListener(type:String) : Boolean
      {
         return MiniclipGameManager.hasEventListener(type);
      }
   }
}

import com.miniclip.gamemanager.GameStorage;

GameStorage;

