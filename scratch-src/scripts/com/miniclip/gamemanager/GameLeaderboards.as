package com.miniclip.gamemanager
{
   import flash.events.IEventDispatcher;
   
   public interface GameLeaderboards extends IEventDispatcher
   {
      
      function submitScore(param1:Number, param2:int) : void;
      
      function registerUser(param1:int) : void;
      
      function listActiveEvents() : void;
      
      function getEvent(param1:int) : void;
   }
}

