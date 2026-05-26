package sfpa.scene;

import sfpa.core.PortContext;
import sfpa.session.LevelSession;
import sfpa.ui.MenuButton;
import starling.text.TextField;

class RouteShellScene extends ShellSceneBase {
	private var routeText:TextField;
	private var detailText:TextField;
	private var browserText:TextField;
	private var settingsText:TextField;
	private var historyText:TextField;
	private var actionButtons:Array<MenuButton> = [];
	private var settingButtons:Array<MenuButton> = [];

	public function new(requestRefresh:Void->Void) {
		super(requestRefresh);

		addPanel(48, 170, 540, 520, 0x151515);
		addPanel(600, 170, 640, 520, 0x161616);

		addText(74, 188, 520, 28, "Route", 16, 0xF0B35A);
		routeText = addText(74, 214, 500, 110, "", 24, 0xF0F0F0);
		detailText = addText(74, 325, 500, 126, "", 15, 0xC8C8C8);

		addText(626, 188, 600, 28, "Level Browser", 16, 0xF0B35A);
		browserText = addText(626, 216, 580, 188, "", 18, 0xE0E0E0);
		settingsText = addText(626, 404, 580, 72, "", 16, 0xBDD0E8);
		historyText = addText(626, 624, 580, 62, "", 12, 0x989898);

		createActionButtons();
		createSettingButtons();
	}

	override public function refresh():Void {
		var context = PortContext.current;
		var session = context.levelSession;
		var counts = context.levelCatalog.topLevelCounts();
		var countLines = [];
		for (item in counts) {
			countLines.push(item.dir + ": " + item.count);
		}

		var previewEntries = session.selectionWindow(2);
		var previewNames = [];
		for (entry in previewEntries) {
			var marker = session.selectedEntry != null && session.selectedEntry.id == entry.id ? "[" + entry.id + "]" : entry.id;
			previewNames.push(marker);
		}

		routeText.text =
			session.levelLoaded + "\n" +
			session.dirLoaded + " | door " + session.doorLoaded;

		detailText.text =
			"View mode: " + session.viewMode + "\n" +
			"Pause state: " + session.pauseStatus + "\n" +
			"Pending route: " + ShellSceneBase.formatRoute(session.dirIt, session.loadIt, session.doorIt) + "\n" +
			"Active asset: " + ShellSceneBase.formatTarget(session.activeTarget, session.dirLoaded, session.levelLoaded) + "\n" +
			"Last full level: " + session.lastFullLevel + "\n" +
			"Catalog groups: " + countLines.join(", ");

		settingsText.text =
			"Settings\n" +
			"language=" + context.settings.language +
			" | fullscreen=" + context.settings.fullscreen +
			" | oneHanded=" + context.settings.oneHanded + "\n" +
			"lives=" + context.settings.lives +
			" | squiggles=" + context.settings.squiggles +
			" | role=" + context.settings.role;

		browserText.text =
			"Selected route\n" +
			session.selectedDir + " / " + (session.selectedEntry == null ? "none" : session.selectedEntry.id) + " / door " + session.selectedDoor + "\n\n" +
			"Visible window\n" + ShellSceneBase.formatNearby(previewNames) + "\n\n" +
			"Browser controls\nW/S directory, A/D level, Q/E door, Enter load";

		historyText.text =
			"Recent transitions:\n" + session.historySnapshot(4).join("\n");

		updateButtonContent(context, session);
	}

	private function createActionButtons():Void {
		var specs = [
			{x: 74.0, y: 470.0, color: 0xF0B35A, action: function() PortContext.current.levelSession.queueSelectedLevel()},
			{x: 328.0, y: 470.0, color: 0xD57647, action: function() PortContext.current.levelSession.changeLevel("bonus")},
			{x: 74.0, y: 586.0, color: 0x7DB4F2, action: function() PortContext.current.levelSession.changeLevel("finish")},
			{x: 328.0, y: 586.0, color: 0x7F9A52, action: function() PortContext.current.levelSession.changeLevel("Respawn")}
		];

		for (spec in specs) {
			var action = spec.action;
			var button = addButton(spec.x, spec.y, 236, 98, spec.color, function() {
				action();
				requestRefresh();
			});
			actionButtons.push(button);
		}
	}

	private function createSettingButtons():Void {
		var specs = [
			{x: 626.0, y: 482.0, width: 180.0, color: 0xE18F4A, action: function() PortContext.current.cycleLanguage(1)},
			{x: 822.0, y: 482.0, width: 180.0, color: 0x5E8AE3, action: function() PortContext.current.toggleFullscreen()},
			{x: 1018.0, y: 482.0, width: 180.0, color: 0x8FCB75, action: function() PortContext.current.toggleOneHanded()},
			{x: 626.0, y: 548.0, width: 278.0, color: 0xB57BE5, action: function() PortContext.current.levelSession.changeLevel("MapScreen")},
			{x: 920.0, y: 548.0, width: 278.0, color: 0x808080, action: function() PortContext.current.levelSession.resumeLoadedView()}
		];

		for (spec in specs) {
			var action = spec.action;
			var button = addButton(spec.x, spec.y, spec.width, 64, spec.color, function() {
				action();
				requestRefresh();
			});
			settingButtons.push(button);
		}
	}

	private function updateButtonContent(context:PortContext, session:LevelSession):Void {
		actionButtons[0].setContent("Enter", "Load Selected", session.selectedDir + " / " + (session.selectedEntry == null ? "none" : session.selectedEntry.id) + " / door " + session.selectedDoor);
		actionButtons[1].setContent("B", "Bonus", "From " + session.levelLoaded + " -> Bonus transition");
		actionButtons[2].setContent("F", "Finish / Return", "Current branch: " + session.dirLoaded + " -> special finish logic");
		actionButtons[3].setContent("R", "Respawn", "Respawn mode for " + session.levelLoaded);

		settingButtons[0].setContent("G", "Language", context.settings.language);
		settingButtons[1].setContent("X", "Fullscreen", context.settings.fullscreen ? "enabled" : "disabled");
		settingButtons[2].setContent("O", "One-Handed", context.settings.oneHanded ? "enabled" : "disabled");
		settingButtons[3].setContent("M / L", "Map / Level Select", "Map=" + (session.viewMode == LevelSession.VIEW_MAP) + ", levelSelect=" + (session.viewMode == LevelSession.VIEW_LEVEL_SELECT));
		settingButtons[4].setContent("Esc", "Resume View", "Return to " + session.levelLoaded);
	}
}
