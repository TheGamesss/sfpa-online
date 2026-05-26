package sfpa.achievements;

class NullAchievementBridge implements AchievementBridge {
	public function new() {}

	public function unlockAchievement(id:String):Void {}

	public function submitStat(name:String, value:Int):Void {}

	public function snapshot():Dynamic {
		return {
			unlocked: [],
			stats: {}
		};
	}
}
