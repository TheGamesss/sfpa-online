package com.miniclip.gamemanager
{
   public class AwardData
   {
      
      private var _id:uint;
      
      private var _title:String;
      
      private var _description:String;
      
      public function AwardData(data:Object)
      {
         super();
         this._id = uint(data.id);
         this._title = String(data.title);
         this._description = String(data.description);
      }
      
      public function toString(useDescription:Boolean = false) : String
      {
         var str:String = "[AwardData (" + this._id + ") " + this._title + "]";
         if(useDescription)
         {
            str += "\rdescription:\r\"" + this._description + "\"";
         }
         return str;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get description() : String
      {
         return this._description;
      }
   }
}

