package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol5194")]
   public class assistant extends staticInteractObjects
   {
      
      public static var truck:iceCreamTruck;
      
      public static var cart:iceCreamCart;
      
      private var b:uint = 0;
      
      public function assistant(p:*)
      {
         isWide = 300;
         isTall = 50;
         super("assistant",p.x,p.y,1,1,p.onRail,"nothing",-1);
         InteractEnterFrameArray.push(this);
         Backgrounds.backgroundsArray[onRail].addChild(this);
         if(Main.world4Progress.talkToAssist)
         {
            gotoAndStop("c");
         }
         else
         {
            gotoAndStop(1);
            truck = new iceCreamTruck();
            truck.x = 1490.15;
            truck.y = 1121.9;
            Backgrounds.backgroundsArray[0].addChild(truck);
            new WarpBox({
               "x":1217.55,
               "y":1164.3,
               "scaleX":2.631287,
               "scaleY":1.748291,
               "ItIs":"TriggerBox",
               "onRail":0,
               "warpLevel":"triggerText",
               "propX":0,
               "removeID":0
            });
            new WarpBox({
               "x":1225.4,
               "y":1086.2,
               "scaleX":5.307312,
               "scaleY":3.516235,
               "ItIs":"TriggerBox",
               "onRail":0,
               "warpLevel":"lockShift",
               "propX":0,
               "propY":0,
               "propZ":0,
               "removeID":0
            });
            new aWall({
               "x":1431.15,
               "y":1121.95,
               "scaleX":1.447998,
               "scaleY":2.64,
               "rail":0,
               "status":"Rock",
               "removeID":0,
               "hide":true
            });
         }
         if(Main.world4Progress.iceCreamShop)
         {
            new WarpBox({
               "x":-1520,
               "y":0,
               "scaleX":2,
               "scaleY":0.8,
               "ItIs":"TriggerBox",
               "onRail":0,
               "warpLevel":"triggerText",
               "propX":3
            });
            new iceCreamCart({
               "x":-1700,
               "y":32,
               "message":true,
               "scaleX":1,
               "rotation":0
            });
         }
      }
      
      override public function InteractEnterFrame() : Boolean
      {
         if(this.b > 0)
         {
            --this.b;
         }
         else
         {
            nextFrame();
            if(currentFrameLabel == "a")
            {
               this.b = 20 + Math.random() * 60;
            }
            if(currentFrameLabel == "b")
            {
               this.b = 10 + Math.random() * 20;
               gotoAndStop(1);
            }
         }
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(Main.world4Progress.talkToIceCream)
         {
            staticInteractObjects.textBubbleArray[2].popupText(char.UpIsDown());
            if(!Main.world4Progress.talkToAssist)
            {
               Main.saveProgress("talkToAssist",true);
               Main.saveProgress("iceCreamShop",true);
               staticInteractObjects.clearByID(0);
               aWall.clearByID(0);
               Backgrounds.backgroundsArray[0].removeChild(truck);
               truck = null;
               gotoAndStop("c");
               new iceCreamCart({
                  "x":-1700,
                  "y":32,
                  "scaleX":1,
                  "rotation":0
               });
               new WarpBox({
                  "x":-1520,
                  "y":0,
                  "scaleX":2,
                  "scaleY":0.8,
                  "ItIs":"TriggerBox",
                  "onRail":0,
                  "warpLevel":"triggerText",
                  "propX":3
               });
               staticInteractObjects.findByUnique(0).changeProperties("nothing",5,30);
            }
         }
         else
         {
            staticInteractObjects.textBubbleArray[1].popupText(char.UpIsDown());
         }
      }
   }
}

