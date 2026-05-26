package com.amanitadesign.steam;

import flash.display.*;
import flash.events.*;
import flash.external.*;
import flash.utils.*;

class FRESteamWorks extends EventDispatcher
{
    
    private var _ExtensionContext : ExtensionContext;
    
    private var _tm : Int;
    
    private var _redrawPixel : Sprite = null;
    
    private var _redrawContainer : DisplayObjectContainer = null;
    
    private var _color : Int;
    
    private var _alwaysVisible : Bool;
    
    public var isReady : Bool = false;
    
    public function new(target : IEventDispatcher = null)
    {
        this._ExtensionContext = ExtensionContext.createExtensionContext("com.amanitadesign.steam.FRESteamWorks", null);
        this._ExtensionContext.addEventListener(StatusEvent.STATUS, this.handleStatusEvent);
        super(target);
    }
    
    private function handleStatusEvent(event : StatusEvent) : Void
    {
        var req_type : Int = new Int(event.code);
        var response : Int = new Int(event.level);
        var sEvent : SteamEvent = new SteamEvent(SteamEvent.STEAM_RESPONSE, req_type, response);
        if (cast(this._redrawContainer, Bool) && cast(!this._alwaysVisible, Bool) && req_type == SteamConstants.RESPONSE_OnGameOverlayActivated)
        {
            if (response == SteamResults.OK && !this._redrawPixel)
            {
                this.addRedrawPixel();
            }
            else if (response == SteamResults.Fail && cast(this._redrawPixel, Bool))
            {
                as3hx.Compat.setTimeout(this.removeRedrawPixel, 3000);
            }
        }
        dispatchEvent(sEvent);
    }
    
    private function addRedrawPixel() : Void
    {
        if (!this._redrawContainer || cast(this._redrawPixel, Bool))
        {
            return;
        }
        this._redrawPixel = new Sprite();
        this._redrawPixel.width = 1;
        this._redrawPixel.height = 1;
        this._redrawPixel.graphics.beginFill(this._color);
        this._redrawPixel.graphics.drawRect(0, 0, 1, 1);
        this._redrawPixel.graphics.endFill();
        this._redrawPixel.addEventListener(Event.ENTER_FRAME, this.redrawPixel);
        this._redrawContainer.addChild(this._redrawPixel);
    }
    
    private function removeRedrawPixel() : Void
    {
        if (!this._redrawContainer || !this._redrawPixel)
        {
            return;
        }
        this._redrawPixel.removeEventListener(Event.ENTER_FRAME, this.redrawPixel);
        this._redrawContainer.removeChild(this._redrawPixel);
        this._redrawPixel = null;
    }
    
    private function redrawPixel(e : Event = null) : Void
    {
        this._redrawPixel.rotation += 1;
    }
    
    public function addOverlayWorkaround(container : DisplayObjectContainer, alwaysVisible : Bool = false, color : Int = 0) : Void
    {
        this._redrawContainer = container;
        this._alwaysVisible = alwaysVisible;
        this._color = color;
        if (alwaysVisible)
        {
            this.addRedrawPixel();
        }
    }
    
    public function dispose() : Void
    {
        as3hx.Compat.clearInterval(this._tm);
        this._ExtensionContext.removeEventListener(StatusEvent.STATUS, this.handleStatusEvent);
        this._ExtensionContext.dispose();
    }
    
    public function init() : Bool
    {
        this.isReady = try cast(this._ExtensionContext.call("AIRSteam_Init"), Bool) catch(e:Dynamic) null;
        if (this.isReady)
        {
            this._tm = as3hx.Compat.setInterval(this.runCallbacks, 100);
        }
        return this.isReady;
    }
    
