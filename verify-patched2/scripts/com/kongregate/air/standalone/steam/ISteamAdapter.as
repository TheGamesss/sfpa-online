package com.kongregate.air.standalone.steam
{
   public interface ISteamAdapter
   {
      
      function get initialized() : Boolean;
      
      function get personaName() : String;
      
      function get steamID() : String;
      
      function getAuthSessionTicket(param1:Function) : void;
   }
}

