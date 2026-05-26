package sfpa;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import sfpa.achievements.Achievements;
import sfpa.achievements.WebAchievementBridge;
import sfpa.boot.PortStarlingRoot;
import sfpa.core.PortContext;
import sfpa.web.SfpaJsApi;
import starling.core.Starling;

class SfpaPortApp extends Sprite {
	private var starlingApp:Starling;

	public function new() {
		super();
		if (stage == null) {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			return;
		}

		start();
	}

	private function onAddedToStage(_:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		start();
	}

	private function start():Void {
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;

		Achievements.install(new WebAchievementBridge());
		PortContext.initialize();
		SfpaJsApi.bootstrap();

		starlingApp = new Starling(PortStarlingRoot, stage);
		starlingApp.skipUnchangedFrames = false;
		starlingApp.simulateMultitouch = false;
		starlingApp.start();
	}
}
