package sfpa.scene;

import sfpa.core.PortContext;
import sfpa.ui.MenuButton;
import starling.text.TextField;

class RespawnShellScene extends ShellSceneBase {
	private var titleText:TextField;
	private var bodyText:TextField;
	private var buttons:Array<MenuButton> = [];

	public function new(requestRefresh:Void->Void) {
		super(requestRefresh);

		addPanel(220, 210, 840, 360, 0x181818);
		addText(256, 238, 768, 34, "Respawn", 22, 0xA4F3B2);
		titleText = addText(256, 292, 768, 48, "", 32, 0xF5F5F5);
		bodyText = addText(256, 360, 768, 96, "", 18, 0xDADADA);
		createButtons();
	}

	override public function refresh():Void {
		var session = PortContext.current.levelSession;
		titleText.text = session.levelLoaded;
		bodyText.text =
			"Respawn mode keeps the current route active while preserving the current session state.\n" +
			"Loaded route: " + ShellSceneBase.formatRoute(session.dirLoaded, session.levelLoaded, session.doorLoaded) + "\n" +
			"Selected route: " + session.selectedDir + " / " + (session.selectedEntry == null ? "none" : session.selectedEntry.id) + " / door " + session.selectedDoor;

		buttons[0].setContent("Esc", "Resume Route", "Return to the loaded route scene.");
		buttons[1].setContent("Enter", "Load Selected", "Respawn shell can still commit the selected route.");
	}

	private function createButtons():Void {
		var specs = [
			{x: 320.0, y: 474.0, width: 220.0, color: 0x808080, action: function() PortContext.current.levelSession.resumeLoadedView()},
			{x: 580.0, y: 474.0, width: 380.0, color: 0xF0B35A, action: function() { PortContext.current.levelSession.queueSelectedLevel(); PortContext.current.levelSession.resumeLoadedView(); }}
		];

		for (spec in specs) {
			var action = spec.action;
			var button = addButton(spec.x, spec.y, spec.width, 78, spec.color, function() {
				action();
				requestRefresh();
			});
			buttons.push(button);
		}
	}
}
