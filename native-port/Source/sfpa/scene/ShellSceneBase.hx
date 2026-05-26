package sfpa.scene;

import sfpa.content.LevelManifestEntry;
import sfpa.ui.MenuButton;
import starling.display.Quad;
import starling.display.Sprite;
import starling.text.TextField;
import starling.text.TextFormat;

class ShellSceneBase extends Sprite implements PortScene {
	public var requestRefresh:Void->Void;

	public function new(requestRefresh:Void->Void) {
		super();
		this.requestRefresh = requestRefresh;
	}

	public function refresh():Void {}

	public function destroy():Void {
		removeChildren(0, -1, true);
		removeFromParent(true);
	}

	public function addPanel(x:Float, y:Float, width:Float, height:Float, color:UInt, alpha:Float = 0.96):Quad {
		var panel = new Quad(width, height, color);
		panel.x = x;
		panel.y = y;
		panel.alpha = alpha;
		addChild(panel);
		return panel;
	}

	public function addText(x:Float, y:Float, width:Int, height:Int, text:String, size:Int, color:UInt):TextField {
		var field = new TextField(width, height, text, new TextFormat("Verdana", size, color));
		field.x = x;
		field.y = y;
		field.autoScale = true;
		addChild(field);
		return field;
	}

	public function addButton(x:Float, y:Float, width:Float, height:Float, color:UInt, onActivate:Void->Void):MenuButton {
		var button = new MenuButton(width, height, color, onActivate);
		button.x = x;
		button.y = y;
		addChild(button);
		return button;
	}

	public static function formatTarget(target:Null<LevelManifestEntry>, dirIt:String, loadIt:String):String {
		if (target == null) {
			return "missing for " + dirIt + "/" + loadIt;
		}

		return target.path;
	}

	public static function formatNearby(nearbyNames:Array<String>):String {
		return nearbyNames.length == 0 ? "none indexed" : nearbyNames.join(", ");
	}

	public static function formatRoute(dirIt:String, loadIt:String, doorIt:Int):String {
		return dirIt + " / " + loadIt + " / door " + doorIt;
	}
}
