package com.kongregate.air.event
{
   import com.kongregate.air.KongregateAPI;
   import flash.events.Event;
   
   public class APIEvent extends Event
   {
      
      private var mName:String;
      
      private var mBundle:Object;
      
      public function APIEvent(name:String, bundle:Object)
      {
         super(KongregateAPI.API_EVENT);
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

