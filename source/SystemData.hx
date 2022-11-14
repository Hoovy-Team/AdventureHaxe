package;

import lime.utils.Assets;

using StringTools;

class SystemData
{
    public static inline function stringFile(path:String):String
    {
        var fileAssets:String = Assets.getText(path).trim();
        
        return fileAssets;
    }
}