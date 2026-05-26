package starling.events
{
   public class KeyboardEvent extends Event
   {
      
      public static const KEY_UP:String = "keyUp";
      
      public static const KEY_DOWN:String = "keyDown";
      
      private var _charCode:uint;
      
      private var _keyCode:uint;
      
      private var _keyLocation:uint;
      
      private var _altKey:Boolean;
      
      private var _ctrlKey:Boolean;
      
      private var _shiftKey:Boolean;
      
      private var _isDefaultPrevented:Boolean;
      
      public function KeyboardEvent(type:String, charCode:uint = 0, keyCode:uint = 0, keyLocation:uint = 0, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false)
      {
         super(type,false,keyCode);
         this._charCode = charCode;
         this._keyCode = keyCode;
         this._keyLocation = keyLocation;
         this._ctrlKey = ctrlKey;
         this._altKey = altKey;
         this._shiftKey = shiftKey;
      }
      
      public function preventDefault() : void
      {
         this._isDefaultPrevented = true;
      }
      
      public function isDefaultPrevented() : Boolean
      {
         return this._isDefaultPrevented;
      }
      
      public function get charCode() : uint
      {
         return this._charCode;
      }
      
      public function get keyCode() : uint
      {
         return this._keyCode;
      }
      
      public function get keyLocation() : uint
      {
         return this._keyLocation;
      }
      
      public function get altKey() : Boolean
      {
         return this._altKey;
      }
      
      public function get ctrlKey() : Boolean
      {
         return this._ctrlKey;
      }
      
      public function get shiftKey() : Boolean
      {
         return this._shiftKey;
      }
   }
}

