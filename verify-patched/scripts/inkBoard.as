package
{
   import flash.display.*;
   import flash.geom.*;
   import starling.display.Image;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4045")]
   public class inkBoard extends staticInteractObjects
   {
      
      public var inkBitmapData:BitmapData;
      
      public var inkBitmap:Image;
      
      public function inkBoard(p:*)
      {
         super("inkBoard",p.x,p.y,p.scaleX,p.scaleY,p.onRail);
         this.inkBitmapData = new BitmapData(scaleX * 100,scaleY * 100,true,0);
         this.inkBitmapData.draw(this,new Matrix(scaleX,0,0,scaleY,isWide,isTall));
         isWide = scaleX * 50;
         isTall = scaleY * 50;
         visible = false;
         this.inkBitmap = StarlingBackgrounds.addBitmapRender(this.inkBitmapData,onRail,x - scaleX * 50,y - scaleY * 50,1);
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(!(char.Status == "Hurt" || char.Status == "Disabled"))
         {
            if(Math.abs(ex - x) < isWide && Math.abs(ey - y) < isTall)
            {
               if(char.JumpIsDown() && char.FloatUp == 0 && Char.hasPen)
               {
                  if(char.Status != "InkBoard" && char.gotoBuffer != "InkBoard")
                  {
                     char.onInkBoard = this;
                     char.gotoBuffer = "InkBoard";
                  }
               }
               char.canStatus = "inkBoard";
            }
         }
      }
      
      override public function cleanUp() : void
      {
         this.inkBitmap.texture.dispose();
         this.inkBitmap.dispose();
         this.inkBitmap.removeFromParent(true);
         this.inkBitmap = null;
      }
   }
}