    public function runCallbacks() : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_RunCallbacks"), Bool) catch(e:Dynamic) null;
    }
    
    public function getUserID() : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_GetUserID"));
    }
    
    public function getAppID() : Int
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetAppID"), Int) catch(e:Dynamic) null;
    }
    
    public function getAvailableGameLanguages() : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_GetAvailableGameLanguages"));
    }
    
    public function getCurrentGameLanguage() : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_GetCurrentGameLanguage"));
    }
    
    public function getPersonaName() : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_GetPersonaName"));
    }
    
    public function restartAppIfNecessary(appID : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_RestartAppIfNecessary", appID), Bool) catch(e:Dynamic) null;
    }
    
    public function requestStats() : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_RequestStats"), Bool) catch(e:Dynamic) null;
    }
    
    public function setAchievement(name : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_SetAchievement", name), Bool) catch(e:Dynamic) null;
    }
    
    public function clearAchievement(name : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_ClearAchievement", name), Bool) catch(e:Dynamic) null;
    }
    
    public function isAchievement(name : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_IsAchievement", name), Bool) catch(e:Dynamic) null;
    }
    
    public function indicateAchievementProgress(name : String, currentProgress : Int, maxProgress : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_IndicateAchievementProgress", name, currentProgress, maxProgress), Bool) catch(e:Dynamic) null;
    }
    
    public function getStatInt(name : String) : Int
    {
        return as3hx.Compat.parseInt(this._ExtensionContext.call("AIRSteam_GetStatInt", name));
    }
    
    public function getStatFloat(name : String) : Float
    {
        return as3hx.Compat.parseFloat(this._ExtensionContext.call("AIRSteam_GetStatFloat", name));
    }
    
    public function setStatInt(name : String, value : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_SetStatInt", name, value), Bool) catch(e:Dynamic) null;
    }
    
    public function setStatFloat(name : String, value : Float) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_SetStatFloat", name, value), Bool) catch(e:Dynamic) null;
    }
    
    public function storeStats() : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_StoreStats"), Bool) catch(e:Dynamic) null;
    }
    
    public function resetAllStats(achievementsToo : Bool) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_ResetAllStats", achievementsToo), Bool) catch(e:Dynamic) null;
    }
    
    public function requestGlobalStats(historyDays : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_RequestGlobalStats", historyDays), Bool) catch(e:Dynamic) null;
    }
    
    public function getGlobalStatInt(name : String) : Float
    {
        return as3hx.Compat.parseFloat(this._ExtensionContext.call("AIRSteam_GetGlobalStatInt", name));
    }
    
    public function getGlobalStatFloat(name : String) : Float
    {
        return as3hx.Compat.parseFloat(this._ExtensionContext.call("AIRSteam_GetGlobalStatFloat", name));
    }
    
    public function getGlobalStatHistoryInt(name : String, days : Int) : Array<Dynamic>
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetGlobalStatHistoryInt", name, days), Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null;
    }
    
    public function getGlobalStatHistoryFloat(name : String, days : Int) : Array<Dynamic>
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetGlobalStatHistoryFloat", name, days), Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null;
    }
    
    public function findLeaderboard(name : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_FindLeaderboard", name), Bool) catch(e:Dynamic) null;
    }
    
    public function findOrCreateLeaderboard(name : String, sortMethod : Int, displayType : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_FindOrCreateLeaderboard", name, sortMethod, displayType), Bool) catch(e:Dynamic) null;
    }
    
    public function findLeaderboardResult() : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_FindLeaderboardResult"));
    }
    
    public function getLeaderboardName(handle : String) : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_GetLeaderboardName", handle));
    }
    
    public function getLeaderboardEntryCount(handle : String) : Int
    {
        return as3hx.Compat.parseInt(this._ExtensionContext.call("AIRSteam_GetLeaderboardEntryCount", handle));
    }
    
    public function getLeaderboardSortMethod(handle : String) : Int
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetLeaderboardSortMethod", handle), Int) catch(e:Dynamic) null;
    }
    
    public function getLeaderboardDisplayType(handle : String) : Int
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetLeaderboardDisplayType", handle), Int) catch(e:Dynamic) null;
    }
    
    public function uploadLeaderboardScore(handle : String, method : Int, score : Int, details : Array<Dynamic> = null) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UploadLeaderboardScore", handle, method, score, details), Bool) catch(e:Dynamic) null;
    }
    
    public function uploadLeaderboardScoreResult() : UploadLeaderboardScoreResult
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UploadLeaderboardScoreResult"), UploadLeaderboardScoreResult) catch(e:Dynamic) null;
    }
    
    public function downloadLeaderboardEntries(handle : String, request : Int = 1, rangeStart : Int = -4, rangeEnd : Int = 5) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_DownloadLeaderboardEntries", handle, request, rangeStart, rangeEnd), Bool) catch(e:Dynamic) null;
    }
    
    public function downloadLeaderboardEntriesResult(numDetails : Int = 0) : Array<Dynamic>
    {
        return try cast(this._ExtensionContext.call("AIRSteam_DownloadLeaderboardEntriesResult", numDetails), Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null;
    }
    
    public function getFileCount() : Int
    {
        return as3hx.Compat.parseInt(this._ExtensionContext.call("AIRSteam_GetFileCount"));
    }
    
    public function getFileSize(name : String) : Int
    {
        return as3hx.Compat.parseInt(this._ExtensionContext.call("AIRSteam_GetFileSize", name));
    }
    
    public function fileExists(name : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_FileExists", name), Bool) catch(e:Dynamic) null;
    }
    
    public function fileWrite(name : String, data : ByteArray) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_FileWrite", name, data), Bool) catch(e:Dynamic) null;
    }
    
    public function fileRead(name : String, data : ByteArray) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_FileRead", name, data), Bool) catch(e:Dynamic) null;
    }
    
    public function fileDelete(name : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_FileDelete", name), Bool) catch(e:Dynamic) null;
    }
    
    public function fileShare(name : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_FileShare", name), Bool) catch(e:Dynamic) null;
    }
    
    public function fileShareResult() : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_FileShareResult"));
    }
    
    public function isCloudEnabledForApp() : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_IsCloudEnabledForApp"), Bool) catch(e:Dynamic) null;
    }
    
    public function setCloudEnabledForApp(enabled : Bool) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_SetCloudEnabledForApp", enabled), Bool) catch(e:Dynamic) null;
    }
    
    public function getQuota() : Array<Dynamic>
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetQuota"), Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null;
    }
    
    public function UGCDownload(handle : String, priority : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UGCDownload", handle, priority), Bool) catch(e:Dynamic) null;
    }
    
    public function UGCRead(handle : String, size : Int, offset : Int, data : ByteArray) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UGCRead", handle, size, offset, data), Bool) catch(e:Dynamic) null;
    }
    
    public function getUGCDownloadProgress(handle : String) : Array<Dynamic>
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetUGCDownloadProgress", handle), Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null;
    }
    
    public function getUGCDownloadResult(handle : String) : DownloadUGCResult
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetUGCDownloadResult", handle), DownloadUGCResult) catch(e:Dynamic) null;
    }
    
    public function publishWorkshopFile(name : String, preview : String, appId : Int, title : String, description : String, visibility : Int, tags : Array<Dynamic>, fileType : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_PublishWorkshopFile", name, preview, appId, title, description, visibility, tags, fileType), Bool) catch(e:Dynamic) null;
    }
    
    public function publishWorkshopFileResult() : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_PublishWorkshopFileResult"));
    }
    
    public function deletePublishedFile(file : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_DeletePublishedFile", file), Bool) catch(e:Dynamic) null;
    }
    
    public function getPublishedFileDetails(file : String, maxAge : Int = 0) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetPublishedFileDetails", file, maxAge), Bool) catch(e:Dynamic) null;
    }
    
    public function getPublishedFileDetailsResult(file : String) : FileDetailsResult
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetPublishedFileDetailsResult", file), FileDetailsResult) catch(e:Dynamic) null;
    }
    
    public function enumerateUserPublishedFiles(startIndex : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_EnumerateUserPublishedFiles", startIndex), Bool) catch(e:Dynamic) null;
    }
    
    public function enumerateUserPublishedFilesResult() : UserFilesResult
    {
        return try cast(this._ExtensionContext.call("AIRSteam_EnumerateUserPublishedFilesResult"), UserFilesResult) catch(e:Dynamic) null;
    }
    
    public function enumeratePublishedWorkshopFiles(type : Int, start : Int, count : Int, days : Int, tags : Array<Dynamic>, userTags : Array<Dynamic>) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_EnumeratePublishedWorkshopFiles", type, start, count, days, tags, userTags), Bool) catch(e:Dynamic) null;
    }
    
    public function enumeratePublishedWorkshopFilesResult() : WorkshopFilesResult
    {
        return try cast(this._ExtensionContext.call("AIRSteam_EnumeratePublishedWorkshopFilesResult"), WorkshopFilesResult) catch(e:Dynamic) null;
    }
    
    public function enumerateUserSubscribedFiles(startIndex : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_EnumerateUserSubscribedFiles", startIndex), Bool) catch(e:Dynamic) null;
    }
    
    public function enumerateUserSubscribedFilesResult() : SubscribedFilesResult
    {
        return try cast(this._ExtensionContext.call("AIRSteam_EnumerateUserSubscribedFilesResult"), SubscribedFilesResult) catch(e:Dynamic) null;
    }
    
    public function enumerateUserSharedWorkshopFiles(steamID : String, start : Int, required : Array<Dynamic>, excluded : Array<Dynamic>) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_EnumerateUserSharedWorkshopFiles", steamID, start, required, excluded), Bool) catch(e:Dynamic) null;
    }
    
    public function enumerateUserSharedWorkshopFilesResult() : UserFilesResult
    {
        return try cast(this._ExtensionContext.call("AIRSteam_EnumerateUserSharedWorkshopFilesResult"), UserFilesResult) catch(e:Dynamic) null;
    }
    
    public function enumeratePublishedFilesByUserAction(action : Int, startIndex : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_EnumeratePublishedFilesByUserAction", action, startIndex), Bool) catch(e:Dynamic) null;
    }
    
    public function enumeratePublishedFilesByUserActionResult() : FilesByUserActionResult
    {
        return try cast(this._ExtensionContext.call("AIRSteam_EnumeratePublishedFilesByUserActionResult"), FilesByUserActionResult) catch(e:Dynamic) null;
    }
    
    public function subscribePublishedFile(file : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_SubscribePublishedFile", file), Bool) catch(e:Dynamic) null;
    }
    
    public function unsubscribePublishedFile(file : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UnsubscribePublishedFile", file), Bool) catch(e:Dynamic) null;
    }
    
    public function createPublishedFileUpdateRequest(file : String) : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_CreatePublishedFileUpdateRequest", file));
    }
    
    public function updatePublishedFileFile(handle : String, file : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UpdatePublishedFileFile", handle, file), Bool) catch(e:Dynamic) null;
    }
    
    public function updatePublishedFilePreviewFile(handle : String, preview : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UpdatePublishedFilePreviewFile", handle, preview), Bool) catch(e:Dynamic) null;
    }
    
    public function updatePublishedFileTitle(handle : String, title : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UpdatePublishedFileTitle", handle, title), Bool) catch(e:Dynamic) null;
    }
    
    public function updatePublishedFileDescription(handle : String, description : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UpdatePublishedFileDescription", handle, description), Bool) catch(e:Dynamic) null;
    }
    
    public function updatePublishedFileSetChangeDescription(handle : String, changeDesc : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UpdatePublishedFileSetChangeDescription", handle, changeDesc), Bool) catch(e:Dynamic) null;
    }
    
    public function updatePublishedFileVisibility(handle : String, visibility : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UpdatePublishedFileVisibility", handle, visibility), Bool) catch(e:Dynamic) null;
    }
    
    public function updatePublishedFileTags(handle : String, tags : Array<Dynamic>) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UpdatePublishedFileTags", handle, tags), Bool) catch(e:Dynamic) null;
    }
    
    public function commitPublishedFileUpdate(handle : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_CommitPublishedFileUpdate", handle), Bool) catch(e:Dynamic) null;
    }
    
    public function getPublishedItemVoteDetails(file : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetPublishedItemVoteDetails", file), Bool) catch(e:Dynamic) null;
    }
    
    public function getPublishedItemVoteDetailsResult() : ItemVoteDetailsResult
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetPublishedItemVoteDetailsResult"), ItemVoteDetailsResult) catch(e:Dynamic) null;
    }
    
    public function getUserPublishedItemVoteDetails(file : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetUserPublishedItemVoteDetails", file), Bool) catch(e:Dynamic) null;
    }
    
    public function getUserPublishedItemVoteDetailsResult() : UserVoteDetails
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetUserPublishedItemVoteDetailsResult"), UserVoteDetails) catch(e:Dynamic) null;
    }
    
    public function updateUserPublishedItemVote(file : String, upvote : Bool) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UpdateUserPublishedItemVote", file, upvote), Bool) catch(e:Dynamic) null;
    }
    
    public function setUserPublishedFileAction(file : String, action : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_SetUserPublishedFileAction", file, action), Bool) catch(e:Dynamic) null;
    }
    
    public function getFriendCount(flags : Int) : Int
    {
        return as3hx.Compat.parseInt(this._ExtensionContext.call("AIRSteam_GetFriendCount", flags));
    }
    
    public function getFriendByIndex(index : Int, flags : Int) : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_GetFriendByIndex", index, flags));
    }
    
    public function getFriendPersonaName(id : String) : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_GetFriendPersonaName", id));
    }
    
    public function getAuthSessionTicket(ticket : ByteArray) : Int
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetAuthSessionTicket", ticket), Int) catch(e:Dynamic) null;
    }
    
    public function getAuthSessionTicketResult() : Int
    {
        return try cast(this._ExtensionContext.call("AIRSteam_GetAuthSessionTicketResult"), Int) catch(e:Dynamic) null;
    }
    
    public function beginAuthSession(ticket : ByteArray, steamID : String) : Int
    {
        return as3hx.Compat.parseInt(this._ExtensionContext.call("AIRSteam_BeginAuthSession", ticket, steamID));
    }
    
    public function endAuthSession(steamID : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_EndAuthSession", steamID), Bool) catch(e:Dynamic) null;
    }
    
    public function cancelAuthTicket(ticketHandle : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_CancelAuthTicket", ticketHandle), Bool) catch(e:Dynamic) null;
    }
    
    public function userHasLicenseForApp(steamID : String, appID : Int) : Int
    {
        return as3hx.Compat.parseInt(this._ExtensionContext.call("AIRSteam_UserHasLicenseForApp", steamID, appID));
    }
    
    public function activateGameOverlay(dialog : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_ActivateGameOverlay", dialog), Bool) catch(e:Dynamic) null;
    }
    
    public function activateGameOverlayToUser(dialog : String, steamId : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_ActivateGameOverlayToUser", dialog, steamId), Bool) catch(e:Dynamic) null;
    }
    
    public function activateGameOverlayToWebPage(url : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_ActivateGameOverlayToWebPage", url), Bool) catch(e:Dynamic) null;
    }
    
    public function activateGameOverlayToStore(appId : Int, flag : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_ActivateGameOverlayToStore", appId, flag), Bool) catch(e:Dynamic) null;
    }
    
    public function activateGameOverlayInviteDialog(steamIdLobby : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_ActivateGameOverlayInviteDialog", steamIdLobby), Bool) catch(e:Dynamic) null;
    }
    
    public function isOverlayEnabled() : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_IsOverlayEnabled"), Bool) catch(e:Dynamic) null;
    }
    
    public function setOverlayNotificationPosition(position : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_SetOverlayNotificationPosition", position), Bool) catch(e:Dynamic) null;
    }
    
    public function isSubscribedApp(appId : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_IsSubscribedApp", appId), Bool) catch(e:Dynamic) null;
    }
    
    public function isDLCInstalled(appId : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_IsDLCInstalled", appId), Bool) catch(e:Dynamic) null;
    }
    
    public function getDLCCount() : Int
    {
        return as3hx.Compat.parseInt(this._ExtensionContext.call("AIRSteam_GetDLCCount"));
    }
    
    public function installDLC(appId : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_InstallDLC", appId), Bool) catch(e:Dynamic) null;
    }
    
    public function uninstallDLC(appId : Int) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_UninstallDLC", appId), Bool) catch(e:Dynamic) null;
    }
    
    public function DLCInstalledResult() : Int
    {
        return try cast(this._ExtensionContext.call("AIRSteam_DLCInstalledResult"), Int) catch(e:Dynamic) null;
    }
    
    public function microTxnResult() : MicroTxnAuthorizationResponse
    {
        return try cast(this._ExtensionContext.call("AIRSteam_MicroTxnResult"), MicroTxnAuthorizationResponse) catch(e:Dynamic) null;
    }
    
    public function getEnv(name : String) : String
    {
        return Std.string(this._ExtensionContext.call("AIRSteam_GetEnv", name));
    }
    
    public function setEnv(name : String, value : String) : Bool
    {
        return try cast(this._ExtensionContext.call("AIRSteam_SetEnv", name, value), Bool) catch(e:Dynamic) null;
    }
}


