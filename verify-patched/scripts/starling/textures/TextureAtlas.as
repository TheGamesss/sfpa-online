package starling.textures
{
   import flash.geom.*;
   import flash.utils.*;
   import starling.utils.*;
   
   public class TextureAtlas
   {
      
      private static var sNames:Vector.<String> = new Vector.<String>(0);
      
      private var _atlasTexture:Texture;
      
      private var _subTextures:Dictionary;
      
      private var _subTextureNames:Vector.<String>;
      
      public function TextureAtlas(texture:Texture, atlasXml:XML = null)
      {
         super();
         this._subTextures = new Dictionary();
         this._atlasTexture = texture;
         if(atlasXml)
         {
            this.parseAtlasXml(atlasXml);
         }
      }
      
      public function dispose() : void
      {
         this._atlasTexture.dispose();
      }
      
      protected function parseAtlasXml(atlasXml:XML) : void
      {
         var subTexture:XML = null;
         var name:String = null;
         var x:Number = NaN;
         var y:Number = NaN;
         var width:Number = NaN;
         var height:Number = NaN;
         var frameX:Number = NaN;
         var frameY:Number = NaN;
         var frameWidth:Number = NaN;
         var frameHeight:Number = NaN;
         var rotated:Boolean = false;
         var scale:Number = Number(this._atlasTexture.scale);
         var region:Rectangle = new Rectangle();
         var frame:Rectangle = new Rectangle();
         for each(subTexture in atlasXml.SubTexture)
         {
            name = StringUtil.clean(subTexture.@name);
            x = parseFloat(subTexture.@x) / scale;
            y = parseFloat(subTexture.@y) / scale;
            width = parseFloat(subTexture.@width) / scale;
            height = parseFloat(subTexture.@height) / scale;
            frameX = parseFloat(subTexture.@frameX) / scale;
            frameY = parseFloat(subTexture.@frameY) / scale;
            frameWidth = parseFloat(subTexture.@frameWidth) / scale;
            frameHeight = parseFloat(subTexture.@frameHeight) / scale;
            rotated = Boolean(StringUtil.parseBoolean(subTexture.@rotated));
            region.setTo(x,y,width,height);
            frame.setTo(frameX,frameY,frameWidth,frameHeight);
            if(frameWidth > 0 && frameHeight > 0)
            {
               this.addRegion(name,region,frame,rotated);
            }
            else
            {
               this.addRegion(name,region,null,rotated);
            }
         }
      }
      
      public function getTexture(name:String) : Texture
      {
         return this._subTextures[name];
      }
      
      public function getTextures(prefix:String = "", out:Vector.<Texture> = null) : Vector.<Texture>
      {
         var name:String = null;
         if(out == null)
         {
            out = new Vector.<Texture>(0);
         }
         for each(name in this.getNames(prefix,sNames))
         {
            out[out.length] = this.getTexture(name);
         }
         sNames.length = 0;
         return out;
      }
      
      public function getNames(prefix:String = "", out:Vector.<String> = null) : Vector.<String>
      {
         var name:String = null;
         if(out == null)
         {
            out = new Vector.<String>(0);
         }
         if(this._subTextureNames == null)
         {
            this._subTextureNames = new Vector.<String>(0);
            for(name in this._subTextures)
            {
               this._subTextureNames[this._subTextureNames.length] = name;
            }
            this._subTextureNames.sort(Array.CASEINSENSITIVE);
         }
         for each(name in this._subTextureNames)
         {
            if(name.indexOf(prefix) == 0)
            {
               out[out.length] = name;
            }
         }
         return out;
      }
      
      public function getRegion(name:String) : Rectangle
      {
         var subTexture:SubTexture = this._subTextures[name];
         return subTexture ? subTexture.region : null;
      }
      
      public function getFrame(name:String) : Rectangle
      {
         var subTexture:SubTexture = this._subTextures[name];
         return subTexture ? subTexture.frame : null;
      }
      
      public function getRotation(name:String) : Boolean
      {
         var subTexture:SubTexture = this._subTextures[name];
         return subTexture ? subTexture.rotated : false;
      }
      
      public function addRegion(name:String, region:Rectangle, frame:Rectangle = null, rotated:Boolean = false) : void
      {
         this.addSubTexture(name,new SubTexture(this._atlasTexture,region,false,frame,rotated));
      }
      
      public function addSubTexture(name:String, subTexture:SubTexture) : void
      {
         if(subTexture.root != this._atlasTexture.root)
         {
            throw new ArgumentError("SubTexture\'s root must be atlas texture.");
         }
         this._subTextures[name] = subTexture;
         this._subTextureNames = null;
      }
      
      public function removeRegion(name:String) : void
      {
         var subTexture:SubTexture = this._subTextures[name];
         if(subTexture)
         {
            subTexture.dispose();
         }
         delete this._subTextures[name];
         this._subTextureNames = null;
      }
      
      public function get texture() : Texture
      {
         return this._atlasTexture;
      }
   }
}

