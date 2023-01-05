package;

import lime.utils.Assets;
import flixel.FlxG;

using StringTools;

class SystemData
{
    public static inline function stringFile(path:String):String
    {
        var fileAssets:String = Assets.getText(path).trim();
        
        return fileAssets;
    }
    
    static public function saveG()
    {
        if (FlxG.save.data.fpsG == null){
            FlxG.save.data.fpsG = 60;
        }
    }
}
