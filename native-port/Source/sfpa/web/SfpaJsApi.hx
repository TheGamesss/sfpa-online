package sfpa.web;

import sfpa.achievements.Achievements;
import sfpa.core.PortContext;
import sfpa.storage.SaveStore;

#if js
import js.Browser;
#end

class SfpaJsApi {
	public static function bootstrap():Void {
		#if js
		var win:Dynamic = Browser.window;
		var api:Dynamic = {};

		api.isReady = function():Bool {
			return true;
		};

		api.snapshot = function():Dynamic {
			var context = PortContext.current;
			return {
				achievements: Achievements.debugSnapshot(),
				port: context == null ? null : context.snapshot()
			};
		};

		api.getBootState = function():Dynamic {
			var context = PortContext.current;
			return context == null ? null : context.boot.snapshot(context.bootTarget);
		};

		api.getSettings = function():Dynamic {
			var context = PortContext.current;
			return context == null ? null : context.settings.toDynamic();
		};

		api.getLevelCatalog = function():Dynamic {
			var context = PortContext.current;
			return context == null ? null : context.levelCatalog.snapshot();
		};

		api.getLevelSession = function():Dynamic {
			var context = PortContext.current;
			return context == null ? null : context.levelSession.snapshot();
		};

		api.clearSave = function():Void {
			SaveStore.clear();
		};

		api.setSink = function(callback:Dynamic):Void {
			untyped win.sfpaAchievementSink = callback;
		};

		untyped win.sfpaAchievementApi = api;
		#end
	}
}
