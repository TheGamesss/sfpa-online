package com.miniclip.gamemanager.player
{
   import com.miniclip.gamemanager.utils.gm_internal;
   
   use namespace gm_internal;
   
   public class LoginScreens
   {
      
      public static const login:LoginScreens = new LoginScreens(0,"login");
      
      public static const signup:LoginScreens = new LoginScreens(1,"signup");
      
      gm_internal static const player:LoginScreens = new LoginScreens(2,"player");
      
      gm_internal static const game:LoginScreens = new LoginScreens(3,"game");
      
      gm_internal static const external:LoginScreens = new LoginScreens(4,"external");
      
      gm_internal static const signupad:LoginScreens = new LoginScreens(5,"signupad");
      
      private var _value:uint;
      
      private var _name:String;
      
      public function LoginScreens(value:uint, name:String)
      {
         super();
         this._value = value;
         this._name = name;
      }
      
      public function toString() : String
      {
         return this._name;
      }
      
      public function valueOf() : uint
      {
         return this._value;
      }
   }
}

