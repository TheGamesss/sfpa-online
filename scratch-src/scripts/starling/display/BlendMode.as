package starling.display
{
   import flash.display3D.*;
   import starling.core.*;
   
   public class BlendMode
   {
      
      private static var sBlendModes:Object;
      
      public static const AUTO:String = "auto";
      
      public static const NONE:String = "none";
      
      public static const NORMAL:String = "normal";
      
      public static const ADD:String = "add";
      
      public static const MULTIPLY:String = "multiply";
      
      public static const SCREEN:String = "screen";
      
      public static const ERASE:String = "erase";
      
      public static const MASK:String = "mask";
      
      public static const BELOW:String = "below";
      
      private var _name:String;
      
      private var _sourceFactor:String;
      
      private var _destinationFactor:String;
      
      public function BlendMode(name:String, sourceFactor:String, destinationFactor:String)
      {
         super();
         this._name = name;
         this._sourceFactor = sourceFactor;
         this._destinationFactor = destinationFactor;
      }
      
      public static function get(modeName:String) : BlendMode
      {
         if(sBlendModes == null)
         {
            registerDefaults();
         }
         if(modeName in sBlendModes)
         {
            return sBlendModes[modeName];
         }
         throw new ArgumentError("Blend mode not found: " + modeName);
      }
      
      public static function register(name:String, srcFactor:String, dstFactor:String) : BlendMode
      {
         if(sBlendModes == null)
         {
            registerDefaults();
         }
         var blendMode:BlendMode = new BlendMode(name,srcFactor,dstFactor);
         sBlendModes[name] = blendMode;
         return blendMode;
      }
      
      private static function registerDefaults() : void
      {
         if(sBlendModes)
         {
            return;
         }
         sBlendModes = {};
         register("none",Context3DBlendFactor.ONE,Context3DBlendFactor.ZERO);
         register("normal",Context3DBlendFactor.ONE,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
         register("add",Context3DBlendFactor.ONE,Context3DBlendFactor.ONE);
         register("multiply",Context3DBlendFactor.DESTINATION_COLOR,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
         register("screen",Context3DBlendFactor.ONE,Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR);
         register("erase",Context3DBlendFactor.ZERO,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
         register("mask",Context3DBlendFactor.ZERO,Context3DBlendFactor.SOURCE_ALPHA);
         register("below",Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA,Context3DBlendFactor.DESTINATION_ALPHA);
      }
      
      public function activate() : void
      {
         Starling.context.setBlendFactors(this._sourceFactor,this._destinationFactor);
      }
      
      public function toString() : String
      {
         return this._name;
      }
      
      public function get sourceFactor() : String
      {
         return this._sourceFactor;
      }
      
      public function get destinationFactor() : String
      {
         return this._destinationFactor;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}

