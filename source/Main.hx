package;

import lime.app.Application;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.display.FPS_MEMORY;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import flixel.text.FlxText;
import lime.app.Application;

class Main extends Sprite
{
	var fwidth:Int = 0;
	var fheight:Int = 0;
	var fpsFrame:Int = 60;
	// var state:Class<FlxState> = TitleMenu();
	var zoom:Float;
	var versionText:FlxText;

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		versionText = new FlxText(0,0,0,"Version: " + Application.current.meta.get("version"),12);
        add(versionText);

		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / fwidth;
			var ratioY:Float = stageHeight / fheight;
			zoom = Math.min(ratioX, ratioY);
			fwidth = Math.ceil(stageWidth / zoom);
			fheight = Math.ceil(stageHeight / zoom);
		}

		super();
		addChild(new FlxGame(fwidth, fheight, TitleMenu, fpsFrame));
		addChild(new FPS_MEMORY(10, 3, 0xFFFFFF));
	}

	function add(versionText:FlxText):Void {}
}
