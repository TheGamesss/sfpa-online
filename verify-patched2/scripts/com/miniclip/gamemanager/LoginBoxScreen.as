package com.miniclip.gamemanager
{
   import com.miniclip.loggers.LogsHandler;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class LoginBoxScreen extends EventDispatcher
   {
      
      public function LoginBoxScreen(showBackground:Boolean = true, showCancelButton:Boolean = true, screen:* = null, position:Point = null, debug:Boolean = false, checkUserDetails:Boolean = false)
      {
         super();
      }
      
      public function show() : void
      {
         LogsHandler.warn("!!! Fake - LoginBoxScreen::show() - NOT IMPLEMENTED !!!");
      }
      
      public function close() : void
      {
         LogsHandler.warn("!!! Fake - LoginBoxScreen::close() - NOT IMPLEMENTED !!!");
      }
      
      public function get x() : Number
      {
         LogsHandler.warn("!!! Fake - LoginBoxScreen::get x() - NOT IMPLEMENTED !!!");
         return 0;
      }
      
      public function set x(value:Number) : void
      {
         LogsHandler.warn("!!! Fake -  LoginBoxScreen::set x() - NOT IMPLEMENTED !!!");
      }
      
      public function get y() : Number
      {
         LogsHandler.warn("!!! Fake - LoginBoxScreen::get y() - NOT IMPLEMENTED !!!");
         return 0;
      }
      
      public function set y(value:Number) : void
      {
         LogsHandler.warn("!!! Fake - LoginBoxScreen::set y() - NOT IMPLEMENTED !!!");
      }
      
      public function get width() : Number
      {
         return 328;
      }
      
      public function get height() : Number
      {
         return 204;
      }
      
      public function get visible() : Boolean
      {
         LogsHandler.warn("!!! Fake - LoginBoxScreen::get visible() - NOT IMPLEMENTED !!!");
         return false;
      }
      
      public function get ready() : Boolean
      {
         LogsHandler.warn("!!! Fake - LoginBoxScreen::get ready() - NOT IMPLEMENTED !!!");
         return true;
      }
   }
}

