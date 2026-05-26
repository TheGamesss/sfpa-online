package sfpa.core;

class LocalSettings {
	public static final AVAILABLE_LANGUAGES = ["English", "Spanish", "French", "Italian", "Portuguese", "German", "Russian"];

	public var gamerId:String = "guest";
	public var W1RProgress:Int = 0;
	public var W1RContProg:Int = 0;
	public var squiggles:Int = 0;
	public var lives:Int = 3;
	public var pantsN:Int = 0;
	public var hatN:Int = 0;
	public var patternN:Int = 0;
	public var colorN:Int = 0;
	public var sfxVol:Float = 1;
	public var musicVol:Float = 1;
	public var language:String = "English";
	public var fullscreen:Bool = true;
	public var hasPantsString:String = "";
	public var hasHatsString:String = "";
	public var hasPatternsString:String = "";
	public var hasPen:Bool = false;
	public var hasShoot:Bool = false;
	public var hasZip:Bool = false;
	public var updatedNumber:Int = 1;
	public var role:String = "guest";
	public var oneHanded:Bool = false;

	public function new() {}

	public static function fromDynamic(value:Dynamic, member:String, reset:Bool = false):LocalSettings {
		var settings = new LocalSettings();
		settings.gamerId = member;

		if (value == null || reset) {
			return settings;
		}

		copyString(value, "gamerId", function(next) settings.gamerId = next, settings.gamerId);
		copyInt(value, "W1RProgress", function(next) settings.W1RProgress = next, settings.W1RProgress);
		copyInt(value, "W1RContProg", function(next) settings.W1RContProg = next, settings.W1RContProg);
		copyInt(value, "squiggles", function(next) settings.squiggles = next, settings.squiggles);
		copyInt(value, "lives", function(next) settings.lives = next, settings.lives);
		copyInt(value, "pantsN", function(next) settings.pantsN = next, settings.pantsN);
		copyInt(value, "hatN", function(next) settings.hatN = next, settings.hatN);
		copyInt(value, "patternN", function(next) settings.patternN = next, settings.patternN);
		copyInt(value, "colorN", function(next) settings.colorN = next, settings.colorN);
		copyFloat(value, "sfxVol", function(next) settings.sfxVol = next, settings.sfxVol);
		copyFloat(value, "musicVol", function(next) settings.musicVol = next, settings.musicVol);
		copyString(value, "language", function(next) settings.language = next, settings.language);
		copyBool(value, "fullscreen", function(next) settings.fullscreen = next, settings.fullscreen);
		copyString(value, "hasPantsString", function(next) settings.hasPantsString = next, settings.hasPantsString);
		copyString(value, "hasHatsString", function(next) settings.hasHatsString = next, settings.hasHatsString);
		copyString(value, "hasPatternsString", function(next) settings.hasPatternsString = next, settings.hasPatternsString);
		copyBool(value, "hasPen", function(next) settings.hasPen = next, settings.hasPen);
		copyBool(value, "hasShoot", function(next) settings.hasShoot = next, settings.hasShoot);
		copyBool(value, "hasZip", function(next) settings.hasZip = next, settings.hasZip);
		copyInt(value, "updatedNumber", function(next) settings.updatedNumber = next, settings.updatedNumber);
		copyString(value, "role", function(next) settings.role = next, settings.role);
		copyBool(value, "oneHanded", function(next) settings.oneHanded = next, settings.oneHanded);

		settings.gamerId = member;
		settings.sanitize();
		return settings;
	}

	public function sanitize():Void {
		if (lives < 0) {
			lives = 3;
		}

		if (pantsN > 3 && charAtOrEmpty(hasPantsString, pantsN - 4) != "y") {
			pantsN = 0;
		}

		if (hatN > 0 && charAtOrEmpty(hasHatsString, hatN - 1) != "y") {
			hatN = 0;
		}

		if (patternN > 0 && charAtOrEmpty(hasPatternsString, patternN - 1) != "y") {
			pantsN = 0;
			patternN = 0;
		}

		if (colorN > 4 && charAtOrEmpty(hasPantsString, colorN - 5) != "y") {
			colorN = 0;
		}
	}

	public function cycleLanguage(step:Int = 1):Void {
		var currentIndex = AVAILABLE_LANGUAGES.indexOf(language);
		if (currentIndex == -1) {
			currentIndex = 0;
		}

		var nextIndex = wrapIndex(currentIndex + step, AVAILABLE_LANGUAGES.length);
		language = AVAILABLE_LANGUAGES[nextIndex];
	}

	public function toggleFullscreen():Void {
		fullscreen = !fullscreen;
	}

	public function toggleOneHanded():Void {
		oneHanded = !oneHanded;
	}

	public function toDynamic():Dynamic {
		return {
			gamerId: gamerId,
			W1RProgress: W1RProgress,
			W1RContProg: W1RContProg,
			squiggles: squiggles,
			lives: lives,
			pantsN: pantsN,
			hatN: hatN,
			patternN: patternN,
			colorN: colorN,
			sfxVol: sfxVol,
			musicVol: musicVol,
			language: language,
			fullscreen: fullscreen,
			hasPantsString: hasPantsString,
			hasHatsString: hasHatsString,
			hasPatternsString: hasPatternsString,
			hasPen: hasPen,
			hasShoot: hasShoot,
			hasZip: hasZip,
			updatedNumber: updatedNumber,
			role: role,
			oneHanded: oneHanded
		};
	}

	private static function charAtOrEmpty(value:String, index:Int):String {
		if (value == null || index < 0 || index >= value.length) {
			return "";
		}

		return value.charAt(index);
	}

	private static function copyString(source:Dynamic, field:String, assign:String->Void, fallback:String):Void {
		var value = Reflect.field(source, field);
		if (value != null) {
			assign(Std.string(value));
		} else {
			assign(fallback);
		}
	}

	private static function copyInt(source:Dynamic, field:String, assign:Int->Void, fallback:Int):Void {
		var value = Reflect.field(source, field);
		assign(value == null ? fallback : Std.int(value));
	}

	private static function copyFloat(source:Dynamic, field:String, assign:Float->Void, fallback:Float):Void {
		var value = Reflect.field(source, field);
		assign(value == null ? fallback : Std.parseFloat(Std.string(value)));
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

	private static function wrapIndex(value:Int, length:Int):Int {
		var wrapped = value % length;
		return wrapped < 0 ? wrapped + length : wrapped;
	}
}
