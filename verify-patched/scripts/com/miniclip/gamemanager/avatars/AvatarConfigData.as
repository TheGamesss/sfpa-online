package com.miniclip.gamemanager.avatars
{
   public class AvatarConfigData
   {
      
      private var _url:String;
      
      private var _userID:uint;
      
      private var _showGlowEffect:Boolean;
      
      private var _showLoader:Boolean;
      
      private var _cacheURL:Boolean;
      
      private var _debugMarker:Boolean;
      
      private var _variables:Object;
      
      private var _avatarData:Object = null;
      
      public function AvatarConfigData(url:String, userID:int, showGlowEffect:Boolean = true, showLoader:Boolean = false, cacheURL:Boolean = false, debugMarker:Boolean = false, avatarData:Object = null)
      {
         super();
         this._url = url;
         this._userID = userID;
         this._showGlowEffect = showGlowEffect;
         this._showLoader = showLoader;
         this._cacheURL = cacheURL;
         this._debugMarker = debugMarker;
         this._avatarData = avatarData;
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function get userID() : int
      {
         return this._userID;
      }
      
      public function get showGlowEffect() : Boolean
      {
         return this._showGlowEffect;
      }
      
      public function get showLoader() : Boolean
      {
         return this._showLoader;
      }
      
      public function get cacheURL() : Boolean
      {
         return this._cacheURL;
      }
      
      public function get debugMarker() : Boolean
      {
         return this._debugMarker;
      }
      
      public function get avatarData() : Object
      {
         return this._avatarData;
      }
   }
}

