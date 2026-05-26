package starling.utils
{
   import flash.display3D.*;
   import flash.events.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   import starling.errors.*;
   
   public class SystemUtil
   {
      
      private static var sPlatform:String;
      
      private static var sDesktop:Boolean;
      
      private static var sVersion:String;
      
      private static var sAIR:Boolean;
      
      private static var sInitialized:Boolean = false;
      
      private static var sApplicationActive:Boolean = true;
      
      private static var sWaitingCalls:Array = [];
      
      private static var sEmbeddedFonts:Array = null;
      
      private static var sSupportsDepthAndStencil:Boolean = true;
      
      public function SystemUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function initialize() : void
      {
         var nativeAppClass:Object = null;
         var nativeApp:EventDispatcher = null;
         var appDescriptor:XML = null;
         var ns:Namespace = null;
         var ds:String = null;
         if(sInitialized)
         {
            return;
         }
         sInitialized = true;
         sPlatform = Capabilities.version.substr(0,3);
         sVersion = Capabilities.version.substr(4);
         sDesktop = /(WIN|MAC|LNX)/.exec(sPlatform) != null;
         try
         {
            nativeAppClass = getDefinitionByName("flash.desktop::NativeApplication");
            nativeApp = nativeAppClass["nativeApplication"] as EventDispatcher;
            nativeApp.addEventListener(Event.ACTIVATE,onActivate,false,0,true);
            nativeApp.addEventListener(Event.DEACTIVATE,onDeactivate,false,0,true);
            appDescriptor = nativeApp["applicationDescriptor"];
            ns = appDescriptor.namespace();
            ds = appDescriptor.ns::initialWindow.ns::depthAndStencil.toString().toLowerCase();
            sSupportsDepthAndStencil = ds == "true";
            sAIR = true;
         }
         catch(e:Error)
         {
            sAIR = false;
         }
      }
      
      private static function onActivate(event:Object) : void
      {
         var call:Array = null;
         sApplicationActive = true;
         for each(call in sWaitingCalls)
         {
            try
            {
               call[0].apply(null,call[1]);
            }
            catch(e:Error)
            {
               trace("[Starling] Error in \'executeWhenApplicationIsActive\' call:",e.message);
            }
         }
         sWaitingCalls = [];
      }
      
      private static function onDeactivate(event:Object) : void
      {
         sApplicationActive = false;
      }
      
      public static function executeWhenApplicationIsActive(call:Function, ... args) : void
      {
         initialize();
         if(sApplicationActive)
         {
            call.apply(null,args);
         }
         else
         {
            sWaitingCalls.push([call,args]);
         }
      }
      
      public static function get isApplicationActive() : Boolean
      {
         initialize();
         return sApplicationActive;
      }
      
      public static function get isAIR() : Boolean
      {
         initialize();
         return sAIR;
      }
      
      public static function get isAndroid() : Boolean
      {
         return platform == "AND";
      }
      
      public static function get isDesktop() : Boolean
      {
         initialize();
         return sDesktop;
      }
      
      public static function get isIOS() : Boolean
      {
         return platform == "IOS";
      }
      
      public static function get isMac() : Boolean
      {
         return platform == "MAC";
      }
      
      public static function get isWindows() : Boolean
      {
         return platform == "WIN";
      }
      
      public static function get platform() : String
      {
         initialize();
         return sPlatform;
      }
      
      public static function get version() : String
      {
         initialize();
         return sVersion;
      }
      
      public static function get supportsDepthAndStencil() : Boolean
      {
         return sSupportsDepthAndStencil;
      }
      
      public static function get supportsVideoTexture() : Boolean
      {
         return Context3D["supportsVideoTexture"];
      }
      
      public static function updateEmbeddedFonts() : void
      {
         sEmbeddedFonts = null;
      }
      
      public static function isEmbeddedFont(fontName:String, bold:Boolean = false, italic:Boolean = false, fontType:String = "embedded") : Boolean
      {
         var font:Font = null;
         var style:String = null;
         var isBold:Boolean = false;
         var isItalic:Boolean = false;
         if(sEmbeddedFonts == null)
         {
            sEmbeddedFonts = Font.enumerateFonts(false);
         }
         for each(font in sEmbeddedFonts)
         {
            style = font.fontStyle;
            isBold = style == FontStyle.BOLD || style == FontStyle.BOLD_ITALIC;
            isItalic = style == FontStyle.ITALIC || style == FontStyle.BOLD_ITALIC;
            if(fontName == font.fontName && bold == isBold && italic == isItalic && fontType == font.fontType)
            {
               return true;
            }
         }
         return false;
      }
   }
}

