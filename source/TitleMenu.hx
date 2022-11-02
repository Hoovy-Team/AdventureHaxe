package;

import flixel.FlxState;
import flixel.FlxG;
import openfl.Assets;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import lime.app.Application;

using StringTools;

class TitleMenu extends FlxState
{
    var text:FlxText;
    var pressEnter:FlxText;
    var spriteTitle:FlxSprite;
    var versionText:FlxText;

    override function create() 
    {
        introGame();

        super.create();    
    }

    override function update(elapsed:Float) 
    {

    }

    function introGame(){
        // placeholder since there's no sprites
    }
}