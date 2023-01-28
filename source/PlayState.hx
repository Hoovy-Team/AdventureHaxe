package;

import flixel.util.FlxTimer;
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

	// turn
	var turn:Bool = true;
	var turnText:FlxText;
	
	var buy:Bool = false;

	var health:Float = 3.0; //player health
	var boss_health:Int = 10; // boss health

	var score:Int = 0;
	var textInfo:FlxText;
	var boss_health_text:FlxText;
	// var selectInfo:FlxText;
	// var someText:FlxText;

	override public function create():Void
	{
		super.create();

		playState = true;
		turn = true;

		boss_sprite = new Boss(0, 0, "boss_1");
		boss_sprite.antialiasing = true;
		boss_sprite.screenCenter();
		add(boss_sprite);

		turnText = new FlxText(5, FlxG.height - 44, 0, '', 16);
		turnText.scrollFactor.set();
			if (turn)
			{
				turnText.text = "Player turn";
				turnText.color = FlxColor.WHITE;
			}
			else
			{
				turnText.text = "Boss turn";
				turnText.color = FlxColor.RED;
			}
		add(turnText);

		textInfo = new FlxText(5, FlxG.height - 22, 0, '', 16);
		textInfo.scrollFactor.set();
		add(textInfo);

		boss_health_text = new FlxText(0, 0, 0, "", 16);
		boss_health_text.scrollFactor.set();
		add(boss_health_text);
	}

	override public function update(elapsed:Float)
	{
		var exit = FlxG.keys.justPressed.E;
		var sel_1 = FlxG.keys.justPressed.Q;
		var sel_2 = FlxG.keys.justPressed.W;

		super.update(elapsed);

		textInfo.text = "Health: " + health + " | Score: " + score;
		boss_health_text.text = "Boss Health: " + boss_health;
		
		// temporary battle system
		if (FlxG.mouse.overlaps(boss_sprite) && FlxG.mouse.justPressed && turn && !buy){
			if (boss_sprite != null){
				boss_sprite.animation.play('hurt');
				FlxG.sound.play(Paths.sound('bossdamage.ogg'));
				boss_sprite.animation.finishCallback = function(name:String){
					boss_sprite.animation.play('idle');
				}

				turn = false;
			}
		}

		if (!turn && !buy)
		{
			new FlxTimer().start(1, function(tmr:FlxTimer){
				trace("boss thinging");
				health -= 0.5; //default boss damage
			});

			turnText.text = "Boss turn";
			turnText.color = FlxColor.RED;
			turn = true;
		}
		
		if (turn && FlxG.keys.justPressed.ONE && !buy)
		{
			score += 10;

			turnText.text = "Player turn";
			turnText.color = FlxColor.WHITE;

			boss_sprite.animation.play('hurt');
			FlxG.sound.play(Paths.sound('bossdamage.ogg'));
			boss_health -= 1;
			trace("player fight");
			turn = false;
		}

		// quick shop system
		if (turn && FlxG.keys.justPressed.TWO && !FlxG.keys.justPressed.ONE)
		{
			buy = true;
		}

		if (turn && FlxG.keys.justPressed.TWO && !FlxG.keys.justPressed.ONE)
		{
			turnText.text = "Q: Gain Health - Cost 5 Score | W: Less boss health - Cost 20 Score | E: Exit Buy Mode";
		}
		else if (turn && !FlxG.keys.justPressed.TWO && !FlxG.keys.justPressed.ONE && exit)
		{
			turnText.text = "Player turn";
			turnText.color = FlxColor.WHITE;
		}

		if (sel_1 && buy && turn && !FlxG.keys.justPressed.ONE)
		{
			if (score >= 5)
			{
				score -= 5;
				trace("buy health");
				health += 1.5;
				turnText.color = FlxColor.GREEN;
				new FlxTimer().start(0.5, function(tmr:FlxTimer)
        		{
					turnText.color = FlxColor.WHITE;
				});
			}
			else
			{
				trace("not much money!");
				turnText.color = FlxColor.RED;
				new FlxTimer().start(0.5, function(tmr:FlxTimer)
				{
					turnText.color = FlxColor.WHITE;
				});
			}
		}

		if (exit && buy && turn && !FlxG.keys.justPressed.ONE)
		{
			trace("exit buy mode");
			buy = false;
			turnText.text = "Player turn";
			turnText.color = FlxColor.WHITE;
		}

		if (sel_2 && buy && turn && !FlxG.keys.justPressed.ONE)
		{
			if (score >= 20)
			{
				score -= 20;
				trace("less boss health");
				boss_health -= 1;
				turnText.color = FlxColor.GREEN;
				new FlxTimer().start(0.5, function(tmr:FlxTimer)
        		{
					turnText.color = FlxColor.WHITE;
				});
			}
			else
			{
				trace("not much money!");
				turnText.color = FlxColor.RED;
				new FlxTimer().start(0.5, function(tmr:FlxTimer)
				{
					turnText.color = FlxColor.WHITE;
				});
			}
		}

		if (boss_health == 0)
		{
			trace("winner!");

			FlxG.switchState(new WinnerState());
		}

		if (health == 0)
		{
			trace("lost!");

			FlxG.switchState(new GameOverState());
		}
	}

	override function destroy(){
		playState = false;

		boss_sprite = null;

		super.destroy();
	}
}
