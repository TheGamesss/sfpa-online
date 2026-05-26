package com.miniclip.mock
{
   import com.miniclip.events.GameChatEvent;
   import com.miniclip.gamemanager.GameChat;
   import flash.events.EventDispatcher;
   
   public class MiniclipChat extends EventDispatcher implements GameChat
   {
      
      public function MiniclipChat()
      {
         super();
      }
      
      public function init() : void
      {
         dispatchEvent(new GameChatEvent(GameChatEvent.LOADED));
      }
      
      public function getWordsBeginning(startChars:String) : Array
      {
         var returnArray:Array = new Array();
         returnArray.push(startChars);
         return returnArray;
      }
      
      public function getFirstWordBeginning(startChars:String) : String
      {
         return startChars;
      }
      
      public function checkPhraseAcceptable(sentence:String) : Boolean
      {
         return true;
      }
      
      public function submitBadPhrase(reported_user_id:int, context:Array) : void
      {
         dispatchEvent(new GameChatEvent(GameChatEvent.SUBMITTED));
      }
   }
}

