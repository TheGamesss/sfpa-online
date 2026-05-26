package com.miniclip.net.authentication
{
   public class UserDetails
   {
      
      protected var _id:uint;
      
      protected var _sessionid:String;
      
      protected var _email:String;
      
      protected var _nickname:String;
      
      protected var _location:String;
      
      protected var _avatar:Boolean;
      
      protected var _worldRank:Number;
      
      protected var _starRank:Number;
      
      protected var _challenges:Number;
      
      protected var _friends:Number;
      
      protected var _playerPageURL:String;
      
      protected var _playerAvatarURL:String;
      
      protected var _userLevel:Number;
      
      public function UserDetails(data:Object)
      {
         super();
         if(data != null)
         {
            this._id = uint(data.id);
            this._sessionid = String(data.sid);
            this._email = String(data.email);
            this._nickname = String(data.nickname);
            this._location = String(data.location);
            this._avatar = false;
            this._worldRank = Number(data.worldRank);
            this._starRank = Number(data.starRank);
            this._challenges = Number(data.challenges);
            this._friends = Number(data.friends);
            this._playerPageURL = String(data.playerPageURL);
            this._playerAvatarURL = String(data.playerAvatarURL);
            this._userLevel = Number(data.userLevel);
            if(data.avatar)
            {
               this._avatar = Boolean(data.avatar);
            }
            if(data.avatarCode)
            {
               this._avatar = data.avatarCode > 0;
            }
         }
      }
      
      public function serialize() : Object
      {
         var obj:Object = new Object();
         obj.id = this._id;
         obj.sessionid = this._sessionid;
         obj.email = this._email;
         obj.nickname = this._nickname;
         obj.location = this._location;
         obj.avatar = this._avatar;
         obj.worldRank = this._worldRank;
         obj.starRank = this._starRank;
         obj.challenges = this._challenges;
         obj.friends = this._friends;
         obj.playerPageURL = this._playerPageURL;
         obj.playerAvatarURL = this._playerAvatarURL;
         obj.userLevel = this._userLevel;
         return obj;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get sessionid() : String
      {
         return this._sessionid;
      }
      
      public function get email() : String
      {
         return this._email;
      }
      
      public function get nickname() : String
      {
         return this._nickname;
      }
      
      public function get location() : String
      {
         return this._location;
      }
      
      public function get avatar() : Boolean
      {
         return this._avatar;
      }
      
      public function set avatar(value:Boolean) : void
      {
         this._avatar = value;
      }
      
      public function get worldRank() : Number
      {
         return this._worldRank;
      }
      
      public function get starRank() : Number
      {
         return this._starRank;
      }
      
      public function get challenges() : Number
      {
         return this._challenges;
      }
      
      public function get friends() : Number
      {
         return this._friends;
      }
      
      public function get playerPageURL() : String
      {
         return this._playerPageURL;
      }
      
      public function get playerAvatarURL() : String
      {
         return this._playerAvatarURL;
      }
      
      public function get userLevel() : Number
      {
         return this._userLevel;
      }
      
      public function toString() : String
      {
         var s:String = "[UserDetails]";
         s += "\n\t id: " + this._id;
         s += "\n\t sessionid: " + this._sessionid;
         s += "\n\t email: " + this._email;
         s += "\n\t nickname: " + this._nickname;
         s += "\n\t location: " + this._location;
         s += "\n\t avatar: " + this._avatar;
         s += "\n\t worldRank: " + this._worldRank;
         s += "\n\t challenges: " + this._challenges;
         s += "\n\t playerPageURL: " + this.playerPageURL;
         return s + ("\n\t playerAvatarURL: " + this._playerAvatarURL);
      }
   }
}

