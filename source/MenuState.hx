package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using StringTools;

class MenuState extends MainCode
{
    var groupMenu:FlxTypedGroup<FlxText>;

	var menuSelect:Array<String> = [
        'Play', 
        #if desktop
        'Options',
        'Quit'
        #end
    ];
	var curSelected:Int = 0;

    var tween:FlxTween;

    override function create() {
        super.create();

        groupMenu = new FlxTypedGroup<FlxText>();
		add(groupMenu);

		for (i in 0...menuSelect.length)
		{
			var select:FlxText = new FlxText(20, 475 + (i * 50), 0, menuSelect[i], 32);
            select.screenCenter(X);
			select.ID = i;
			groupMenu.add(select);
            FlxTween.tween(select, {y: 475 + (i * 50)}, 1 + (i * 0.25), {
                ease: FlxEase.expoInOut,
                onComplete: function(flxTween:FlxTween)
                {
                    tween.cancel;
                }
            });
		}
    }

    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.UP){
            curSelected -= 1;
        }

        if (FlxG.keys.justPressed.DOWN){
            curSelected += 1;
        }

        if (curSelected < 0)
			curSelected = menuSelect.length - 1;

		if (curSelected >= menuSelect.length)
			curSelected = 0;

		groupMenu.forEach(function(txt:FlxText)
        {
            txt.color = FlxColor.WHITE;
    
            if (txt.ID == curSelected)
                txt.color = FlxColor.YELLOW;
        });

        if (FlxG.keys.justPressed.ENTER){
            switch(menuSelect[curSelected]){
                case "Play":
                    trace('test');
                #if desktop
                case "Options":
                    //trace('options in progress');
                    FlxG.switchState(new OptionsState());
                case "Quit":
                    FlxG.save.flush();
                    Sys.exit(0);
                #end
            }
        }
    }
}