package com.kongregate.air.standalone
{
   import com.kongregate.air.KongregateAPI;
   import com.kongregate.air.base.Mobile;
   import com.kongregate.air.standalone.steam.ISteamAdapter;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   
   public class StandaloneMobile extends Mobile
   {
      
      private var mInternal:StandaloneInternal;
      
      public function StandaloneMobile(api:KongregateAPI, §internal§:StandaloneInternal)
      {
         super(api);
         this.mInternal = §internal§;
      }
      
      override public function openKongregateWindow(target:String = "", id:String = "") : void
      {
         var steam:ISteamAdapter = null;
         trace("Standalone.OpenKongregateWindow target=" + target + ", id=" + id);
         steam = KongregateAPI.settings.steamAdapter;
         if(steam == null)
         {
            trace("No steam adapter. unable to authenticate and open Kongregate window");
            return;
         }
         steam.getAuthSessionTicket(function(ticketRaw:ByteArray):void
         {
            var req:URLRequest = new URLRequest(StandaloneInternal.getKongregateURL("/steam"));
            req.method = URLRequestMethod.GET;
            req.data = new URLVariables();
            req.data.game_id = mInternal.gameID;
            req.data.auth_ticket = StandaloneInternal.bytesToHexString(ticketRaw);
            req.data.persona = steam.personaName;
            trace("opening: " + req.url + "?" + req.data);
            navigateToURL(req);
         });
      }
   }
}

