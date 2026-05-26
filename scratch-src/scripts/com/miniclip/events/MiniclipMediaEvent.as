package com.miniclip.events
{
   import flash.events.Event;
   
   public class MiniclipMediaEvent extends Event
   {
      
      public static const PLAYER_READY:String = "mcplayerready";
      
      public static const PLAYER_ERROR:String = "mcplayererror";
      
      public static const PLAYBACK_START:String = "mcplaybackstart";
      
      public static const PLAYBACK_END:String = "mcplaybackend";
      
      public static const PLAYER_DESTROYED:String = "mcplayerdestroyed";
      
      public static const CONFIG_RECEIVED:String = "configreceived";
      
      public static const PLAYER_CONFIG_RECEIVED:String = "playerconfigreceived";
      
      public static const METADATA_RECEIVED:String = "metadatareceived";
      
      public static const SOUND_STATUS_CHANGED:String = "soundchanged";
      
      private static var allowedEventIDs:Array = [PLAYER_READY,PLAYER_ERROR,PLAYBACK_START,PLAYBACK_END,PLAYER_DESTROYED,CONFIG_RECEIVED,PLAYER_CONFIG_RECEIVED,SOUND_STATUS_CHANGED,METADATA_RECEIVED];
      
      private var _data:*;
      
      public function MiniclipMediaEvent(type:String, data:Object = null)
      {
         this._data = data;
         super(type,false,false);
      }
      
      public static function isTypeAllowed(type:String) : Boolean
      {
         var a:String = null;
         for each(a in allowedEventIDs)
         {
            if(type == a)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      override public function clone() : Event
      {
         return new MiniclipMediaEvent(super.type,this.data);
      }
   }
}

