package display;

import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end
import openfl.Lib;
import lime.app.Application;
import flixel.math.FlxMath;
import openfl.system.System;
import openfl.Memory;
import flixel.FlxG;

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/

/**
 * FPS class extension to display memory usage.
 * @author Kirill Poletaev
 */
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class FPS_MEMORY extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second, and memory usage
	**/
	public var currentFPS(default, null):Int;

	private var memPeak:Float = 0;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(inX:Float = 10.0, inY:Float = 10.0, inCol:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = true;
		mouseEnabled = true;
		defaultTextFormat = new TextFormat(Paths.font("vcr.ttf"), 12, inCol, true, false, false, "", "", LEFT, 5, 0, 1, 1);
		text = "FPS: ";

		cacheCount = 0;
		currentTime = 0;
		times = [];

		x = inX;
		y = inY;
		width = 800;
		height = 600;

		#if flash
		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end
	}

	// Event Handlers
	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);
		if (currentFPS > FlxG.save.data.fpsG){
			currentFPS = FlxG.save.data.fpsG;
		}

		var mem:Float = Math.round(System.totalMemory / 1024 / 1024 * 100) / 100;
		if (mem > memPeak)
			memPeak = mem;

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);

		if (currentCount != cacheCount && visible)
		{
			text = "FPS: " + currentFPS + "\nMemory: " + mem + " MB" + "\nVersion: " + Application.current.meta.get("version");

			#if (gl_stats && !disable_cffi && (!html5 || !canvas))
			text += "\ntotalDC: " + Context3DStats.totalDrawCalls();
			text += "\nstageDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE);
			text += "\nstage3DDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE3D);
			#end

			textColor = 0xFFFFFFFF;
			if (mem > 3000 || currentFPS <= currentFPS / 2)
			{
				textColor = 0xFFFF0000;
			}
		}

		cacheCount = currentCount;
	}
}
