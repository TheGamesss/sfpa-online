package sfpa.core;

class World4Progress {
	public var cutieLeftWindow:Bool = false;
	public var cutieIsGone:Bool = false;
	public var cutieHasHeyLady:Bool = false;
	public var catIsDown:Bool = false;
	public var volcanoBlown:Bool = false;
	public var talkToIceCream:Bool = false;
	public var talkToAssist:Bool = false;
	public var iceCreamShop:Bool = false;
	public var defeatBoss1:Bool = false;
	public var defeatBigBad1:Bool = false;
	public var talkToMayor0:Bool = false;
	public var talkToCapt0:Bool = false;
	public var bentPipe0:Bool = false;
	public var bentPipe1:Bool = false;
	public var bentPipe2:Bool = false;
	public var bentPipe3:Bool = false;
	public var peekBoss2:Bool = false;
	public var messageOutline:Bool = true;
	public var messageSpinner:Bool = true;
	public var messageUpgrade:Bool = true;
	public var messageUpgradeAgain:Bool = true;
	public var healthLevel:Int = 0;
	public var powerLevel:Int = 0;
	public var threeLevel:Int = 0;
	public var fourLevel:Int = 0;
	public var fiveLevel:Int = 0;
	public var sixLevel:Int = 0;
	public var canBuzzSaw:Bool = false;
	public var canPokeDown:Bool = false;
	public var canRising:Bool = false;
	public var freePirateShip:Bool = false;
	public var canMapAround:Bool = false;
	public var volcanoUnlocked:Bool = false;
	public var centerUnlocked:Bool = false;
	public var gotPushed:Bool = false;
	public var realUnlocked:Bool = false;
	public var beatGame:Bool = false;
	public var defeatBoss2:Bool = false;

	public function new() {}

	public static function fromDynamic(value:Dynamic, reset:Bool = false):World4Progress {
		var progress = new World4Progress();
		if (value == null || reset) {
			progress.syncLegacyUpgradeFlags(true);
			return progress;
		}

		copyBool(value, "cutieLeftWindow", function(next) progress.cutieLeftWindow = next, progress.cutieLeftWindow);
		copyBool(value, "cutieIsGone", function(next) progress.cutieIsGone = next, progress.cutieIsGone);
		copyBool(value, "cutieHasHeyLady", function(next) progress.cutieHasHeyLady = next, progress.cutieHasHeyLady);
		copyBool(value, "catIsDown", function(next) progress.catIsDown = next, progress.catIsDown);
		copyBool(value, "volcanoBlown", function(next) progress.volcanoBlown = next, progress.volcanoBlown);
		copyBool(value, "talkToIceCream", function(next) progress.talkToIceCream = next, progress.talkToIceCream);
		copyBool(value, "talkToAssist", function(next) progress.talkToAssist = next, progress.talkToAssist);
		copyBool(value, "iceCreamShop", function(next) progress.iceCreamShop = next, progress.iceCreamShop);
		copyBool(value, "defeatBoss1", function(next) progress.defeatBoss1 = next, progress.defeatBoss1);
		copyBool(value, "defeatBigBad1", function(next) progress.defeatBigBad1 = next, progress.defeatBigBad1);
		copyBool(value, "talkToMayor0", function(next) progress.talkToMayor0 = next, progress.talkToMayor0);
		copyBool(value, "talkToCapt0", function(next) progress.talkToCapt0 = next, progress.talkToCapt0);
		copyBool(value, "bentPipe0", function(next) progress.bentPipe0 = next, progress.bentPipe0);
		copyBool(value, "bentPipe1", function(next) progress.bentPipe1 = next, progress.bentPipe1);
		copyBool(value, "bentPipe2", function(next) progress.bentPipe2 = next, progress.bentPipe2);
		copyBool(value, "bentPipe3", function(next) progress.bentPipe3 = next, progress.bentPipe3);
		copyBool(value, "peekBoss2", function(next) progress.peekBoss2 = next, progress.peekBoss2);
		copyBool(value, "messageOutline", function(next) progress.messageOutline = next, progress.messageOutline);
		copyBool(value, "messageSpinner", function(next) progress.messageSpinner = next, progress.messageSpinner);
		copyBool(value, "messageUpgrade", function(next) progress.messageUpgrade = next, progress.messageUpgrade);
		copyBool(value, "messageUpgradeAgain", function(next) progress.messageUpgradeAgain = next, progress.messageUpgradeAgain);
		copyInt(value, "healthLevel", function(next) progress.healthLevel = next, progress.healthLevel);
		copyInt(value, "powerLevel", function(next) progress.powerLevel = next, progress.powerLevel);
		copyInt(value, "threeLevel", function(next) progress.threeLevel = next, progress.threeLevel);
		copyInt(value, "fourLevel", function(next) progress.fourLevel = next, progress.fourLevel);
		copyInt(value, "fiveLevel", function(next) progress.fiveLevel = next, progress.fiveLevel);
		copyInt(value, "sixLevel", function(next) progress.sixLevel = next, progress.sixLevel);
		copyBool(value, "canBuzzSaw", function(next) progress.canBuzzSaw = next, progress.canBuzzSaw);
		copyBool(value, "canPokeDown", function(next) progress.canPokeDown = next, progress.canPokeDown);
		copyBool(value, "canRising", function(next) progress.canRising = next, progress.canRising);
		copyBool(value, "freePirateShip", function(next) progress.freePirateShip = next, progress.freePirateShip);
		copyBool(value, "canMapAround", function(next) progress.canMapAround = next, progress.canMapAround);
		copyBool(value, "volcanoUnlocked", function(next) progress.volcanoUnlocked = next, progress.volcanoUnlocked);
		copyBool(value, "centerUnlocked", function(next) progress.centerUnlocked = next, progress.centerUnlocked);
		copyBool(value, "gotPushed", function(next) progress.gotPushed = next, progress.gotPushed);
		copyBool(value, "realUnlocked", function(next) progress.realUnlocked = next, progress.realUnlocked);
		copyBool(value, "beatGame", function(next) progress.beatGame = next, progress.beatGame);
		copyBool(value, "defeatBoss2", function(next) progress.defeatBoss2 = next, progress.defeatBoss2);
		progress.syncLegacyUpgradeFlags(false);
		return progress;
	}

