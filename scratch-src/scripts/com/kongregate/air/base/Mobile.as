package com.kongregate.air.base
{
   import com.kongregate.air.IMobile;
   import com.kongregate.air.KongregateAPI;
   
   public class Mobile implements IMobile
   {
      
      public static const TARGET_MORE_GAMES:String = "more_games";
      
      public static const TARGET_HIGH_SCORES:String = "high_scores";
      
      public static const TARGET_FORUMS:String = "forums";
      
      public static const TARGET_SUPPORT:String = "support";
      
      public static const TARGET_OFFERS:String = "offer_rewards";
      
      public static const TARGET_REGISTRATION:String = "registration";
      
      public static const TARGET_TERMS:String = "terms";
      
      public static const TARGET_PRIVACY:String = "privacy";
      
      public static const TARGET_GUILD_CHAT:String = "guild_chat";
      
      public static const TARGET_TOPICS:String = "topics";
      
      public static const TARGET_MESSAGES:String = "messages";
      
      public static const PANEL_EVENT_GO_TO_GUILDS:String = "GO_TO_GUILDS";
      
      public static const PANEL_TRANSITION_SLIDE_FROM_LEFT:String = "slideFromLeft";
      
      public static const PANEL_TRANSITION_SLIDE_FROM_RIGHT:String = "slideFromRight";
      
      protected var mAPI:KongregateAPI;
      
      public function Mobile(api:KongregateAPI)
      {
         super();
         this.mAPI = api;
      }
      
      public function openKongregateWindow(target:String = "", id:String = "") : void
      {
      }
   }
}

