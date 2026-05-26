package com.miniclip.events
{
   import flash.events.Event;
   
   public class LeaderboardsEvent extends Event
   {
      
      public static const EVENTS_GET_EVENT:String = "events_get_event";
      
      public static const EVENTS_LIST_ACTIVE:String = "events_list_event";
      
      public static const EVENTS_REGISTER_USER:String = "events_register_user";
      
      public static const LEADERBOARDS_SUBMIT_SCORE:String = "leaderboards_submit_score";
      
      public static const LEADERBOARDS_ON_SHOW:String = "leaderboards_on_show";
      
      public static const LEADERBOARDS_ON_HIDE:String = "leaderboards_on_hide";
      
      private var _data:Object;
      
      public function LeaderboardsEvent(type:String, data:Object = null)
      {
         super(type,false,false);
         this._data = data;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}

