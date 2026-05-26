package com.miniclip.events
{
   import flash.events.Event;
   
   public class AlertboxEvent extends Event
   {
      
      public static const CLOSE:String = "alertbox_close";
      
      public static const YES:String = "alertbox_yes";
      
      public static const NO:String = "alertbox_no";
      
      private var _data:*;
      
      public function AlertboxEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this._data = data;
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      override public function clone() : Event
      {
         return new AlertboxEvent(type,this.data,bubbles,cancelable);
      }
   }
}

