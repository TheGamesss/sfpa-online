package sfpa.scene;

import sfpa.core.PortContext;
import sfpa.ui.MenuButton;
import starling.display.Quad;
import starling.text.TextField;

class MapShellScene extends ShellSceneBase {
	private var summaryText:TextField;
	private var markerText:TextField;
	private var historyText:TextField;
	private var buttons:Array<MenuButton> = [];
	private var markerBars:Array<Quad> = [];

	public function new(requestRefresh:Void->Void) {
		super(requestRefresh);

		addPanel(72, 188, 1136, 476, 0x141414);
		addText(96, 208, 420, 34, "Map Mode", 20, 0x8FD0FF);
		summaryText = addText(96, 252, 420, 210, "", 18, 0xE8F0FF);

		var mapArea = addPanel(532, 222, 640, 274, 0x101010, 1);
		mapArea.color = 0x121A20;
		addText(560, 242, 584, 34, "Route Markers", 16, 0xF0B35A);
		markerText = addText(560, 448, 584, 34, "", 14, 0xB8D7F4);

		historyText = addText(96, 532, 520, 96, "", 13, 0x9CA3A9);

		for (index in 0...5) {
			var bar = new Quad(88, 22 + index * 14, 0x4A7CAB + index * 0x09110A);
			bar.x = 580 + index * 108;
			bar.y = 320 - index * 16;
			bar.alpha = 0.85;
			addChild(bar);
			markerBars.push(bar);
		}

		createButtons();
	}

	override public function refresh():Void {
		var context = PortContext.current;
		var session = context.levelSession;
		var previewEntries = session.selectionWindow(2);
		var previewNames = [];
		for (entry in previewEntries) {
			var marker = session.selectedEntry != null && session.selectedEntry.id == entry.id ? "[" + entry.id + "]" : entry.id;
			previewNames.push(marker);
		}

		summaryText.text =
			"Loaded route\n" +
			ShellSceneBase.formatRoute(session.dirLoaded, session.levelLoaded, session.doorLoaded) + "\n\n" +
			"Selected route\n" +
			session.selectedDir + " / " + (session.selectedEntry == null ? "none" : session.selectedEntry.id) + " / door " + session.selectedDoor + "\n\n" +
			"Settings\n" +
			"language=" + context.settings.language + " | oneHanded=" + context.settings.oneHanded;

		markerText.text =
			"Visible route window: " + ShellSceneBase.formatNearby(previewNames) + "\nAsset: " + ShellSceneBase.formatTarget(session.activeTarget, session.dirLoaded, session.levelLoaded);

		historyText.text =
			"Map history\n" + session.historySnapshot(5).join("\n");

		buttons[0].setContent("Enter", "Load Selected", "Jump from map mode into the selected route.");
		buttons[1].setContent("Esc", "Resume Route", "Return to the currently loaded route view.");
		buttons[2].setContent("L", "Level Select", "Switch from map mode to level-select mode.");
	}

	private function createButtons():Void {
		var specs = [
			{x: 640.0, y: 548.0, width: 180.0, color: 0xF0B35A, action: function() { PortContext.current.levelSession.queueSelectedLevel(); PortContext.current.levelSession.resumeLoadedView(); }},
			{x: 846.0, y: 548.0, width: 180.0, color: 0x808080, action: function() PortContext.current.levelSession.resumeLoadedView()},
			{x: 1052.0, y: 548.0, width: 120.0, color: 0xB57BE5, action: function() PortContext.current.levelSession.changeLevel("LevelSelect")}
		];

		for (spec in specs) {
			var action = spec.action;
			var button = addButton(spec.x, spec.y, spec.width, 72, spec.color, function() {
				action();
				requestRefresh();
			});
			buttons.push(button);
		}
	}
}
