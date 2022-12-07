package utils;

class MathUtils
{
    // @MemeHoovy
    // see `https://github.com/lambert2015/asexample/blob/ece36afc42edfffd3b8684bc20e59d4973552840/angle3dhaxe3/src/org/angle3d/texture/TextureUtil.hx`
	inline public static function isPowerOfTwo(value:Int):Bool
	{
		return value != 0 ? ((value & -value) == value) : false;
	}

    // using the pythagorean theorem to make a haxe game, let that sink in
    // see `https://www.codingem.com/pythagorean-theorem-in-python/`
    inline public static function hypotenuse(a:Float, b:Float){
        return Math.sqrt(a * 2 + b * 2);
    }
}