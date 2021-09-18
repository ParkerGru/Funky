
package;

import flixel.addons.effects.FlxSkewedSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;
import flixel.*;
import haxe.*;
import lime.*;
import openfl.*;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end

using StringTools;

/**
 * note splash particles for sicks!!!
 * detoria wrote the original version of this code (i think. i might be dumb.)
 * cyndaquildac did some fixins hehe.
 * so yeah.
 */
class NoteSplash extends FlxSprite
{
	public function new(?fromNote:Int = 0, x:Float, y:Float)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas('noteSplashes');

		animation.addByPrefix('note0-0', 'note impact 1 purple', 21, false);
		animation.addByPrefix('note0-1', 'note impact 2 purple', 21, false);
		animation.addByPrefix('note1-0', 'note impact 1 blue', 21, false);
		animation.addByPrefix('note1-1', 'note impact 2 blue', 21, false);
		animation.addByPrefix('note2-0', 'note impact 1 green', 21, false);
		animation.addByPrefix('note2-1', 'note impact 2 green', 21, false);
		animation.addByPrefix('note3-0', 'note impact 1 red', 21, false);
		animation.addByPrefix('note3-1', 'note impact 2 red', 21, false);

		setupNoteSplash(fromNote, x, y);
	}

	public function setupNoteSplash(?fromNote:Int = 0, x:Float, y:Float)
	{
		this.x = x;
		this.y = y;

        visible = true;

		alpha = 0.6;

		animation.play("note" + fromNote + "-" + FlxG.random.int(0, 1), true);
		//animation.curAnim.frameRate += Random.int(-2, 2);
		updateHitbox();

		offset.x += 90;
		offset.y += 80;

		//trace('note splash called');
	}

	override function update(elapsed:Float)
    {
        super.update(elapsed);
            if(animation.curAnim.finished)
                {
                    visible = false;
                    kill();
                }
    }
} 