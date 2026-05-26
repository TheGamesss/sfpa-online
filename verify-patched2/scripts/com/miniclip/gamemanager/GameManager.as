package com.miniclip.gamemanager
{
   import flash.display.DisplayObjectContainer;
   import flash.events.IEventDispatcher;
   import flash.system.ApplicationDomain;
   
   public interface GameManager extends IEventDispatcher
   {
      
      function init(param1:DisplayObjectContainer) : void;
      
      function get ready() : Boolean;
      
      function get info() : String;
      
      function get gmDomain() : ApplicationDomain;
      
      function get gameCustomParameters() : Object;
      
      function get version() : String;
      
      function get services() : GameServices;
      
      function get player() : GamePlayer;
      
      function get avatars() : GameAvatars;
      
      function get credits() : GameCredits;
      
      function get currencies() : GameCurrencies;
      
      function get lobby() : GameLobby;
      
      function get tracking() : GameTracking;
      
      function get midRoll() : GameMidroll;
      
      function get chat() : GameChat;
      
      function get sponsorship() : GameSponsorship;
      
      function get utils() : Utils;
      
      function get AMFGateway() : String;
      
      function get sharedGui() : GameSharedGUI;
      
      function get storage() : GameStorage;
      
      function get socialAPI() : GameSocialAPI;
      
      function get leaderboards() : GameLeaderboards;
   }
}

GameSocialAPI;

