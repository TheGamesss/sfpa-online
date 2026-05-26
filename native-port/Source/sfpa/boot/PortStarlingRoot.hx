package sfpa.boot;

import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import sfpa.achievements.Achievements;
import sfpa.core.PortContext;
import sfpa.scene.PortSceneController;
import starling.core.Starling;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event as StarlingEvent;
import starling.text.TextField;
import starling.text.TextFormat;

class PortStarlingRoot extends Sprite {
	private var sceneController:PortSceneController;

	public function new() {
		super();

		var backdrop = new Quad(1280, 720, 0x111111);
		addChild(backdrop);

		var glow = new Quad(1280, 180, 0x5D3D1F);
		glow.alpha = 0.16;
		addChild(glow);

		var leftPanel = new Quad(540, 520, 0x151515);
		leftPanel.x = 48;
		leftPanel.y = 170;
		leftPanel.alpha = 0.96;
		addChild(leftPanel);

		var rightPanel = new Quad(640, 520, 0x161616);
		rightPanel.x = 600;
		rightPanel.y = 170;
		rightPanel.alpha = 0.96;
		addChild(rightPanel);

		var title = new TextField(960, 72, "Super Fancy Pants Adventure", new TextFormat("Verdana", 34, 0xF5F5F5));
		title.x = 64;
		title.y = 56;
		title.autoScale = true;
		addChild(title);

		var subtitle = new TextField(960, 40, "Native HTML5 port workspace", new TextFormat("Verdana", 18, 0xF0B35A));
		subtitle.x = 64;
		subtitle.y = 132;
		subtitle.autoScale = true;
		addChild(subtitle);

		sceneController = new PortSceneController();
		addChild(sceneController);

		addEventListener(StarlingEvent.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(StarlingEvent.REMOVED_FROM_STAGE, onRemovedFromStage);
		refresh();
		Achievements.SendScore("native_port_menu_shell", 1);
	}

	private function onAddedToStage(_:StarlingEvent):Void {
		var nativeStage = Starling.current.nativeStage;
		nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}

	private function onRemovedFromStage(_:StarlingEvent):Void {
		var nativeStage = Starling.current.nativeStage;
		nativeStage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}

	private function onKeyDown(event:KeyboardEvent):Void {
		var context = PortContext.current;
		var session = context.levelSession;
		switch (event.keyCode) {
			case Keyboard.W:
				session.cycleSelectedDir(-1);
			case Keyboard.S:
				session.cycleSelectedDir(1);
			case Keyboard.A:
				session.cycleSelectedLevel(-1);
			case Keyboard.D:
				session.cycleSelectedLevel(1);
			case Keyboard.Q:
				session.cycleSelectedDoor(-1);
			case Keyboard.E:
				session.cycleSelectedDoor(1);
			case Keyboard.ENTER:
				session.queueSelectedLevel();
			case Keyboard.B:
				session.changeLevel("bonus");
			case Keyboard.F:
				session.changeLevel("finish");
			case Keyboard.R:
				session.changeLevel("Respawn");
			case Keyboard.M:
				session.changeLevel("MapScreen");
			case Keyboard.L:
				session.changeLevel("LevelSelect");
			case Keyboard.G:
				context.cycleLanguage(1);
			case Keyboard.X:
				context.toggleFullscreen();
			case Keyboard.O:
				context.toggleOneHanded();
			case Keyboard.ESCAPE:
				session.resumeLoadedView();
			default:
				return;
		}

		refresh();
	}

	private function refresh():Void {
		sceneController.refresh();
	}
}
