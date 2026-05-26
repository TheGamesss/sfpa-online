package
{
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3679")]
   public class progressNode extends staticInteractObjects
   {
      
      private static var distX:int;
      
      private static var distY:int;
      
      private static var maxNodes:uint;
      
      private static var tempArray:Vector.<progressNode> = new Vector.<progressNode>();
      
      private static var nodeArray:Vector.<progressNode> = new Vector.<progressNode>();
      
      private static var nodeDist:uint = 10000;
      
      private static var tempDist:uint = 10000;
      
      private static var nodeN:int = 0;
      
      public var num:TextField;
      
      private var ang:Number;
      
      public function progressNode(p:*)
      {
         super("progressNode",p.x,p.y,p.scaleX,1,p.onRail,"nothing",-1);
         tempArray.push(this);
         visible = false;
      }
      
      public static function arrangeNodes() : Boolean
      {
         var nodeAng:Number = NaN;
         if(tempArray.length == 0)
         {
            return false;
         }
         var ex:int = int(DoorArray[0].x);
         var ey:int = int(DoorArray[0].y);
         maxNodes = tempArray.length;
         for(var n:uint = 0; n < maxNodes; n++)
         {
            nodeDist = 20000;
            for(i = 0; i < tempArray.length; ++i)
            {
               distX = ex - tempArray[i].x;
               distY = ey - tempArray[i].y;
               tempDist = Math.sqrt(distX * distX + distY * distY);
               if(tempDist < nodeDist)
               {
                  nodeN = i;
                  nodeDist = tempDist;
               }
            }
            ex = int(tempArray[nodeN].x);
            ey = int(tempArray[nodeN].y);
            tempArray[nodeN].num.text = n;
            nodeArray.push(tempArray[nodeN]);
            tempArray.removeAt(nodeN);
         }
         return true;
      }
      
      public static function findClosest(ex:Number, ey:Number, start:uint) : int
      {
         nodeDist = 1000;
         nodeN = -1;
         if(start < 3)
         {
            start = 3;
         }
         var i:uint = start - 3;
         var l:uint = uint(nodeArray.length);
         while(i < l && i < start + 3)
         {
            distX = ex - nodeArray[i].x;
            distY = ey - nodeArray[i].y;
            tempDist = Math.sqrt(distX * distX + distY * distY);
            if(tempDist < nodeDist)
            {
               nodeN = i;
               nodeDist = tempDist;
            }
            i++;
         }
         if(nodeN == -1)
         {
            nodeN = findClosestFull(ex,ey);
         }
         return nodeN;
      }
      
      public static function findClosestFull(ex:Number, ey:Number) : int
      {
         nodeDist = 1000;
         var i:uint = 0;
         var l:uint = uint(nodeArray.length);
         while(i < l)
         {
            distX = ex - nodeArray[i].x;
            distY = ey - nodeArray[i].y;
            tempDist = Math.sqrt(distX * distX + distY * distY);
            if(tempDist < nodeDist)
            {
               nodeN = i;
               nodeDist = tempDist;
            }
            i++;
         }
         return nodeN;
      }
      
      public static function findNextDist(ex:Number, ey:Number, node:uint) : uint
      {
         if(node >= maxNodes)
         {
            return 0;
         }
         distX = ex - nodeArray[node].x;
         distY = ey - nodeArray[node].y;
         tempDist = Math.sqrt(distX * distX + distY * distY);
         return tempDist;
      }
   }
}

