package sfpa.ui;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.text.TextFormat;

class MenuButton extends Sprite {
	private final background:Quad;
	private final accent:Quad;
	private final shortcutText:TextField;
	private final titleText:TextField;
	private final subtitleText:TextField;
	private final onActivate:Void->Void;

	public function new(width:Float, height:Float, accentColor:UInt, onActivate:Void->Void) {
		super();
		this.onActivate = onActivate;
		useHandCursor = true;
		var compact = height < 88;
		var titleY = compact ? 22 : 34;
		var titleHeight = compact ? 28 : 44;
		var subtitleY = compact ? 42 : 82;
		var subtitleHeight = compact ? Std.int(Math.max(18, height - 46)) : Std.int(Math.max(18, height - 88));
		var titleSize = compact ? 18 : 24;
		var subtitleSize = compact ? 11 : 14;

		background = new Quad(width, height, 0x1B1B1B);
		background.alpha = 0.92;
		addChild(background);

		accent = new Quad(8, height, accentColor);
		addChild(accent);

		shortcutText = new TextField(Std.int(width - 28), 26, "", new TextFormat("Verdana", 12, 0xF5D49A));
		shortcutText.x = 18;
		shortcutText.y = compact ? 6 : 10;
		shortcutText.autoScale = true;
		shortcutText.touchable = false;
		addChild(shortcutText);

		titleText = new TextField(Std.int(width - 28), titleHeight, "", new TextFormat("Verdana", titleSize, 0xF4F4F4));
		titleText.x = 18;
		titleText.y = titleY;
		titleText.autoScale = true;
		titleText.touchable = false;
		addChild(titleText);

		subtitleText = new TextField(Std.int(width - 28), subtitleHeight, "", new TextFormat("Verdana", subtitleSize, 0xBDBDBD));
		subtitleText.x = 18;
		subtitleText.y = subtitleY;
		subtitleText.autoScale = true;
		subtitleText.touchable = false;
		addChild(subtitleText);

		addEventListener(TouchEvent.TOUCH, onTouch);
	}

	public function setContent(shortcut:String, title:String, subtitle:String):Void {
		shortcutText.text = shortcut;
		titleText.text = title;
		subtitleText.text = subtitle;
	}

	private function onTouch(event:TouchEvent):Void {
		var hover = event.getTouch(this, TouchPhase.HOVER);
		var began = event.getTouch(this, TouchPhase.BEGAN);
		var ended = event.getTouch(this, TouchPhase.ENDED);
		background.color = hover != null || began != null ? 0x242424 : 0x1B1B1B;
		background.alpha = hover != null || began != null ? 1 : 0.92;

		if (ended == null || onActivate == null) {
			return;
		}

		onActivate();
	}
}
