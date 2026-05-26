package com.kongregate.air.event
{
   import com.kongregate.air.KongregateAPI;
   import flash.events.Event;
   
   public class SwrveEvent extends Event
   {
      
      private var mAction:String;
      
      public function SwrveEvent(action:String)
      {
         super(KongregateAPI.SWRVE_BUTTON_EVENT);
         this.mAction = action;
      }
      
      public function get action() : String
      {
         return this.mAction;
      }
   }
}

