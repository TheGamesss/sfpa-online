package com.kongregate.as3.common.comm;


class Opcode
{
    
    public static inline var OP_CONNECT : String = "connect";
    
    public static inline var OP_CONNECTED : String = "connected";
    
    public static inline var OP_DISCONNECT : String = "disconnect";
    
    public static inline var OP_DISCONNECTED : String = "disconnected";
    
    public static inline var OP_HELLO : String = "hello";
    
    public static inline var OP_GOODBYE : String = "goodbye";
    
    public static inline var OP_USER_INFO : String = "user.info";
    
    public static inline var OP_PING : String = "ping";
    
    public static inline var OP_PING_LOCAL : String = "ping.local";
    
    public static inline var OP_KICK : String = "kick";
    
    public static inline var OP_SILENCED : String = "silenced";
    
    public static inline var OP_PARTICIPATE : String = "participate";
    
    public static inline var OP_STATUS_UPDATE : String = "status_update";
    
    public static inline var OP_ADMIN_MESSAGE : String = "admin_message";
    
    public static inline var PARAM_ADMIN_MESSAGE : String = "admin_message";
    
    public static inline var OP_SET_PRESENCE : String = "set_presence";
    
    public static inline var PARAM_PRESENCE : String = "presence";
    
    public static inline var OP_ALERT : String = "alert";
    
    public static inline var PARAM_ALERT_NAME : String = "alert.name";
    
    public static inline var OP_ALERT_REQUEST : String = "alert.rq";
    
    public static inline var OP_FORWARD : String = "fwd";
    
    public static inline var OP_CHAT : String = "chat";
    
    public static inline var PARAM_MESSAGE : String = "message";
    
    public static inline var OP_HTTP_REQUEST : String = "http";
    
    public static inline var PARAM_URL : String = "url";
    
    public static inline var OP_AVATAR_SUBMIT : String = "avatar.submit";
    
    public static inline var OP_AVATAR_FINISHED : String = "avatar.finished";
    
    public static inline var OP_GAME_SAVE : String = "gm.save";
    
    public static inline var OP_GAME_LOAD : String = "gm.load";
    
    public static inline var OP_GAME_LOAD_ALL : String = "gm.load.all";
    
    public static inline var OP_GAME_LIST_SAVES : String = "gm.list";
    
    public static inline var OP_GAME_DELETE : String = "gm.del";
    
    public static inline var PARAM_SLOT : String = "slot";
    
    public static inline var PARAM_DESCRIPTION : String = "desc";
    
    public static inline var PARAM_SAVE_LIST : String = "list";
    
    public static inline var PARAM_SAVE_GAME : String = "game";
    
    public static inline var PARAM_SAVE_GAMES : String = "games";
    
    public static inline var PARAM_CONFLICTS : String = "conflicts";
    
    public static inline var OP_STATS_REGISTER : String = "stat.reg";
    
    public static inline var OP_STATS_LIST : String = "stat.list";
    
    public static inline var OP_STATS_SUBMIT : String = "stat.submit";
    
    public static inline var OP_STATS_PLAYER : String = "stat.player";
    
    public static inline var PARAM_TASKS_COMPLETED : String = "stats.tc";
    
    public static inline var PARAM_STATS_PROGRESSED : String = "stats.prgs";
    
    public static inline var PARAM_STATS : String = "stats";
    
    public static inline var PARAM_STAT_NAME : String = "stat";
    
    public static inline var PARAM_STAT_MAX : String = "max";
    
    public static inline var PARAM_STAT_START : String = "start";
    
    public static inline var PARAM_STAT_SORT : String = "sort";
    
    public static inline var PARAM_STATS_CURRENT_HIGH_SCORE : String = "stats.current_high";
    
    public static inline var OP_GAME_START : String = "game_start";
    
    public static inline var OP_GAME_END : String = "game_end";
    
    public static inline var OP_GAME_BREAK : String = "game_break";
    
    public static inline var OP_GAME_CONTINUE : String = "game_cont";
    
