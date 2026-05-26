package com.kongregate.air.event
{
   import com.kongregate.air.KongregateAPI;
   import flash.events.Event;
   
   public class AnalyticsEvent extends Event
   {
      
      private var mName:String;
      
      private var mBundle:Object;
      
      public function AnalyticsEvent(name:String, bundle:Object)
      {
         super(KongregateAPI.ANALYTICS_AUTO_EVENT);
         this.mName = name;
         this.mBundle = bundle ? bundle : {};
      }
      
      public function get name() : String
      {
         return this.mName;
      }
      
      public function get bundle() : Object
      {
         return this.mBundle;
      }
   }
}