	public function syncLegacyUpgradeFlags(forceReset:Bool):Void {
		if (forceReset || !freePirateShip) {
			freePirateShip = canMapAround;
		}

		if (forceReset || !defeatBoss2) {
			defeatBoss2 = volcanoUnlocked;
		}
	}

	public function toDynamic():Dynamic {
		return {
			cutieLeftWindow: cutieLeftWindow,
			cutieIsGone: cutieIsGone,
			cutieHasHeyLady: cutieHasHeyLady,
			catIsDown: catIsDown,
			volcanoBlown: volcanoBlown,
			talkToIceCream: talkToIceCream,
			talkToAssist: talkToAssist,
			iceCreamShop: iceCreamShop,
			defeatBoss1: defeatBoss1,
			defeatBigBad1: defeatBigBad1,
			talkToMayor0: talkToMayor0,
			talkToCapt0: talkToCapt0,
			bentPipe0: bentPipe0,
			bentPipe1: bentPipe1,
			bentPipe2: bentPipe2,
			bentPipe3: bentPipe3,
			peekBoss2: peekBoss2,
			messageOutline: messageOutline,
			messageSpinner: messageSpinner,
			messageUpgrade: messageUpgrade,
			messageUpgradeAgain: messageUpgradeAgain,
			healthLevel: healthLevel,
			powerLevel: powerLevel,
			threeLevel: threeLevel,
			fourLevel: fourLevel,
			fiveLevel: fiveLevel,
			sixLevel: sixLevel,
			canBuzzSaw: canBuzzSaw,
			canPokeDown: canPokeDown,
			canRising: canRising,
			freePirateShip: freePirateShip,
			canMapAround: canMapAround,
			volcanoUnlocked: volcanoUnlocked,
			centerUnlocked: centerUnlocked,
			gotPushed: gotPushed,
			realUnlocked: realUnlocked,
			beatGame: beatGame,
			defeatBoss2: defeatBoss2
		};
	}

	private static function copyInt(source:Dynamic, field:String, assign:Int->Void, fallback:Int):Void {
		var value = Reflect.field(source, field);
		assign(value == null ? fallback : Std.int(value));
	}

	private static function copyBool(source:Dynamic, field:String, assign:Bool->Void, fallback:Bool):Void {
		var value = Reflect.field(source, field);
		if (value == null) {
			assign(fallback);
			return;
		}

		var normalized = Std.string(value).toLowerCase();
		assign(normalized == "true" || normalized == "1");
	}
}
