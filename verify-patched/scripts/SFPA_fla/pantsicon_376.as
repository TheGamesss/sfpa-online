package SFPA_fla
{
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1426")]
   public dynamic class pantsicon_376 extends MovieClip
   {
      
      public var smoke:TextField;
      
      public function pantsicon_376()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         updateCounter = function(lives:*):*
         {
            smoke.text = lives;
            spring = 10;
            onEnterFrame = function():*
            {
               _yscale += spring;
               _xscale = this._yscale;
               spring += (100 - _yscale) / 3;
               spring *= 0.5;
            };
         };
      }
   }
}

