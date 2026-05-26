import com.amanitadesign.steam.*;
import com.kongregate.air.standalone.steam.*;
import flash.desktop.*;
import flash.utils.*;

class FRESteamWorksAdapter implements ISteamAdapter
{
    public var initialized(get, never) : Bool;
    public var personaName(get, never) : String;
    public var steamID(get, never) : String;

    
    private static var mSteamworks : FRESteamWorks = new FRESteamWorks();
    
    private var mAppId : Int = 0;
    
    private var mAuthHandle : Int = 0;
    
    private var mAuthTicket : ByteArray = null;
    
    private var mAuthTicketCallback : Dynamic = null;
    
    private var mUserId : String = null;
    
    public function new()
    {
        var language : String = null;
        super();
        if (!mSteamworks.init())
        {
            trace("STEAMWORKS API is NOT available");
            NativeApplication.nativeApplication.exit();
        }
        else
        {
            trace("STEAMWORKS API is available");
            this.mUserId = mSteamworks.getUserID();
            this.mAppId = mSteamworks.getAppID();
            trace("- language " + mSteamworks.getCurrentGameLanguage());
            language = mSteamworks.getCurrentGameLanguage();
            switch (language)
            {
                case "english":
                    Main.localSettings.language = "English";
                case "spanish":
                    Main.localSettings.language = "Spanish";
                case "french":
                    Main.localSettings.language = "French";
                case "italian":
                    Main.localSettings.language = "Italian";
                case "portuguese":
                    Main.localSettings.language = "Portuguese";
                case "german":
                    Main.localSettings.language = "German";
                case "russian":
                    Main.localSettings.language = "Russian";
            }
            mSteamworks.requestStats();
            mSteamworks.addEventListener(SteamEvent.STEAM_RESPONSE, this.onSteamResponse);
        }
    }
    
    public static function setAchievement(e : String) : Void
    {
        trace("get " + e + " " + mSteamworks.isAchievement(e));
        mSteamworks.setAchievement(e);
        mSteamworks.storeStats();
    }
    
    public static function flushStats() : Void
    {
    }
    
    private function get_initialized() : Bool
    {
        return this.mAppId > 0;
    }
    
    private function get_personaName() : String
    {
        return mSteamworks.getPersonaName();
    }
    
    private function get_steamID() : String
    {
        return mSteamworks.getUserID();
    }
    
    public function getAuthSessionTicket(callback : Dynamic) : Void
    {
        this.mAuthTicket = new ByteArray();
        this.mAuthHandle = mSteamworks.getAuthSessionTicket(this.mAuthTicket);
        this.mAuthTicketCallback = callback;
        trace("getAuthSessionTicket(ticket) == " + this.mAuthHandle);
        trace(this.mAuthHandle > 0);
    }
    
    private function onSteamResponse(e : SteamEvent) : Void
    {
        var apiCall : Bool = false;
        var i : Int = 0;
        var authTicket : ByteArray = null;
        trace("- language " + mSteamworks.getCurrentGameLanguage());
        var _sw26_ = (e.req_type);        

        switch (_sw26_)
        {
            case SteamConstants.RESPONSE_OnGetAuthSessionTicketResponse:
                trace("RESPONSE_OnGetAuthSessionTicketResponse: " + e.response);
                if (e.response != SteamResults.OK)
                {
                    trace("FAILED!");
                    break;
                }
                if (this.mAuthHandle == UserConstants.AUTHTICKET_Invalid)
                {
                    trace("Invalid authHandle (cancelled?)");
                    break;
                }
                if (this.mAuthHandle != mSteamworks.getAuthSessionTicketResult())
                {
                    trace("Result is for the wrong handle");
                    break;
                }
                authTicket = new ByteArray();
                authTicket.writeBytes(this.mAuthTicket);
                authTicket.position = 0;
                this.mAuthTicket = null;
                this.mAuthHandle = 0;
                if (this.mAuthTicketCallback != null)
                {
                    trace("Got auth ticket: notifying callback");
                    this.mAuthTicketCallback(authTicket);
                }
                else
                {
                    trace("Got auth ticket: callback not defined");
                }
            default:
                trace("STEAMresponse type:" + e.req_type + " response:" + e.response);
        }
    }
}


