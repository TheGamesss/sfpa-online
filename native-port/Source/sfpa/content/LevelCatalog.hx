package sfpa.content;

import haxe.Json;
import haxe.ds.StringMap;
import openfl.Assets;

class LevelCatalog {
	public static inline var MANIFEST_PATH = "assets/data/level-manifest.json";
	private static final PREFERRED_DIR_ORDER = ["World 4", "World 1", "Arcade", "Extra", "Custom"];

	public final entries:Array<LevelManifestEntry>;
	private final byTopLevel:StringMap<Array<LevelManifestEntry>>;

	public function new(entries:Array<LevelManifestEntry>) {
		this.entries = entries;
		byTopLevel = new StringMap<Array<LevelManifestEntry>>();
		for (entry in entries) {
			if (!byTopLevel.exists(entry.topLevelDir)) {
				byTopLevel.set(entry.topLevelDir, []);
			}
			byTopLevel.get(entry.topLevelDir).push(entry);
		}
	}

	public static function loadDefault():LevelCatalog {
		try {
			var raw = Assets.getText(MANIFEST_PATH);
			if (raw == null || raw == "") {
				return new LevelCatalog([]);
			}

			var decoded:Array<Dynamic> = Json.parse(raw);
			var entries = [];
			for (item in decoded) {
				entries.push(LevelManifestEntry.fromDynamic(item));
			}

			return new LevelCatalog(entries);
		} catch (_:Dynamic) {
			return new LevelCatalog([]);
		}
	}

	public function totalCount():Int {
		return entries.length;
	}

	public function topLevelCounts():Array<{dir:String, count:Int}> {
		var counts = [];
		for (dir in topLevelDirs()) {
			counts.push({
				dir: dir,
				count: byTopLevel.get(dir).length
			});
		}
		return counts;
	}

	public function topLevelDirs():Array<String> {
		var dirs = [];
		for (dir in byTopLevel.keys()) {
			dirs.push(dir);
		}

		dirs.sort(compareDirs);
		return dirs;
	}

	public function listAllFor(topLevelDir:String):Array<LevelManifestEntry> {
		var matches = byTopLevel.get(topLevelDir);
		return matches == null ? [] : matches.copy();
	}

	public function listFor(topLevelDir:String, limit:Int = 8):Array<LevelManifestEntry> {
		var matches = byTopLevel.get(topLevelDir);
		if (matches == null) {
			return [];
		}

		return matches.slice(0, Std.int(Math.min(limit, matches.length)));
	}

	public function findBootTarget(loadIt:String, dirIt:String):Null<LevelManifestEntry> {
		var exact = byTopLevel.get(dirIt);
		if (exact != null) {
			for (entry in exact) {
				if (entry.id == loadIt) {
					return entry;
				}
			}
		}

		for (entry in entries) {
			if (entry.id == loadIt) {
				return entry;
			}
		}

		return null;
	}

	public function snapshot():Dynamic {
		var counts:Dynamic = {};
		for (item in topLevelCounts()) {
			Reflect.setField(counts, item.dir, item.count);
		}

		return {
			totalCount: totalCount(),
			countsByTopLevel: counts
		};
	}

	private static function compareDirs(a:String, b:String):Int {
		var aRank = PREFERRED_DIR_ORDER.indexOf(a);
		var bRank = PREFERRED_DIR_ORDER.indexOf(b);
		if (aRank == -1 && bRank == -1) {
			return Reflect.compare(a, b);
		}
		if (aRank == -1) {
			return 1;
		}
		if (bRank == -1) {
			return -1;
		}
		return Reflect.compare(aRank, bRank);
	}
}
