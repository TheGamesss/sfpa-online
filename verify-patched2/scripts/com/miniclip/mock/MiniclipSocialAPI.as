package com.miniclip.mock
{
   import com.miniclip.gamemanager.GameSocialAPI;
   import flash.events.EventDispatcher;
   
   public class MiniclipSocialAPI extends EventDispatcher implements GameSocialAPI
   {
      
      public function MiniclipSocialAPI()
      {
         super();
      }
      
      public function saveFriend(uid:int) : void
      {
         trace("submitAward saveFriend");
      }
      
      public function listUsersFriended(uid:int) : void
      {
         trace("submitAward listUsersFriended");
      }
      
      public function listUsersFriending(uid:int) : void
      {
         trace("submitAward listUsersFriending");
      }
      
      public function getFriendship(uid0:int, uid1:int) : void
      {
         trace("submitAward getFriendship");
      }
      
      public function deleteFriend(uid:int) : void
      {
         trace("submitAward deleteFriend");
      }
      
      public function submitAward(awards:Array, platform:String = "") : void
      {
         trace("MiniclipSocialAPI::submitAward ");
      }
      
      public function submitScore(scores:Number, platform:String = "") : void
      {
         trace("MiniclipSocialAPI::submitScore");
      }
      
      public function inviteFriend(platform:String = "") : void
      {
         trace("MiniclipSocialAPI::inviteFriend");
      }
      
      public function challengeFriend(platform:String = "") : void
      {
         trace("MiniclipSocialAPI::challengeFriend");
      }
      
      public function postMessage(msg:String, platform:String = "") : void
      {
         trace("MiniclipSocialAPI::postMessage");
      }
   }
}

import com.miniclip.events.SocialApiEvent;

SocialApiEvent;

