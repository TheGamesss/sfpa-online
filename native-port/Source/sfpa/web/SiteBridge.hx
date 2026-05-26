package sfpa.web;

import haxe.ds.StringMap;

#if js
import js.Browser;
#end

class SiteBridge {
	public final locationHref:String;
	public final queryParams:StringMap<String>;
	private final callLog:Array<String> = [];

	public function new(locationHref:String, queryParams:StringMap<String>) {
		this.locationHref = locationHref;
		this.queryParams = queryParams;
	}

	public static function create():SiteBridge {
		#if js
		var href = Browser.window.location.href;
		var query = parseQuery(Browser.window.location.search);
		return new SiteBridge(href, query);
		#else
		return new SiteBridge("", new StringMap<String>());
		#end
	}

	public function getParameter(name:String):Null<String> {
		return queryParams.get(name);
	}

	public function reportHref():String {
		return locationHref;
	}

	public function openUrl(url:String):Void {
		callLog.push("openUrl:" + url);
		#if js
		Browser.window.open(url, "_blank");
		#end
	}

	public function resume():Void {
		callLog.push("resume");
	}

	public function disableGc():Void {
		callLog.push("DisableGC");
	}

	public function getLogoUrl():Null<String> {
		return getParameter("logoUrl");
	}

	public function snapshot():Dynamic {
		var params:Dynamic = {};
		for (key in queryParams.keys()) {
			Reflect.setField(params, key, queryParams.get(key));
		}

		return {
			locationHref: locationHref,
			queryParams: params,
			callLog: callLog.copy()
		};
	}

	private static function parseQuery(query:String):StringMap<String> {
		var params = new StringMap<String>();
		if (query == null || query == "" || query == "?") {
			return params;
		}

		var trimmed = StringTools.startsWith(query, "?") ? query.substr(1) : query;
		for (pair in trimmed.split("&")) {
			if (pair == "") {
				continue;
			}

			var pieces = pair.split("=");
			var key = StringTools.urlDecode(pieces[0]);
			var value = pieces.length > 1 ? StringTools.urlDecode(pieces.slice(1).join("=")) : "";
			params.set(key, value);
		}

		return params;
	}
}
