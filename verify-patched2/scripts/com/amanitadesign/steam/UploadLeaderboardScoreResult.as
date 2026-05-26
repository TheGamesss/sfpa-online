package com.amanitadesign.steam
{
   public class UploadLeaderboardScoreResult
   {
      
      public var success:Boolean;
      
      public var leaderboardHandle:String;
      
      public var score:int;
      
      public var scoreChanged:Boolean;
      
      public var newGlobalRank:int;
      
      public var previousGlobalRank:int;
      
      public function UploadLeaderboardScoreResult()
      {
         super();
      }
   }
}

