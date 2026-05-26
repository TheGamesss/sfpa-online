package
{
   import com.amanitadesign.steam.SteamConstants;
   import com.amanitadesign.steam.SteamEvent;
   import com.amanitadesign.steam.SteamResults;
   import com.amanitadesign.steam.UserConstants;
   import com.kongregate.air.standalone.steam.*;
   import flash.desktop.*;
   import flash.utils.*;
   
   public class FRESteamWorksAdapter implements ISteamAdapter
   {
      
      private static var mSteamworks:Object = null;
      
      private static var mAvailable:Boolean = false;
      
      private var mAppId:uint = 0;
      
      private var mAuthHandle:uint = 0;
      
      private var mAuthTicket:ByteArray = null;
      
      private var mAuthTicketCallback:Function = null;
      
      private var mUserId:String = null;
      
      public function FRESteamWorksAdapter()
      {
         var language:String = null;
         var steamWorksClass:Class = null;
         super();
         mAvailable = false;
         if(mSteamworks == null)
         {
            try
            {
               steamWorksClass = getDefinitionByName("com.amanitadesign.steam::FRESteamWorks") as Class;
               if(steamWorksClass != null)
               {
                  mSteamworks = new steamWorksClass();
               }
            }
            catch(error:Error)
            {
               trace("STEAMWORKS API class is unavailable; continuing without Steam integration");
            }
         }
         if(mSteamworks != null)
         {
            try
            {
               mAvailable = Boolean(mSteamworks.init());
            }
            catch(error:Error)
            {
               trace("STEAMWORKS API failed to initialize; continuing without Steam integration");
               mAvailable = false;
               mSteamworks = null;
            }
         }
         if(!mAvailable)
         {
            trace("STEAMWORKS API is NOT available; continuing without Steam integration");
            this.mUserId = "web-player";
            if(Main.localSettings.language == null || Main.localSettings.language == "")
            {
               Main.localSettings.language = "English";
            }
         }
         else
         {
            trace("STEAMWORKS API is available");
            this.mUserId = mSteamworks.getUserID();
            this.mAppId = mSteamworks.getAppID();
            trace("- language " + mSteamworks.getCurrentGameLanguage());
            language = mSteamworks.getCurrentGameLanguage();
            switch(language)
            {
               case "english":
                  Main.localSettings.language = "English";
                  break;
               case "spanish":
                  Main.localSettings.language = "Spanish";
                  break;
               case "french":
                  Main.localSettings.language = "French";
                  break;
               case "italian":
                  Main.localSettings.language = "Italian";
                  break;
               case "portuguese":
                  Main.localSettings.language = "Portuguese";
                  break;
               case "german":
                  Main.localSettings.language = "German";
                  break;
               case "russian":
                  Main.localSettings.language = "Russian";
            }
            mSteamworks.requestStats();
            mSteamworks.addEventListener(SteamEvent.STEAM_RESPONSE,this.onSteamResponse);
         }
      }
      
      public static function setAchievement(e:String) : void
      {
         if(!mAvailable)
         {
            return;
         }
         trace("get " + e + " " + mSteamworks.isAchievement(e));
         mSteamworks.setAchievement(e);
         mSteamworks.storeStats();
      }
      
      public static function flushStats() : void
      {
      }
      
      public function get initialized() : Boolean
      {
         return mAvailable && this.mAppId > 0;
      }
      
      public function get personaName() : String
      {
         if(!mAvailable)
         {
            return "Web Player";
         }
         return mSteamworks.getPersonaName();
      }
      
      public function get steamID() : String
      {
         if(!mAvailable)
         {
            return this.mUserId;
         }
         return mSteamworks.getUserID();
      }
      
      public function getAuthSessionTicket(callback:Function) : void
      {
         if(!mAvailable)
         {
            if(callback != null)
            {
               callback(new ByteArray());
            }
            return;
         }
         this.mAuthTicket = new ByteArray();
         this.mAuthHandle = mSteamworks.getAuthSessionTicket(this.mAuthTicket);
         this.mAuthTicketCallback = callback;
         trace("getAuthSessionTicket(ticket) == " + this.mAuthHandle);
         trace(this.mAuthHandle > 0);
      }
      
      private function onSteamResponse(e:SteamEvent) : void
      {
         var apiCall:Boolean = false;
         var i:int = 0;
         var authTicket:ByteArray = null;
         if(!mAvailable)
         {
            return;
         }
         trace("- language " + mSteamworks.getCurrentGameLanguage());
         switch(e.req_type)
         {
            case SteamConstants.RESPONSE_OnGetAuthSessionTicketResponse:
               trace("RESPONSE_OnGetAuthSessionTicketResponse: " + e.response);
               if(e.response != SteamResults.OK)
               {
                  trace("FAILED!");
                  break;
               }
               if(this.mAuthHandle == UserConstants.AUTHTICKET_Invalid)
               {
                  trace("Invalid authHandle (cancelled?)");
                  break;
               }
               if(this.mAuthHandle != mSteamworks.getAuthSessionTicketResult())
               {
                  trace("Result is for the wrong handle");
                  break;
               }
               authTicket = new ByteArray();
               authTicket.writeBytes(this.mAuthTicket);
               authTicket.position = 0;
               this.mAuthTicket = null;
               this.mAuthHandle = 0;
               if(this.mAuthTicketCallback != null)
               {
                  trace("Got auth ticket: notifying callback");
                  this.mAuthTicketCallback(authTicket);
               }
               else
               {
                  trace("Got auth ticket: callback not defined");
               }
               break;
            default:
               trace("STEAMresponse type:" + e.req_type + " response:" + e.response);
         }
      }
   }
}

