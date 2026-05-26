package sfpa.storage;

import haxe.Json;
import sfpa.core.LocalSettings;
import sfpa.core.World4Progress;

#if js
import js.Browser;
#end

typedef SaveSnapshot = {
	var settings:LocalSettings;
	var world4Progress:World4Progress;
}

class SaveStore {
	public static inline var STORAGE_KEY = "sfpa_native_port_state";

	public static function load(member:String, reset:Bool = false):SaveSnapshot {
		if (reset) {
			return fresh(member);
		}

		#if js
		var raw = Browser.window.localStorage.getItem(STORAGE_KEY);
		if (raw == null || raw == "") {
			return fresh(member);
		}

		try {
			var decoded:Dynamic = Json.parse(raw);
			return {
				settings: LocalSettings.fromDynamic(Reflect.field(decoded, "settings"), member),
				world4Progress: World4Progress.fromDynamic(Reflect.field(decoded, "world4Progress"))
			};
		} catch (_:Dynamic) {
			return fresh(member);
		}
		#else
		return fresh(member);
		#end
	}

	public static function save(settings:LocalSettings, world4Progress:World4Progress):Void {
		#if js
		var snapshot = {
			settings: settings.toDynamic(),
			world4Progress: world4Progress.toDynamic()
		};
		Browser.window.localStorage.setItem(STORAGE_KEY, Json.stringify(snapshot));
		#end
	}

	public static function clear():Void {
		#if js
		Browser.window.localStorage.removeItem(STORAGE_KEY);
		#end
	}

	private static function fresh(member:String):SaveSnapshot {
		return {
			settings: LocalSettings.fromDynamic(null, member, true),
			world4Progress: World4Progress.fromDynamic(null, true)
		};
	}
}
