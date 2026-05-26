package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol4966")]
   public class cutieBob extends staticInteractObjects
   {
      
      private var loopRand:uint = 60;
      
      private var rand:uint = 0;
      
      private var disabled:Boolean;
      
      private var tempN:uint;
      
      public function cutieBob(p:*)
      {
         isWide = 150;
         super("cutieBob",p.x,p.y,1,1,p.onRail);
         this.disabled = Main.world4Progress.cutieLeftWindow;
         if(this.disabled)
         {
            if(Main.AllEverything.walls0.doorWall != null)
            {
               Main.AllEverything.walls0.removeChild(Main.AllEverything.walls0.doorWall);
               Main.AllEverything.walls0.doorWall = null;
            }
         }
         else
         {
            this.tempN = StarlingTemporary.Spawn("cutieBob",x,y,rotation * (Math.PI / 180),scaleX,onRail,true,60);
            InteractEnterFrameArray.push(this);
            StarlingBackgrounds.addScrollObject(new houseFrontDoor(),0);
            Main.stageRoot.houseFrontDoor = StarlingBackgrounds.backgroundObjectsArray[StarlingBackgrounds.backgroundObjectsArray.length - 1];
         }
         if(!Main.world4Progress.cutieIsGone)
         {
            new WarpBox({
               "x":91.6,
               "y":-349.65,
               "scaleX":1.673065,
               "scaleY":2.177261,
               "ItIs":"TriggerBox",
               "onRail":0,
               "warpLevel":"cueCutieRun"
            });
         }
         StarlingBackgrounds.addScrollObject(new houseUber(),0);
         StarlingBackgrounds.addScrollObject(new caveUber(),0);
         StarlingBackgrounds.addScrollObject(new houseFront(),0);
         Main.stageRoot.houseFront = StarlingBackgrounds.backgroundObjectsArray[StarlingBackgrounds.backgroundObjectsArray.length - 1];
         Main.stageRoot.houseFront.alpha = 0;
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(!this.disabled)
         {
            if(ex < x + 50)
            {
               staticInteractObjects.textBubbleArray[0].popupText(char.UpIsDown());
            }
         }
      }
      
      override public function cleanUp() : void
      {
      }
   }
}

