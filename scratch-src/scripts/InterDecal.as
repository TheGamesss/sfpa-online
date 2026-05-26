package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3740")]
   public class InterDecal extends MovieClip
   {
      
      public static var theThing:Object;
      
      public var button:SimpleButton;
      
      public var startorcontinue:MovieClip;
      
      public function InterDecal(p:*)
      {
         super();
         x = p.x;
         y = p.y;
         Backgrounds.backgroundsArray[0].addChild(this);
         gotoAndStop(p.reallyIs);
         theThing = this;
         switch(p.reallyIs)
         {
            case "startContinue":
               if(Main.localSettings.W1RContProg == 0)
               {
                  this.startorcontinue.gotoAndStop(1);
               }
               else
               {
                  this.startorcontinue.gotoAndStop(2);
               }
               break;
            case "soundtrackbutton":
               name = "soundtrack";
               visible = false;
         }
      }
   }
}

