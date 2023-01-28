package;

import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;

class WinnerState extends FlxState
{
    var text:FlxText;

    override function create()
    {
        super.create();

        text = new FlxText(0, 0, 0, "", 24);
        text.screenCenter();
        text.setFormat(FlxAssets.FONT_DEFAULT, 24, 0x5E5F32, CENTER);
        add(text);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    
        text.text = "!YOU WIN!\n\nIt just a alpha testing boss fight system\nIt will continue update\nto be a full version!\n\nPress ENTER to return menu state";

        if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.switchState(new MenuState());
        }
    }
}