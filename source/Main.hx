package;

import lime.app.Application;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxGame;
import openfl.display.Sprite;
import display.FPS_MEMORY;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import flixel.text.FlxText;
import lime.app.Application;

class Main extends Sprite
{
	var fwidth:Int = 0;
	var fheight:Int = 0;
	final fpsFrame:Int = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));
	// var state:Class<FlxState> = TitleMenu();
	var versionText:FlxText;

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		versionText = new FlxText(0,0,0,"Version: " + Application.current.meta.get("version"),12);
        add(versionText);

		super();
		addChild(new FlxGame(fwidth, fheight, TitleMenu, fpsFrame));
		addChild(new FPS_MEMORY(0, 0, 0xFFFFFF));
		
		#if desktop
		if (FlxG.save.data.fullscreen != null)
		{
			FlxG.fullscreen = FlxG.save.data.fullscreen;
		}
		#end
	}

	function add(versionText:FlxText):Void {}
}
