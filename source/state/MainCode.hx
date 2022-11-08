package state;

import display.FPSState;
import flixel.util.FlxAxes;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;

using StringTools;

class MainCode extends FlxState
{
    var textHint:FlxText;
    var sine:Float = 0;
    var titleText:FlxText;

	override public function create()
    {
        super.create();

        titleText = new FlxText(0, 22, 0, "Adventure Haxe", 30);
        titleText.alignment = CENTER;
        titleText.alpha = 0;
        titleText.screenCenter(FlxAxes.X);
        add(titleText);

        textHint = new FlxText(5, FlxG.height - 18, 0, 
            if (FPSState.fpsState == true){
                "Press Left or Right to change | Press Back to return options";
            }else{
                "Press Up or Down to change | Press Enter to select";
            },12);
        textHint.scrollFactor.set();
        add(textHint);
    }
    
    override public function update(elapsed:Float)
    {
        sine += 180 * elapsed;
        titleText.alpha = 1 - Math.sin((Math.PI * sine) / 180);
        
        super.update(elapsed);

        titleText.text = "Adventure Haxe";

        if (FPSState.fpsState == true){
            textHint.text = "Press Left or Right to change | Press Back to return options";
        }else{
            textHint.text = "Press Up or Down to change | Press Enter to select";
        }

        #if desktop
        if (FlxG.keys.justPressed.F){
            FlxG.fullscreen = !FlxG.fullscreen;
            FlxG.save.data.fullscreen = FlxG.fullscreen;
        }
        #end
    }
}