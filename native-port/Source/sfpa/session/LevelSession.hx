package sfpa.session;

import sfpa.content.LevelCatalog;
import sfpa.content.LevelManifestEntry;
import sfpa.core.BootState;

class LevelSession {
	public static inline var VIEW_LEVEL = "Level";
	public static inline var VIEW_LOADING = "Loading";
	public static inline var VIEW_LEVEL_SELECT = "LevelSelect";
	public static inline var VIEW_MAP = "Map";
	public static inline var VIEW_RESPAWN = "Respawn";
	public static inline var VIEW_TURTLE_WARP = "TurtleWarp";

	public var loadIt(default, null):String;
	public var doorIt(default, null):Int;
	public var dirIt(default, null):String;
	public var levelLoaded(default, null):String;
	public var doorLoaded(default, null):Int;
	public var dirLoaded(default, null):String;
	public var lastFullLevel(default, null):String = "nothing";
	public var levelStatus(default, null):String;
	public var statusName(default, null):String;
	public var worldPrefix(default, null):String;
	public var pauseStatus(default, null):String = "nothing";
	public var viewMode(default, null):String = VIEW_LEVEL;
	public var activeTarget(default, null):Null<LevelManifestEntry>;
	public var selectedDir(default, null):String;
	public var selectedDoor(default, null):Int;
	public var selectedEntry(default, null):Null<LevelManifestEntry>;

	private final catalog:LevelCatalog;
	private final history:Array<String> = [];

	public function new(boot:BootState, catalog:LevelCatalog) {
		this.catalog = catalog;
		levelStatus = boot.levelStatus;
		statusName = boot.statusName;
		worldPrefix = boot.worldPrefix;
		levelLoaded = "nothing";
		doorLoaded = -1;
		dirLoaded = boot.dirIt;
		selectedDir = boot.dirIt;
		selectedDoor = clampDoor(boot.doorIt);
		selectedEntry = catalog.findBootTarget(boot.loadIt, boot.dirIt);
		if (selectedEntry == null) {
			selectedEntry = firstEntryFor(selectedDir);
		}

		record("boot request " + formatRoute(boot.dirIt, boot.loadIt, boot.doorIt));
		startLoad(boot.loadIt, boot.dirIt, boot.doorIt);
		commitLoad();
	}

	public function cycleSelectedDir(step:Int):Void {
		var dirs = catalog.topLevelDirs();
		if (dirs.length == 0) {
			return;
		}

		var current = dirs.indexOf(selectedDir);
		if (current == -1) {
			current = 0;
		}

		var next = wrapIndex(current + step, dirs.length);
		selectedDir = dirs[next];
		alignSelectedEntry(loadIt);
		record("select dir " + selectedDir + " -> " + selectedLabel());
	}

	public function cycleSelectedLevel(step:Int):Void {
		var entries = catalog.listAllFor(selectedDir);
		if (entries.length == 0) {
			selectedEntry = null;
			record("select level none in " + selectedDir);
			return;
		}

		var current = selectedIndex(entries);
		if (current == -1) {
			current = 0;
		}

		selectedEntry = entries[wrapIndex(current + step, entries.length)];
		record("select level " + selectedLabel());
	}

	public function cycleSelectedDoor(step:Int):Void {
		selectedDoor = clampDoor(selectedDoor + step);
		record("select door " + selectedDoor);
	}

	public function queueSelectedLevel():Void {
		if (selectedEntry == null) {
			record("queue skipped: no selection");
			return;
		}

		startLoad(selectedEntry.id, selectedDir, selectedDoor);
		commitLoad();
	}

	public function changeLevel(load:String):Void {
		switch (load) {
			case "LevelSelect":
				viewMode = VIEW_LEVEL_SELECT;
				pauseStatus = VIEW_LEVEL_SELECT;
				record("changeLevel LevelSelect");
			case "MapScreen":
				viewMode = VIEW_MAP;
				pauseStatus = VIEW_MAP;
				record("changeLevel MapScreen");
			case "Respawn":
				viewMode = VIEW_RESPAWN;
				pauseStatus = VIEW_RESPAWN;
				record("changeLevel Respawn on " + levelLoaded);
			case "TurtleWarp":
				viewMode = VIEW_TURTLE_WARP;
				pauseStatus = VIEW_TURTLE_WARP;
				record("changeLevel TurtleWarp");
			default:
				var nextDir = dirLoaded == "nothing" ? dirIt : dirLoaded;
				var nextDoor = selectedDoor;
				var nextLoad = load;

				if (load == "bonus") {
					nextDoor = 0;
					nextLoad = "Bonus" + suffixAfterPrefix(levelLoaded, 5);
				} else if (load == "return" || load == "finish") {
					if (nextDir == "Extra") {
						nextLoad = "Villa0-b";
						nextDir = "World 4";
						nextDoor = 1;
					} else if (nextDir == "World 4") {
						nextDoor = 20;
						nextLoad = "Level" + suffixAfterPrefix(levelLoaded, 5);
					} else {
						nextDoor = -1;
						nextLoad = lastFullLevel == "nothing" ? levelLoaded : lastFullLevel;
					}
				}

				startLoad(nextLoad, nextDir, nextDoor);
				commitLoad();
		}
	}

