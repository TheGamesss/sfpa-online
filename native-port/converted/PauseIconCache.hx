import flash.display.*;
import flash.geom.*;

class PauseIconCache extends Sprite
{
    
    public static var stamp : CustomizeIcon;
    
    private static var outline : ButtonOutline;
    
    public static var grabDt : Bool;
    
    private static var firstDt : Int;
    
    private static var offset : Matrix = new Matrix(1, 0, 0, 1, 40, 40);
    
    public var anchorX : Float;
    
    public var anchorY : Float;
    
    public var ratio : Float;
    
    public var downtime : Float;
    
    public var type : String;
    
    public var ID : Int;
    
    public var selected : Bool;
    
    public var unlocked : Bool;
    
    private var bitmap : Bitmap;
    
    private var bitmapdata : BitmapData;
    
    public function new(ex : Dynamic, ey : Dynamic, n : Dynamic, ay : Dynamic, r : Dynamic, dt : Dynamic, t : Dynamic, id : Dynamic, sel : Dynamic, pantsN : Int = -1, has : Bool = false)
    {
        super();
        if (Main.localSettings.canColor)
        {
            ey -= 20;
        }
        if (Main.localSettings.canColor)
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
        this.bitmapdata = new BitmapData(80, 80, true, 0);
        this.drawCurrentStamp(t, id, sel, pantsN, has);
        if (sel != null)
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
    
    public static function createStamp() : Dynamic
    {
        if (stamp == null)
        {
            stamp = new CustomizeIcon();
            stamp.stop();
            stamp.pattern.stop();
            stamp.visible = false;
            outline = new ButtonOutline();
            outline.stop();
            outline.visible = false;
        }
    }
    
    public static function clearColorPants() : Dynamic
    {
        stamp.pants.transform.colorTransform = new ColorTransform();
    }
    
    public function drawOutline(n : Dynamic) : Dynamic
    {
        outline.gotoAndStop(n);
        this.bitmapdata.drawWithQuality(outline, offset, null, null, null, true, StageQuality.HIGH);
    }
    
    public function drawCurrentStamp(t : Dynamic, id : Dynamic, sel : Dynamic, pantsN : Int = -1, has : Bool = false) : Void
    {
        if (t == "pants")
        {
            if (has)
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
        else if (t == "hat")
        {
            if (has)
            {
                stamp.gotoAndStop(id + 11);
            }
            else
            {
                stamp.gotoAndStop(10);
            }
        }
        else if (t == "pattern")
        {
            if (!has)
            {
                stamp.gotoAndStop(10);
            }
            else if (id == 0)
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
        else if (t == "color")
        {
            if (pantsN == id)
            {
                stamp.pattern.transform.colorTransform = new ColorTransform();
            }
            else
            {
                stamp.pattern.transform.colorTransform = Main.getColorTransform(id);
            }
        }
        this.bitmapdata.drawWithQuality(stamp, offset, null, null, null, true, StageQuality.HIGH);
        if (sel != null)
        {
            this.drawOutline(2);
        }
    }
    
    public function PauseIconReset(n : Int, ay : Float, r : Float, dt : Int, sel : Bool, offset : Float = 0, has : Bool = false) : Dynamic
    {
        if (Main.localSettings.canColor)
        {
            ay -= 20;
        }
        this.anchorX = 40 + (40 + n * 80) * r;
        if (this.anchorX + offset < -40 || this.anchorX + offset > 840)
        {
            x = this.anchorX + offset;
            this.downtime = 0;
        }
        else
        {
            if (grabDt)
            {
                firstDt = dt;
                grabDt = false;
            }
            if (this.type != "hat")
            {
                dt += 4;
            }
            x = 900;
            this.downtime = dt - firstDt;
        }
        this.anchorY = ay;
        if (sel)
        {
            this.drawOutline(2);
            r *= 0.8;
        }
        else if (this.selected)
        {
            this.drawOutline(1);
        }
        if (!this.unlocked && has)
        {
            this.bitmapdata.fillRect(this.bitmapdata.rect, 0);
            this.drawCurrentStamp(this.type, this.ID, this.selected, -1, true);
            this.unlocked = true;
        }
        scaleX = scaleY = this.ratio = r;
        this.selected = sel;
    }
}


