package com.kongregate.as3.common.comm
{
   import com.adobe.serialization.json.JSON;
   import com.kongregate.as3.common.error.ErrorCode;
   import com.kongregate.as3.common.util.Base64;
   
   public class Message
   {
      
      public static const NORMAL_TYPE:String = "normal";
      
      public static const CHAT_TYPE:String = "chat";
      
      public static const GROUPCHAT_TYPE:String = "groupchat";
      
      public static const HEADLINE_TYPE:String = "headline";
      
      public static const ERROR_TYPE:String = "error";
      
      private var mOpcode:String;
      
      private var mParams:Object;
      
      public function Message()
      {
         super();
         this.mOpcode = "";
         this.mParams = new Object();
      }
      
      public static function fromBase64(base64:String) : Message
      {
         return fromString(Base64.decode(base64));
      }
      
      public static function fromObject(obj:Object) : Message
      {
         var msg:Message = Message.fromOpcode(obj.mOpcode);
         msg.setParams(obj.mParams);
         return msg;
      }
      
      public static function fromOpcode(opcode:String) : Message
      {
         var msg:Message = new Message();
         msg.setOpcode(opcode);
         return msg;
      }
      
      public static function fromString(text:String) : Message
      {
         var jsonObject:Object = null;
         var msg:Message = null;
         var key:String = null;
         try
         {
            jsonObject = com.adobe.serialization.json.JSON.decode(text);
            msg = Message.fromOpcode(jsonObject.mOpcode);
            for(key in jsonObject.mParams)
            {
               msg.addParam(key,jsonObject.mParams[key]);
            }
            return msg;
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      public function setOpcode(opcode:String) : void
      {
         this.mOpcode = opcode;
      }
      
      public function getOpcode() : String
      {
         return this.mOpcode;
      }
      
      public function addParam(key:String, value:*) : void
      {
         this.mParams[key] = value;
      }
      
      public function getParam(key:String) : *
      {
         return this.mParams[key];
      }
      
      public function getParams() : Object
      {
         return this.mParams;
      }
      
      public function setParams(params:Object) : void
      {
         this.mParams = params;
      }
      
      public function getRequestID() : Number
      {
         return this.getParam(Opcode.PARAM_REQUEST_ID);
      }
      
      public function getMessageID() : Number
      {
         return this.getParam(Opcode.PARAM_MESSAGE_ID);
      }
      
      public function isSuccessful() : Boolean
      {
         return this.getParam(Opcode.PARAM_SUCCESS);
      }
      
      public function getError() : int
      {
         var error:int = this.getParam(Opcode.PARAM_ERROR);
         return error ? ErrorCode.NONE : error;
      }
      
      public function toString() : String
      {
         return this.getOpcode() + ": " + com.adobe.serialization.json.JSON.encode(this.getParams());
      }
      
      public function toBase64() : String
      {
         return Base64.encode(com.adobe.serialization.json.JSON.encode({
            "mOpcode":this.mOpcode,
            "mParams":this.mParams
         }));
      }
      
      public function toJSON() : String
      {
         return com.adobe.serialization.json.JSON.encode({
            "opcode":this.getOpcode(),
            "params":this.getParams()
         });
      }
   }
}