	public function resumeLoadedView():Void {
		viewMode = VIEW_LEVEL;
		pauseStatus = isChallengeWaiting() ? "Wait" : "nothing";
		record("resume view " + levelLoaded);
	}

	public function selectionWindow(radius:Int = 2):Array<LevelManifestEntry> {
		var entries = catalog.listAllFor(selectedDir);
		if (entries.length == 0) {
			return [];
		}

		var current = selectedIndex(entries);
		if (current == -1) {
			return entries.slice(0, Std.int(Math.min(entries.length, radius * 2 + 1)));
		}

		var start = Std.int(Math.max(0, current - radius));
		var end = Std.int(Math.min(entries.length, current + radius + 1));
		return entries.slice(start, end);
	}

	public function historySnapshot(limit:Int = 6):Array<String> {
		var start = Std.int(Math.max(0, history.length - limit));
		return history.slice(start, history.length);
	}

	public function snapshot():Dynamic {
		return {
			viewMode: viewMode,
			loadIt: loadIt,
			doorIt: doorIt,
			dirIt: dirIt,
			levelLoaded: levelLoaded,
			doorLoaded: doorLoaded,
			dirLoaded: dirLoaded,
			lastFullLevel: lastFullLevel,
			levelStatus: levelStatus,
			statusName: statusName,
			worldPrefix: worldPrefix,
			pauseStatus: pauseStatus,
			selectedDir: selectedDir,
			selectedDoor: selectedDoor,
			selectedLevel: selectedEntry == null ? null : selectedEntry.id,
			activeTargetPath: activeTarget == null ? null : activeTarget.path,
			history: historySnapshot()
		};
	}

	private function startLoad(level:String, dir:String, door:Int):Void {
		loadIt = level;
		dirIt = dir;
		doorIt = door;
		viewMode = VIEW_LOADING;
		worldPrefix = dirIt == "World 1" ? "_W1R" : "_W4A";
		updateLastFullLevel(level, dir);
		activeTarget = catalog.findBootTarget(loadIt, dirIt);
		selectedDir = dirIt;
		selectedDoor = clampDoor(door);
		alignSelectedEntry(level);
		record("startLoad " + formatRoute(dirIt, loadIt, doorIt));
	}

	private function commitLoad():Void {
		levelLoaded = loadIt;
		doorLoaded = doorIt;
		dirLoaded = dirIt;
		activeTarget = catalog.findBootTarget(levelLoaded, dirLoaded);
		viewMode = VIEW_LEVEL;
		pauseStatus = isChallengeWaiting() ? "Wait" : "nothing";
		selectedDir = dirLoaded;
		selectedDoor = clampDoor(doorLoaded);
		alignSelectedEntry(levelLoaded);
		record("loadLevel " + formatRoute(dirLoaded, levelLoaded, doorLoaded));
		doorIt = -1;
	}

	private function updateLastFullLevel(level:String, dir:String):Void {
		if (dir != "World 4") {
			if (StringTools.startsWith(level, "Level")) {
				lastFullLevel = level;
			}
			return;
		}

		if (StringTools.startsWith(level, "Level") || StringTools.startsWith(level, "Villa")) {
			lastFullLevel = level;
		}
	}

	private function alignSelectedEntry(preferredId:String):Void {
		var entries = catalog.listAllFor(selectedDir);
		if (entries.length == 0) {
			selectedEntry = null;
			return;
		}

		for (entry in entries) {
			if (entry.id == preferredId) {
				selectedEntry = entry;
				return;
			}
		}

		selectedEntry = entries[0];
	}

	private function firstEntryFor(dir:String):Null<LevelManifestEntry> {
		var entries = catalog.listAllFor(dir);
		return entries.length == 0 ? null : entries[0];
	}

	private function selectedIndex(entries:Array<LevelManifestEntry>):Int {
		if (selectedEntry == null) {
			return -1;
		}

		for (index in 0...entries.length) {
			if (entries[index].id == selectedEntry.id) {
				return index;
			}
		}

		return -1;
	}

	private function isChallengeWaiting():Bool {
		return levelStatus != "Normal" && levelStatus != "Race" && levelStatus != "Smash";
	}

	private function selectedLabel():String {
		return selectedEntry == null ? selectedDir + "/none" : selectedDir + "/" + selectedEntry.id;
	}

	private function record(message:String):Void {
		history.push(message);
		if (history.length > 18) {
			history.shift();
		}
	}

	private static function clampDoor(value:Int):Int {
		return Std.int(Math.max(0, Math.min(20, value)));
	}

	private static function wrapIndex(value:Int, length:Int):Int {
		var wrapped = value % length;
		return wrapped < 0 ? wrapped + length : wrapped;
	}

	private static function formatRoute(dir:String, load:String, door:Int):String {
		return dir + "/" + load + " door " + door;
	}

	private static function suffixAfterPrefix(value:String, prefixLength:Int):String {
		if (value == null || value.length <= prefixLength) {
			return "";
		}

		return value.substr(prefixLength, value.length - prefixLength);
	}
}
