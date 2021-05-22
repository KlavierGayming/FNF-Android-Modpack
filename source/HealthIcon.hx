package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = true;
		animation.add('bf', [0, 1, 30], 2, false, isPlayer);
		animation.add('bf-car', [0, 1, 30], 2, false, isPlayer);
		animation.add('bf-christmas', [0, 1, 30], 2, false, isPlayer);
		animation.add('bf-pixel', [21, 41, 40], 2, false, isPlayer);
		animation.add('spooky', [2, 3, 31], 2, false, isPlayer);
		animation.add('pico', [4, 5, 32], 2, false, isPlayer);
		animation.add('mom', [6, 7, 33], 2, false, isPlayer);
		animation.add('mom-car', [6, 7, 33], 2, false, isPlayer);
		animation.add('tankman', [8, 9, 50], 2, false, isPlayer);
		animation.add('face', [10, 11, 38], 2, false, isPlayer);
		animation.add('dad', [12, 13, 34], 2, false, isPlayer);
		animation.add('senpai', [22, 42, 43], 2, false, isPlayer);
		animation.add('senpai-angry', [44, 45, 46], 2, false, isPlayer);
		animation.add('spirit', [23, 47, 48], 2, false, isPlayer);
		animation.add('bf-old', [14, 15, 39], 2, false, isPlayer);
		animation.add('gf', [16, 49, 36], 2, false, isPlayer);
		animation.add('parents-christmas', [17, 18, 37], 0, false, isPlayer);
		animation.add('monster', [19, 20, 38], 2, false, isPlayer);
		animation.add('monster-christmas', [19, 20, 38], 0, false, isPlayer);
		animation.add('tricky', [26, 27, 53], 2, false, isPlayer);
		animation.add('trickymask', [24, 25, 54], 2, false, isPlayer);
		animation.add('gf-pico', [4, 5, 32], 2, false, isPlayer);
		animation.add('bf-holding-gf', [28, 29, 55], 2, false, isPlayer);
		animation.add('miku', [2, 3], 2, false, isPlayer);
		animation.add('zardy', [12, 13], 2, false, isPlayer);
		animation.add('miku-mad', [4, 5], 2, false, isPlayer);
		animation.add('sarv', [20, 21], 2, false, isPlayer);
		animation.add('sarv-angry', [20, 21], 2, false, isPlayer);
		animation.add('ruv', [22, 23], 2, false, isPlayer);
		animation.add('gacha', [24, 25], 2, false, isPlayer);
		animation.add('garcello', [6, 7], 2, false, isPlayer);
		animation.add('garcellotired', [8, 9], 2, false, isPlayer);
		animation.add('garcellodead', [10, 11], 2, false, isPlayer);
		animation.add('sarv-demon', [42, 43], 2, false, isPlayer);
		animation.add('selever', [44, 45], 2, false, isPlayer);
		animation.add('tord', [14, 15], 2, false, isPlayer);
		animation.add('tordbot', [16, 17], 2, false, isPlayer);
		animation.add('kapi', [36, 37], 2, false, isPlayer);
		animation.add('gameAndWatch', [26, 27], 2, false, isPlayer);
		animation.add('agoti', [47, 48, 49], 2, false, isPlayer);
		animation.add('agoti-crazy', [53, 54, 55], 2, false, isPlayer);

		animation.play(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
