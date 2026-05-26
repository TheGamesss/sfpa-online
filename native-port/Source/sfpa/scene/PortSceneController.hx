package sfpa.scene;

import sfpa.core.PortContext;
import sfpa.session.LevelSession;
import starling.display.Sprite;

class PortSceneController extends Sprite {
	private var currentScene:PortScene;
	private var currentKey:String = "";

	public function new() {
		super();
	}

	public function refresh():Void {
		var nextKey = resolveSceneKey();
		if (currentScene == null || nextKey != currentKey) {
			swapScene(nextKey);
		}

		currentScene.refresh();
	}

	public function destroy():Void {
		if (currentScene != null) {
			currentScene.destroy();
			currentScene = null;
		}
		removeChildren(0, -1, true);
	}

	private function swapScene(nextKey:String):Void {
		if (currentScene != null) {
			currentScene.destroy();
			currentScene = null;
		}

		removeChildren(0, -1, true);

		var scene:PortScene = switch (nextKey) {
			case "map": new MapShellScene(refresh);
			case "levelselect": new LevelSelectShellScene(refresh);
			case "respawn": new RespawnShellScene(refresh);
			default: new RouteShellScene(refresh);
		};

		currentScene = scene;
		currentKey = nextKey;
		addChild(cast scene);
	}

	private function resolveSceneKey():String {
		return switch (PortContext.current.levelSession.viewMode) {
			case LevelSession.VIEW_MAP: "map";
			case LevelSession.VIEW_LEVEL_SELECT: "levelselect";
			case LevelSession.VIEW_RESPAWN: "respawn";
			default: "route";
		};
	}
}
