package com.miniclip.mock
{
   import com.miniclip.events.GameManagerEvent;
   import com.miniclip.gamemanager.GameAvatars;
   import com.miniclip.gamemanager.GameChat;
   import com.miniclip.gamemanager.GameCredits;
   import com.miniclip.gamemanager.GameCurrencies;
   import com.miniclip.gamemanager.GameLeaderboards;
   import com.miniclip.gamemanager.GameLobby;
   import com.miniclip.gamemanager.GameManager;
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
   import flash.display.Sprite;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class GameManagerMock extends Sprite implements GameManager
   {
      
      private var _ready:Boolean;
      
      private var _services:GameServices;
      
      private var _player:GamePlayer;
      
      private var _avatars:GameAvatars;
      
      private var _credits:GameCredits;
      
      private var _currencies:GameCurrencies;
      
      private var _lobby:GameLobby;
      
      private var _tracking:GameTracking;
      
      private var _midroll:GameMidroll;
      
      private var _chat:GameChat;
      
      private var _sponsorship:GameSponsorship;
      
      private var _storage:GameStorage;
      
      private var _sharedGui:GameSharedGUI;
      
      private var _socialAPI:GameSocialAPI;
      
      private const delayedReadyPeriod:uint = 250;
      
      private var _hReadyDelayInterval:uint;
      
      private var _leaderboards:GameLeaderboards;
      
      public function GameManagerMock()
      {
         super();
         if(Capabilities.playerType != "Desktop")
         {
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
         }
         this.initServices();
      }
      
      private function initServices() : void
      {
         this._services = new MiniclipServices();
         this._player = new MiniclipPlayer(new MiniclipStorage());
         this._avatars = new MiniclipAvatars();
         this._avatars = new MiniclipAvatars();
         this._credits = new MiniclipCredits();
         this._currencies = new MiniclipCurrencies();
         this._lobby = new MiniclipLobby();
         this._tracking = new MiniclipTracking();
         this._chat = new MiniclipChat();
         this._storage = new MiniclipStorage();
         this._socialAPI = new MiniclipSocialAPI();
         this._sharedGui = new GameSharedGUI(ApplicationDomain.currentDomain);
         this._leaderboards = new LeaderboardsMock();
      }
      
      public function init(display:DisplayObjectContainer) : void
      {
         this._ready = true;
         this.dispatchEvent(new GameManagerEvent(GameManagerEvent.READY));
         this._hReadyDelayInterval = setInterval(this.onDelayedGameReadyTimer,this.delayedReadyPeriod);
      }
      
      private function onDelayedGameReadyTimer() : void
      {
         clearInterval(this._hReadyDelayInterval);
         this.dispatchEvent(new GameManagerEvent(GameManagerEvent.GAME_READY));
      }
      
      public function get gameCustomParameters() : Object
      {
         return {};
      }
      
      public function get gmDomain() : ApplicationDomain
      {
         return ApplicationDomain.currentDomain;
      }
      
      public function get version() : String
      {
         return "4.0.0.0";
      }
      
      public function get services() : GameServices
      {
         return this._services;
      }
      
      public function get player() : GamePlayer
      {
         return this._player;
      }
      
      public function get avatars() : GameAvatars
      {
         return this._avatars;
      }
      
      public function get credits() : GameCredits
      {
         return this._credits;
      }
      
      public function get currencies() : GameCurrencies
      {
         return this._currencies;
      }
      
      public function get lobby() : GameLobby
      {
         return this._lobby;
      }
      
      public function get tracking() : GameTracking
      {
         return this._tracking;
      }
      
      public function get ready() : Boolean
      {
         return this._ready;
      }
      
      public function get midRoll() : GameMidroll
      {
         return null;
      }
      
      public function get chat() : GameChat
      {
         return this._chat;
      }
      
      public function get info() : String
      {
         return "Miniclip Game Manager (Development Mode)";
      }
      
      public function get sponsorship() : GameSponsorship
      {
         return null;
      }
      
      public function get utils() : Utils
      {
         return Utils.instance;
      }
      
      public function get AMFGateway() : String
      {
         return "/php/amfphp/gateway.php";
      }
      
      public function get sharedGui() : GameSharedGUI
      {
         return this._sharedGui;
      }
      
      public function get storage() : GameStorage
      {
         return this._storage;
      }
      
      public function get socialAPI() : GameSocialAPI
      {
         return this._socialAPI;
      }
      
      public function get leaderboards() : GameLeaderboards
      {
         return this._leaderboards;
      }
   }
}

import com.miniclip.events.MiniclipMediaEvent;

MiniclipMediaEvent;

