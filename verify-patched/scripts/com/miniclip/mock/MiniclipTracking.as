package com.miniclip.mock
{
   import com.miniclip.gamemanager.GameTracking;
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   
   public class MiniclipTracking implements GameTracking
   {
      
      private var _uniqueID:uint;
      
      public function MiniclipTracking()
      {
         super();
         this._uniqueID = this._generate32bitRandom();
      }
      
      private function _generate32bitRandom() : int
      {
         return int(Math.random() * 2147483647);
      }
      
      public function get uniqueID() : uint
      {
         return this._uniqueID;
      }
      
      public function get sessionID() : String
      {
         return "thisisafakesession";
      }
      
      public function get gameID() : uint
      {
         return 1808;
      }
      
      public function get userID() : uint
      {
         return 0;
      }
      
      public function get time() : int
      {
         return getTimer();
      }
      
      public function get timeStamp() : Number
      {
         var now:Date = new Date();
         return Math.round(now.time / 1000);
      }
      
      public function get locale() : String
      {
         return Capabilities.language;
      }
   }
}

