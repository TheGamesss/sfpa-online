package starling.utils
{
   import flash.display.Stage3D;
   import flash.display3D.*;
   import flash.events.*;
   import flash.utils.*;
   import starling.core.*;
   import starling.errors.*;
   import starling.textures.*;
   
   public class RenderUtil
   {
      
      public function RenderUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function clear(rgb:uint = 0, alpha:Number = 0) : void
      {
         Starling.context.clear(Color.getRed(rgb) / 255,Color.getGreen(rgb) / 255,Color.getBlue(rgb) / 255,alpha,1,127);
      }
      
      public static function getTextureLookupFlags(format:String, mipMapping:Boolean, repeat:Boolean = false, smoothing:String = "bilinear") : String
      {
         var options:Array = ["2d",repeat ? "repeat" : "clamp"];
         if(format == Context3DTextureFormat.COMPRESSED)
         {
            options.push("dxt1");
         }
         else if(format == "compressedAlpha")
         {
            options.push("dxt5");
         }
         if(smoothing == TextureSmoothing.NONE)
         {
            options.push("nearest",mipMapping ? "mipnearest" : "mipnone");
         }
         else if(smoothing == TextureSmoothing.BILINEAR)
         {
            options.push("linear",mipMapping ? "mipnearest" : "mipnone");
         }
         else
         {
            options.push("linear",mipMapping ? "miplinear" : "mipnone");
         }
         return "<" + options.join() + ">";
      }
      
      public static function getTextureVariantBits(texture:Texture) : uint
      {
         if(texture == null)
         {
            return 0;
         }
         var bitField:uint = 0;
         var formatBits:uint = 0;
         switch(texture.format)
         {
            case Context3DTextureFormat.COMPRESSED_ALPHA:
               formatBits = 3;
               break;
            case Context3DTextureFormat.COMPRESSED:
               formatBits = 2;
               break;
            default:
               formatBits = 1;
         }
         bitField |= formatBits;
         if(!texture.premultipliedAlpha)
         {
            bitField |= 1 << 2;
         }
         return bitField;
      }
      
      public static function setSamplerStateAt(sampler:int, mipMapping:Boolean, smoothing:String = "bilinear", repeat:Boolean = false) : void
      {
         var filter:String = null;
         var mipFilter:String = null;
         var wrap:String = repeat ? Context3DWrapMode.REPEAT : Context3DWrapMode.CLAMP;
         if(smoothing == TextureSmoothing.NONE)
         {
            filter = Context3DTextureFilter.NEAREST;
            mipFilter = mipMapping ? Context3DMipFilter.MIPNEAREST : Context3DMipFilter.MIPNONE;
         }
         else if(smoothing == TextureSmoothing.BILINEAR)
         {
            filter = Context3DTextureFilter.LINEAR;
            mipFilter = mipMapping ? Context3DMipFilter.MIPNEAREST : Context3DMipFilter.MIPNONE;
         }
         else
         {
            filter = Context3DTextureFilter.LINEAR;
            mipFilter = mipMapping ? Context3DMipFilter.MIPLINEAR : Context3DMipFilter.MIPNONE;
         }
         Starling.context.setSamplerStateAt(sampler,wrap,filter,mipFilter);
      }
      
      public static function createAGALTexOperation(resultReg:String, uvReg:String, sampler:int, texture:Texture, convertToPmaIfRequired:Boolean = true, tempReg:String = "ft0") : String
      {
         var formatFlag:String = null;
         var format:String = texture.format;
         switch(format)
         {
            case Context3DTextureFormat.COMPRESSED:
               formatFlag = "dxt1";
               break;
            case Context3DTextureFormat.COMPRESSED_ALPHA:
               formatFlag = "dxt5";
               break;
            default:
               formatFlag = "rgba";
         }
         var needsConversion:Boolean = convertToPmaIfRequired && !texture.premultipliedAlpha;
         var texReg:String = needsConversion && resultReg == "oc" ? tempReg : resultReg;
         var operation:String = "tex " + texReg + ", " + uvReg + ", fs" + sampler + " <2d, " + formatFlag + ">\n";
         if(needsConversion)
         {
            if(resultReg == "oc")
            {
               operation += "mul " + texReg + ".xyz, " + texReg + ".xyz, " + texReg + ".www\n";
               operation += "mov " + resultReg + ", " + texReg;
            }
            else
            {
               operation += "mul " + resultReg + ".xyz, " + texReg + ".xyz, " + texReg + ".www\n";
            }
         }
         return operation;
      }
      
      public static function requestContext3D(stage3D:Stage3D, renderMode:String, profile:*) : void
      {
         var profiles:Array = null;
         var currentProfile:String = null;
         var requestNextProfile:* = undefined;
         var onCreated:* = undefined;
         var onError:* = undefined;
         requestNextProfile = function():void
         {
            currentProfile = profiles.shift();
            try
            {
               execute(stage3D.requestContext3D,renderMode,currentProfile);
            }
            catch(error:Error)
            {
               if(profiles.length == 0)
               {
                  throw error;
               }
               setTimeout(requestNextProfile,1);
            }
         };
         onCreated = function(event:Event):void
         {
            var context:Context3D = stage3D.context3D;
            if(renderMode == Context3DRenderMode.AUTO && profiles.length != 0 && context.driverInfo.indexOf("Software") != -1)
            {
               onError(event);
            }
            else
            {
               onFinished();
            }
         };
         onError = function(event:Event):void
         {
            if(profiles.length != 0)
            {
               event.stopImmediatePropagation();
               setTimeout(requestNextProfile,1);
            }
            else
            {
               onFinished();
            }
         };
         var onFinished:* = function():void
         {
            stage3D.removeEventListener(Event.CONTEXT3D_CREATE,onCreated);
            stage3D.removeEventListener(ErrorEvent.ERROR,onError);
         };
         if(profile == "auto")
         {
            profiles = ["standardExtended","standard","standardConstrained","baselineExtended","baseline","baselineConstrained"];
         }
         else if(profile is String)
         {
            profiles = [profile as String];
         }
         else
         {
            if(!(profile is Array))
            {
               throw new ArgumentError("Profile must be of type \'String\' or \'Array\'");
            }
            profiles = profile as Array;
         }
         stage3D.addEventListener(Event.CONTEXT3D_CREATE,onCreated,false,100);
         stage3D.addEventListener(ErrorEvent.ERROR,onError,false,100);
         requestNextProfile();
      }
   }
}

