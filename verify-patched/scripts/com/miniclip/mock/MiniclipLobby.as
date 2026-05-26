package com.miniclip.mock
{
   import com.miniclip.gamemanager.GameLobby;
   import com.miniclip.gamemanager.lobby.LobbyConfig;
   import com.miniclip.gamemanager.lobby.MultiplayerClient;
   import com.miniclip.loggers.LogsHandler;
   import flash.display.Sprite;
   
   public class MiniclipLobby extends Sprite implements GameLobby
   {
      
      private var _client:MultiplayerClient;
      
      private var _features:int;
      
      public function MiniclipLobby()
      {
         super();
         LogsHandler.debug("MiniclipLobby ctor");
      }
      
      public function connect(zoneName:String = null) : void
      {
         LogsHandler.info("MiniclipLobby.connect(" + zoneName + ")");
      }
      
      public function disconnect() : void
      {
         LogsHandler.info("MiniclipLobby.disconnect()");
      }
      
      public function showLobby(zoneName:String = null) : void
      {
         LogsHandler.info("MiniclipLobby.showLobby(" + zoneName + ")");
      }
      
      public function hideLobby() : void
      {
         LogsHandler.info("MiniclipLobby.hideLobby()");
      }
      
      public function startGame(client:MultiplayerClient, game:Object) : void
      {
         LogsHandler.info("MiniclipLobby.startGame(" + client + ", " + game + ")");
         this._client = client;
      }
      
      public function endGame(game:Object) : void
      {
         LogsHandler.info("MiniclipLobby.endGame(" + game + ")");
      }
      
      public function updateGame(game:Object) : void
      {
         LogsHandler.info("MiniclipLobby.updateGame(" + game + ")");
      }
      
      public function updateStatistics(statistics:Object) : void
      {
         LogsHandler.info("MiniclipLobby.updateStatistics(" + statistics + ")");
      }
      
      public function playerLeft(player:Object) : void
      {
         LogsHandler.info("MiniclipLobby.playerLeft(" + player + ")");
      }
      
      public function track(trackID:String, parameters:Object = null) : void
      {
         LogsHandler.info("MiniclipLobby.track(" + trackID + ", " + parameters + ")");
      }
      
      public function sendChatMessage(message:String) : void
      {
         LogsHandler.info("MiniclipLobby.sendChatMessage(" + message + ")");
      }
      
      public function get client() : MultiplayerClient
      {
         LogsHandler.info("MiniclipLobby.client = " + this._client + ")");
         return this._client;
      }
      
      public function setFeatures(value:int) : void
      {
         LogsHandler.info("MiniclipLobby.setFeatures(" + value + ")");
         this._features = value;
      }
      
      public function getFeatures() : int
      {
         LogsHandler.info("MiniclipLobby.getFeatures()");
         return this._features;
      }
      
      public function joinQueue() : void
      {
         LogsHandler.info("MiniclipLobby.joinQueue()");
      }
      
      public function leaveQueue() : void
      {
         LogsHandler.info("MiniclipLobby.leaveQueue()");
      }
      
      public function get config() : LobbyConfig
      {
         LogsHandler.info("MiniclipLobby.config");
         return null;
      }
   }
}

