package;

import lime.utils.Assets;

using StringTools;

class SystemData
{
    public static function stringFile(path:String):String
    {
        var fileAssets:String = Assets.getText(path).trim();
        
        return fileAssets;
    }
}