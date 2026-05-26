package sfpa.content;

class LevelManifestEntry {
	public final id:String;
	public final topLevelDir:String;
	public final relativeDir:String;
	public final path:String;

	public function new(id:String, topLevelDir:String, relativeDir:String, path:String) {
		this.id = id;
		this.topLevelDir = topLevelDir;
		this.relativeDir = relativeDir;
		this.path = path;
	}

	public static function fromDynamic(value:Dynamic):LevelManifestEntry {
		return new LevelManifestEntry(
			Std.string(Reflect.field(value, "id")),
			Std.string(Reflect.field(value, "topLevelDir")),
			Std.string(Reflect.field(value, "relativeDir")),
			Std.string(Reflect.field(value, "path"))
		);
	}
}
