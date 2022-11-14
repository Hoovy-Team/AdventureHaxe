package;

import flixel.FlxState;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.FlxG;
import openfl.Assets;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxAxes;
// Game KeyBind
import flixel.input.FlxKeyManager;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKeyboard;

using StringTools;

class TitleMenu extends MainCode
{
    public static var titleMenu:Bool = false;

    var text:FlxText;
    var pressEnter:FlxText;
    var sineP:Float = 0;

    override function create():Void 
    {
        MainCode.showNow == true;

        pressEnter = new FlxText(0, 622, 0, "Press Enter to play", 22);
        pressEnter.alignment = CENTER;
        pressEnter.alpha = 0;
        pressEnter.screenCenter(FlxAxes.X);
        add(pressEnter);

        /*titleText = new FlxText(0, 22, 0, "Adventure Haxe", 30);
        titleText.alignment = CENTER;
        titleText.alpha = 0;
        titleText.screenCenter(FlxAxes.X);
        add(titleText);*/

        super.create();    
    }

    override function update(elapsed:Float) 
    {
		/*if (FlxG.sound.music.volume < 0.8)
        {
            FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
        }*/

        sineP += 180 * elapsed;
        pressEnter.alpha = 1 - Math.sin((Math.PI * sineP) / 180);

        if (FlxG.keys.justPressed.ENTER){
            FlxG.camera.flash(FlxColor.WHITE, 1);
            // pressEnter.kill();
            FlxG.sound.play(Paths.sound('enter.ogg'));
            titleMenu = true;
            new FlxTimer().start(2, function(tmr:FlxTimer){
                FlxG.switchState(new MenuState());
                trace('play game');
            });
        }
    }
}