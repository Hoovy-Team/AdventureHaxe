package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import Boss;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using StringTools;

class PlayState extends MainCode
{
	public static var playState:Bool;

	var boss_sprite:Boss;

	var health:Int = 3; //player health
	var boss_health:Int = 10; // boss health

	var score:Int = 0;
	var textInfo:FlxText;
	var selectInfo:FlxText;
	var someText:FlxText;

	override public function create():Void
	{
		super.create();

		playState = true;

		boss_sprite = new Boss(0, 0);
		boss_sprite.screenCenter();
		add(boss_sprite);

		textInfo = new FlxText(5, FlxG.height - 22, 0, '', 16);
		textInfo.scrollFactor.set();
		add(textInfo);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		/*if (boss_sprite.animation.curAnim.name == 'hurt' && boss_sprite.animation.finished)
			boss_sprite.animation.play('idle');
		else*/
			boss_sprite.animation.play('idle');

		textInfo.text = "Health: " + health + " | Score: " + score;

		animationsBoss();
	}

	function animationsBoss()
	{
		
	}
}
