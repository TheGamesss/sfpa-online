package sfpa.scene;

import sfpa.core.PortContext;
import sfpa.ui.MenuButton;
import starling.text.TextField;

class LevelSelectShellScene extends ShellSceneBase {
	private var selectionText:TextField;
	private var browserText:TextField;
	private var controlsText:TextField;
	private var buttons:Array<MenuButton> = [];

	public function new(requestRefresh:Void->Void) {
		super(requestRefresh);

		addPanel(72, 188, 1136, 476, 0x141414);
		addText(96, 208, 420, 34, "Level Select", 20, 0xDFA4FF);
		selectionText = addText(96, 252, 420, 232, "", 18, 0xF1E6FF);
		browserText = addText(544, 252, 620, 190, "", 18, 0xE0E0E0);
		controlsText = addText(544, 468, 620, 64, "", 15, 0xF0B35A);

		createButtons();
	}

	override public function refresh():Void {
		var session = PortContext.current.levelSession;
		var previewEntries = session.selectionWindow(3);
		var previewNames = [];
		for (entry in previewEntries) {
			var marker = session.selectedEntry != null && session.selectedEntry.id == entry.id ? "[" + entry.id + "]" : entry.id;
			previewNames.push(marker);
		}

		selectionText.text =
			"Selected\n" +
			session.selectedDir + " / " + (session.selectedEntry == null ? "none" : session.selectedEntry.id) + " / door " + session.selectedDoor + "\n\n" +
			"Loaded\n" +
			ShellSceneBase.formatRoute(session.dirLoaded, session.levelLoaded, session.doorLoaded) + "\n\n" +
			"Last full level\n" + session.lastFullLevel;

		browserText.text =
			"Window\n" + ShellSceneBase.formatNearby(previewNames) + "\n\n" +
			"Controls\n" +
			"W/S directory\n" +
			"A/D level\n" +
			"Q/E door\n" +
			"Enter load selected route";

		controlsText.text =
			"Shortcuts: Enter load, M map mode, Esc resume route";

		buttons[0].setContent("Enter", "Load Selected", "Commit the highlighted route as the active route.");
		buttons[1].setContent("M", "Map Mode", "Switch to the map-style route view.");
		buttons[2].setContent("Esc", "Resume Route", "Return to the loaded route scene.");
	}

	private function createButtons():Void {
		var specs = [
			{x: 544.0, y: 560.0, width: 200.0, color: 0xF0B35A, action: function() { PortContext.current.levelSession.queueSelectedLevel(); PortContext.current.levelSession.resumeLoadedView(); }},
			{x: 772.0, y: 560.0, width: 180.0, color: 0xB57BE5, action: function() PortContext.current.levelSession.changeLevel("MapScreen")},
			{x: 980.0, y: 560.0, width: 184.0, color: 0x808080, action: function() PortContext.current.levelSession.resumeLoadedView()}
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
