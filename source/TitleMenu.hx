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
    static var songs_main_menu:Bool = false;

    static inline final mp3:String = ".mp3";
    static inline final ogg:String = ".ogg";

    public static var titleMenu:Bool = false;

    var text:FlxText;
    var pressEnter:FlxText;
    var sine:Float = 0;
    var titleText:FlxText;
    
    override function create():Void 
    {
	    SystemData.saveG();
	    
        pressEnter = new FlxText(0, 622, 0, "Press Enter to play", 22);
        pressEnter.alignment = CENTER;
        pressEnter.alpha = 0;
        pressEnter.screenCenter(FlxAxes.X);
        add(pressEnter);

        titleText = new FlxText(0, 22, 0, "Adventure Haxe", 30);
        titleText.alignment = CENTER;
        titleText.alpha = 0;
        titleText.screenCenter(FlxAxes.X);
        add(titleText);

        super.create();   
        
        // new FlxTimer().start(1, function(tmr:FlxTimer)
        // {
        playMusic();
        // });
    }

    inline function playMusic()
    {
		if (FlxG.sound.music == null) // don't restart the music if it's already playing
        {
            FlxG.sound.playMusic(Paths.music('Main_Menu$ogg'), 1, true);
        }
    }

    override function update(elapsed:Float) 
    {
        sine += 180 * elapsed;
        pressEnter.alpha = 1 - Math.sin((Math.PI * sine) / 180);
		titleText.alpha = 1 - Math.sin((Math.PI * sine) / 180);

        if (FlxG.keys.justPressed.ENTER){
            FlxG.camera.flash(FlxColor.WHITE, 1);
            pressEnter.kill();
            FlxG.sound.play(Paths.sound('enter$ogg'));
            titleMenu = true;
            new FlxTimer().start(2, function(tmr:FlxTimer){
                FlxG.switchState(new MenuState());
                trace('play game');
            });
        }
    }
}