    public static inline var OP_GAME_PAUSE : String = "game_pause";
    
    public static inline var OP_GAME_UNPAUSE : String = "game_unpause";
    
    public static inline var OP_GAME_MUTE : String = "game_mute";
    
    public static inline var OP_GAME_UNMUTE : String = "game_unmute";
    
    public static inline var OP_GAME_SET_MODE : String = "game_set_mode";
    
    public static inline var OP_GAME_RESTART : String = "game_restart";
    
    public static inline var OP_GAME_SETTING_ON : String = "game_setting_on";
    
    public static inline var OP_GAME_SETTING_OFF : String = "game_setting_off";
    
    public static inline var OP_GAME_MENU : String = "game_menu";
    
    public static inline var PARAM_GAME_START : String = "game_start";
    
    public static inline var PARAM_GAME_BREAK : String = "game_break";
    
    public static inline var PARAM_GAME_END : String = "game_end";
    
    public static inline var OP_SCORE_SUBMIT : String = "score.submit";
    
    public static inline var OP_SCORE_LIST : String = "score.list";
    
    public static inline var OP_SCORE_MODE : String = "score.mode";
    
    public static inline var PARAM_SCORE : String = "score";
    
    public static inline var PARAM_SCORE_LIST : String = "list";
    
    public static inline var PARAM_SCORE_POSITION : String = "pos";
    
    public static inline var PARAM_SCORE_POSTED : String = "posted";
    
    public static inline var PARAM_SCORE_LOW : String = "lowscore";
    
    public static inline var PARAM_SCORE_MODE : String = "mode";
    
    public static var OP_CHAT_ROOM_MESSAGE : String = "chat.room.msg";
    
    public static var OP_CHAT_TAB : String = "chat.tab";
    
    public static var OP_CHAT_MSG : String = "chat.msg";
    
    public static var OP_CHAT_DISPLAY : String = "chat.disp";
    
    public static var OP_CHAT_CANVAS_ELEMENT : String = "chat.elm";
    
    public static var OP_CHAT_DISPLAY_SIGN_IN : String = "chat.sign";
    
    public static var OP_CHAT_DISPLAY_REGISTRATION : String = "chat.registration";
    
    public static var OP_CHAT_DISPLAY_SHOUT_BOX : String = "chat.shoutbox";
    
    public static var OP_CHAT_DISPLAY_FEED_POST_BOX : String = "chat.feedpost";
    
    public static var OP_CHAT_PRIVATE_MESSAGE : String = "chat.privateMessage";
    
    public static var OP_CHAT_CLEAR_DIALOG : String = "chat.dlg.clear";
    
    public static var OP_CHAT_RESIZE_GAME : String = "chat.resizeGame";
    
    public static var OP_CHAT_DISPLAY_INVITATION_BOX : String = "chat.invite";
    
    public static var PARAM_CANVAS_SIZE : String = "chat.canvas.size";
    
    public static var PARAM_SHOUT_MESSAGE : String = "shout_message";
    
    public static var PARAM_INVITATION_MESSAGE : String = "invitation_message";
    
    public static var PARAM_FRIEND_FILTER : String = "filter";
    
    public static var PARAM_IMAGE_URI : String = "image_uri";
    
    public static var PARAM_KV_PARAMS : String = "kv_params";
    
    public static var PARAM_RESIZE_GAME_WIDTH : String = "chat.resizeGame.width";
    
    public static var PARAM_RESIZE_GAME_HEIGHT : String = "chat.resizeGame.height";
    
    public static var OP_USER_PROFILE : String = "user.profile";
    
    public static inline var OP_META_INFO : String = "meta.info";
    
    public static inline var OP_META_INVALIDATE : String = "meta.inval";
    
    public static inline var OP_META_STATE : String = "meta.state";
    
    public static inline var OP_META_EVENT : String = "meta.event";
    
    public static inline var OP_META_CREATE : String = "meta.create";
    
    public static inline var OP_META_JOIN : String = "meta.join";
    
