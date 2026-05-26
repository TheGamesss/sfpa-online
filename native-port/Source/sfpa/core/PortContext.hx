package sfpa.core;

import sfpa.content.LevelCatalog;
import sfpa.content.LevelManifestEntry;
import sfpa.session.LevelSession;
import sfpa.storage.SaveStore;
import sfpa.web.SiteBridge;

class PortContext {
	public static var current(default, null):PortContext;

	public final site:SiteBridge;
	public final settings:LocalSettings;
	public final world4Progress:World4Progress;
	public final boot:BootState;
	public final levelCatalog:LevelCatalog;
	public final bootTarget:Null<LevelManifestEntry>;
	public final levelSession:LevelSession;

	public function new(
		site:SiteBridge,
		settings:LocalSettings,
		world4Progress:World4Progress,
		boot:BootState,
		levelCatalog:LevelCatalog,
		bootTarget:Null<LevelManifestEntry>,
		levelSession:LevelSession
	) {
		this.site = site;
		this.settings = settings;
		this.world4Progress = world4Progress;
		this.boot = boot;
		this.levelCatalog = levelCatalog;
		this.bootTarget = bootTarget;
		this.levelSession = levelSession;
	}

	public static function initialize(member:String = "web-player"):PortContext {
		var site = SiteBridge.create();
		var save = SaveStore.load(member);
		save.settings.sanitize();
		save.world4Progress.syncLegacyUpgradeFlags(false);
		var levelCatalog = LevelCatalog.loadDefault();
		var boot = BootState.fromEnvironment(site, save.settings);
		var target = boot.findTarget(levelCatalog);
		var levelSession = new LevelSession(boot, levelCatalog);
		SaveStore.save(save.settings, save.world4Progress);

		current = new PortContext(site, save.settings, save.world4Progress, boot, levelCatalog, target, levelSession);
		return current;
	}

	public function snapshot():Dynamic {
		return {
			boot: boot.snapshot(bootTarget),
			settings: settings.toDynamic(),
			world4Progress: world4Progress.toDynamic(),
			levelCatalog: levelCatalog.snapshot(),
			levelSession: levelSession.snapshot(),
			site: site.snapshot()
		};
	}

	public function persist():Void {
		SaveStore.save(settings, world4Progress);
	}

	public function cycleLanguage(step:Int = 1):Void {
		settings.cycleLanguage(step);
		persist();
	}

	public function toggleFullscreen():Void {
		settings.toggleFullscreen();
		persist();
	}

	public function toggleOneHanded():Void {
		settings.toggleOneHanded();
		persist();
	}
}
