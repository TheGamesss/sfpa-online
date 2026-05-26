package com.miniclip.utils
{
   public class uri
   {
      
      private var _source:String = "";
      
      private var _scheme:String = "";
      
      private var _host:String = "";
      
      private var _username:String = "";
      
      private var _password:String = "";
      
      private var _port:int = -1;
      
      private var _path:String = "";
      
      private var _query:String = "";
      
      private var _fragment:String = "";
      
      private var _r:RegExp = /\\/g;
      
      public function uri(raw:String)
      {
         super();
         this._source = raw;
         this._parse(raw);
      }
      
      private function _parseUnixAbsoluteFilePath(str:String) : void
      {
         this.scheme = "file";
         this._port = -1;
         this._fragment = "";
         this._query = "";
         this._host = "";
         this._path = "";
         if(str.substr(0,2) == "//")
         {
            while(str.charAt(0) == "/")
            {
               str = str.substr(1);
            }
            this._path = "/" + str;
         }
         if(!this._path)
         {
            this._path = str;
         }
      }
      
      private function _parseWindowsAbsoluteFilePath(str:String) : void
      {
         if(str.length > 2 && str.charAt(2) != "\\" && str.charAt(2) != "/")
         {
            return;
         }
         this.scheme = "file";
         this._port = -1;
         this._fragment = "";
         this._query = "";
         this._host = "";
         this._path = "/" + str.replace(this._r,"/");
      }
      
      private function _parseWindowsUNC(str:String) : void
      {
         this.scheme = "file";
         this._port = -1;
         this._fragment = "";
         this._query = "";
         while(str.charAt(0) == "\\")
         {
            str = str.substr(1);
         }
         var pos:int = str.indexOf("\\");
         if(pos > 0)
         {
            this._path = str.substring(pos);
            this._host = str.substring(0,pos);
         }
         else
         {
            this._host = str;
            this._path = "";
         }
         this._path = this._path.replace(this._r,"/");
      }
      
      private function _parse(str:String) : void
      {
         var authority:String = null;
         var host:String = null;
         var userinfos:String = null;
         var port:String = null;
         var i:int = 0;
         var c:String = null;
         var validPort:Boolean = false;
         var pos:int = str.indexOf(":");
         if(pos < 0)
         {
            if(str.charAt(0) == "/")
            {
               this._parseUnixAbsoluteFilePath(str);
            }
            else if(str.substr(0,2) == "\\\\")
            {
               this._parseWindowsUNC(str);
            }
            return;
         }
         if(pos == 1)
         {
            this._parseWindowsAbsoluteFilePath(str);
            return;
         }
         var p:RegExp = new RegExp("^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)([?]([^#]*))?(#(.*))?",null);
         var r:Object = p.exec(str);
         if(Boolean(r[1]) && Boolean(r[2]))
         {
            this.scheme = r[2];
         }
         if(r[3])
         {
            authority = r[4];
            host = "";
            if(authority.indexOf("@") > -1)
            {
               userinfos = authority.split("@")[0];
               host = authority.split("@")[1];
               if(userinfos.indexOf(":") != -1)
               {
                  this._username = userinfos.split(":")[0];
                  this._password = userinfos.split(":")[1];
               }
               else
               {
                  this._username = userinfos;
               }
            }
            else
            {
               host = authority;
            }
            if(host.indexOf(":") > -1)
            {
               port = host.split(":")[1];
               validPort = true;
               for(i = 0; i < port.length; i++)
               {
                  c = port.charAt(i);
                  if(!("0" <= c && c <= "9"))
                  {
                     validPort = false;
                  }
               }
               if(validPort)
               {
                  host = host.split(":")[0];
                  if(Boolean(port) && port.length > 0)
                  {
                     this.port = parseInt(port);
                  }
               }
            }
            this.host = host;
         }
         if(r[5])
         {
            this.path = r[5];
         }
         if(r[6])
         {
            this._query = r[7];
         }
         if(r[8])
         {
            this._fragment = r[9];
         }
      }
      
      public function get authority() : String
      {
         var str:String = "";
         if(this.userinfo)
         {
            str += this.userinfo + "@";
         }
         str += this.host;
         if(this.host != "" && this.port > -1)
         {
            str += ":" + this.port;
         }
         return str;
      }
      
      public function get fragment() : String
      {
         return this._fragment;
      }
      
      public function set fragment(value:String) : void
      {
         this._fragment = value;
      }
      
      public function get host() : String
      {
         return this._host;
      }
      
      public function set host(value:String) : void
      {
         this._host = value;
      }
      
      public function get path() : String
      {
         return this._path;
      }
      
      public function set path(value:String) : void
      {
         this._path = value;
      }
      
      public function get port() : int
      {
         return this._port;
      }
      
      public function set port(value:int) : void
      {
         this._port = value;
      }
      
      public function get scheme() : String
      {
         return this._scheme;
      }
      
      public function set scheme(value:String) : void
      {
         this._scheme = value;
      }
      
      public function get source() : String
      {
         return this._source;
      }
      
      public function get userinfo() : String
      {
         if(!this._username)
         {
            return "";
         }
         var str:String = "";
         str += this._username;
         return str + (":" + this._password);
      }
      
      public function get query() : String
      {
         return this._query;
      }
      
      public function set query(value:String) : void
      {
         this._query = value;
      }
      
      public function toString() : String
      {
         var str:String = "";
         if(this.scheme)
         {
            str += this.scheme + ":";
         }
         if(this.authority)
         {
            str += "//" + this.authority;
         }
         if(this.authority == "" && this.scheme == "file")
         {
            str += "//";
         }
         str += this.path;
         if(this.query)
         {
            str += "?" + this.query;
         }
         if(this.fragment)
         {
            str += "#" + this.fragment;
         }
         return str;
      }
      
      public function valueOf() : String
      {
         return this.toString();
      }
   }
}

