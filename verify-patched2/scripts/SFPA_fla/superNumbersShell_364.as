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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1388")]
   public dynamic class superNumbersShell_364 extends MovieClip
   {
      
      public var smoke:TextField;
      
      public function superNumbersShell_364()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         updateCounter = function(squiggles:*):*
         {
            smoke.text = squiggles;
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

