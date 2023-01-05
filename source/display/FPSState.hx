package display;

import flixel.FlxG;
// import flixel.FlxSubState;
import flixel.text.FlxText;
import openfl.Assets;

using StringTools;

class FPSState extends MainCode
{
    public static var fpsState:Bool = false;

    var fpsText:FlxText;

    var recommendText:FlxText;

    override function create()
    {
        fpsState = true;

        fpsText = new FlxText(0, 0, 0, "FPS Cap: " + FlxG.save.data.fpsG, 20);
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

        fpsText.text = "FPS Cap: " + FlxG.save.data.fpsG;

        var back = FlxG.keys.justPressed.ESCAPE;
        var left = FlxG.keys.justPressed.LEFT;
        var right = FlxG.keys.justPressed.RIGHT;

        if (FlxG.keys.justPressed.ESCAPE){
            // closeSubState();
            FlxG.switchState(new OptionsState());
            fpsState = false;
        }

        if (left){
            if (FlxG.save.data.fpsG >= 60){
                FlxG.sound.play(Paths.sound('select.ogg'));
		FlxG.save.data.fpsG -= 10;
            }       
        }

        if (right){
            if (FlxG.save.data.fpsG <= 240){
                FlxG.sound.play(Paths.sound('select.ogg'));
		FlxG.save.data.fpsG += 10;
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

    // make some objects here null to help garbage collection
    override function destroy() {
        super.destroy();

        fpsText = null;
    }    
}
