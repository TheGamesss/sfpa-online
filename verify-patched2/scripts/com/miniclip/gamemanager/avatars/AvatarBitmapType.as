package com.miniclip.gamemanager.avatars
{
   public class AvatarBitmapType
   {
      
      public static const cropped:AvatarBitmapType = new AvatarBitmapType(2,"cropped");
      
      public static const fullbody:AvatarBitmapType = new AvatarBitmapType(1,"fullbody");
      
      private var _value:uint;
      
      private var _name:String;
      
      public function AvatarBitmapType(value:uint, name:String)
      {
         super();
         this._value = value;
         this._name = name;
      }
      
      public function toString() : String
      {
         return "AvatarBitmapType." + this._name;
      }
      
      public function valueOf() : uint
      {
         return this._value;
      }
      
      public function get value() : uint
      {
         return this._value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}

