package com.miniclip.mock
{
   import com.miniclip.gamemanager.GameStorage;
   import com.miniclip.loggers.LogsHandler;
   import flash.events.EventDispatcher;
   
   public class MiniclipStorage extends EventDispatcher implements GameStorage
   {
      
      private var _data:Object;
      
      private var _notifications:Boolean;
      
      public function MiniclipStorage()
      {
         super();
         this._data = {};
         this._notifications = false;
      }
      
      public function get notifications() : Boolean
      {
         return this._notifications;
      }
      
      public function set notifications(value:Boolean) : void
      {
         this._notifications = value;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function get limit() : uint
      {
         return 1024;
      }
      
      public function load() : void
      {
         LogsHandler.info("storage.load()");
      }
      
      public function save() : void
      {
         LogsHandler.info("storage.save()");
      }
      
      public function set(json:String) : void
      {
         LogsHandler.info("storage.set()");
      }
      
      public function get(json:String) : void
      {
         LogsHandler.info("storage.get()");
      }
      
      public function deleteData(jsonArray:String) : void
      {
         LogsHandler.info("storage.deleteData()");
      }
      
      public function listGhostData(level:int, limit:int, random:int, lek:int = -1, min_score:Number = -1, top_score:Number = -1) : void
      {
         LogsHandler.info("storage.listGhostData()");
      }
      
      public function listGhostDataByUserID(level:int, uids:Array) : void
      {
         LogsHandler.info("storage.listGhostData()");
      }
      
      public function deleteGhostData(uid:uint, level:int) : void
      {
         LogsHandler.info("storage.deleteGhostData()");
      }
      
      public function setGhostData(uid:uint, level:int, json_data:String, score:String = null) : void
      {
         LogsHandler.info("storage.setGhostData()");
      }
      
      public function getGhostData(uid:uint, level:int) : void
      {
         LogsHandler.info("storage.getGhostData()");
      }
   }
}

import com.miniclip.events.StorageErrorEvent;

StorageErrorEvent;

