package com.miniclip.events
{
   import com.miniclip.serialization.json.MC_JSON;
   import flash.events.Event;
   
   public class StorageEvent extends Event
   {
      
      public static const LOADED:String = "loaded";
      
      public static const SAVED:String = "saved";
      
      public static const STORAGE_ERROR:String = "storage_error";
      
      public static const DELETED:String = "deleted";
      
      public static const SET:String = "set";
      
      public static const GET:String = "get";
      
      public static const GHOSTDATA_DELETED:String = "ghostdata_deleted";
      
      public static const GHOSTDATA_SET:String = "ghostdata_set";
      
      public static const GHOSTDATA_GET:String = "ghostdata_get";
      
      public static const GHOSTDATA_LIST:String = "ghostdata_list";
      
      private var _data:String;
      
      private var _success:Boolean;
      
      public function StorageEvent(type:String, success:Boolean = false, srcData:Object = null)
      {
         super(type,bubbles,cancelable);
         this._success = success;
         this._data = String(srcData);
         if(this._success)
         {
            try
            {
               if(srcData is String)
               {
                  this._data = String(srcData);
               }
               else
               {
                  this._data = MC_JSON.stringify(srcData);
               }
            }
            catch(er:Error)
            {
            }
         }
      }
      
      override public function clone() : Event
      {
         var data:Object = null;
         try
         {
            data = MC_JSON.parse(this._data);
         }
         catch(er:Error)
         {
         }
         return new StorageEvent(type,this._success,data);
      }
      
      public function get success() : Boolean
      {
         return this._success;
      }
      
      public function get data() : String
      {
         return this._data;
      }
   }
}