    public static inline var OP_META_JOINED : String = "meta.joined";
    
    public static inline var OP_META_PLAYNOW : String = "meta.playnow";
    
    public static inline var OP_META_QUIT : String = "meta.quit";
    
    public static inline var OP_META_LIST : String = "meta.list";
    
    public static inline var OP_META_WAITING : String = "meta.waiting";
    
    public static inline var PARAM_OPPONENT : String = "opponent";
    
    public static inline var PARAM_PATHS : String = "paths";
    
    public static inline var PARAM_PLAYER_NO : String = "player_no";
    
    public static inline var PARAM_TYPE : String = "type";
    
    public static inline var PARAM_CHOICE : String = "choice";
    
    public static inline var PARAM_INVALIDATED : String = "invalidated";
    
    public static inline var PARAM_WAIT : String = "wait";
    
    public static inline var PARAM_STATE : String = "state";
    
    public static inline var PARAM_GAME_TYPE : String = "game_type";
    
    public static inline var PARAM_PHASE_NO : String = "phase_no";
    
    public static inline var PARAM_DECKS : String = "decks";
    
    public static inline var OP_REQUEST_GAME_ROOM : String = "room.rq";
    
    public static inline var PARAM_ROOM_NAME : String = "room.name";
    
    public static inline var PARAM_ROOM_NATURAL_NAME : String = "room.natural";
    
    public static var OP_ITEM_LIST : String = "mtx.item_list";
    
    public static var OP_ITEM_INSTANCES : String = "mtx.item_instances";
    
    public static var OP_ITEM_CHECKOUT : String = "mtx.checkout";
    
    public static var OP_USE_ITEM_INSTANCE : String = "mtx.use_item_instance";
    
    public static var OP_PURCHASE_KREDS : String = "mtx.kred_purchase";
    
    public static var PARAM_ITEM_TAGS : String = "item_tags";
    
    public static var PARAM_ITEM_IDENTIFIERS : String = "item_ids";
    
    public static var PARAM_ITEMS : String = "items";
    
    public static var PARAM_PURCHASE_METHOD : String = "purchase_method";
    
    public static var PARAM_ORDER_INFO : String = "order_info";
    
    public static var OP_EXTERNAL_MESSAGE : String = "ext.msg";
    
    public static inline var OP_SHOUT_CALLBACK : String = "ext.shout_callback";
    
    public static inline var PARAM_MESSAGE_TYPE : String = "ext.message_type";
    
    public static inline var PARAM_MESSAGE_RECIPIENTS : String = "ext.message_recipients";
    
    public static var OP_LOG : String = "log.msg";
    
    public static var PARAM_LOG_LEVEL : String = "level";
    
    public static var PARAM_LOG_MESSAGE : String = "msg";
    
    public static var OP_ANALYTICS_PAYLOAD : String = "analytics.payload";
    
    public static inline var PARAM_USER : String = "user";
    
    public static inline var PARAM_USER_ID : String = "user_id";
    
    public static inline var PARAM_CHANNEL : String = "chnl";
    
    public static inline var PARAM_SUCCESS : String = "success";
    
    public static inline var PARAM_SESSION_ID : String = "sessionid";
    
    public static inline var PARAM_SESSION_LOOKUP_KEY : String = "slk";
    
    public static inline var PARAM_DURATION : String = "duration";
    
    public static inline var PARAM_REASON : String = "reason";
    
    public static inline var PARAM_GAME_ID : String = "game_id";
    
    public static inline var PARAM_DATA : String = "data";
    
    public static inline var PARAM_CLIENT_VERSION : String = "client.ver";
    
    public static inline var PARAM_GAME_VERSION : String = "gm.ver";
    
    public static inline var PARAM_ERROR : String = "error";
    
    public static inline var PARAM_REQUEST_ID : String = "req.id";
    
    public static inline var PARAM_MESSAGE_ID : String = "msg.id";
    
    public static inline var PARAM_MESSAGES : String = "msgs";
    
