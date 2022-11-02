package;

import flixel.util.FlxColor;
import flixel.FlxState;
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

class TitleMenu extends FlxState
{
    var text:FlxText;
    var pressEnter:FlxText;
    var sine:Float = 0;
    var when_Intro:Bool = true;

    override function create():Void 
    {
        pressEnter = new FlxText(0, 622, 0, "Press Enter to play", 22);
        pressEnter.alignment = CENTER;
        pressEnter.alpha = 0;
        pressEnter.screenCenter(FlxAxes.X);
        add(pressEnter);

        if (FlxG.keys.justPressed.ENTER){
            pressEnter_Game();
        }else{
            introGame();
        }

        super.create();    
    }

    override function update(elapsed:Float) 
    {
        sine += 180 * elapsed;
        pressEnter.alpha = 1 - Math.sin((Math.PI * sine) / 180);
    }

    function introGame(){
        //Intro Game
    }

    function pressEnter_Game() {
    }
}