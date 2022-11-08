package display;

import flixel.FlxG;
// import flixel.FlxSubState;
import flixel.text.FlxText;
import openfl.Assets;

using StringTools;

class FPSState extends MainCode
{
    public static var fpsState:Bool = false;

	var fps:Int = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));
	var fpsText:FlxText;

    override function create()
    {
        fpsState = true;

        fpsText = new FlxText(0, 0, 0, "FPS Cap: " + Std.string(fps), 20);
        fpsText.screenCenter();
        add(fpsText);

        super.create();
    }

    override function update(elapsed:Float){
        super.update(elapsed);

        fpsText.text = "FPS Cap: " + Std.string(fps);

        var back = FlxG.keys.justPressed.ESCAPE;
        var left = FlxG.keys.justPressed.LEFT;
        var right = FlxG.keys.justPressed.RIGHT;

        if (FlxG.keys.justPressed.ESCAPE){
            // closeSubState();
            FlxG.switchState(new OptionsState());
            sys.io.File.saveContent(Paths.txt('fps'), Std.string(fps));
            FlxG.updateFramerate = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));
            FlxG.drawFramerate = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));

            fpsState = false;
        }

        if (left){
            if (fps >= 60){
                fps -= 10;
                sys.io.File.saveContent(Paths.txt('fps'), Std.string(fps));
                FlxG.updateFramerate = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));
                FlxG.drawFramerate = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));     
            }       
        }

        if (right){
            if (fps <= 230){
                fps += 10;
                sys.io.File.saveContent(Paths.txt('fps'), Std.string(fps));
                FlxG.updateFramerate = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));
                FlxG.drawFramerate = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));    
            }        
        }
    }
}