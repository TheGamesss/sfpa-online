package com.miniclip.gamemanager
{
   import flash.events.IEventDispatcher;
   
   public interface GameSocialAPI extends IEventDispatcher
   {
      
      function submitAward(param1:Array, param2:String = "") : void;
      
      function challengeFriend(param1:String = "") : void;
      
      function submitScore(param1:Number, param2:String = "") : void;
      
      function inviteFriend(param1:String = "") : void;
      
      function postMessage(param1:String, param2:String = "") : void;
      
      function saveFriend(param1:int) : void;
      
      function listUsersFriended(param1:int) : void;
      
      function listUsersFriending(param1:int) : void;
      
      function getFriendship(param1:int, param2:int) : void;
      
      function deleteFriend(param1:int) : void;
   }
}

