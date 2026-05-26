package com.kongregate.air.base;

import com.kongregate.air.IMobile;
import com.kongregate.air.KongregateAPI;

class Mobile implements IMobile
{
    
    public static inline var TARGET_MORE_GAMES : String = "more_games";
    
    public static inline var TARGET_HIGH_SCORES : String = "high_scores";
    
    public static inline var TARGET_FORUMS : String = "forums";
    
    public static inline var TARGET_SUPPORT : String = "support";
    
    public static inline var TARGET_OFFERS : String = "offer_rewards";
    
    public static inline var TARGET_REGISTRATION : String = "registration";
    
    public static inline var TARGET_TERMS : String = "terms";
    
    public static inline var TARGET_PRIVACY : String = "privacy";
    
    public static inline var TARGET_GUILD_CHAT : String = "guild_chat";
    
    public static inline var TARGET_TOPICS : String = "topics";
    
    public static inline var TARGET_MESSAGES : String = "messages";
    
    public static inline var PANEL_EVENT_GO_TO_GUILDS : String = "GO_TO_GUILDS";
    
    public static inline var PANEL_TRANSITION_SLIDE_FROM_LEFT : String = "slideFromLeft";
    
    public static inline var PANEL_TRANSITION_SLIDE_FROM_RIGHT : String = "slideFromRight";
    
    private var mAPI : KongregateAPI;
    
    public function new(api : KongregateAPI)
    {
        super();
        this.mAPI = api;
    }
    
    public function openKongregateWindow(target : String = "", id : String = "") : Void
    {
    }
}


