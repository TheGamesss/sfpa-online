package com.miniclip.gamemanager.lobby
{
   public class LobbyConfig
   {
      
      private var _name:String;
      
      private var _zone:String;
      
      private var _server:String;
      
      private var _minplayer:int;
      
      private var _maxplayer:int;
      
      private var _port:int;
      
      private var _extra:Object;
      
      public function LobbyConfig(name:String, zone:String, server:String, minplayer:int, maxplayer:int, port:int, extra:Object = null)
      {
         super();
         this._name = name;
         this._zone = zone;
         this._server = server;
         this._minplayer = minplayer;
         this._maxplayer = maxplayer;
         this._port = port;
         this._extra = extra;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get zone() : String
      {
         return this._zone;
      }
      
      public function get server() : String
      {
         return this._server;
      }
      
      public function get minplayer() : int
      {
         return this._minplayer;
      }
      
      public function get maxplayer() : int
      {
         return this._maxplayer;
      }
      
      public function get port() : int
      {
         return this._port;
      }
      
      public function get extra() : Object
      {
         return this._extra;
      }
   }
}

