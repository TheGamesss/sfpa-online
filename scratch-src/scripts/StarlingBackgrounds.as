package
{
   import com.emibap.textureAtlas.*;
   import flash.display.*;
   import flash.display3D.*;
   import flash.display3D.textures.RectangleTexture;
   import flash.display3D.textures.Texture;
   import flash.events.*;
   import flash.filters.BlurFilter;
   import flash.geom.*;
   import flash.system.*;
   import flash.utils.*;
   import starling.core.*;
   import starling.display.*;
   import starling.events.*;
   import starling.filters.BlurFilter;
   import starling.textures.*;
   import starling.utils.*;
   
   public class StarlingBackgrounds extends starling.display.Sprite
   {
      
      public static var myStarling:Starling;
      
      private static var StaticBackground:starling.display.Sprite;
      
      public static var volcanoBackground:ScrollingObject;
      
      private static var inkboardAtlas:TextureAtlas;
      
      public static var inkSplat:starling.display.MovieClip;
      
      public static var cheatScale:starling.display.Sprite;
      
      private static var holdCacheFunc:Function;
      
      private static var croppedBD:BitmapData;
      
      public static var depthOfField:Boolean;
      
      public static var depthOfFieldCache:Boolean;
      
      public static var realStageX:int;
      
      public static var realStageY:int;
      
      public static var doorTexture:starling.textures.Texture;
      
      public static var tearTexture:starling.textures.Texture;
      
      public static var springSurfaceTexture:starling.textures.Texture;
      
      public static var springSpringTexture:starling.textures.Texture;
      
      public static var BackgroundArray:Array = [];
      
      public static var BackgroundObjArray:Array = [];
      
      public static var BackContainerArray:Array = [];
      
      public static var BackgroundMeshes:Array = [];
      
      public static var allImages:Array = [];
      
      private static var effectsAtlas:Array = [];
      
      private static var backBitMax:uint = 4096 - 1;
      
      private static var backFormat:String = "bgraPacked4444";
      
      private static var blurRes:Number = 0.5;
      
      public static var constrained:Boolean = false;
      
      private static var sliceNx:uint = 0;
      
      public static var sliceNy:uint = 0;
      
      public static var cameraFocalLength:int = 200;
      
      public static var backgroundObjectsArray:Array = [];
      
      public static var bitRes:Number = 1;
      
      public static var doorStampArray:Array = [];
      
      public static var groundTextures:Vector.<starling.textures.Texture> = new Vector.<Texture>(0);
      
      public static var groundBounds:Vector.<Rectangle> = new Vector.<Rectangle>(0);
      
      private static var charImage:Vector.<Image> = new Vector.<Image>(0);
      
      private static var charTexture:Vector.<starling.textures.Texture> = new Vector.<Texture>(0);
      
      private static var charNative:Vector.<RectangleTexture> = new Vector.<RectangleTexture>(0);
      
      private static var charNativeConstrained:Vector.<flash.display3D.textures.Texture> = new Vector.<flash.display3D.textures.Texture>(0);
      
      private static var pencilImage:Vector.<Image> = new Vector.<Image>(0);
      
      private static var pencilTexture:Vector.<starling.textures.Texture> = new Vector.<Texture>(0);
      
      private static var pencilNative:Vector.<RectangleTexture> = new Vector.<RectangleTexture>(0);
      
      private static var pencilNativeConstrained:Vector.<flash.display3D.textures.Texture> = new Vector.<flash.display3D.textures.Texture>(0);
      
      public static var charColor:uint = 16777215;
      
      public function StarlingBackgrounds()
      {
         super();
         textBubbles.setConstrained(constrained);
         StaticBackground = new Sprite();
         myStarling.stage.addChild(StaticBackground);
         Texture.asyncBitmapUploadEnabled = false;
         if(Capabilities.os.substr(0,3) != "Win")
         {
            backFormat = "bgra";
         }
         if(constrained)
         {
            backBitMax = 2048 - 1;
            StarlingSmoke.createAtlas(createEffect(new toBeCachedSmoke(),0.74,true));
            StarlingInteract.createAtlas(createEffect(new toBeCachedInteracts(),1.5,true));
            StarlingEffect.createAtlas(createEffect(new toBeCachedEffects(),1.25,true));
            StarlingDecals.createAtlas(createEffect(new toBeCachedDecals(),1.5,true));
         }
         else
         {
            StarlingSmoke.createAtlas(createEffect(new toBeCachedSmoke(),1.5,true,true));
            StarlingInteract.createAtlas(createEffect(new toBeCachedInteracts(),1.5,true));
            StarlingEffect.createAtlas(createEffect(new toBeCachedEffects(),1.5,true));
            StarlingDecals.createAtlas(createEffect(new toBeCachedDecals(),1.5,true));
         }
         groundCache();
         Main.stageRoot.StartAfterStarling();
      }
      
      public static function startStarling(e:flash.display.Stage) : *
      {
         var stage3D:Stage3D = null;
         if(rootHUD.HUD.isReallyMobile)
         {
            myStarling = new Starling(StarlingBackgrounds,Main.stageRoot.stage,null,null,"auto","auto");
            Main.FadeClip.x = Main.realStageX;
            Main.FadeClip.y = Main.realStageY;
            myStarling.start();
         }
         else
         {
            stage3D = e.stage3Ds[0];
            stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE,onExtendedComplete);
            stage3D.addEventListener(ErrorEvent.ERROR,onExtendedFailed);
            try
            {
               stage3D.requestContext3D("auto",Context3DProfile.BASELINE_EXTENDED);
            }
            catch(err:Error)
            {
               onExtendedFailed(null);
            }
         }
      }
      
      private static function onExtendedComplete(e:flash.events.Event) : void
      {
         Main.stageRoot.stage.stage3Ds[0].removeEventListener(flash.events.Event.CONTEXT3D_CREATE,onExtendedComplete);
         Main.stageRoot.stage.stage3Ds[0].removeEventListener(ErrorEvent.ERROR,onExtendedFailed);
         if(Main.stageRoot.stage.stage3Ds[0].context3D)
         {
            Main.stageRoot.stage.stage3Ds[0].context3D.dispose(false);
         }
         setTimeout(reallyStartStarling,100);
      }
      
      private static function onExtendedFailed(e:flash.events.Event) : void
      {
         Main.stageRoot.stage.stage3Ds[0].removeEventListener(flash.events.Event.CONTEXT3D_CREATE,onExtendedComplete);
         Main.stageRoot.stage.stage3Ds[0].removeEventListener(ErrorEvent.ERROR,onExtendedFailed);
         if(Main.stageRoot.stage.stage3Ds[0].context3D)
         {
            Main.stageRoot.stage.stage3Ds[0].context3D.dispose(false);
         }
         constrained = true;
         setTimeout(reallyStartStarling,1000);
      }
      
      private static function reallyStartStarling() : void
      {
         if(constrained)
         {
            myStarling = new Starling(StarlingBackgrounds,Main.stageRoot.stage,null,null,"auto",Context3DProfile.BASELINE_CONSTRAINED);
         }
         else
         {
            myStarling = new Starling(StarlingBackgrounds,Main.stageRoot.stage,null,null,"auto",Context3DProfile.BASELINE_EXTENDED);
         }
         Main.FadeClip.x = Main.realStageX;
         Main.FadeClip.y = Main.realStageY;
         myStarling.start();
      }
      
      public static function addStaticBack(bitmap:BitmapData) : *
      {
         if(StaticBackground.numChildren > 0)
         {
            StaticBackground.removeChildAt(0);
         }
         var tile:Image = new Image(Texture.fromBitmapData(bitmap,false,true,1,backFormat));
         StaticBackground.blendMode = BlendMode.NONE;
         StaticBackground.addChild(tile);
      }
      
      public static function resizeStaticBack(scx:Number, scy:Number) : void
      {
         StaticBackground.scaleX = scx;
         StaticBackground.scaleY = scy;
      }
      
      public static function setupCharStarling(ratio:Number, id:uint) : void
      {
         charTexture[id] = Texture.empty(133,140,true,false,true,ratio);
         if(constrained)
         {
            charNativeConstrained[id] = charTexture[id].base as flash.display3D.textures.Texture;
         }
         else
         {
            charNative[id] = charTexture[id].base as RectangleTexture;
         }
         charImage[id] = new Image(charTexture[id]);
         charImage[id].textureSmoothing = "bilinear";
         charImage[id].pivotX = 66.5;
         charImage[id].pivotY = 70;
         myStarling.stage.addChild(charImage[id]);
         pencilTexture[id] = Texture.empty(20,80,true,false,true,1.5);
         if(constrained)
         {
            pencilNativeConstrained[id] = pencilTexture[id].base as flash.display3D.textures.Texture;
         }
         else
         {
            pencilNative[id] = pencilTexture[id].base as RectangleTexture;
         }
         pencilImage[id] = new Image(pencilTexture[id]);
         pencilImage[id].pivotX = 5;
         pencilImage[id].pivotY = 60;
         myStarling.stage.addChild(pencilImage[id]);
      }
      
      public static function addCharStarling(id:uint) : void
      {
         myStarling.stage.addChild(charImage[id]);
         myStarling.stage.addChild(pencilImage[id]);
      }
      
      public static function pressCharBitmap(charBitmap:BitmapData, id:uint) : void
      {
         if(constrained)
         {
            charNativeConstrained[id].uploadFromBitmapData(charBitmap);
         }
         else
         {
            charNative[id].uploadFromBitmapData(charBitmap);
         }
         charImage[id].texture = charTexture[id];
      }
      
      public static function placeCharBitmap(ex:Number, ey:Number, rot:Number, ratio:Number, id:uint) : void
      {
         charImage[id].x = ex;
         charImage[id].y = ey;
         charImage[id].rotation = rot;
         charImage[id].scaleX = charImage[id].scaleY = ratio;
      }
      
      public static function ArrangeBackgrounds(rail:uint, id:uint) : void
      {
         charImage[id].parent.addChild(charImage[id]);
         pencilImage[id].parent.addChild(pencilImage[id]);
         var depth:uint = uint(BackgroundObjArray[rail].parent.getChildIndex(BackgroundObjArray[rail]));
         charImage[id].parent.addChildAt(charImage[id],depth + 1);
         pencilImage[id].parent.addChildAt(pencilImage[id],depth + 2);
         charImage[id].color = charColor;
         pencilImage[id].color = charColor;
      }
      
      public static function placeSlash(slash:*) : void
      {
         myStarling.stage.addChildAt(slash,pencilImage[0].parent.getChildIndex(pencilImage[0]) + 1);
      }
      
      public static function pressPencilBitmap(pencilBitmap:BitmapData, id:uint) : void
      {
         if(constrained)
         {
            pencilNativeConstrained[id].uploadFromBitmapData(pencilBitmap);
         }
         else
         {
            pencilNative[id].uploadFromBitmapData(pencilBitmap);
         }
         pencilImage[id].texture = pencilTexture[id];
      }
      
      public static function placePencilBitmap(ex:Number, ey:Number, rot:Number, ratioX:Number, ratioY:Number, id:uint) : void
      {
         pencilImage[id].x = ex;
         pencilImage[id].y = ey;
         pencilImage[id].rotation = rot;
         pencilImage[id].scaleX = ratioX;
         pencilImage[id].scaleY = ratioY;
      }
      
      public static function charVisible(vis:Boolean, id:uint) : void
      {
         charImage[id].visible = vis;
      }
      
      public static function pencilVisible(vis:Boolean, id:uint) : void
      {
         pencilImage[id].visible = vis;
      }
      
      public static function toStarlingFromMC(clip:*, ratio:*, background:*, offsetX:int = 0, offsetY:int = 0, toMesh:Boolean = false, func:Function = null, blur:Number = 0) : Boolean
      {
         var ex:int = 0;
         var ey:int = 0;
         var rec:Rectangle = null;
         var filter:flash.filters.BlurFilter = null;
         var bounds:Rectangle = clip.getBounds(clip);
         bounds.x -= 5 / ratio;
         bounds.y -= 5 / ratio;
         bounds.width += 10 / ratio;
         bounds.height += 10 / ratio;
         holdCacheFunc = null;
         if(sliceNx < bounds.width * ratio / backBitMax)
         {
            ex = bounds.width * ratio - sliceNx * backBitMax;
            if(ex > backBitMax)
            {
               ex = int(backBitMax);
            }
            if(sliceNy < bounds.height * ratio / backBitMax)
            {
               ey = bounds.height * ratio - sliceNy * backBitMax;
               if(ey > backBitMax)
               {
                  ey = int(backBitMax);
               }
               bitmapData = new BitmapData(ex + 1,ey + 1,true,0);
               bitmapData.drawWithQuality(clip,new Matrix(ratio,0,0,ratio,-(bounds.x * ratio + sliceNx * backBitMax),-(bounds.y * ratio + sliceNy * backBitMax)),null,null,null,true,StageQuality.BEST);
               rec = new Rectangle(0,0,ex,ey);
               if(blur < 0)
               {
                  blur = 1 + Math.abs(blur);
               }
               else if(blur > 0)
               {
                  blur = 2 + Math.abs(blur) / 10;
               }
               if(blur != 0 && depthOfFieldCache)
               {
                  filter = new flash.filters.BlurFilter(blur,blur);
                  filter.quality = 3;
                  bitmapData.applyFilter(bitmapData,rec,new Point(0,0),filter);
               }
               rec = bitmapData.getColorBoundsRect(4278190080,0,false);
               if(!(rec.width == 0 || rec.height == 0))
               {
                  Main.bitmapTotal += rec.height * rec.width;
                  croppedBD = new BitmapData(rec.width,rec.height);
                  croppedBD.copyPixels(bitmapData,rec,new Point(0,0));
                  bitmapData.dispose();
                  if(func == null)
                  {
                     addBitmap(croppedBD,background,bounds.x + offsetX + sliceNx * backBitMax / ratio + rec.x / ratio,bounds.y + offsetY + sliceNy * backBitMax / ratio + rec.y / ratio,1 / ratio,true,null,blur);
                     ++sliceNy;
                     croppedBD.dispose();
                  }
                  else
                  {
                     holdCacheFunc = func;
                     addBitmap(croppedBD,background,bounds.x + offsetX + sliceNx * backBitMax / ratio + rec.x / ratio,bounds.y + offsetY + sliceNy * backBitMax / ratio + rec.y / ratio,1 / ratio,true,advanceBitmap,blur);
                  }
               }
               else
               {
                  ++sliceNy;
                  if(func != null)
                  {
                     func();
                  }
               }
            }
            else
            {
               ++sliceNx;
               sliceNy = 0;
               if(func != null)
               {
                  func();
               }
            }
            return false;
         }
         sliceNx = 0;
         sliceNy = 0;
         return true;
      }
      
      public static function toStarlingObj(clip:*, ratio:*, background:*) : Image
      {
         var bounds:Rectangle = clip.getBounds(clip);
         bitmapData = new BitmapData(bounds.width + 4,bounds.height + 4,true,0);
         bitmapData.drawWithQuality(clip,new Matrix(ratio,0,0,ratio,-bounds.x,-bounds.y),clip.transform.colorTransform,null,null,true,StageQuality.BEST);
         return addBitmap(bitmapData,background,clip.x + bounds.x,clip.y + bounds.y,1 / ratio);
      }
      
      private static function advanceBitmap() : void
      {
         ++sliceNy;
         croppedBD.dispose();
         if(holdCacheFunc != null)
         {
            holdCacheFunc();
         }
      }
      
      public static function addBackground(i:*) : *
      {
         BackContainerArray[i] = new Sprite();
         BackgroundArray[i] = new Sprite();
         BackgroundObjArray[i] = new Sprite();
         myStarling.stage.addChild(BackContainerArray[i]);
         myStarling.stage.addChild(BackgroundArray[i]);
         myStarling.stage.addChild(BackgroundObjArray[i]);
      }
      
      public static function addBitmap(bitmap:BitmapData, background:*, ex:*, ey:*, ratio:*, toAll:Boolean = true, func:Function = null, blur:Number = 0) : Image
      {
         var tile:Image = null;
         if(bitmap.width > 5 && bitmap.height > 5)
         {
            tile = new Image(Texture.fromBitmapData(bitmap,false,true,1,backFormat,false,func));
            tile.textureSmoothing = "bilinear";
            tile.x = ex;
            tile.y = ey;
            tile.scaleX = tile.scaleY = ratio;
            if(toAll)
            {
               allImages.push(tile);
            }
            background.addChild(tile);
            return tile;
         }
         if(func != null)
         {
            func();
         }
      }
      
      public static function setBlur(rail:uint, clear:Boolean = false) : void
      {
         var i:uint = 0;
         var blur:Number = NaN;
         if(!depthOfField || constrained)
         {
            return;
         }
         var blurOffset:Number = Main.getBlurOffset(rail);
         var ratio:Number = 2.16 / Main.overRatio;
         for(i in BackgroundArray)
         {
            blur = (0.25 + Math.abs(Main.getBlurOffset(i) - blurOffset) * 1.5) / 2.16 * Main.overRatio;
            if(i == rail)
            {
               if(BackgroundArray[i].filter != null)
               {
                  BackgroundArray[i].filter.dispose();
                  BackgroundArray[i].filter = null;
               }
            }
            else
            {
               if(BackgroundArray[i].filter == null)
               {
                  BackgroundArray[i].filter = new starling.filters.BlurFilter(blur,blur,blurRes * ratio);
               }
               else
               {
                  BackgroundArray[i].filter.blurX = blur;
                  BackgroundArray[i].filter.blurY = blur;
               }
               BackgroundArray[i].filter.cache();
            }
            if(i == rail)
            {
               if(BackgroundObjArray[i].filter != null)
               {
                  BackgroundObjArray[i].filter.dispose();
                  BackgroundObjArray[i].filter = null;
               }
            }
            else
            {
               if(BackgroundObjArray[i].filter == undefined || clear)
               {
                  BackgroundObjArray[i].filter = new starling.filters.BlurFilter(blur,blur,blurRes * ratio);
               }
               else
               {
                  BackgroundObjArray[i].filter.blurX = blur;
                  BackgroundObjArray[i].filter.blurY = blur;
               }
               BackgroundObjArray[i].filter.padding = new Padding(40,40,40,40);
            }
            if(i == rail)
            {
               if(BackContainerArray[i].filter != null)
               {
                  BackContainerArray[i].filter.dispose();
                  BackContainerArray[i].filter = null;
               }
            }
            else if(BackContainerArray[i].filter == undefined || clear)
            {
               BackContainerArray[i].filter = new starling.filters.BlurFilter(blur,blur,blurRes * ratio);
            }
            else
            {
               BackContainerArray[i].filter.blurX = blur;
               BackContainerArray[i].filter.blurY = blur;
            }
         }
      }
      
      public static function addScrollObject(e:*, ez:*, res:Number = 1, func:Function = null) : Boolean
      {
         var obj:ScrollingObject = new ScrollingObject(e.x,e.y,ez);
         backgroundObjectsArray.push(obj);
         myStarling.stage.addChild(obj);
         if(func == null)
         {
            while(!toStarlingFromMC(e,res,obj))
            {
            }
            return true;
         }
         return toStarlingFromMC(e,res,obj,0,0,false,func);
      }
      
      public static function addVolcano() : void
      {
         volcanoBackground = new ScrollingObject(0,0,1000);
         myStarling.stage.addChild(volcanoBackground);
         var clip:volcanoClip = new volcanoClip();
         var bounds:Rectangle = clip.getBounds(clip);
         bounds.y -= 10;
         bounds.height += 20;
         bitmapData = new BitmapData(1100,350,true,0);
         bitmapData.drawWithQuality(clip,new Matrix(1,0,0,1,-bounds.x,-bounds.y),null,null,null,true,StageQuality.BEST);
         var filter:flash.filters.BlurFilter = new flash.filters.BlurFilter();
         filter.blurX = 2;
         filter.blurY = 2;
         bitmapData.applyFilter(bitmapData,new Rectangle(0,0,1100,350),new Point(0,0),filter);
         addBitmap(bitmapData,volcanoBackground,bounds.x,bounds.y,1,false);
         volcanoBackground.touchable = false;
      }
      
      public static function resizeVolcano(ex:*, ey:*) : void
      {
         volcanoBackground.scaleX = ex;
         volcanoBackground.scaleY = ey;
      }
      
      public static function addBitmapRender(bitmap:*, n:*, ex:*, ey:*, ratio:*) : *
      {
         var rend:RenderTexture = new RenderTexture(bitmap.width,bitmap.height,true,1);
         var image:Image = new Image(Texture.fromBitmapData(bitmap,false,true,1,backFormat));
         rend.draw(image);
         image.texture.dispose();
         image.dispose();
         var tile:Image = new Image(rend);
         tile.x = ex;
         tile.y = ey;
         tile.scaleX = tile.scaleY = ratio;
         BackgroundObjArray[n].addChild(tile);
         return tile;
      }
      
      private static function createEffect(mc:*, n:*, compress:*, xl:Boolean = false) : *
      {
         return DynamicAtlas.fromMovieClipContainer(mc,n,1,true,true,compress,xl);
      }
      
      public static function addObject(mc:*, rail:int) : void
      {
         BackgroundObjArray[rail].addChild(mc);
      }
      
      public static function addObjectBack(mc:starling.display.MovieClip, rail:int) : void
      {
         BackContainerArray[rail].addChild(mc);
      }
      
      public static function stampInkSplat(bit:*, b:*, matrix:*) : *
      {
         inkSplat.currentFrame = b;
         bit.texture.draw(inkSplat,matrix);
      }
      
      public static function removeMovieClip(e:*) : *
      {
         myStarling.juggler.remove(e);
         e.removeFromParent(true);
         e.dispose();
      }
      
      public static function scrollBackgrounds(n:*, ex:*, ey:*, ratio:*) : void
      {
         BackContainerArray[n].x = BackgroundObjArray[n].x = BackgroundArray[n].x = ex;
         BackContainerArray[n].y = BackgroundObjArray[n].y = BackgroundArray[n].y = ey;
         BackContainerArray[n].scaleX = BackContainerArray[n].scaleY = BackgroundObjArray[n].scaleX = BackgroundObjArray[n].scaleY = BackgroundArray[n].scaleX = BackgroundArray[n].scaleY = ratio;
      }
      
      public static function scrollVolcano(ex:Number, ey:Number, ratio:Number) : void
      {
         volcanoBackground.x = realStageX + (ex - 20000) * ratio;
         volcanoBackground.y = realStageY + (ey - 12500) * ratio;
         volcanoBackground.scaleX = volcanoBackground.scaleY = 50 * ratio;
      }
      
      public static function scrollBackgroundObjects(cameraX:*, cameraY:*, cameraZ:*) : *
      {
         var ratio:Number = NaN;
         for(var i:int = 0; i < backgroundObjectsArray.length; i++)
         {
            ratio = cameraFocalLength / (cameraFocalLength + backgroundObjectsArray[i].theZ - cameraZ) * Main.overRatio;
            if(ratio > 0)
            {
               backgroundObjectsArray[i].visible = true;
               backgroundObjectsArray[i].x = realStageX + (backgroundObjectsArray[i].theX - cameraX) * ratio;
               backgroundObjectsArray[i].y = realStageY + (backgroundObjectsArray[i].theY - cameraY) * ratio;
               backgroundObjectsArray[i].scaleX = backgroundObjectsArray[i].scaleY = ratio;
            }
            else
            {
               backgroundObjectsArray[i].visible = false;
            }
         }
      }
      
      public static function onResize() : *
      {
         myStarling.viewPort.width = Main.stageRoot.stage.stageWidth;
         myStarling.viewPort.height = Main.stageRoot.stage.stageHeight;
         myStarling.stage.stageWidth = Main.stageRoot.stage.stageWidth;
         myStarling.stage.stageHeight = Main.stageRoot.stage.stageHeight;
      }
      
      public static function flattenBackgrounds() : *
      {
         var i:uint = 0;
         for(i in BackgroundArray)
         {
            BackgroundArray[i].touchable = false;
            BackContainerArray[i].touchable = false;
            BackgroundObjArray[i].touchable = false;
         }
         for(i in backgroundObjectsArray)
         {
            backgroundObjectsArray[i].touchable = false;
         }
      }
      
      public static function unflattenBackgrounds() : *
      {
      }
      
      public static function flushBackgrounds() : *
      {
         var i:uint = 0;
         for(i in allImages)
         {
            allImages[i].removeFromParent(true);
            allImages[i].texture.dispose();
            allImages[i].dispose();
            allImages[i] = null;
         }
         allImages = [];
      }
      
      public static function removeBackgrounds() : *
      {
         var i:uint = 0;
         for(i in BackgroundArray)
         {
            if(BackgroundArray[i].filter != null)
            {
               BackgroundArray[i].filter.dispose();
               BackgroundArray[i].filter = null;
            }
            if(BackgroundObjArray[i].filter != null)
            {
               BackgroundObjArray[i].filter.dispose();
               BackgroundObjArray[i].filter = null;
            }
            if(BackContainerArray[i].filter != null)
            {
               BackContainerArray[i].filter.dispose();
               BackContainerArray[i].filter = null;
            }
            BackgroundArray[i].removeFromParent(true);
            BackgroundArray[i].dispose();
            BackgroundObjArray[i].removeFromParent(true);
            BackgroundObjArray[i].dispose();
            BackContainerArray[i].removeFromParent(true);
            BackContainerArray[i].dispose();
         }
         BackgroundArray = [];
         BackgroundObjArray = [];
         BackContainerArray = [];
      }
      
      public static function removeOneBackground(i:*) : *
      {
         BackgroundArray[i].removeFromParent(true);
         BackgroundArray[i].dispose();
         BackgroundArray.splice(i,1);
         BackgroundObjArray.splice(i,1);
         BackContainerArray.splice(i,1);
      }
      
      private static function groundCache() : void
      {
         var bounds:Rectangle = null;
         var bitmapData:BitmapData = null;
         var ground:groundStampW4 = new groundStampW4();
         for(var i:uint = 0; i < ground.totalFrames; i++)
         {
            ground.gotoAndStop(i + 1);
            bounds = groundBounds[i] = ground.getBounds(ground);
            bitmapData = new BitmapData(bounds.width,bounds.height,true,0);
            bitmapData.drawWithQuality(ground,new Matrix(1,0,0,1,-bounds.x,-bounds.y),null,null,null,true,StageQuality.BEST);
            groundTextures[i] = Texture.fromBitmapData(bitmapData,false,true,1,Context3DTextureFormat.BGRA_PACKED);
            bitmapData.dispose();
         }
      }
      
      public static function getGroundSmoke(frame:uint, rail:uint) : Image
      {
         var ground:Image = new Image(groundTextures[frame]);
         ground.pivotX = -groundBounds[frame].x;
         ground.pivotY = -groundBounds[frame].y;
         BackContainerArray[rail].addChild(ground);
         return ground;
      }
   }
}

