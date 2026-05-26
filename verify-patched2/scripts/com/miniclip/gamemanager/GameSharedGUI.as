package com.miniclip.gamemanager
{
   import com.miniclip.gamemanager.ui.SharedGUI;
   import com.miniclip.loggers.LogsHandler;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class GameSharedGUI extends SharedGUI
   {
      
      public function GameSharedGUI(srcAppDomain:ApplicationDomain)
      {
         LogsHandler.log("SharedGuiManager");
         super(SharedGUI.getKey(),this);
         this.mapStates(srcAppDomain);
      }
      
      protected function mapStates(srcAppDomain:ApplicationDomain) : void
      {
         SharedGUI.statesMap[SharedGUI.MINICLIP_LOGO] = {};
         SharedGUI.statesMap[SharedGUI.MINICLIP_LOGO][MouseEvent.MOUSE_OUT] = {"stateUIClass":Sprite};
         SharedGUI.statesMap[SharedGUI.MINICLIP_LOGO][MouseEvent.MOUSE_DOWN] = {"stateUIClass":Sprite};
         SharedGUI.statesMap[SharedGUI.MINICLIP_LOGO][MouseEvent.MOUSE_OVER] = {"stateUIClass":Sprite};
         SharedGUI.statesMap[SharedGUI.PLAY_MORE_GAMES_BT] = {};
         SharedGUI.statesMap[SharedGUI.PLAY_MORE_GAMES_BT][MouseEvent.MOUSE_OUT] = {"stateUIClass":Sprite};
         SharedGUI.statesMap[SharedGUI.PLAY_MORE_GAMES_BT][MouseEvent.MOUSE_DOWN] = {"stateUIClass":Sprite};
         SharedGUI.statesMap[SharedGUI.PLAY_MORE_GAMES_BT][MouseEvent.MOUSE_OVER] = {"stateUIClass":Sprite};
      }
      
      public function getAsset(assetID:String) : SharedGUI
      {
         var asset:SharedGUI = null;
         assetID = SharedGUI.PLAY_MORE_GAMES_BT;
         if(SharedGUI.statesMap[assetID])
         {
            asset = new SharedGUI(SharedGUI.getKey(),this);
            asset.factory(assetID);
            return asset;
         }
         return null;
      }
   }
}

