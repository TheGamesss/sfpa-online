package com.miniclip.mock
{
   import com.miniclip.events.AuthenticationEvent;
   import com.miniclip.events.PlayerEvent;
   import com.miniclip.gamemanager.GamePlayer;
   import com.miniclip.gamemanager.GameStorage;
   import com.miniclip.gamemanager.LoginBoxScreen;
   import com.miniclip.gamemanager.player.LoginScreens;
   import com.miniclip.loggers.LogsHandler;
   import com.miniclip.net.authentication.UserDetails;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class MiniclipPlayer extends EventDispatcher implements GamePlayer
   {
      
      private var _storage:GameStorage;
      
      public function MiniclipPlayer(storage:GameStorage = null)
      {
         super();
         this._storage = storage;
      }
      
      public function get storage() : GameStorage
      {
         return this._storage;
      }
      
      public function getUserDetails(useCache:Boolean = true) : void
      {
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.NOT_LOGGED_IN));
      }
      
      public function isLoggedIn(useCache:Boolean = true) : void
      {
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.NOT_LOGGED_IN));
      }
      
      public function get userDetails() : UserDetails
      {
         return null;
      }
      
      public function isAlreadyLoggedIn() : Boolean
      {
         LogsHandler.info("player.isAlreadyLoggedIn()");
         return false;
      }
      
      public function logout() : void
      {
         LogsHandler.info("player.logout()");
      }
      
      public function login(forceDisplay:Boolean = false, showBackground:Boolean = true, showCancelButton:Boolean = true, screen:LoginScreens = null, position:Point = null) : LoginBoxScreen
      {
         LogsHandler.info("player.login()");
         return null;
      }
      
      public function editYoMe(showBackground:Boolean = true, showCloseButton:Boolean = false, position:Point = null) : *
      {
         LogsHandler.warn("player.editYoMe() - not supported in Developers\' GameManager");
         return null;
      }
      
      public function getAvatarSelection(id:uint) : void
      {
         var result:Object = null;
         LogsHandler.info("player.getAvatarSelection(" + String(id) + ")");
         if(id > 0)
         {
            result = new Object();
            result.id = id;
            result.avatar = 1;
            dispatchEvent(new PlayerEvent(PlayerEvent.AVATAR_STATUS,result));
         }
         else
         {
            dispatchEvent(new PlayerEvent(PlayerEvent.ERROR,"Player ID must be greater than zero"));
         }
      }
   }
}

