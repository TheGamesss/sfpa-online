package
{
   import com.emibap.textureAtlas.*;
   import flash.display.MovieClip;
   import starling.display.MovieClip;
   import starling.textures.TextureAtlas;
   
   public class StarlingTemporary extends starling.display.MovieClip
   {
      
      public static var arrayLength:uint;
      
      public static var textureObj:Object;
      
      private static var alreadyCached:Boolean;
      
      private static var tempAtlas:TextureAtlas;
      
      public static var TempArray:Vector.<StarlingTemporary> = new Vector.<StarlingTemporary>(0);
      
      public static var tempEnterFrameArray:Vector.<StarlingTemporary> = new Vector.<StarlingTemporary>(0);
      
      public var ItIs:String;
      
      public var onRail:int;
      
      private var loopRand:uint = 0;
      
      private var rand:uint = 0;
      
      public function StarlingTemporary(e:String, ex:int, ey:int, rot:Number, sca:Number, rail:int, loop:Boolean, lr:uint)
      {
         super(textureObj[e + "Textures"]);
         this.ItIs = e;
         x = ex;
         y = ey;
         rotation = rot;
         scaleX = sca;
         scaleY = Math.abs(sca);
         this.onRail = rail;
         this.loopRand = lr;
      }
      
      public static function createCache(mc:flash.display.MovieClip, n:Number, compress:Boolean) : *
      {
         if(!alreadyCached)
         {
            createAtlas(DynamicAtlas.fromMovieClipContainer(mc,n,1,true,true,compress),mc);
         }
         alreadyCached = true;
      }
      
      public static function createAtlas(atlas:*, mc:flash.display.MovieClip) : void
      {
         var itis:String = null;
         textureObj = new Object();
         tempAtlas = atlas;
         var i:uint = 0;
         var l:uint = uint(mc.numChildren);
         while(i < l)
         {
            itis = mc.getChildAt(i).name;
            textureObj[itis + "Textures"] = atlas.getTextures(itis);
            i++;
         }
      }
      
      public static function Spawn(e:String, ex:int, ey:int, rot:Number, sca:Number, rail:int, loop:Boolean = false, lr:uint = 0, back:Boolean = false) : uint
      {
         var temp:StarlingTemporary = new StarlingTemporary(e,ex,ey,rot,sca,rail,loop,lr);
         temp.textureSmoothing = "trilinear";
         if(loop)
         {
            tempEnterFrameArray.push(temp);
         }
         TempArray.push(temp);
         if(rail > -1)
         {
            if(back)
            {
               StarlingBackgrounds.addObjectBack(temp,rail);
            }
            else
            {
               StarlingBackgrounds.addObject(temp,rail);
            }
         }
         return TempArray.length - 1;
      }
      
      public static function placeTemp(n:uint, ex:Number, ey:Number, erot:Number) : void
      {
         TempArray[n].place(ex,ey,erot);
      }
      
      public static function setScales(n:uint, scx:Number, scy:Number) : void
      {
         TempArray[n].scaleX = scx;
         TempArray[n].scaleY = scy;
      }
      
      public static function setFrame(n:uint, f:uint) : void
      {
         TempArray[n].currentFrame = f;
      }
      
      public static function setVisible(n:uint, vis:Boolean) : void
      {
         TempArray[n].visible = vis;
      }
      
      public static function justGetWithN(n:uint) : StarlingTemporary
      {
         return TempArray[n];
      }
      
      public static function clearAll() : void
      {
         for(var i:* = int(TempArray.length - 1); i >= 0; i--)
         {
            TempArray[i].cleanUp();
         }
         TempArray = new Vector.<StarlingTemporary>(0);
      }
      
      public static function wipeAtlas() : void
      {
         if(alreadyCached)
         {
            tempAtlas.texture.dispose();
            tempAtlas.dispose();
            tempAtlas = null;
            alreadyCached = false;
            effectsArray = new Vector.<StarlingTemporary>(0);
            tempEnterFrameArray = new Vector.<StarlingTemporary>(0);
         }
      }
      
      public static function tempEnterFrames() : void
      {
         for(var i:* = int(tempEnterFrameArray.length - 1); i >= 0; i--)
         {
            tempEnterFrameArray[i].tempEnterFrame();
         }
      }
      
      public function setupEffect() : void
      {
      }
      
      private function place(ex:Number, ey:Number, erot:Number) : void
      {
         x = ex;
         y = ey;
         rotation = erot;
      }
      
      public function cleanUp() : void
      {
         removeFromParent(true);
         texture.dispose();
         dispose();
      }
      
      public function tempEnterFrame() : Boolean
      {
         if(this.rand > 0)
         {
            --this.rand;
         }
         else if(currentFrame < numFrames)
         {
            ++currentFrame;
         }
         else
         {
            currentFrame = 1;
            this.rand = Math.random() * this.loopRand;
         }
      }
   }
}

