package sfpa.achievements;

interface AchievementBridge {
	public function unlockAchievement(id:String):Void;
	public function submitStat(name:String, value:Int):Void;
	public function snapshot():Dynamic;
}
