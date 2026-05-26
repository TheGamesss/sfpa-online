package sfpa.achievements;

import haxe.ds.StringMap;

#if js
import js.Browser;
#end

class WebAchievementBridge implements AchievementBridge {
	private final unlocked = new StringMap<Bool>();
	private final stats = new StringMap<Int>();

	public function new() {
		publishState();
	}

	public function unlockAchievement(id:String):Void {
		if (unlocked.exists(id)) {
			return;
		}

		unlocked.set(id, true);
		emit("achievementUnlocked", {id: id});
	}

	public function submitStat(name:String, value:Int):Void {
		stats.set(name, value);
		emit("statUpdated", {name: name, value: value});
	}

	public function snapshot():Dynamic {
		var unlockedList = [];
		for (id in unlocked.keys()) {
			unlockedList.push(id);
		}

		var statObject:Dynamic = {};
		for (name in stats.keys()) {
			Reflect.setField(statObject, name, stats.get(name));
		}

		return {
			unlocked: unlockedList,
			stats: statObject
		};
	}

	private function emit(eventName:String, payload:Dynamic):Void {
		#if js
		var win:Dynamic = Browser.window;
		var sink:Dynamic = Reflect.field(win, "sfpaAchievementSink");
		publishState();
		if (sink != null && Reflect.isFunction(sink)) {
			Reflect.callMethod(win, sink, [eventName, payload, snapshot()]);
		}
		#end
	}

	private function publishState():Void {
		#if js
		var win:Dynamic = Browser.window;
		untyped win.sfpaAchievementState = snapshot();
		untyped win.sfpaAchievementBridgeReady = true;
		#end
	}
}
