package com.miniclip.mock
{
   import com.miniclip.events.LeaderboardsEvent;
   import com.miniclip.gamemanager.GameLeaderboards;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class LeaderboardsMock extends EventDispatcher implements GameLeaderboards
   {
      
      public function LeaderboardsMock(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public function submitScore(score:Number, level:int) : void
      {
         this.dispatchEvent(new LeaderboardsEvent(LeaderboardsEvent.LEADERBOARDS_SUBMIT_SCORE,{
            "success":false,
            "description":"called outside Game Manager"
         }));
      }
      
      public function registerUser(event_id:int) : void
      {
         this.dispatchEvent(new LeaderboardsEvent(LeaderboardsEvent.EVENTS_REGISTER_USER,{
            "success":false,
            "description":"called outside Game Manager"
         }));
      }
      
      public function listActiveEvents() : void
      {
         this.dispatchEvent(new LeaderboardsEvent(LeaderboardsEvent.EVENTS_LIST_ACTIVE,{
            "success":false,
            "description":"called outside Game Manager"
         }));
      }
      
      public function getEvent(event_id:int) : void
      {
         this.dispatchEvent(new LeaderboardsEvent(LeaderboardsEvent.EVENTS_GET_EVENT,{
            "success":false,
            "description":"called outside Game Manager"
         }));
      }
   }
}

import com.miniclip.events.LeaderboardsEvent;

LeaderboardsEvent;

