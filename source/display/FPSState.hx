package display;

import flixel.FlxG;
// import flixel.FlxSubState;
import flixel.text.FlxText;
import openfl.Assets;

using StringTools;

class FPSState extends MainCode
{
    public static var fpsState:Bool = false;

	@:isVar var fps(get, set):Int = 60;
	var fpsText:FlxText;

    var recommendText:FlxText;

    inline function get_fps() {
        return Std.parseInt(SystemData.stringFile(Paths.txt('fps')));
    }

    inline function set_fps(v:Int){
        return v;
    }

    override function create()
    {
        fpsState = true;

        fpsText = new FlxText(0, 0, 0, "FPS Cap: " + Std.string(fps), 20);
        fpsText.color = 0xFFFFFF;
        fpsText.screenCenter();
        add(fpsText);

        recommendText = new FlxText(0, -60, 0, "Recommended", 20);
        recommendText.color = 0x00FA3E;
        recommendText.screenCenter(X);
        recommendText.visible = false;
        add(recommendText);

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
                FlxG.sound.play(Paths.sound('select.ogg'));
                fps -= 10;
                sys.io.File.saveContent(Paths.txt('fps'), Std.string(fps));
                FlxG.updateFramerate = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));
                FlxG.drawFramerate = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));     
            }       
        }

        if (right){
            if (fps <= 230){
                FlxG.sound.play(Paths.sound('select.ogg'));
                fps += 10;
                sys.io.File.saveContent(Paths.txt('fps'), Std.string(fps));
                FlxG.updateFramerate = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));
                FlxG.drawFramerate = Std.parseInt(SystemData.stringFile(Paths.txt('fps')));    
            }        
        }

        if (fps == 240){
            fpsText.color = 0x00FA3E;
        }else if (fps == 50){
            fpsText.color = 0xC8FF00;
        }else if (fps == 120){
            fpsText.color = 0x00FFAA;
        }else{
            fpsText.color = 0xFFFFFF;
        }

        if (fps == 120){
            recommendText.visible = true;
        }else{
            recommendText.visible = false;
        }
    }
}