package;

import flixel.FlxState;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;

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
    var stopSelected:Bool = false;

    var tween:FlxTween;
    var titleText:FlxText;
    var sine:Float = 0;

    var textInfo:FlxText;

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

        titleText = new FlxText(0, 22, 0, "Adventure Haxe", 30);
        titleText.alignment = CENTER;
        titleText.alpha = 0;
        titleText.screenCenter(FlxAxes.X);
        add(titleText);

        #if html5
        textInfo = new FlxText(5, FlxG.height - 22, 0, '', 16);
		textInfo.scrollFactor.set();
		add(textInfo);
        #end
    }

    override function update(elapsed:Float) {
        sine += 180 * elapsed;

		titleText.alpha = 1 - Math.sin((Math.PI * sine) / 180);

        #if html5
        textInfo.text = "Antialiasing: " + FlxG.save.data.dis_antialiasing;
        #end

        if (FlxG.keys.justPressed.UP){
            if (stopSelected == true){}
            else {
                FlxG.sound.play(Paths.sound('select.ogg'));
                curSelected -= 1;
            }
        }

        if (FlxG.keys.justPressed.DOWN){
            if (stopSelected == true){}
            else {
                FlxG.sound.play(Paths.sound('select.ogg'));
                curSelected += 1;
            }
        }

        #if html5
        if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.RIGHT)
        {
            if (FlxG.save.data.dis_antialiasing == true)
            {
                FlxG.sound.play(Paths.sound('select.ogg'));
                FlxG.save.data.dis_antialiasing = false;
            }
            else
            {
                FlxG.sound.play(Paths.sound('select.ogg'));
                FlxG.save.data.dis_antialiasing = true;
            }
        }
        #end

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
            // menuSelect.kill();
            FlxG.sound.play(Paths.sound('enter.ogg'));
            FlxG.camera.flash(FlxColor.WHITE, 1);
            stopSelected = true;
            new FlxTimer().start(2, function(tmr:FlxTimer){
                switch(menuSelect[curSelected]){
                    case "Play":
                        // trace('test');
                        FlxG.switchState(new PlayState());
                    #if desktop
                    case "Options":
                        // FlxG.sound.play(Paths.sound('enter.ogg'));
                         //trace('options in progress');
                        FlxG.switchState(new OptionsState());
                    case "Quit":
                        FlxG.save.flush();
                        Sys.sleep(1);
                        Sys.exit(0);
                        trace("quit game");
                    #end
                }
            });
        }
    }
}