package state;

import display.FPSState;
import flixel.util.FlxAxes;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;

using StringTools;

class MainCode extends FlxState {
	public static var showNow:Bool = true;

	var textHint:FlxText;

	override public function create() {
		super.create();

		textHint = new FlxText(5, FlxG.height - 18, 0, '', 12);
		textHint.scrollFactor.set();
		add(textHint);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		FlxG.save.data.fpsG = FlxG.updateFramerate;
		FlxG.save.data.fpsG = FlxG.drawFramerate;

		if (FlxG.keys.justPressed.F) {
			FlxG.fullscreen = !FlxG.fullscreen;
		}
	}
}
