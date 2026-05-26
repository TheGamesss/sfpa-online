package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol131")]
   public class KongIntro extends MovieClip
   {
      
      public var KongButton:SimpleButton;
      
      public function KongIntro(ex:*, ey:*)
      {
         super();
         this.KongButton.addEventListener(MouseEvent.MOUSE_DOWN,this.goToKong,false,0,true);
         x = ex;
         y = ey;
         stop();
      }
      
      private function goToKong(e:MouseEvent) : *
      {
         Main.launchURL("http://www.kongregate.com?haref=fpa_remix&src=spon&cm=fpa_remix");
      }
   }
}

