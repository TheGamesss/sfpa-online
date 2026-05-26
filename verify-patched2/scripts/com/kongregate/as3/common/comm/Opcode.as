package com.kongregate.as3.common.comm
{
   public class Opcode
   {
      
      public static const OP_CONNECT:String = "connect";
      
      public static const OP_CONNECTED:String = "connected";
      
      public static const OP_DISCONNECT:String = "disconnect";
      
      public static const OP_DISCONNECTED:String = "disconnected";
      
      public static const OP_HELLO:String = "hello";
      
      public static const OP_GOODBYE:String = "goodbye";
      
      public static const OP_USER_INFO:String = "user.info";
      
      public static const OP_PING:String = "ping";
      
      public static const OP_PING_LOCAL:String = "ping.local";
      
      public static const OP_KICK:String = "kick";
      
      public static const OP_SILENCED:String = "silenced";
      
      public static const OP_PARTICIPATE:String = "participate";
      
      public static const OP_STATUS_UPDATE:String = "status_update";
      
      public static const OP_ADMIN_MESSAGE:String = "admin_message";
      
      public static const PARAM_ADMIN_MESSAGE:String = "admin_message";
      
      public static const OP_SET_PRESENCE:String = "set_presence";
      
      public static const PARAM_PRESENCE:String = "presence";
      
      public static const OP_ALERT:String = "alert";
      
      public static const PARAM_ALERT_NAME:String = "alert.name";
      
      public static const OP_ALERT_REQUEST:String = "alert.rq";
      
      public static const OP_FORWARD:String = "fwd";
      
      public static const OP_CHAT:String = "chat";
      
      public static const PARAM_MESSAGE:String = "message";
      
      public static const OP_HTTP_REQUEST:String = "http";
      
      public static const PARAM_URL:String = "url";
      
      public static const OP_AVATAR_SUBMIT:String = "avatar.submit";
      
      public static const OP_AVATAR_FINISHED:String = "avatar.finished";
      
      public static const OP_GAME_SAVE:String = "gm.save";
      
      public static const OP_GAME_LOAD:String = "gm.load";
      
      public static const OP_GAME_LOAD_ALL:String = "gm.load.all";
      
      public static const OP_GAME_LIST_SAVES:String = "gm.list";
      
      public static const OP_GAME_DELETE:String = "gm.del";
      
      public static const PARAM_SLOT:String = "slot";
      
      public static const PARAM_DESCRIPTION:String = "desc";
      
      public static const PARAM_SAVE_LIST:String = "list";
      
      public static const PARAM_SAVE_GAME:String = "game";
      
      public static const PARAM_SAVE_GAMES:String = "games";
      
      public static const PARAM_CONFLICTS:String = "conflicts";
      
      public static const OP_STATS_REGISTER:String = "stat.reg";
      
      public static const OP_STATS_LIST:String = "stat.list";
      
      public static const OP_STATS_SUBMIT:String = "stat.submit";
      
      public static const OP_STATS_PLAYER:String = "stat.player";
      
      public static const PARAM_TASKS_COMPLETED:String = "stats.tc";
      
      public static const PARAM_STATS_PROGRESSED:String = "stats.prgs";
      
      public static const PARAM_STATS:String = "stats";
      
      public static const PARAM_STAT_NAME:String = "stat";
      
      public static const PARAM_STAT_MAX:String = "max";
      
      public static const PARAM_STAT_START:String = "start";
      
      public static const PARAM_STAT_SORT:String = "sort";
      
      public static const PARAM_STATS_CURRENT_HIGH_SCORE:String = "stats.current_high";
      
      public static const OP_GAME_START:String = "game_start";
      
      public static const OP_GAME_END:String = "game_end";
      
      public static const OP_GAME_BREAK:String = "game_break";
      
      public static const OP_GAME_CONTINUE:String = "game_cont";
      
      public static const OP_GAME_PAUSE:String = "game_pause";
      
      public static const OP_GAME_UNPAUSE:String = "game_unpause";
      
      public static const OP_GAME_MUTE:String = "game_mute";
      
      public static const OP_GAME_UNMUTE:String = "game_unmute";
      
      public static const OP_GAME_SET_MODE:String = "game_set_mode";
      
      public static const OP_GAME_RESTART:String = "game_restart";
      
      public static const OP_GAME_SETTING_ON:String = "game_setting_on";
      
      public static const OP_GAME_SETTING_OFF:String = "game_setting_off";
      
      public static const OP_GAME_MENU:String = "game_menu";
      
      public static const PARAM_GAME_START:String = "game_start";
      
      public static const PARAM_GAME_BREAK:String = "game_break";
      
      public static const PARAM_GAME_END:String = "game_end";
      
      public static const OP_SCORE_SUBMIT:String = "score.submit";
      
      public static const OP_SCORE_LIST:String = "score.list";
      
      public static const OP_SCORE_MODE:String = "score.mode";
      
      public static const PARAM_SCORE:String = "score";
      
      public static const PARAM_SCORE_LIST:String = "list";
      
      public static const PARAM_SCORE_POSITION:String = "pos";
      
      public static const PARAM_SCORE_POSTED:String = "posted";
      
      public static const PARAM_SCORE_LOW:String = "lowscore";
      
      public static const PARAM_SCORE_MODE:String = "mode";
      
      public static var OP_CHAT_ROOM_MESSAGE:String = "chat.room.msg";
      
      public static var OP_CHAT_TAB:String = "chat.tab";
      
      public static var OP_CHAT_MSG:String = "chat.msg";
      
      public static var OP_CHAT_DISPLAY:String = "chat.disp";
      
      public static var OP_CHAT_CANVAS_ELEMENT:String = "chat.elm";
      
      public static var OP_CHAT_DISPLAY_SIGN_IN:String = "chat.sign";
      
      public static var OP_CHAT_DISPLAY_REGISTRATION:String = "chat.registration";
      
      public static var OP_CHAT_DISPLAY_SHOUT_BOX:String = "chat.shoutbox";
      
      public static var OP_CHAT_DISPLAY_FEED_POST_BOX:String = "chat.feedpost";
      
      public static var OP_CHAT_PRIVATE_MESSAGE:String = "chat.privateMessage";
      
      public static var OP_CHAT_CLEAR_DIALOG:String = "chat.dlg.clear";
      
      public static var OP_CHAT_RESIZE_GAME:String = "chat.resizeGame";
      
      public static var OP_CHAT_DISPLAY_INVITATION_BOX:String = "chat.invite";
      
      public static var PARAM_CANVAS_SIZE:String = "chat.canvas.size";
      
      public static var PARAM_SHOUT_MESSAGE:String = "shout_message";
      
      public static var PARAM_INVITATION_MESSAGE:String = "invitation_message";
      
      public static var PARAM_FRIEND_FILTER:String = "filter";
      
      public static var PARAM_IMAGE_URI:String = "image_uri";
      
      public static var PARAM_KV_PARAMS:String = "kv_params";
      
      public static var PARAM_RESIZE_GAME_WIDTH:String = "chat.resizeGame.width";
      
      public static var PARAM_RESIZE_GAME_HEIGHT:String = "chat.resizeGame.height";
      
      public static var OP_USER_PROFILE:String = "user.profile";
      
      public static const OP_META_INFO:String = "meta.info";
      
      public static const OP_META_INVALIDATE:String = "meta.inval";
      
      public static const OP_META_STATE:String = "meta.state";
      
      public static const OP_META_EVENT:String = "meta.event";
      
      public static const OP_META_CREATE:String = "meta.create";
      
      public static const OP_META_JOIN:String = "meta.join";
      
      public static const OP_META_JOINED:String = "meta.joined";
      
      public static const OP_META_PLAYNOW:String = "meta.playnow";
      
      public static const OP_META_QUIT:String = "meta.quit";
      
      public static const OP_META_LIST:String = "meta.list";
      
      public static const OP_META_WAITING:String = "meta.waiting";
      
      public static const PARAM_OPPONENT:String = "opponent";
      
      public static const PARAM_PATHS:String = "paths";
      
      public static const PARAM_PLAYER_NO:String = "player_no";
      
      public static const PARAM_TYPE:String = "type";
      
      public static const PARAM_CHOICE:String = "choice";
      
      public static const PARAM_INVALIDATED:String = "invalidated";
      
      public static const PARAM_WAIT:String = "wait";
      
      public static const PARAM_STATE:String = "state";
      
      public static const PARAM_GAME_TYPE:String = "game_type";
      
      public static const PARAM_PHASE_NO:String = "phase_no";
      
      public static const PARAM_DECKS:String = "decks";
      
      public static const OP_REQUEST_GAME_ROOM:String = "room.rq";
      
      public static const PARAM_ROOM_NAME:String = "room.name";
      
      public static const PARAM_ROOM_NATURAL_NAME:String = "room.natural";
      
      public static var OP_ITEM_LIST:String = "mtx.item_list";
      
      public static var OP_ITEM_INSTANCES:String = "mtx.item_instances";
      
      public static var OP_ITEM_CHECKOUT:String = "mtx.checkout";
      
      public static var OP_USE_ITEM_INSTANCE:String = "mtx.use_item_instance";
      
      public static var OP_PURCHASE_KREDS:String = "mtx.kred_purchase";
      
      public static var PARAM_ITEM_TAGS:String = "item_tags";
      
      public static var PARAM_ITEM_IDENTIFIERS:String = "item_ids";
      
      public static var PARAM_ITEMS:String = "items";
      
      public static var PARAM_PURCHASE_METHOD:String = "purchase_method";
      
      public static var PARAM_ORDER_INFO:String = "order_info";
      
      public static var OP_EXTERNAL_MESSAGE:String = "ext.msg";
      
      public static const OP_SHOUT_CALLBACK:String = "ext.shout_callback";
      
      public static const PARAM_MESSAGE_TYPE:String = "ext.message_type";
      
      public static const PARAM_MESSAGE_RECIPIENTS:String = "ext.message_recipients";
      
      public static var OP_LOG:String = "log.msg";
      
      public static var PARAM_LOG_LEVEL:String = "level";
      
      public static var PARAM_LOG_MESSAGE:String = "msg";
      
      public static var OP_ANALYTICS_PAYLOAD:String = "analytics.payload";
      
      public static const PARAM_USER:String = "user";
      
      public static const PARAM_USER_ID:String = "user_id";
      
      public static const PARAM_CHANNEL:String = "chnl";
      
      public static const PARAM_SUCCESS:String = "success";
      
      public static const PARAM_SESSION_ID:String = "sessionid";
      
      public static const PARAM_SESSION_LOOKUP_KEY:String = "slk";
      
      public static const PARAM_DURATION:String = "duration";
      
      public static const PARAM_REASON:String = "reason";
      
      public static const PARAM_GAME_ID:String = "game_id";
      
      public static const PARAM_DATA:String = "data";
      
      public static const PARAM_CLIENT_VERSION:String = "client.ver";
      
      public static const PARAM_GAME_VERSION:String = "gm.ver";
      
      public static const PARAM_ERROR:String = "error";
      
      public static const PARAM_REQUEST_ID:String = "req.id";
      
      public static const PARAM_MESSAGE_ID:String = "msg.id";
      
      public static const PARAM_MESSAGES:String = "msgs";
      
      public static const PARAM_JAVASCRIPT:String = "javascript";
      
      public static const PARAM_RESULTS:String = "results";
      
      public static const PARAM_RESULT:String = "result";
      
      public static const PARAM_RESEND:String = "resend";
      
      public static const PARAM_TIME:String = "time";
      
      public static const PARAM_ID:String = "id";
      
      public static const PARAM_KEY:String = "key";
      
      public static const PARAM_CONFIRMATION:String = "conf";
      
      public static const PARAM_FROM:String = "from";
      
      public static const PARAM_TO:String = "to";
      
      public static const PARAM_FROM_PLAYER:String = "from.pl";
      
      public static const PARAM_LIST:String = "list";
      
      public static const PARAM_PERMALINK:String = "permalink";
      
      public static const PARAM_NAME:String = "name";
      
      public static const PARAM_GAME_NAME:String = "game_name";
      
      public static const PARAM_OPCODE:String = "opcode";
      
      public static const PARAM_GAME_AUTH_TOKEN:String = "auth_token";
      
      public static const PARAM_FILENAME:String = "filename";
      
      public static const PARAM_IMAGE:String = "image";
      
      public static const PARAM_SORT:String = "sort_order";
      
      public static const PARAM_CAPABILITIES:String = "caps";
      
      public static const PARAM_URL_PARAMS:String = "param_url_params";
      
      public static const PARAM_TITLE:String = "param_title";
      
      public static const PARAM_EXPIRATION:String = "param_expiration";
      
      public static const PARAM_OPTIONS:String = "param_options";
      
      public static const PARAM_LOCALCONNECTION_ONLY:String = "localconnection_only";
      
      public static const OP_PRIVATE_MESSAGE:String = "chat.pm";
      
      public static const OP_SAVE_SHARED_CONTENT:String = "save_shared_content";
      
      public static const OP_BROWSE_SHARED_CONTENT:String = "browse_shared_content";
      
      public static const OP_LOAD_SHARED_CONTENT:String = "load_shared_content";
      
      public static const OP_SHARED_CONTENT_SAVE_COMPLETE:String = "shared_content_save_complete";
      
      public static const PARAM_CONTENT_TYPE:String = "content_type";
      
      public static const PARAM_LABEL:String = "label";
      
      public static const OP_CREATE_PRIVATE_ROOM:String = "room.create";
      
      public static const OP_DESTROY_PRIVATE_ROOM:String = "room.destroy";
      
      public static const OP_PRIVATE_ROOM_INVITE:String = "room.invite.private";
      
      public static const OP_PRIVATE_ROOM_KICK:String = "room.kick.private";
      
      public static const OP_HOLODECK_DATA:String = "holodeck_data";
      
      public static const PARAM_HOLODECK_TYPE:String = "holodeck_type";
      
      public static const OP_JOIN_GUILD_ROOM:String = "guild.room.join";
      
      public static const OP_GUILD_ID:String = "guild.id";
      
      public static const OP_THROTTLE:String = "throttle";
      
      public static const OP_RESUME:String = "resume";
      
      public static const OP_ADS_INITIALIZE:String = "ads.initialize";
      
      public static const OP_ADS_SHOW_INCENTIVIZED:String = "ads.show_incentivized";
      
      public static const OP_ADS_AVAILABLE:String = "ads.available";
      
      public static const OP_ADS_UNAVAILABLE:String = "ads.unavailable";
      
      public static const OP_AD_OPENED:String = "ads.ad_opened";
      
      public static const OP_AD_COMPLETED:String = "ads.ad_completed";
      
      public static const OP_AD_ABANDONED:String = "ads.ad_abandoned";
      
      public function Opcode()
      {
         super();
      }
   }
}

