package starling.text
{
   import flash.geom.*;
   import flash.text.*;
   import starling.display.*;
   import starling.textures.*;
   import starling.utils.*;
   
   public class TrueTypeCompositor implements ITextCompositor
   {
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperQuad:Quad = new Quad(100,100);
      
      private static var sNativeTextField:flash.text.TextField = new flash.text.TextField();
      
      private static var sNativeFormat:flash.text.TextFormat = new flash.text.TextFormat();
      
      public function TrueTypeCompositor()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function fillMeshBatch(meshBatch:MeshBatch, width:Number, height:Number, text:String, format:starling.text.TextFormat, options:TextOptions = null) : void
      {
         var textureFormat:String;
         var texture:Texture = null;
         var bitmapData:BitmapDataEx = null;
         if(text == null || text == "")
         {
            return;
         }
         textureFormat = options.textureFormat;
         bitmapData = this.renderText(width,height,text,format,options);
         texture = Texture.fromBitmapData(bitmapData,false,false,bitmapData.scale,textureFormat);
         texture.root.onRestore = function():void
         {
            bitmapData = renderText(width,height,text,format,options);
            texture.root.uploadBitmapData(bitmapData);
            bitmapData.dispose();
            bitmapData = null;
         };
         bitmapData.dispose();
         bitmapData = null;
         sHelperQuad.texture = texture;
         sHelperQuad.readjustSize();
         if(format.horizontalAlign == Align.LEFT)
         {
            sHelperQuad.x = 0;
         }
         else if(format.horizontalAlign == Align.CENTER)
         {
            sHelperQuad.x = int((width - texture.width) / 2);
         }
         else
         {
            sHelperQuad.x = width - texture.width;
         }
         if(format.verticalAlign == Align.TOP)
         {
            sHelperQuad.y = 0;
         }
         else if(format.verticalAlign == Align.CENTER)
         {
            sHelperQuad.y = int((height - texture.height) / 2);
         }
         else
         {
            sHelperQuad.y = height - texture.height;
         }
         meshBatch.addMesh(sHelperQuad);
         sHelperQuad.texture = null;
      }
      
      public function clearMeshBatch(meshBatch:MeshBatch) : void
      {
         meshBatch.clear();
         if(meshBatch.texture)
         {
            meshBatch.texture.dispose();
            meshBatch.texture = null;
         }
      }
      
      private function renderText(width:Number, height:Number, text:String, format:starling.text.TextFormat, options:TextOptions) : BitmapDataEx
      {
         var offsetX:Number = NaN;
         var offsetY:Number = NaN;
         var bitmapData:BitmapDataEx = null;
         var scale:Number = options.textureScale;
         var scaledWidth:Number = width * scale;
         var scaledHeight:Number = height * scale;
         var hAlign:String = format.horizontalAlign;
         format.toNativeFormat(sNativeFormat);
         sNativeFormat.size = Number(sNativeFormat.size) * scale;
         sNativeTextField.embedFonts = SystemUtil.isEmbeddedFont(format.font,format.bold,format.italic);
         sNativeTextField.styleSheet = null;
         sNativeTextField.defaultTextFormat = sNativeFormat;
         sNativeTextField.styleSheet = options.styleSheet;
         sNativeTextField.width = scaledWidth;
         sNativeTextField.height = scaledHeight;
         sNativeTextField.antiAliasType = AntiAliasType.ADVANCED;
         sNativeTextField.selectable = false;
         sNativeTextField.multiline = true;
         sNativeTextField.wordWrap = options.wordWrap;
         if(options.isHtmlText)
         {
            sNativeTextField.htmlText = text;
         }
         else
         {
            sNativeTextField.text = text;
         }
         if(options.autoScale)
         {
            this.autoScaleNativeTextField(sNativeTextField,text,options.isHtmlText);
         }
         var minTextureSize:int = 1;
         var maxTextureSize:int = int(Texture.maxSize);
         var paddingX:Number = options.padding * scale;
         var paddingY:Number = options.padding * scale;
         var textWidth:Number = sNativeTextField.textWidth + 4;
         var textHeight:Number = sNativeTextField.textHeight + 4;
         var bitmapWidth:int = Math.ceil(textWidth) + 2 * paddingX;
         var bitmapHeight:int = Math.ceil(textHeight) + 2 * paddingY;
         if(bitmapWidth > scaledWidth)
         {
            paddingX = Number(MathUtil.max(0,(scaledWidth - textWidth) / 2));
            bitmapWidth = Math.ceil(scaledWidth);
         }
         if(bitmapHeight > scaledHeight)
         {
            paddingY = Number(MathUtil.max(0,(scaledHeight - textHeight) / 2));
            bitmapHeight = Math.ceil(scaledHeight);
         }
         if(options.isHtmlText)
         {
            textWidth = bitmapWidth = scaledWidth;
         }
         if(bitmapWidth < minTextureSize)
         {
            bitmapWidth = 1;
         }
         if(bitmapHeight < minTextureSize)
         {
            bitmapHeight = 1;
         }
         if(bitmapHeight > maxTextureSize || bitmapWidth > maxTextureSize)
         {
            options.textureScale *= maxTextureSize / Math.max(bitmapWidth,bitmapHeight);
            return this.renderText(width,height,text,format,options);
         }
         offsetX = -paddingX;
         offsetY = -paddingY;
         if(!options.isHtmlText)
         {
            if(hAlign == Align.RIGHT)
            {
               offsetX = scaledWidth - textWidth - paddingX;
            }
            else if(hAlign == Align.CENTER)
            {
               offsetX = (scaledWidth - textWidth) / 2 - paddingX;
            }
         }
         bitmapData = new BitmapDataEx(bitmapWidth,bitmapHeight);
         sHelperMatrix.setTo(1,0,0,1,-offsetX,-offsetY);
         bitmapData.draw(sNativeTextField,sHelperMatrix);
         bitmapData.scale = scale;
         sNativeTextField.text = "";
         return bitmapData;
      }
      
      private function autoScaleNativeTextField(textField:flash.text.TextField, text:String, isHtmlText:Boolean) : void
      {
         var textFormat:flash.text.TextFormat = textField.defaultTextFormat;
         var maxTextWidth:int = textField.width - 4;
         var maxTextHeight:int = textField.height - 4;
         var size:Number = Number(textFormat.size);
         while(textField.textWidth > maxTextWidth || textField.textHeight > maxTextHeight)
         {
            if(size <= 4)
            {
               break;
            }
            textFormat.size = size--;
            textField.defaultTextFormat = textFormat;
            if(isHtmlText)
            {
               textField.htmlText = text;
            }
            else
            {
               textField.text = text;
            }
         }
      }
   }
}

import flash.display.BitmapData;

class BitmapDataEx extends BitmapData
{
   
   private var _scale:Number = 1;
   
   public function BitmapDataEx(width:int, height:int, transparent:Boolean = true, fillColor:uint = 0)
   {
      super(width,height,transparent,fillColor);
   }
   
   public function get scale() : Number
   {
      return this._scale;
   }
   
   public function set scale(value:Number) : void
   {
      this._scale = value;
   }
}
