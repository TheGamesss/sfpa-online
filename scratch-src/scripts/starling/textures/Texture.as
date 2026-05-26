package starling.textures
{
   import flash.display.*;
   import flash.display3D.*;
   import flash.display3D.textures.*;
   import flash.geom.*;
   import flash.media.Camera;
   import flash.net.NetStream;
   import flash.system.*;
   import flash.utils.*;
   import starling.core.*;
   import starling.errors.*;
   import starling.rendering.VertexData;
   import starling.utils.*;
   
   public class Texture
   {
      
      private static var sDefaultOptions:TextureOptions = new TextureOptions();
      
      private static var sRectangle:Rectangle = new Rectangle();
      
      private static var sMatrix:Matrix = new Matrix();
      
      private static var sPoint:Point = new Point();
      
      public function Texture()
      {
         super();
         if(Boolean(Capabilities.isDebugger) && getQualifiedClassName(this) == "starling.textures::Texture")
         {
            throw new AbstractClassError();
         }
      }
      
      public static function fromData(data:Object, options:TextureOptions = null) : starling.textures.Texture
      {
         if(data is Bitmap)
         {
            data = (data as Bitmap).bitmapData;
         }
         if(options == null)
         {
            options = sDefaultOptions;
         }
         if(data is Class)
         {
            return fromEmbeddedAsset(data as Class,options.mipMapping,options.optimizeForRenderToTexture,options.scale,options.format,options.forcePotTexture);
         }
         if(data is BitmapData)
         {
            return fromBitmapData(data as BitmapData,options.mipMapping,options.optimizeForRenderToTexture,options.scale,options.format,options.forcePotTexture,options.onReady);
         }
         if(data is ByteArray)
         {
            return fromAtfData(data as ByteArray,options.scale,options.mipMapping,options.onReady);
         }
         throw new ArgumentError("Unsupported \'data\' type: " + getQualifiedClassName(data));
      }
      
      public static function fromTextureBase(base:TextureBase, width:int, height:int, options:TextureOptions = null) : ConcreteTexture
      {
         if(options == null)
         {
            options = sDefaultOptions;
         }
         if(base is flash.display3D.textures.Texture)
         {
            return new ConcretePotTexture(base as flash.display3D.textures.Texture,options.format,width,height,options.mipMapping,options.premultipliedAlpha,options.optimizeForRenderToTexture,options.scale);
         }
         if(base is RectangleTexture)
         {
            return new ConcreteRectangleTexture(base as RectangleTexture,options.format,width,height,options.premultipliedAlpha,options.optimizeForRenderToTexture,options.scale);
         }
         if(base is VideoTexture)
         {
            return new ConcreteVideoTexture(base as VideoTexture,options.scale);
         }
         throw new ArgumentError("Unsupported \'base\' type: " + getQualifiedClassName(base));
      }
      
      public static function fromEmbeddedAsset(assetClass:Class, mipMapping:Boolean = false, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra", forcePotTexture:Boolean = false) : starling.textures.Texture
      {
         var texture:starling.textures.Texture = null;
         var asset:Object = new assetClass();
         if(asset is Bitmap)
         {
            texture = Texture.fromBitmap(asset as Bitmap,mipMapping,optimizeForRenderToTexture,scale,format,forcePotTexture);
            texture.root.onRestore = function():void
            {
               texture.root.uploadBitmap(new assetClass());
            };
         }
         else
         {
            if(!(asset is ByteArray))
            {
               throw new ArgumentError("Invalid asset type: " + getQualifiedClassName(asset));
            }
            texture = Texture.fromAtfData(asset as ByteArray,scale,mipMapping,null);
            texture.root.onRestore = function():void
            {
               texture.root.uploadAtfData(new assetClass());
            };
         }
         asset = null;
         return texture;
      }
      
      public static function fromBitmap(bitmap:Bitmap, generateMipMaps:Boolean = false, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra", forcePotTexture:Boolean = false, async:Function = null) : starling.textures.Texture
      {
         return fromBitmapData(bitmap.bitmapData,generateMipMaps,optimizeForRenderToTexture,scale,format,forcePotTexture,async);
      }
      
      public static function fromBitmapData(data:BitmapData, generateMipMaps:Boolean = false, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra", forcePotTexture:Boolean = false, async:Function = null) : starling.textures.Texture
      {
         var texture:starling.textures.Texture = null;
         texture = Texture.empty(data.width / scale,data.height / scale,true,generateMipMaps,optimizeForRenderToTexture,scale,format,forcePotTexture);
         texture.root.uploadBitmapData(data,async != null ? function():void
         {
            execute(async,texture);
         } : null);
         texture.root.onRestore = function():void
         {
            texture.root.uploadBitmapData(data);
         };
         return texture;
      }
      
      public static function fromAtfData(data:ByteArray, scale:Number = 1, useMipMaps:Boolean = true, async:Function = null, premultipliedAlpha:Boolean = false) : starling.textures.Texture
      {
         var atfData:AtfData;
         var nativeTexture:flash.display3D.textures.Texture;
         var concreteTexture:ConcreteTexture = null;
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         atfData = new AtfData(data);
         nativeTexture = context.createTexture(atfData.width,atfData.height,atfData.format,false);
         concreteTexture = new ConcretePotTexture(nativeTexture,atfData.format,atfData.width,atfData.height,useMipMaps && atfData.numTextures > 1,premultipliedAlpha,false,scale);
         concreteTexture.uploadAtfData(data,0,async);
         concreteTexture.onRestore = function():void
         {
            concreteTexture.uploadAtfData(data,0);
         };
         return concreteTexture;
      }
      
      public static function fromNetStream(stream:NetStream, scale:Number = 1, onComplete:Function = null) : starling.textures.Texture
      {
         if(stream.client == stream && !("onMetaData" in stream))
         {
            stream.client = {"onMetaData":function(md:Object):void
            {
            }};
         }
         return fromVideoAttachment("NetStream",stream,scale,onComplete);
      }
      
      public static function fromCamera(camera:Camera, scale:Number = 1, onComplete:Function = null) : starling.textures.Texture
      {
         return fromVideoAttachment("Camera",camera,scale,onComplete);
      }
      
      private static function fromVideoAttachment(type:String, attachment:Object, scale:Number, onComplete:Function) : starling.textures.Texture
      {
         var context:Context3D;
         var base:VideoTexture;
         var texture:ConcreteTexture = null;
         if(!SystemUtil.supportsVideoTexture)
         {
            throw new NotSupportedError("Video Textures are not supported on this platform");
         }
         context = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         base = context.createVideoTexture();
         texture = new ConcreteVideoTexture(base,scale);
         texture.attachVideo(type,attachment,onComplete);
         texture.onRestore = function():void
         {
            texture.root.attachVideo(type,attachment);
         };
         return texture;
      }
      
      public static function fromColor(width:Number, height:Number, color:uint = 16777215, alpha:Number = 1, optimizeForRenderToTexture:Boolean = false, scale:Number = -1, format:String = "bgra", forcePotTexture:Boolean = false) : starling.textures.Texture
      {
         var texture:starling.textures.Texture = null;
         texture = Texture.empty(width,height,true,false,optimizeForRenderToTexture,scale,format,forcePotTexture);
         texture.root.clear(color,alpha);
         texture.root.onRestore = function():void
         {
            texture.root.clear(color,alpha);
         };
         return texture;
      }
      
      public static function empty(width:Number, height:Number, premultipliedAlpha:Boolean = true, mipMapping:Boolean = false, optimizeForRenderToTexture:Boolean = false, scale:Number = -1, format:String = "bgra", forcePotTexture:Boolean = false) : starling.textures.Texture
      {
         var actualWidth:int = 0;
         var actualHeight:int = 0;
         var nativeTexture:TextureBase = null;
         var concreteTexture:ConcreteTexture = null;
         if(scale <= 0)
         {
            scale = Number(Starling.contentScaleFactor);
         }
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         var origWidth:Number = width * scale;
         var origHeight:Number = height * scale;
         var useRectTexture:Boolean = !forcePotTexture && !mipMapping && Starling.current.profile != "baselineConstrained" && format.indexOf("compressed") == -1;
         if(useRectTexture)
         {
            actualWidth = Math.ceil(origWidth - 1e-9);
            actualHeight = Math.ceil(origHeight - 1e-9);
            nativeTexture = context.createRectangleTexture(actualWidth,actualHeight,format,optimizeForRenderToTexture);
            concreteTexture = new ConcreteRectangleTexture(nativeTexture as RectangleTexture,format,actualWidth,actualHeight,premultipliedAlpha,optimizeForRenderToTexture,scale);
         }
         else
         {
            actualWidth = int(MathUtil.getNextPowerOfTwo(origWidth));
            actualHeight = int(MathUtil.getNextPowerOfTwo(origHeight));
            nativeTexture = context.createTexture(actualWidth,actualHeight,format,optimizeForRenderToTexture);
            concreteTexture = new ConcretePotTexture(nativeTexture as flash.display3D.textures.Texture,format,actualWidth,actualHeight,mipMapping,premultipliedAlpha,optimizeForRenderToTexture,scale);
         }
         concreteTexture.onRestore = concreteTexture.clear;
         if(actualWidth - origWidth < 0.001 && actualHeight - origHeight < 0.001)
         {
            return concreteTexture;
         }
         return new SubTexture(concreteTexture,new Rectangle(0,0,width,height),true);
      }
      
      public static function fromTexture(texture:starling.textures.Texture, region:Rectangle = null, frame:Rectangle = null, rotated:Boolean = false, scaleModifier:Number = 1) : starling.textures.Texture
      {
         return new SubTexture(texture,region,false,frame,rotated,scaleModifier);
      }
      
      public static function get maxSize() : int
      {
         var target:Starling = Starling.current;
         var profile:String = target ? target.profile : "baseline";
         if(profile == "baseline" || profile == "baselineConstrained")
         {
            return 2048;
         }
         return 4096;
      }
      
      public static function get asyncBitmapUploadEnabled() : Boolean
      {
         return ConcreteRectangleTexture.asyncUploadEnabled;
      }
      
      public static function set asyncBitmapUploadEnabled(value:Boolean) : void
      {
         ConcreteRectangleTexture.asyncUploadEnabled = value;
         ConcretePotTexture.asyncUploadEnabled = value;
      }
      
      public function dispose() : void
      {
      }
      
      public function setupVertexPositions(vertexData:VertexData, vertexID:int = 0, attrName:String = "position", bounds:Rectangle = null) : void
      {
         var scaleX:Number = NaN;
         var scaleY:Number = NaN;
         var frame:Rectangle = this.frame;
         var width:Number = this.width;
         var height:Number = this.height;
         if(frame)
         {
            sRectangle.setTo(-frame.x,-frame.y,width,height);
         }
         else
         {
            sRectangle.setTo(0,0,width,height);
         }
         vertexData.setPoint(vertexID,attrName,sRectangle.left,sRectangle.top);
         vertexData.setPoint(vertexID + 1,attrName,sRectangle.right,sRectangle.top);
         vertexData.setPoint(vertexID + 2,attrName,sRectangle.left,sRectangle.bottom);
         vertexData.setPoint(vertexID + 3,attrName,sRectangle.right,sRectangle.bottom);
         if(bounds)
         {
            scaleX = bounds.width / this.frameWidth;
            scaleY = bounds.height / this.frameHeight;
            if(scaleX != 1 || scaleY != 1 || bounds.x != 0 || bounds.y != 0)
            {
               sMatrix.identity();
               sMatrix.scale(scaleX,scaleY);
               sMatrix.translate(bounds.x,bounds.y);
               vertexData.transformPoints(attrName,sMatrix,vertexID,4);
            }
         }
      }
      
      public function setupTextureCoordinates(vertexData:VertexData, vertexID:int = 0, attrName:String = "texCoords") : void
      {
         this.setTexCoords(vertexData,vertexID,attrName,0,0);
         this.setTexCoords(vertexData,vertexID + 1,attrName,1,0);
         this.setTexCoords(vertexData,vertexID + 2,attrName,0,1);
         this.setTexCoords(vertexData,vertexID + 3,attrName,1,1);
      }
      
      public function localToGlobal(u:Number, v:Number, out:Point = null) : Point
      {
         if(out == null)
         {
            out = new Point();
         }
         if(this == this.root)
         {
            out.setTo(u,v);
         }
         else
         {
            MatrixUtil.transformCoords(this.transformationMatrixToRoot,u,v,out);
         }
         return out;
      }
      
      public function globalToLocal(u:Number, v:Number, out:Point = null) : Point
      {
         if(out == null)
         {
            out = new Point();
         }
         if(this == this.root)
         {
            out.setTo(u,v);
         }
         else
         {
            sMatrix.identity();
            sMatrix.copyFrom(this.transformationMatrixToRoot);
            sMatrix.invert();
            MatrixUtil.transformCoords(sMatrix,u,v,out);
         }
         return out;
      }
      
      public function setTexCoords(vertexData:VertexData, vertexID:int, attrName:String, u:Number, v:Number) : void
      {
         this.localToGlobal(u,v,sPoint);
         vertexData.setPoint(vertexID,attrName,sPoint.x,sPoint.y);
      }
      
      public function getTexCoords(vertexData:VertexData, vertexID:int, attrName:String = "texCoords", out:Point = null) : Point
      {
         if(out == null)
         {
            out = new Point();
         }
         vertexData.getPoint(vertexID,attrName,out);
         return this.globalToLocal(out.x,out.y,out);
      }
      
      public function get frame() : Rectangle
      {
         return null;
      }
      
      public function get frameWidth() : Number
      {
         return this.frame ? this.frame.width : this.width;
      }
      
      public function get frameHeight() : Number
      {
         return this.frame ? this.frame.height : this.height;
      }
      
      public function get width() : Number
      {
         return 0;
      }
      
      public function get height() : Number
      {
         return 0;
      }
      
      public function get nativeWidth() : Number
      {
         return 0;
      }
      
      public function get nativeHeight() : Number
      {
         return 0;
      }
      
      public function get scale() : Number
      {
         return 1;
      }
      
      public function get base() : TextureBase
      {
         return null;
      }
      
      public function get root() : ConcreteTexture
      {
         return null;
      }
      
      public function get format() : String
      {
         return Context3DTextureFormat.BGRA;
      }
      
      public function get mipMapping() : Boolean
      {
         return false;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return false;
      }
      
      public function get transformationMatrix() : Matrix
      {
         return null;
      }
      
      public function get transformationMatrixToRoot() : Matrix
      {
         return null;
      }
   }
}

