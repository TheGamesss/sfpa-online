package
{
   import flash.display.*;
   import flash.geom.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3041")]
   public class slidePole extends staticInteractObjects
   {
      
      public function slidePole(p:Object)
      {
         var i:String = null;
         for(i in p)
         {
            if(i != "componentInspectorSetting")
            {
               this[i] = p[i];
            }
         }
         isWide = 20;
         isTall = scaleY * 100;
         predictOffsetY = 200;
         super("slidePole",p.x,p.y,p.scaleX,p.scaleY,p.onRail,"nothing",-1);
         var bitmapData:BitmapData = new BitmapData(scaleX * 6,scaleY * 200,true,0);
         bitmapData.draw(this,new Matrix(scaleX,0,0,scaleY,scaleX * 3,scaleY * 100));
         StarlingBackgrounds.addBitmapRender(bitmapData,onRail,x - scaleX * 3,y - scaleY * 100,1);
         cameraCollideArray.push(this);
         visible = false;
      }
      
      override public function hitChar(ex:Number, ey:Number, eRL:Number, eUD:Number, char:Char) : Boolean
      {
         if(Math.abs(x - ex) < char.isWide + 12 && Math.abs(y - ey) < isTall + char.isTall)
         {
            if((x - ex) * eRL > 0)
            {
               char.rotter = 0;
               if(char.Status != "SlidePole" && char.gotoBuffer != "SlidePole" && char.Status != "Hurt")
               {
                  char.onSlidePole = this;
                  char.gotoBuffer = "SlidePole";
               }
               char.canStatus = "slidePole";
            }
            else if(char.Status == "SlidePole" || char.gotoBuffer == "SlidePole")
            {
               char.canStatus = "slidePole";
            }
         }
      }
   }
}

