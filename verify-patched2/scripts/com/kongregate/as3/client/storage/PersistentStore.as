package com.kongregate.as3.client.storage
{
   import com.kongregate.as3.common.util.Log;
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   
   public class PersistentStore
   {
      
      private var mName:String;
      
      private var mSharedObject:SharedObject;
      
      private var mFailed:Boolean = false;
      
      public function PersistentStore(name:String, localPath:String)
      {
         super();
         this.mName = name;
         this.mSharedObject = SharedObject.getLocal(name,localPath,false);
      }
      
      public function putObject(name:String, value:Object) : void
      {
         this.mSharedObject.data[name] = value;
      }
      
      public function get(name:String, def:Object = undefined) : *
      {
         var value:* = this.mSharedObject.data[name];
         if(Boolean(value) || !def)
         {
            return value;
         }
         this.mSharedObject.data[name] = def;
         return def;
      }
      
      public function flush() : Boolean
      {
         var state:String = null;
         try
         {
            state = this.mSharedObject.flush(65536);
            if(state == SharedObjectFlushStatus.FLUSHED)
            {
               return true;
            }
         }
         catch(e:Error)
         {
            Log.error("Error while flushing shared object: " + e);
         }
         this.mFailed = true;
         return false;
      }
      
      public function hasFailed() : Boolean
      {
         return this.mFailed;
      }
      
      public function destroy() : void
      {
         this.mSharedObject.clear();
         this.flush();
      }
   }
}

