package
{
   import flash.display.*;
   import flash.geom.*;
   
   public class PauseIconCache extends Sprite
   {
      
      public static var stamp:customizeIcon;
      
      private static var outline:buttonOutline;
      
      public static var grabDt:Boolean;
      
      private static var firstDt:uint;
      
      private static var offset:Matrix = new Matrix(1,0,0,1,40,40);
      
      public var anchorX:Number;
      
      public var anchorY:Number;
      
      public var ratio:Number;
      
      public var downtime:Number;
      
      public var type:String;
      
      public var ID:uint;
      
      public var selected:Boolean;
      
      public var unlocked:Boolean;
      
      private var bitmap:Bitmap;
      
      private var bitmapdata:BitmapData;
      
      public function PauseIconCache(ex:*, ey:*, n:*, ay:*, r:*, dt:*, t:*, id:*, sel:*, pantsN:int = -1, has:Boolean = false)
      {
         super();
         if(Main.localSettings.canColor)
         {
            ey -= 20;
         }
         if(Main.localSettings.canColor)
         {
            ay -= 20;
         }
         this.anchorX = 40 + (40 + n * 80) * r;
         this.anchorY = ay;
         x = ex;
         y = ey;
         this.type = t;
         this.ID = id;
         this.downtime = dt;
         this.selected = sel;
         name = "customize";
         this.unlocked = has;
         this.bitmapdata = new BitmapData(80,80,true,0);
         this.drawCurrentStamp(t,id,sel,pantsN,has);
         if(sel)
         {
            r *= 0.8;
         }
         scaleX = scaleY = this.ratio = r;
         this.bitmap = new Bitmap(this.bitmapdata);
         this.bitmap.x = -40;
         this.bitmap.y = -40;
         this.bitmap.smoothing = true;
         addChild(this.bitmap);
      }
      
      public static function createStamp() : *
      {
         if(stamp == null)
         {
            stamp = new customizeIcon();
            stamp.stop();
            stamp.pattern.stop();
            stamp.visible = false;
            outline = new buttonOutline();
            outline.stop();
            outline.visible = false;
         }
      }
      
      public static function clearColorPants() : *
      {
         stamp.pants.transform.colorTransform = new ColorTransform();
      }
      
      public function drawOutline(n:*) : *
      {
         outline.gotoAndStop(n);
         this.bitmapdata.drawWithQuality(outline,offset,null,null,null,true,StageQuality.HIGH);
      }
      
      public function drawCurrentStamp(t:*, id:*, sel:*, pantsN:int = -1, has:Boolean = false) : void
      {
         if(t == "pants")
         {
            if(has)
            {
               stamp.gotoAndStop(1);
               stamp.pattern.visible = false;
               stamp.pants.transform.colorTransform = Main.getColorTransform(id);
            }
            else
            {
               stamp.gotoAndStop(10);
            }
         }
         else if(t == "hat")
         {
            if(has)
            {
               stamp.gotoAndStop(id + 11);
            }
            else
            {
               stamp.gotoAndStop(10);
            }
         }
         else if(t == "pattern")
         {
            if(!has)
            {
               stamp.gotoAndStop(10);
            }
            else if(id == 0)
            {
               stamp.pattern.visible = false;
            }
            else
            {
               stamp.gotoAndStop(1);
               stamp.pattern.visible = true;
               stamp.pattern.gotoAndStop(id);
            }
         }
         else if(t == "color")
         {
            if(pantsN == id)
            {
               stamp.pattern.transform.colorTransform = new ColorTransform();
            }
            else
            {
               stamp.pattern.transform.colorTransform = Main.getColorTransform(id);
            }
         }
         this.bitmapdata.drawWithQuality(stamp,offset,null,null,null,true,StageQuality.HIGH);
         if(sel)
         {
            this.drawOutline(2);
         }
      }
      
      public function PauseIconReset(n:uint, ay:Number, r:Number, dt:uint, sel:Boolean, offset:Number = 0, has:Boolean = false) : *
      {
         if(Main.localSettings.canColor)
         {
            ay -= 20;
         }
         this.anchorX = 40 + (40 + n * 80) * r;
         if(this.anchorX + offset < -40 || this.anchorX + offset > 840)
         {
            x = this.anchorX + offset;
            this.downtime = 0;
         }
         else
         {
            if(grabDt)
            {
               firstDt = dt;
               grabDt = false;
            }
            if(this.type != "hat")
            {
               dt += 4;
            }
            x = 900;
            this.downtime = dt - firstDt;
         }
         this.anchorY = ay;
         if(sel)
         {
            this.drawOutline(2);
            r *= 0.8;
         }
         else if(this.selected)
         {
            this.drawOutline(1);
         }
         if(!this.unlocked && has)
         {
            this.bitmapdata.fillRect(this.bitmapdata.rect,0);
            this.drawCurrentStamp(this.type,this.ID,this.selected,-1,true);
            this.unlocked = true;
         }
         scaleX = scaleY = this.ratio = r;
         this.selected = sel;
      }
   }
}

