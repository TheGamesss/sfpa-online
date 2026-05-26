package com.miniclip.mock
{
   import com.miniclip.gamemanager.GameAvatars;
   import com.miniclip.gamemanager.YoMe;
   import com.miniclip.gamemanager.YoMeBitmap;
   import com.miniclip.gamemanager.avatars.AvatarBitmapType;
   import com.miniclip.gamemanager.avatars.AvatarConfigData;
   import com.miniclip.loggers.LogsHandler;
   import flash.events.EventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class MiniclipAvatars extends EventDispatcher implements GameAvatars
   {
      
      private var _debugMarkers:Boolean;
      
      private var _allowDuplicates:Boolean;
      
      private var _list:Object;
      
      public function MiniclipAvatars()
      {
         super();
         this._debugMarkers = false;
         this._allowDuplicates = true;
         this._list = new Object();
      }
      
      public function get debugMarkers() : Boolean
      {
         return this._debugMarkers;
      }
      
      public function set debugMarkers(value:Boolean) : void
      {
         this._debugMarkers = value;
      }
      
      public function get allowDuplicates() : Boolean
      {
         return this._allowDuplicates;
      }
      
      public function set allowDuplicates(value:Boolean) : void
      {
         this._allowDuplicates = value;
      }
      
      public function load(id:int, showGlowEffect:Boolean = true, showLoader:Boolean = false, cacheURL:Boolean = false) : YoMe
      {
         var count:uint = 0;
         LogsHandler.info("MiniclipAvatars.load()");
         var refid:String = "";
         var url:String = "";
         var yoMeData:AvatarConfigData = new AvatarConfigData(url,id,showGlowEffect,showLoader,cacheURL,this._debugMarkers);
         var context:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         if(this.allowDuplicates)
         {
            refid = String(id) + "_";
            count = 1;
            while(this._list[refid + String(count)])
            {
               count++;
            }
            refid += String(count);
            return new YoMe(yoMeData);
         }
         refid = String(id);
         LogsHandler.debug("YoMe refid: " + refid);
         if(!this._list[refid])
         {
            this._list[refid] = new YoMe(yoMeData);
         }
         return this._list[refid];
      }
      
      public function loadBitmap(id:uint, width:Number = 200, height:Number = 200, type:AvatarBitmapType = null) : YoMeBitmap
      {
         var url:String = "";
         var yoMeData:AvatarConfigData = new AvatarConfigData(url,id);
         LogsHandler.info("MiniclipAvatars.loadBitmap()");
         return new YoMeBitmap(yoMeData,width,height,type);
      }
   }
}