    public static inline var PARAM_JAVASCRIPT : String = "javascript";
    
    public static inline var PARAM_RESULTS : String = "results";
    
    public static inline var PARAM_RESULT : String = "result";
    
    public static inline var PARAM_RESEND : String = "resend";
    
    public static inline var PARAM_TIME : String = "time";
    
    public static inline var PARAM_ID : String = "id";
    
    public static inline var PARAM_KEY : String = "key";
    
    public static inline var PARAM_CONFIRMATION : String = "conf";
    
    public static inline var PARAM_FROM : String = "from";
    
    public static inline var PARAM_TO : String = "to";
    
    public static inline var PARAM_FROM_PLAYER : String = "from.pl";
    
    public static inline var PARAM_LIST : String = "list";
    
    public static inline var PARAM_PERMALINK : String = "permalink";
    
    public static inline var PARAM_NAME : String = "name";
    
    public static inline var PARAM_GAME_NAME : String = "game_name";
    
    public static inline var PARAM_OPCODE : String = "opcode";
    
    public static inline var PARAM_GAME_AUTH_TOKEN : String = "auth_token";
    
    public static inline var PARAM_FILENAME : String = "filename";
    
    public static inline var PARAM_IMAGE : String = "image";
    
    public static inline var PARAM_SORT : String = "sort_order";
    
    public static inline var PARAM_CAPABILITIES : String = "caps";
    
    public static inline var PARAM_URL_PARAMS : String = "param_url_params";
    
    public static inline var PARAM_TITLE : String = "param_title";
    
    public static inline var PARAM_EXPIRATION : String = "param_expiration";
    
    public static inline var PARAM_OPTIONS : String = "param_options";
    
    public static inline var PARAM_LOCALCONNECTION_ONLY : String = "localconnection_only";
    
    public static inline var OP_PRIVATE_MESSAGE : String = "chat.pm";
    
    public static inline var OP_SAVE_SHARED_CONTENT : String = "save_shared_content";
    
    public static inline var OP_BROWSE_SHARED_CONTENT : String = "browse_shared_content";
    
    public static inline var OP_LOAD_SHARED_CONTENT : String = "load_shared_content";
    
    public static inline var OP_SHARED_CONTENT_SAVE_COMPLETE : String = "shared_content_save_complete";
    
    public static inline var PARAM_CONTENT_TYPE : String = "content_type";
    
    public static inline var PARAM_LABEL : String = "label";
    
    public static inline var OP_CREATE_PRIVATE_ROOM : String = "room.create";
    
    public static inline var OP_DESTROY_PRIVATE_ROOM : String = "room.destroy";
    
    public static inline var OP_PRIVATE_ROOM_INVITE : String = "room.invite.private";
    
    public static inline var OP_PRIVATE_ROOM_KICK : String = "room.kick.private";
    
    public static inline var OP_HOLODECK_DATA : String = "holodeck_data";
    
    public static inline var PARAM_HOLODECK_TYPE : String = "holodeck_type";
    
    public static inline var OP_JOIN_GUILD_ROOM : String = "guild.room.join";
    
    public static inline var OP_GUILD_ID : String = "guild.id";
    
    public static inline var OP_THROTTLE : String = "throttle";
    
    public static inline var OP_RESUME : String = "resume";
    
    public static inline var OP_ADS_INITIALIZE : String = "ads.initialize";
    
    public static inline var OP_ADS_SHOW_INCENTIVIZED : String = "ads.show_incentivized";
    
    public static inline var OP_ADS_AVAILABLE : String = "ads.available";
    
    public static inline var OP_ADS_UNAVAILABLE : String = "ads.unavailable";
    
    public static inline var OP_AD_OPENED : String = "ads.ad_opened";
    
    public static inline var OP_AD_COMPLETED : String = "ads.ad_completed";
    
    public static inline var OP_AD_ABANDONED : String = "ads.ad_abandoned";
    
    public function new()
    {
        super();
    }
}


