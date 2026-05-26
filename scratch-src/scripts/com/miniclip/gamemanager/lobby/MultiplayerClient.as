package com.miniclip.gamemanager.lobby
{
   import com.miniclip.logger;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.net.FileReference;
   
   public dynamic class MultiplayerClient implements IEventDispatcher, SmartFoxPro
   {
      
      public static const MODMSG_TO_USER:String = "u";
      
      public static const MODMSG_TO_ROOM:String = "r";
      
      public static const MODMSG_TO_ZONE:String = "z";
      
      public static const XTMSG_TYPE_XML:String = "xml";
      
      public static const XTMSG_TYPE_STR:String = "str";
      
      public static const XTMSG_TYPE_JSON:String = "json";
      
      public static const CONNECTION_MODE_DISCONNECTED:String = "disconnected";
      
      public static const CONNECTION_MODE_SOCKET:String = "socket";
      
      public static const CONNECTION_MODE_HTTP:String = "http";
      
      private var _client:*;
      
      private var _debug:Boolean;
      
      public function MultiplayerClient(client:*, debug:Boolean = false)
      {
         super();
         this._client = client;
         this._debug = debug;
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         if(this._debug)
         {
            logger.log("MultiplayerClient.addEventListener( " + arguments.join(",") + " )");
         }
         this._client.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         if(this._debug)
         {
            logger.log("MultiplayerClient.removeEventListener( " + arguments.join(",") + " )");
         }
         this._client.removeEventListener(type,listener,useCapture);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         if(this._debug)
         {
            logger.log("MultiplayerClient.dispatchEvent( " + arguments.join(",") + " )");
         }
         return this._client.dispatchEvent(event);
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         if(this._debug)
         {
            logger.log("MultiplayerClient.hasEventListener( " + arguments.join(",") + " )");
         }
         return this._client.hasEventListener(type);
      }
      
      public function willTrigger(type:String) : Boolean
      {
         if(this._debug)
         {
            logger.log("MultiplayerClient.willTrigger( " + arguments.join(",") + " )");
         }
         return this._client.willTrigger(type);
      }
      
      public function toString() : String
      {
         return "[object MultiplayerClient]";
      }
      
      public function valueOf() : *
      {
         return this._client;
      }
      
      public function get activeRoomId() : int
      {
         return this._client.activeRoomId;
      }
      
      public function set activeRoomId(value:int) : void
      {
         this._client.activeRoomId = value;
      }
      
      public function get amIModerator() : Boolean
      {
         return this._client.amIModerator;
      }
      
      public function get myUserId() : int
      {
         return this._client.myUserId;
      }
      
      public function set myUserId(value:int) : void
      {
         this._client.myUserId = value;
      }
      
      public function get myUserName() : String
      {
         return this._client.myUserName;
      }
      
      public function set myUserName(value:String) : void
      {
         this._client.myUserName = value;
      }
      
      public function get playerId() : int
      {
         return this._client.playerId;
      }
      
      public function get buddyList() : Array
      {
         return this._client.buddyList;
      }
      
      public function get httpPort() : int
      {
         return this._client.httpPort;
      }
      
      public function get debug() : Boolean
      {
         return this._client.debug;
      }
      
      public function set debug(value:Boolean) : void
      {
         this._client.debug = value;
      }
      
      public function get isConnected() : Boolean
      {
         return this._client.isConnected;
      }
      
      public function set isConnected(value:Boolean) : void
      {
         this._client.isConnected = value;
      }
      
      public function autoJoin() : void
      {
         this._client.autoJoin();
      }
      
      public function createRoom(roomObj:Object, roomId:int = -1) : void
      {
         this._client.createRoom(roomObj,roomId);
      }
      
      public function disconnect() : void
      {
         this._client.disconnect();
      }
      
      public function getActiveRoom() : *
      {
         return this._client.getActiveRoom();
      }
      
      public function getAllRooms() : Array
      {
         return this._client.getAllRooms();
      }
      
      public function getBuddyRoom(buddy:Object) : void
      {
         this._client.getBuddyRoom(buddy);
      }
      
      public function getRoom(roomId:int) : *
      {
         return this._client.getRoom(roomId);
      }
      
      public function getRoomByName(roomName:String) : *
      {
         return this._client.getRoomByName(roomName);
      }
      
      public function getRoomList() : void
      {
         this._client.getRoomList();
      }
      
      public function getVersion() : String
      {
         return this._client.getVersion();
      }
      
      public function joinRoom(newRoom:*, pword:String = "", isSpectator:Boolean = false, dontLeave:Boolean = false, oldRoom:int = -1) : void
      {
         this._client.joinRoom(newRoom,pword,isSpectator,dontLeave,oldRoom);
      }
      
      public function leaveRoom(roomId:int) : void
      {
         this._client.leaveRoom(roomId);
      }
      
      public function loadBuddyList() : void
      {
         this._client.loadBuddyList();
      }
      
      public function login(zone:String, name:String, pass:String) : void
      {
         this._client.login(zone,name,pass);
      }
      
      public function logout() : void
      {
         this._client.logout();
      }
      
      public function roundTripBench() : void
      {
         this._client.roundTripBench();
      }
      
      public function sendObject(obj:Object, roomId:int = -1) : void
      {
         this._client.sendObject(obj,roomId);
      }
      
      public function sendObjectToGroup(obj:Object, userList:Array, roomId:int = -1) : void
      {
         this._client.sendObjectToGroup(obj,userList,roomId);
      }
      
      public function sendPrivateMessage(message:String, recipientId:int, roomId:int = -1) : void
      {
         this._client.sendPrivateMessage(message,recipientId,roomId);
      }
      
      public function sendPublicMessage(message:String, roomId:int = -1) : void
      {
         this._client.sendPublicMessage(message,roomId);
      }
      
      public function setRoomVariables(varList:Array, roomId:int = -1, setOwnership:Boolean = true) : void
      {
         this._client.setRoomVariables(varList,roomId,setOwnership);
      }
      
      public function setUserVariables(varObj:Object, roomId:int = -1) : void
      {
         this._client.setUserVariables(varObj,roomId);
      }
      
      public function switchSpectator(roomId:int = -1) : void
      {
         this._client.switchSpectator(roomId);
      }
      
      public function sendModeratorMessage(message:String, type:String, id:int = -1) : void
      {
         this._client.sendModeratorMessage(message,type,id);
      }
      
      public function getUploadPath() : String
      {
         return this._client.getUploadPath();
      }
      
      public function uploadFile(fileRef:FileReference, id:int = -1, nick:String = "", port:int = -1) : void
      {
         this._client.uploadFile(fileRef,id,nick,port);
      }
      
      public function addBuddy(buddyName:String) : void
      {
         this._client.addBuddy(buddyName);
      }
      
      public function clearBuddyList() : void
      {
         this._client.clearBuddyList();
      }
      
      public function connect(ipAdr:String, port:int = 9339) : void
      {
         this._client.connect(ipAdr,port);
      }
      
      public function removeBuddy(buddyName:String) : void
      {
         this._client.removeBuddy(buddyName);
      }
      
      public function setBuddyVariables(varList:Array) : void
      {
         this._client.setBuddyVariables(varList);
      }
      
      public function get defaultZone() : String
      {
         return this._client.defaultZone;
      }
      
      public function get ipAddress() : String
      {
         return this._client.ipAddress;
      }
      
      public function get port() : int
      {
         return this._client.port;
      }
      
      public function get blueBoxIpAddress() : String
      {
         return this._client.blueBoxIpAddress;
      }
      
      public function get blueBoxPort() : Number
      {
         return this._client.blueBoxPort;
      }
      
      public function get myBuddyVars() : Array
      {
         return this._client.myBuddyVars;
      }
      
      public function get smartConnect() : Boolean
      {
         return this._client.smartConnect;
      }
      
      public function get rawProtocolSeparator() : String
      {
         return this._client.rawProtocolSeparator;
      }
      
      public function set rawProtocolSeparator(value:String) : void
      {
         this._client.rawProtocolSeparator = value;
      }
      
      public function get httpPollSpeed() : int
      {
         return this._client.httpPollSpeed;
      }
      
      public function set httpPollSpeed(value:int) : void
      {
         this._client.httpPollSpeed = value;
      }
      
      public function getRandomKey() : void
      {
         this._client.getRandomKey();
      }
      
      public function sendXtMessage(xtName:String, cmd:String, paramObj:*, type:String = "xml", roomId:int = -1) : void
      {
         if(this._debug)
         {
            logger.log("MultiplayerClient.sendXtMessage( " + arguments.join(",") + " )");
         }
         this._client.sendXtMessage(xtName,cmd,paramObj,type,roomId);
      }
      
      public function getBuddyById(id:int) : Object
      {
         return this._client.getBuddyById(id);
      }
      
      public function getBuddyByName(buddyName:String) : Object
      {
         return this._client.getBuddyByName(buddyName);
      }
      
      public function getConnectionMode() : String
      {
         return this._client.getConnectionMode();
      }
      
      public function loadConfig(configFile:String = "config.xml", autoConnect:Boolean = true) : void
      {
         this._client.loadConfig(configFile,autoConnect);
      }
      
      public function sendBuddyPermissionResponse(allowBuddy:Boolean, targetBuddy:String) : void
      {
         this._client.sendBuddyPermissionResponse(allowBuddy,targetBuddy);
      }
      
      public function setBuddyBlockStatus(buddyName:String, status:Boolean) : void
      {
         this._client.setBuddyBlockStatus(buddyName,status);
      }
   }
}

