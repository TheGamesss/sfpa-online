package com.miniclip.gamemanager.ui
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SharedGUI extends Sprite
   {
      
      public static const MINICLIP_LOGO:String = "minclip_logo";
      
      public static const PLAY_MORE_GAMES_BT:String = "play_more_games";
      
      protected static var statesMap:Object = {};
      
      private var id:String;
      
      private var hit:Sprite;
      
      private var _width:Number = 0;
      
      private var _height:Number = 0;
      
      private var statesUIs:Object;
      
      private var actionNotificator:Object;
      
      public function SharedGUI(key:Key, master:SharedGUI)
      {
         super();
         if(!SharedGUI || !master)
         {
            throw new Error("Instantiation not allowed");
         }
      }
      
      protected static function getKey() : Key
      {
         return new Key();
      }
      
      public function factory(assetID:String) : void
      {
         var states:Object = null;
         var state_id:String = null;
         var stateUIClass:Class = null;
         var stateUI:DisplayObject = null;
         var a:Number = 0;
         this.id = assetID;
         this.statesUIs = {};
         states = SharedGUI.statesMap[this.id];
         this.hit = new Sprite();
         for(state_id in states)
         {
            stateUIClass = states[state_id]["stateUIClass"] as Class;
            if(!stateUIClass)
            {
               continue;
            }
            switch(state_id)
            {
               case MouseEvent.MOUSE_OUT:
               case MouseEvent.MOUSE_OVER:
               case MouseEvent.MOUSE_DOWN:
               case MouseEvent.ROLL_OVER:
               case MouseEvent.ROLL_OUT:
                  stateUI = new stateUIClass() as DisplayObject;
                  if(!stateUI)
                  {
                     trace("incopatible stateUI type");
                  }
                  else
                  {
                     this._width = stateUI.width > this._width ? stateUI.width : this._width;
                     this._height = stateUI.height > this.height ? stateUI.height : this._height;
                     this.statesUIs[state_id] = this.addChild(stateUI);
                     trace("data??");
                     trace(states[state_id]["data"]);
                     this.hit.addEventListener(state_id,function(e:MouseEvent):void
                     {
                        var carriedData:Object = states[state_id]["data"];
                        onStateAction(e.type,carriedData);
                     },false,0,true);
                  }
                  break;
               default:
                  trace("unsuported state_id: " + state_id);
            }
         }
         this.hit.graphics.beginFill(0,0);
         this.hit.graphics.drawRect(0,0,this._width,this._height);
         this.hit.mouseEnabled = true;
         this.hit.buttonMode = true;
         addChild(this.hit);
         if(this.hit.stage)
         {
            this._onAdded(null);
         }
         this.hit.addEventListener(Event.ADDED_TO_STAGE,this._onAdded);
      }
      
      private function onStateAction(type:String, data:Object) : void
      {
         var notify:Function = data["notify"] as Function;
         this.showState(type);
         if(notify != null)
         {
            try
            {
               notify.apply(null,[type,this.id]);
            }
            catch(er:Error)
            {
               trace(er);
            }
         }
      }
      
      private function _onAdded(e:Event) : void
      {
         if(this.hit.hitTestPoint(this.hit.mouseX,this.hit.mouseY,true))
         {
            this.onStateAction(MouseEvent.MOUSE_OVER,{});
         }
         else
         {
            this.onStateAction(MouseEvent.MOUSE_OUT,{});
         }
      }
      
      private function showState(stateID:String) : void
      {
         var id:String = null;
         DisplayObject(this.statesUIs[stateID]).visible = true;
         for(id in this.statesUIs)
         {
            if(id != stateID)
            {
               DisplayObject(this.statesUIs[id]).visible = false;
            }
         }
      }
      
      private function get alowed() : Boolean
      {
         return true;
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      override public function set scaleX(val:Number) : void
      {
         trace("not allowed");
      }
      
      override public function set scaleY(val:Number) : void
      {
         trace("not allowed");
      }
      
      override public function set width(val:Number) : void
      {
         trace("not allowed");
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         trace("not allowed");
      }
   }
}

class Key
{
   
   public function Key()
   {
      super();
   }
}
