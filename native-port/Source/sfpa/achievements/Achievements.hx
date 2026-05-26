package sfpa.achievements;

import haxe.ds.StringMap;

class Achievements {
	private static var bridge:AchievementBridge;
	private static var trackedTimers = new StringMap<Int>();
	private static var trackedCounts = new StringMap<Int>();

	public static function install(nextBridge:AchievementBridge):Void {
		bridge = nextBridge == null ? new NullAchievementBridge() : nextBridge;
	}

	public static function unlock(id:String):Void {
		currentBridge().unlockAchievement(id);
	}

	public static function SendScore(stat:String, value:Int):Void {
		currentBridge().submitStat(stat, value);
	}

	public static function track(id:String, ttlFrames:Int, max:Int, reset:Bool = false):Void {
		if (!trackedCounts.exists(id)) {
			trackedCounts.set(id, 1);
			trackedTimers.set(id, ttlFrames);
			return;
		}

		if (reset) {
			trackedTimers.set(id, ttlFrames);
		}

		var count = trackedCounts.get(id) + 1;
		trackedCounts.set(id, count);
		if (count == max) {
			unlock(id);
		}
	}

	public static function clearTracked(id:String):Void {
		trackedCounts.remove(id);
		trackedTimers.remove(id);
	}

	public static function counter():Void {
		var expired = [];
		for (id in trackedTimers.keys()) {
			var ttl = trackedTimers.get(id) - 1;
			if (ttl <= 0) {
				expired.push(id);
			} else {
				trackedTimers.set(id, ttl);
			}
		}

		for (id in expired) {
			clearTracked(id);
		}
	}

	public static function startKong():Void {}

	public static function KongButton():Void {}

	public static function debugSnapshot():Dynamic {
		return currentBridge().snapshot();
	}

	private static function currentBridge():AchievementBridge {
		if (bridge == null) {
			bridge = new NullAchievementBridge();
		}

		return bridge;
	}
}
