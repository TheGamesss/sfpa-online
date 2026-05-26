package
{
   import com.amanitadesign.steam.*;
   import com.kongregate.air.standalone.steam.*;
   import flash.desktop.*;
   import flash.utils.*;
   
   public class FRESteamWorksAdapter implements ISteamAdapter
   {
      
      private static var mSteamworks:FRESteamWorks = new FRESteamWorks();
      
      private var mAppId:uint = 0;
      
      private var mAuthHandle:uint = 0;
      
      private var mAuthTicket:ByteArray = null;
      
      private var mAuthTicketCallback:Function = null;
      
      private var mUserId:String = null;
      
      public function FRESteamWorksAdapter()
      {
         var language:String = null;
         super();
         if(!mSteamworks.init())
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
         trace("get " + e + " " + mSteamworks.isAchievement(e));
         mSteamworks.setAchievement(e);
         mSteamworks.storeStats();
      }
      
      public static function flushStats() : void
      {
      }
      
      public function get initialized() : Boolean
      {
         return this.mAppId > 0;
      }
      
      public function get personaName() : String
      {
         return mSteamworks.getPersonaName();
      }
      
      public function get steamID() : String
      {
         return mSteamworks.getUserID();
      }
      
      public function getAuthSessionTicket(callback:Function) : void
      {
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

