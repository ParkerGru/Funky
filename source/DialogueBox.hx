package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitLeftagain:FlxSprite;
	var portraitLeftAGAIN:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'malled':
				FlxG.sound.playMusic(Paths.music('funky_mode', 'shared'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'bananas':
				FlxG.sound.playMusic(Paths.music('funky_mode', 'shared'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);

		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

				case 'malled':
				box = new FlxSprite(0, 40);
				hasDialog = true;
				box.loadGraphic(Paths.image('dia', 'shared'));
				box.animation.add('normalOpen',[0], 24, false);
				box.animation.add('normal', [0], 24);
				box.setPosition();
				box.setGraphicSize(Std.int( box.width * PlayState.daPixelZoom * 1.2));
				PlayState.daPixelZoom = 1;

				case 'bananas':
				box = new FlxSprite(0, 40);
				hasDialog = true;
				box.loadGraphic(Paths.image('dia', 'shared'));
				box.animation.add('normalOpen',[0], 24, false);
				box.animation.add('normal', [0], 24);
				box.setPosition();
				box.setGraphicSize(Std.int( box.width * PlayState.daPixelZoom * 1.2));
				PlayState.daPixelZoom = 1;

				case 'ultra-shortcut':
					box = new FlxSprite(0, 40);
					hasDialog = true;
					box.loadGraphic(Paths.image('dia', 'shared'));
					box.animation.add('normalOpen',[0], 24, false);
					box.animation.add('normal', [0], 24);
					box.setPosition();
					box.setGraphicSize(Std.int( box.width * PlayState.daPixelZoom * 1.2));
					PlayState.daPixelZoom = 1;

		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		portraitLeft = new FlxSprite(62, 40);
		portraitLeft.loadGraphic(Paths.image('FK', 'shared'));
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 1.1));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		portraitLeft.antialiasing = true;
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitLeftagain = new FlxSprite(62, -10);
		portraitLeftagain.loadGraphic(Paths.image('FK_tired', 'shared'));
		portraitLeftagain.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 1.1));
		portraitLeftagain.updateHitbox();
		portraitLeftagain.scrollFactor.set();
		portraitLeftagain.antialiasing = true;
		add(portraitLeftagain);
		portraitLeftagain.visible = false;

		portraitLeftAGAIN = new FlxSprite(77, 42);
		portraitLeftAGAIN.loadGraphic(Paths.image('FK_tired_point', 'shared'));
		portraitLeftAGAIN.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 1.1));
		portraitLeftAGAIN.updateHitbox();
		portraitLeftAGAIN.scrollFactor.set();
		portraitLeftAGAIN.antialiasing = true;
		add(portraitLeftAGAIN);
		portraitLeftAGAIN.visible = false;
		portraitLeftAGAIN.scale.set(1.2, 1.2);

		portraitRight = new FlxSprite(782, 190);
		portraitRight.loadGraphic(Paths.image('BF', 'shared'));
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		portraitRight.antialiasing = true;
		add(portraitRight);
		portraitRight.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);
		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('1_malled', 'shared'), 0.8);

				case 'dad2':
					portraitRight.visible = false;
					if (!portraitLeft.visible)
					{
						portraitLeft.visible = true;
						portraitLeft.animation.play('enter');
					}
					FlxG.sound.play(Paths.sound('2_malled', 'shared'), 0.8);

					case 'dad3':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('3_malled', 'shared'), 0.8);

				case 'dad4':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			    FlxG.sound.play(Paths.sound('4_malled', 'shared'), 0.8);

				case 'dad5':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('5_malled', 'shared'), 0.8);

				case 'dad6':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('6_malled', 'shared'), 0.8);

				case 'dad7':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('7_malled', 'shared'), 0.8);

				case 'dad8':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('8_malled', 'shared'), 0.8);
				case 'dad9':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('9_malled', 'shared'), 0.8);
			/* ______________________________________________________________________________________*/
			case 'dad10':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('1_bananas', 'shared'), 0.8);

				case 'dad11':
					portraitRight.visible = false;
					if (!portraitLeft.visible)
					{
						portraitLeft.visible = true;
						portraitLeft.animation.play('enter');
					}
					FlxG.sound.play(Paths.sound('2_bananas', 'shared'), 0.8);

					case 'dad12':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('3_bananas', 'shared'), 0.8);

				case 'dad13':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			    FlxG.sound.play(Paths.sound('4_bananas', 'shared'), 0.8);

				case 'dad14':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('5_bananas', 'shared'), 0.8);

				case 'dad15':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('6_bananas', 'shared'), 0.8);

				case 'dad16':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('7_bananas', 'shared'), 0.8);

				case 'dad17':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('8_bananas', 'shared'), 0.8);
				case 'dad18':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('9_bananas', 'shared'), 0.8);
				case 'dad19':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('10_bananas', 'shared'), 0.8);
				case 'dad20':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('11_bananas', 'shared'), 0.8);
				/*____________________________________________________________________*/
				case 'dadok':
				portraitRight.visible = false;
				if (!portraitLeftagain.visible)
				{
					portraitLeftagain.visible = true;
					portraitLeftagain.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('1_shortcut', 'shared'), 0.8);

				case 'dadthis':
				portraitRight.visible = false;
				if (!portraitLeftagain.visible)
				{
					portraitLeftagain.visible = true;
					portraitLeftagain.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('2_shortcut', 'shared'), 0.8);

				case 'dadis':
				portraitRight.visible = false;
				portraitLeftagain.visible = false;
				if (!portraitLeftAGAIN.visible)
				{
					portraitLeftAGAIN.visible = true;
					portraitLeftAGAIN.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('3_shortcut', 'shared'), 0.8);

				case 'dadfr':
				portraitRight.visible = false;
				portraitLeftAGAIN.visible = false;
				if (!portraitLeftagain.visible)
				{
					portraitLeftagain.visible = true;
					portraitLeftagain.animation.play('enter');
				}

				
				case 'dadover':
				portraitLeftAGAIN.visible = false;
				portraitRight.visible = false;
				if (!portraitLeftagain.visible)
				{
					portraitLeftagain.visible = true;
					portraitLeftagain.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('4_shortcut', 'shared'), 0.8);

				case 'daddawg':
				portraitRight.visible = false;
				portraitLeftagain.visible = false;
				if (!portraitLeftAGAIN.visible)
				{
					portraitLeftAGAIN.visible = true;
					portraitLeftAGAIN.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('5_shortcut', 'shared'), 0.8);


				case 'dadk':
				portraitRight.visible = false;
				portraitLeftAGAIN.visible = false;
				portraitLeftagain.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				FlxG.sound.play(Paths.sound('6_shortcut', 'shared'), 0.8);


			case 'bf':
				portraitLeftagain.visible = false;
				portraitLeftAGAIN.visible = false;
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');

				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
