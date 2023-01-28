package;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;

class Boss extends FlxSprite
{
    var name:String = "boss_1";

    public function new(x:Float, y:Float, name:String = "boss_1")
    {
        super(x, y, name);

        switch(name)
        {
            case "boss_1":
                loadGraphic(Paths.image("boss_1"), true, 32, 32);
                animation.add('idle', [0,1,2,3,4,5,6,7,8,9,10], 24, true);
                animation.add('hurt', [11,12,13,14,15,16,17,18,19,20,21,22], 24, false);
                scale.set(12, 12);
        }
        
        antialiasing = true;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        animation.play("idle");
    }
}