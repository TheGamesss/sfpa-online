package com.miniclip.mock
{
   import com.miniclip.events.AlertboxEvent;
   import com.miniclip.events.AwardsEvent;
   import com.miniclip.events.GameLoaderEvent;
   import com.miniclip.gamemanager.AwardData;
   import com.miniclip.gamemanager.GameServices;
   import com.miniclip.gamemanager.utils.strings;
   import com.miniclip.loggers.LogsHandler;
   import flash.events.EventDispatcher;
   import flash.system.Security;
   
   public class MiniclipServices extends EventDispatcher implements GameServices
   {
      
      private var _key:String;
      
      private var _disableGameEvent:GameLoaderEvent = new GameLoaderEvent(GameLoaderEvent.DISABLE_GAME);
      
      private var _enableGameEvent:GameLoaderEvent = new GameLoaderEvent(GameLoaderEvent.ENABLE_GAME);
      
      public function MiniclipServices()
      {
         super();
      }
      
      private function onAwardResponse(event:AwardsEvent) : void
      {
         LogsHandler.info("services.onAwardResponse(" + event + ")");
         dispatchEvent(event.clone());
      }
      
      private function onCloseAlertbox(event:AlertboxEvent) : void
      {
         LogsHandler.info("services.onCloseAlertbox(" + event + ")");
         dispatchEvent(this._enableGameEvent.clone());
         dispatchEvent(event.clone());
      }
      
      public function validateLocation() : Boolean
      {
         LogsHandler.info("services.validateLocation()");
         return Security.sandboxType != Security.REMOTE;
      }
      
      public function showHighscores(level:uint = 0, levelName:String = "") : void
      {
         LogsHandler.info("services.showHighscores(" + level + " " + levelName + ")");
      }
      
      public function saveHighscore(score:Number, level:uint = 0, levelName:String = "") : void
      {
         LogsHandler.info("services.saveHighscore(" + score + ", " + level + ", " + levelName + ")");
      }
      
      public function giveAward(awardID:uint) : void
      {
         var award_data:AwardData = null;
         LogsHandler.info("services.giveAward(" + awardID + ")");
         if(awardID > 0)
         {
            LogsHandler.log("Awards success (with awardID = " + awardID + ")");
            award_data = new AwardData({
               "id":awardID,
               "title":strings.awardLocalTest + " #" + awardID,
               "description":"test award description"
            });
            dispatchEvent(new AwardsEvent(AwardsEvent.SUCCESS,award_data));
         }
         else
         {
            LogsHandler.error("Awards fail (with awardID = " + awardID + ")");
            dispatchEvent(new AwardsEvent(AwardsEvent.FAIL,"Award ID must be bigger than zero"));
         }
      }
      
      public function hasAward(awardID:uint, playerID:uint = 0) : void
      {
         LogsHandler.info("services.hasAward(" + awardID + ", " + playerID + ")");
         dispatchEvent(new AwardsEvent(AwardsEvent.STATUS,false));
      }
      
      public function getUserAwards() : void
      {
         LogsHandler.log("getUserAwards() called");
         dispatchEvent(new AwardsEvent(AwardsEvent.USER_GAME_AWARDS,[]));
      }
      
      public function trackAds(trackerID:String) : void
      {
         LogsHandler.info("services.trackAds(" + trackerID + ")");
         if(trackerID != "" && trackerID.length > 0)
         {
            LogsHandler.log("Ads Tracking success (with trackerID = " + trackerID + ")");
         }
         else
         {
            LogsHandler.error("Ads Tracking fail (with trackerID = " + trackerID + ")");
         }
      }
      
      public function getUserDetails(useCache:Boolean = true) : void
      {
         LogsHandler.info("services.getUserDetails(" + useCache + ")");
      }
      
      public function isLoggedIn(useCache:Boolean = true) : void
      {
         LogsHandler.info("services.isLoggedIn(" + useCache + ")");
      }
      
      public function showAlert(message:String = "Alert!", buttonLabel:String = "OK") : void
      {
         LogsHandler.info("services.showAlert(" + message + ", " + buttonLabel + ")");
         LogsHandler.warn(message);
      }
      
      public function get highscoresVisible() : Boolean
      {
         return false;
      }
      
      public function get userDetails() : Object
      {
         return null;
      }
      
      public function get datacenterID() : String
      {
         return "";
      }
      
      public function trackData(tag:String, group:String = "", data:Object = null, replaceData:Boolean = false) : void
      {
         LogsHandler.info("services.trackData() Tag :  " + tag + " Group :  " + group + " Object :  " + (data ? "NOT " : "") + "NULL");
      }
      
      public function trackError(errorCode:String) : void
      {
         LogsHandler.info("services.trackError() ErrorCode :  " + errorCode);
      }
      
      public function trackMappedError(errorCode:String) : void
      {
         LogsHandler.info("services.trackMappedError() ErrorCode :  " + errorCode);
      }
      
      public function encrypt(value:String) : String
      {
         LogsHandler.info("-> GMProxy - GameServicesProxy::encrypt(" + value + ")");
         return "";
      }
      
      public function decrypt(value:String) : String
      {
         LogsHandler.info("-> GMProxy - GameServicesProxy::decrypt(" + value + ")");
         return "";
      }
   }
}

