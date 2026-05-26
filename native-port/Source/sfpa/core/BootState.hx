package sfpa.core;

import sfpa.content.LevelCatalog;
import sfpa.content.LevelManifestEntry;
import sfpa.web.SiteBridge;

class BootState {
	public var loadIt:String = "Menus0-a";
	public var doorIt:Int = 1;
	public var dirIt:String = "World 4";
	public var levelStatus:String = "Normal";
	public var statusName:String = "nothing";
	public var worldPrefix:String = "_W4A";
	public var loadedFromUrl:Bool = false;
	public var source:String = "default";

	public function new() {}

	public static function fromEnvironment(site:SiteBridge, settings:LocalSettings):BootState {
		var boot = new BootState();

		var challenge = site.getParameter("challenge");
		if (challenge != null && challenge != "") {
			boot.levelStatus = challenge;
			boot.statusName = challenge;
			boot.source = "query:challenge";
		}

		var loadFrom = site.getParameter("loadFrom");
		var levelTo = site.getParameter("levelTo");
		var reportHref = site.reportHref();
		var levelParam = readEmbeddedParam(reportHref, "level");
		var doorParam = readEmbeddedParam(reportHref, "door");

		if (levelParam != null) {
			if (loadFrom == "W4") {
				boot.applyWorld4Shortcut(levelParam);
			} else if (loadFrom == "remix") {
				if (settings.role == "full" && levelParam.length > 0) {
					boot.loadIt = "Level" + levelParam.charAt(0);
					boot.dirIt = "World 1";
					boot.source = "query:remix-level";
				}
			} else {
				boot.loadedFromUrl = true;
				boot.loadIt = normalizeLegacyLevelName(levelParam);
				if (doorParam != null) {
					boot.doorIt = Std.parseInt(doorParam);
				}
				var explicitDir = site.getParameter("dir");
				if (explicitDir != null && explicitDir != "") {
					boot.dirIt = explicitDir;
				}
				boot.source = "query:level";
			}
		} else if (loadFrom == "remix") {
			boot.loadIt = levelTo == null || levelTo == "" ? "Menus0" : levelTo;
			boot.dirIt = "World 1";
			boot.source = "query:remix";
		} else if (loadFrom == "W4") {
			boot.loadIt = "Trans1";
			boot.dirIt = "World 4";
			boot.source = "query:world4";
		}

		boot.worldPrefix = boot.dirIt == "World 1" ? "_W1R" : "_W4A";
		return boot;
	}

	public function findTarget(catalog:LevelCatalog):Null<LevelManifestEntry> {
		return catalog.findBootTarget(loadIt, dirIt);
	}

	public function snapshot(target:Null<LevelManifestEntry>):Dynamic {
		return {
			loadIt: loadIt,
			doorIt: doorIt,
			dirIt: dirIt,
			levelStatus: levelStatus,
			statusName: statusName,
			worldPrefix: worldPrefix,
			loadedFromUrl: loadedFromUrl,
			source: source,
			targetPath: target == null ? null : target.path
		};
	}

	private function applyWorld4Shortcut(levelParam:String):Void {
		var key = levelParam.length > 0 ? levelParam.charAt(0) : "";
		switch (key) {
			case "1":
				loadIt = "Level1";
				dirIt = "World 4";
				source = "query:world4-level1";
			case "d":
				loadIt = "Dared3";
				dirIt = "World 4";
				source = "query:world4-dared3";
			case "a":
				loadIt = "Arena1";
				dirIt = "World 4";
				source = "query:world4-arena1";
			case "s":
				loadIt = "Arena0";
				dirIt = "World 4";
				levelStatus = "Smash";
				source = "query:world4-smash";
			default:
				loadIt = "Trans1";
				dirIt = "World 4";
				source = "query:world4-fallback";
		}
	}

	private static function normalizeLegacyLevelName(value:String):String {
		if (value == null || value == "") {
			return "Menus0-a";
		}

		return value.length <= 8 ? value : value.substr(0, 8);
	}

	private static function readEmbeddedParam(url:String, key:String):Null<String> {
		if (url == null || url == "") {
			return null;
		}

		var token = key + "=";
		var index = url.indexOf(token);
		if (index == -1) {
			return null;
		}

		var start = index + token.length;
		var end = url.indexOf("&", start);
		if (end == -1) {
			end = url.length;
		}

		return StringTools.urlDecode(url.substring(start, end));
	}
}
