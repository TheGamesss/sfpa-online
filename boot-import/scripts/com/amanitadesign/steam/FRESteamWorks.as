package com.amanitadesign.steam
{
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class FRESteamWorks extends EventDispatcher
   {
      
      private var _ExtensionContext:*;
      
      private var _tm:int;
      
      private var _redrawPixel:Sprite = null;
      
      private var _redrawContainer:DisplayObjectContainer = null;
      
      private var _color:uint;
      
      private var _alwaysVisible:Boolean;
      
      public var isReady:Boolean = false;
      
      public function FRESteamWorks(target:IEventDispatcher = null)
      {
         super(target);
         try
         {
            var extensionContextClass:Class = getDefinitionByName("flash.external.ExtensionContext") as Class;
            if(extensionContextClass != null)
            {
               this._ExtensionContext = extensionContextClass.createExtensionContext("com.amanitadesign.steam.FRESteamWorks",null);
            }
         }
         catch(error:Error)
         {
            this._ExtensionContext = null;
         }
         if(this._ExtensionContext != null)
         {
            this._ExtensionContext.addEventListener(StatusEvent.STATUS,this.handleStatusEvent);
         }
      }
      
      private function handleStatusEvent(event:StatusEvent) : void
      {
         var req_type:int = new int(event.code);
         var response:int = new int(event.level);
         var sEvent:SteamEvent = new SteamEvent(SteamEvent.STEAM_RESPONSE,req_type,response);
         if(Boolean(this._redrawContainer) && Boolean(!this._alwaysVisible) && req_type == SteamConstants.RESPONSE_OnGameOverlayActivated)
         {
            if(response == SteamResults.OK && !this._redrawPixel)
            {
               this.addRedrawPixel();
            }
            else if(response == SteamResults.Fail && Boolean(this._redrawPixel))
            {
               setTimeout(this.removeRedrawPixel,3000);
            }
         }
         dispatchEvent(sEvent);
      }
      
      private function addRedrawPixel() : void
      {
         if(!this._redrawContainer || Boolean(this._redrawPixel))
         {
            return;
         }
         this._redrawPixel = new Sprite();
         this._redrawPixel.width = 1;
         this._redrawPixel.height = 1;
         this._redrawPixel.graphics.beginFill(this._color);
         this._redrawPixel.graphics.drawRect(0,0,1,1);
         this._redrawPixel.graphics.endFill();
         this._redrawPixel.addEventListener(Event.ENTER_FRAME,this.redrawPixel);
         this._redrawContainer.addChild(this._redrawPixel);
      }
      
      private function removeRedrawPixel() : void
      {
         if(!this._redrawContainer || !this._redrawPixel)
         {
            return;
         }
         this._redrawPixel.removeEventListener(Event.ENTER_FRAME,this.redrawPixel);
         this._redrawContainer.removeChild(this._redrawPixel);
         this._redrawPixel = null;
      }
      
      private function redrawPixel(e:Event = null) : void
      {
         this._redrawPixel.rotation += 1;
      }
      
      public function addOverlayWorkaround(container:DisplayObjectContainer, alwaysVisible:Boolean = false, color:uint = 0) : void
      {
         this._redrawContainer = container;
         this._alwaysVisible = alwaysVisible;
         this._color = color;
         if(alwaysVisible)
         {
            this.addRedrawPixel();
         }
      }
      
      public function dispose() : void
      {
         clearInterval(this._tm);
         if(this._ExtensionContext != null)
         {
            this._ExtensionContext.removeEventListener(StatusEvent.STATUS,this.handleStatusEvent);
            this._ExtensionContext.dispose();
         }
      }
      
      public function init() : Boolean
      {
         if(this._ExtensionContext == null)
         {
            this.isReady = false;
            return false;
         }
         this.isReady = this._ExtensionContext.call("AIRSteam_Init") as Boolean;
         if(this.isReady)
         {
            this._tm = setInterval(this.runCallbacks,100);
         }
         return this.isReady;
      }
      
      public function runCallbacks() : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_RunCallbacks") as Boolean;
      }
      
      public function getUserID() : String
      {
         return this._ExtensionContext.call("AIRSteam_GetUserID") as String;
      }
      
      public function getAppID() : uint
      {
         return this._ExtensionContext.call("AIRSteam_GetAppID") as uint;
      }
      
      public function getAvailableGameLanguages() : String
      {
         return this._ExtensionContext.call("AIRSteam_GetAvailableGameLanguages") as String;
      }
      
      public function getCurrentGameLanguage() : String
      {
         return this._ExtensionContext.call("AIRSteam_GetCurrentGameLanguage") as String;
      }
      
      public function getPersonaName() : String
      {
         return this._ExtensionContext.call("AIRSteam_GetPersonaName") as String;
      }
      
      public function restartAppIfNecessary(appID:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_RestartAppIfNecessary",appID) as Boolean;
      }
      
      public function requestStats() : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_RequestStats") as Boolean;
      }
      
      public function setAchievement(name:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_SetAchievement",name) as Boolean;
      }
      
      public function clearAchievement(name:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_ClearAchievement",name) as Boolean;
      }
      
      public function isAchievement(name:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_IsAchievement",name) as Boolean;
      }
      
      public function indicateAchievementProgress(name:String, currentProgress:int, maxProgress:int) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_IndicateAchievementProgress",name,currentProgress,maxProgress) as Boolean;
      }
      
      public function getStatInt(name:String) : int
      {
         return this._ExtensionContext.call("AIRSteam_GetStatInt",name) as int;
      }
      
      public function getStatFloat(name:String) : Number
      {
         return this._ExtensionContext.call("AIRSteam_GetStatFloat",name) as Number;
      }
      
      public function setStatInt(name:String, value:int) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_SetStatInt",name,value) as Boolean;
      }
      
      public function setStatFloat(name:String, value:Number) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_SetStatFloat",name,value) as Boolean;
      }
      
      public function storeStats() : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_StoreStats") as Boolean;
      }
      
      public function resetAllStats(achievementsToo:Boolean) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_ResetAllStats",achievementsToo) as Boolean;
      }
      
      public function requestGlobalStats(historyDays:int) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_RequestGlobalStats",historyDays) as Boolean;
      }
      
      public function getGlobalStatInt(name:String) : Number
      {
         return this._ExtensionContext.call("AIRSteam_GetGlobalStatInt",name) as Number;
      }
      
      public function getGlobalStatFloat(name:String) : Number
      {
         return this._ExtensionContext.call("AIRSteam_GetGlobalStatFloat",name) as Number;
      }
      
      public function getGlobalStatHistoryInt(name:String, days:int) : Array
      {
         return this._ExtensionContext.call("AIRSteam_GetGlobalStatHistoryInt",name,days) as Array;
      }
      
      public function getGlobalStatHistoryFloat(name:String, days:int) : Array
      {
         return this._ExtensionContext.call("AIRSteam_GetGlobalStatHistoryFloat",name,days) as Array;
      }
      
      public function findLeaderboard(name:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_FindLeaderboard",name) as Boolean;
      }
      
      public function findOrCreateLeaderboard(name:String, sortMethod:uint, displayType:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_FindOrCreateLeaderboard",name,sortMethod,displayType) as Boolean;
      }
      
      public function findLeaderboardResult() : String
      {
         return this._ExtensionContext.call("AIRSteam_FindLeaderboardResult") as String;
      }
      
      public function getLeaderboardName(handle:String) : String
      {
         return this._ExtensionContext.call("AIRSteam_GetLeaderboardName",handle) as String;
      }
      
      public function getLeaderboardEntryCount(handle:String) : int
      {
         return this._ExtensionContext.call("AIRSteam_GetLeaderboardEntryCount",handle) as int;
      }
      
      public function getLeaderboardSortMethod(handle:String) : uint
      {
         return this._ExtensionContext.call("AIRSteam_GetLeaderboardSortMethod",handle) as uint;
      }
      
      public function getLeaderboardDisplayType(handle:String) : uint
      {
         return this._ExtensionContext.call("AIRSteam_GetLeaderboardDisplayType",handle) as uint;
      }
      
      public function uploadLeaderboardScore(handle:String, method:uint, score:int, details:Array = null) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UploadLeaderboardScore",handle,method,score,details) as Boolean;
      }
      
      public function uploadLeaderboardScoreResult() : UploadLeaderboardScoreResult
      {
         return this._ExtensionContext.call("AIRSteam_UploadLeaderboardScoreResult") as UploadLeaderboardScoreResult;
      }
      
      public function downloadLeaderboardEntries(handle:String, request:uint = 1, rangeStart:int = -4, rangeEnd:int = 5) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_DownloadLeaderboardEntries",handle,request,rangeStart,rangeEnd) as Boolean;
      }
      
      public function downloadLeaderboardEntriesResult(numDetails:int = 0) : Array
      {
         return this._ExtensionContext.call("AIRSteam_DownloadLeaderboardEntriesResult",numDetails) as Array;
      }
      
      public function getFileCount() : int
      {
         return this._ExtensionContext.call("AIRSteam_GetFileCount") as int;
      }
      
      public function getFileSize(name:String) : int
      {
         return this._ExtensionContext.call("AIRSteam_GetFileSize",name) as int;
      }
      
      public function fileExists(name:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_FileExists",name) as Boolean;
      }
      
      public function fileWrite(name:String, data:ByteArray) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_FileWrite",name,data) as Boolean;
      }
      
      public function fileRead(name:String, data:ByteArray) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_FileRead",name,data) as Boolean;
      }
      
      public function fileDelete(name:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_FileDelete",name) as Boolean;
      }
      
      public function fileShare(name:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_FileShare",name) as Boolean;
      }
      
      public function fileShareResult() : String
      {
         return this._ExtensionContext.call("AIRSteam_FileShareResult") as String;
      }
      
      public function isCloudEnabledForApp() : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_IsCloudEnabledForApp") as Boolean;
      }
      
      public function setCloudEnabledForApp(enabled:Boolean) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_SetCloudEnabledForApp",enabled) as Boolean;
      }
      
      public function getQuota() : Array
      {
         return this._ExtensionContext.call("AIRSteam_GetQuota") as Array;
      }
      
      public function UGCDownload(handle:String, priority:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UGCDownload",handle,priority) as Boolean;
      }
      
      public function UGCRead(handle:String, size:int, offset:uint, data:ByteArray) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UGCRead",handle,size,offset,data) as Boolean;
      }
      
      public function getUGCDownloadProgress(handle:String) : Array
      {
         return this._ExtensionContext.call("AIRSteam_GetUGCDownloadProgress",handle) as Array;
      }
      
      public function getUGCDownloadResult(handle:String) : DownloadUGCResult
      {
         return this._ExtensionContext.call("AIRSteam_GetUGCDownloadResult",handle) as DownloadUGCResult;
      }
      
      public function publishWorkshopFile(name:String, preview:String, appId:uint, title:String, description:String, visibility:uint, tags:Array, fileType:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_PublishWorkshopFile",name,preview,appId,title,description,visibility,tags,fileType) as Boolean;
      }
      
      public function publishWorkshopFileResult() : String
      {
         return this._ExtensionContext.call("AIRSteam_PublishWorkshopFileResult") as String;
      }
      
      public function deletePublishedFile(file:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_DeletePublishedFile",file) as Boolean;
      }
      
      public function getPublishedFileDetails(file:String, maxAge:uint = 0) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_GetPublishedFileDetails",file,maxAge) as Boolean;
      }
      
      public function getPublishedFileDetailsResult(file:String) : FileDetailsResult
      {
         return this._ExtensionContext.call("AIRSteam_GetPublishedFileDetailsResult",file) as FileDetailsResult;
      }
      
      public function enumerateUserPublishedFiles(startIndex:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_EnumerateUserPublishedFiles",startIndex) as Boolean;
      }
      
      public function enumerateUserPublishedFilesResult() : UserFilesResult
      {
         return this._ExtensionContext.call("AIRSteam_EnumerateUserPublishedFilesResult") as UserFilesResult;
      }
      
      public function enumeratePublishedWorkshopFiles(type:uint, start:uint, count:uint, days:uint, tags:Array, userTags:Array) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_EnumeratePublishedWorkshopFiles",type,start,count,days,tags,userTags) as Boolean;
      }
      
      public function enumeratePublishedWorkshopFilesResult() : WorkshopFilesResult
      {
         return this._ExtensionContext.call("AIRSteam_EnumeratePublishedWorkshopFilesResult") as WorkshopFilesResult;
      }
      
      public function enumerateUserSubscribedFiles(startIndex:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_EnumerateUserSubscribedFiles",startIndex) as Boolean;
      }
      
      public function enumerateUserSubscribedFilesResult() : SubscribedFilesResult
      {
         return this._ExtensionContext.call("AIRSteam_EnumerateUserSubscribedFilesResult") as SubscribedFilesResult;
      }
      
      public function enumerateUserSharedWorkshopFiles(steamID:String, start:uint, required:Array, excluded:Array) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_EnumerateUserSharedWorkshopFiles",steamID,start,required,excluded) as Boolean;
      }
      
      public function enumerateUserSharedWorkshopFilesResult() : UserFilesResult
      {
         return this._ExtensionContext.call("AIRSteam_EnumerateUserSharedWorkshopFilesResult") as UserFilesResult;
      }
      
      public function enumeratePublishedFilesByUserAction(action:uint, startIndex:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_EnumeratePublishedFilesByUserAction",action,startIndex) as Boolean;
      }
      
      public function enumeratePublishedFilesByUserActionResult() : FilesByUserActionResult
      {
         return this._ExtensionContext.call("AIRSteam_EnumeratePublishedFilesByUserActionResult") as FilesByUserActionResult;
      }
      
      public function subscribePublishedFile(file:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_SubscribePublishedFile",file) as Boolean;
      }
      
      public function unsubscribePublishedFile(file:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UnsubscribePublishedFile",file) as Boolean;
      }
      
      public function createPublishedFileUpdateRequest(file:String) : String
      {
         return this._ExtensionContext.call("AIRSteam_CreatePublishedFileUpdateRequest",file) as String;
      }
      
      public function updatePublishedFileFile(handle:String, file:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UpdatePublishedFileFile",handle,file) as Boolean;
      }
      
      public function updatePublishedFilePreviewFile(handle:String, preview:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UpdatePublishedFilePreviewFile",handle,preview) as Boolean;
      }
      
      public function updatePublishedFileTitle(handle:String, title:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UpdatePublishedFileTitle",handle,title) as Boolean;
      }
      
      public function updatePublishedFileDescription(handle:String, description:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UpdatePublishedFileDescription",handle,description) as Boolean;
      }
      
      public function updatePublishedFileSetChangeDescription(handle:String, changeDesc:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UpdatePublishedFileSetChangeDescription",handle,changeDesc) as Boolean;
      }
      
      public function updatePublishedFileVisibility(handle:String, visibility:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UpdatePublishedFileVisibility",handle,visibility) as Boolean;
      }
      
      public function updatePublishedFileTags(handle:String, tags:Array) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UpdatePublishedFileTags",handle,tags) as Boolean;
      }
      
      public function commitPublishedFileUpdate(handle:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_CommitPublishedFileUpdate",handle) as Boolean;
      }
      
      public function getPublishedItemVoteDetails(file:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_GetPublishedItemVoteDetails",file) as Boolean;
      }
      
      public function getPublishedItemVoteDetailsResult() : ItemVoteDetailsResult
      {
         return this._ExtensionContext.call("AIRSteam_GetPublishedItemVoteDetailsResult") as ItemVoteDetailsResult;
      }
      
      public function getUserPublishedItemVoteDetails(file:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_GetUserPublishedItemVoteDetails",file) as Boolean;
      }
      
      public function getUserPublishedItemVoteDetailsResult() : UserVoteDetails
      {
         return this._ExtensionContext.call("AIRSteam_GetUserPublishedItemVoteDetailsResult") as UserVoteDetails;
      }
      
      public function updateUserPublishedItemVote(file:String, upvote:Boolean) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UpdateUserPublishedItemVote",file,upvote) as Boolean;
      }
      
      public function setUserPublishedFileAction(file:String, action:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_SetUserPublishedFileAction",file,action) as Boolean;
      }
      
      public function getFriendCount(flags:uint) : int
      {
         return this._ExtensionContext.call("AIRSteam_GetFriendCount",flags) as int;
      }
      
      public function getFriendByIndex(index:int, flags:uint) : String
      {
         return this._ExtensionContext.call("AIRSteam_GetFriendByIndex",index,flags) as String;
      }
      
      public function getFriendPersonaName(id:String) : String
      {
         return this._ExtensionContext.call("AIRSteam_GetFriendPersonaName",id) as String;
      }
      
      public function getAuthSessionTicket(ticket:ByteArray) : uint
      {
         return this._ExtensionContext.call("AIRSteam_GetAuthSessionTicket",ticket) as uint;
      }
      
      public function getAuthSessionTicketResult() : uint
      {
         return this._ExtensionContext.call("AIRSteam_GetAuthSessionTicketResult") as uint;
      }
      
      public function beginAuthSession(ticket:ByteArray, steamID:String) : int
      {
         return this._ExtensionContext.call("AIRSteam_BeginAuthSession",ticket,steamID) as int;
      }
      
      public function endAuthSession(steamID:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_EndAuthSession",steamID) as Boolean;
      }
      
      public function cancelAuthTicket(ticketHandle:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_CancelAuthTicket",ticketHandle) as Boolean;
      }
      
      public function userHasLicenseForApp(steamID:String, appID:uint) : int
      {
         return this._ExtensionContext.call("AIRSteam_UserHasLicenseForApp",steamID,appID) as int;
      }
      
      public function activateGameOverlay(dialog:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_ActivateGameOverlay",dialog) as Boolean;
      }
      
      public function activateGameOverlayToUser(dialog:String, steamId:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_ActivateGameOverlayToUser",dialog,steamId) as Boolean;
      }
      
      public function activateGameOverlayToWebPage(url:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_ActivateGameOverlayToWebPage",url) as Boolean;
      }
      
      public function activateGameOverlayToStore(appId:uint, flag:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_ActivateGameOverlayToStore",appId,flag) as Boolean;
      }
      
      public function activateGameOverlayInviteDialog(steamIdLobby:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_ActivateGameOverlayInviteDialog",steamIdLobby) as Boolean;
      }
      
      public function isOverlayEnabled() : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_IsOverlayEnabled") as Boolean;
      }
      
      public function setOverlayNotificationPosition(position:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_SetOverlayNotificationPosition",position) as Boolean;
      }
      
      public function isSubscribedApp(appId:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_IsSubscribedApp",appId) as Boolean;
      }
      
      public function isDLCInstalled(appId:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_IsDLCInstalled",appId) as Boolean;
      }
      
      public function getDLCCount() : int
      {
         return this._ExtensionContext.call("AIRSteam_GetDLCCount") as int;
      }
      
      public function installDLC(appId:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_InstallDLC",appId) as Boolean;
      }
      
      public function uninstallDLC(appId:uint) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_UninstallDLC",appId) as Boolean;
      }
      
      public function DLCInstalledResult() : uint
      {
         return this._ExtensionContext.call("AIRSteam_DLCInstalledResult") as uint;
      }
      
      public function microTxnResult() : MicroTxnAuthorizationResponse
      {
         return this._ExtensionContext.call("AIRSteam_MicroTxnResult") as MicroTxnAuthorizationResponse;
      }
      
      public function getEnv(name:String) : String
      {
         return this._ExtensionContext.call("AIRSteam_GetEnv",name) as String;
      }
      
      public function setEnv(name:String, value:String) : Boolean
      {
         return this._ExtensionContext.call("AIRSteam_SetEnv",name,value) as Boolean;
      }
   }
}

