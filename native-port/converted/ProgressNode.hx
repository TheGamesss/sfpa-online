import flash.text.TextField;

@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3679"))

class ProgressNode extends StaticInteractObjects
{
    
    private static var distX : Int;
    
    private static var distY : Int;
    
    private static var maxNodes : Int;
    
    private static var tempArray : Array<ProgressNode> = new Array<ProgressNode>();
    
    private static var nodeArray : Array<ProgressNode> = new Array<ProgressNode>();
    
    private static var nodeDist : Int = 10000;
    
    private static var tempDist : Int = 10000;
    
    private static var nodeN : Int = 0;
    
    public var num : TextField;
    
    private var ang : Float;
    
    public function new(p : Dynamic)
    {
        super("progressNode", p.x, p.y, p.scaleX, 1, p.onRail, "nothing", -1);
        tempArray.push(this);
        visible = false;
    }
    
    public static function arrangeNodes() : Bool
    {
        var nodeAng : Float = Math.NaN;
        if (tempArray.length == 0)
        {
            return false;
        }
        var ex : Int = as3hx.Compat.parseInt(DoorArray[0].x);
        var ey : Int = as3hx.Compat.parseInt(DoorArray[0].y);
        maxNodes = tempArray.length;
        for (n in 0...maxNodes)
        {
            nodeDist = 20000;
            for (i in 0...tempArray.length)
            {
                distX = as3hx.Compat.parseInt(ex - tempArray[i].x);
                distY = as3hx.Compat.parseInt(ey - tempArray[i].y);
                tempDist = Math.sqrt(distX * distX + distY * distY);
                if (tempDist < nodeDist)
                {
                    nodeN = i;
                    nodeDist = tempDist;
                }
            }
            ex = as3hx.Compat.parseInt(tempArray[nodeN].x);
            ey = as3hx.Compat.parseInt(tempArray[nodeN].y);
            tempArray[nodeN].num.text = n;
            nodeArray.push(tempArray[nodeN]);
            tempArray.splice(nodeN, 1)[0];
        }
        return true;
    }
    
    public static function findClosest(ex : Float, ey : Float, start : Int) : Int
    {
        nodeDist = 1000;
        nodeN = -1;
        if (start < 3)
        {
            start = 3;
        }
        var i : Int = as3hx.Compat.parseInt(start - 3);
        var l : Int = as3hx.Compat.parseInt(nodeArray.length);
        while (i < l && i < start + 3)
        {
            distX = as3hx.Compat.parseInt(ex - nodeArray[i].x);
            distY = as3hx.Compat.parseInt(ey - nodeArray[i].y);
            tempDist = Math.sqrt(distX * distX + distY * distY);
            if (tempDist < nodeDist)
            {
                nodeN = i;
                nodeDist = tempDist;
            }
            i++;
        }
        if (nodeN == -1)
        {
            nodeN = findClosestFull(ex, ey);
        }
        return nodeN;
    }
    
    public static function findClosestFull(ex : Float, ey : Float) : Int
    {
        nodeDist = 1000;
        var i : Int = 0;
        var l : Int = as3hx.Compat.parseInt(nodeArray.length);
        while (i < l)
        {
            distX = as3hx.Compat.parseInt(ex - nodeArray[i].x);
            distY = as3hx.Compat.parseInt(ey - nodeArray[i].y);
            tempDist = Math.sqrt(distX * distX + distY * distY);
            if (tempDist < nodeDist)
            {
                nodeN = i;
                nodeDist = tempDist;
            }
            i++;
        }
        return nodeN;
    }
    
    public static function findNextDist(ex : Float, ey : Float, node : Int) : Int
    {
        if (node >= maxNodes)
        {
            return 0;
        }
        distX = as3hx.Compat.parseInt(ex - nodeArray[node].x);
        distY = as3hx.Compat.parseInt(ey - nodeArray[node].y);
        tempDist = Math.sqrt(distX * distX + distY * distY);
        return tempDist;
    }
}


