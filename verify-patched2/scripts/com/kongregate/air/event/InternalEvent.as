package com.kongregate.air.event
{
   import flash.events.Event;
   
   public class InternalEvent extends Event
   {
      
      public static const INTERNAL_EVENT:String = "KONGREGATE_INTERNAL_EVENT";
      
      public static const ACTIVE_USER_INITIALIZED:String = "active_user_init";
      
      public static const ANALYTICS_INITIALIZED:String = "analytics_init";
      
      public static const USER_INFO:String = "active_user_info";
      
      private var mName:String;
      
      private var mBundle:Object;
      
      public function InternalEvent(name:String, bundle:Object)
      {
         super(InternalEvent.INTERNAL_EVENT);
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

