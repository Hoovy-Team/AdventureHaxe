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
	var sine:Float = 0;
	var titleText:FlxText;

	/*var titleString(get, never):String;

		function get_titleString():String
		{
			if (FPSState.fpsState == true)
				return "FPS Setting";
			else if (MainCode.showNow == true || MenuState.menuState == true){
				return "Adventure Haxe";
			}
			else {
				return "Adventure Haxe";
			}
		}

		var textHintString(get, never):String;

		function get_textHintString():String
		{
			if (FPSState.fpsState == true){
				return "Press Left or Right to change | Press Back to return options";
			}
			else if (TitleMenu.titleMenu == false){
				return "";
			}
			else if (TitleMenu.titleMenu == true){
				return "Press Up or Down to change | Press Enter to select";
			}
			else {
				return "Press Up or Down to change | Press Enter to select";
			}
	}*/
	override public function create() {
		super.create();

		titleText = new FlxText(0, 22, 0, '', 30);
		titleText.alignment = CENTER;
		titleText.alpha = 0;
		titleText.screenCenter(FlxAxes.X);
		add(titleText);

		textHint = new FlxText(5, FlxG.height - 18, 0, '', 12);
		textHint.scrollFactor.set();
		add(textHint);
	}

	override public function update(elapsed:Float) {
		sine += 180 * elapsed;
		titleText.alpha = 1 - Math.sin((Math.PI * sine) / 180);

		super.update(elapsed);

		if (FPSState.fpsState == true) {
			titleText.text = "FPS Setting";
		} else if (MainCode.showNow == true) {
			titleText.text = "Adventure Haxe";
		} else if (MenuState.menuState == true) {
			titleText.text = "Adventure Haxe";
		} else {
			titleText.text = "Adventure Haxe";
		}

		if (FPSState.fpsState == true) {
			textHint.text = "Press Left or Right to change | Press Back to return options";
		} else if (TitleMenu.titleMenu == true) {
			textHint.text = "Press Up or Down to change | Press Enter to select";
		} else if (TitleMenu.titleMenu == false) {
			textHint.text = "";
		} else {
			textHint.text = "Press Up or Down to change | Press Enter to select";
		}

		#if desktop
		if (FlxG.keys.justPressed.F) {
			FlxG.fullscreen = !FlxG.fullscreen;
			FlxG.save.data.fullscreen = FlxG.fullscreen;
		}
		#end
	}
}
