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

/*		if (FPSState.fpsState == true) {
			textHint.text = "Press Left or Right to change | Press Back to return options";
		} else if (TitleMenu.titleMenu == true) {
			textHint.text = "Press Up or Down to change | Press Enter to select";
		} else if (TitleMenu.titleMenu == false) {
			textHint.text = "";
		} else if (PlayState.playState == true) {
			textHint.text = "";
		} else {
			textHint.text = "";
		}*/

		if (FlxG.keys.justPressed.F) {
			FlxG.fullscreen = !FlxG.fullscreen;
			FlxG.save.data.fullscreen = FlxG.fullscreen;
		}
	}
}
