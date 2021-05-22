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
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	var screenJustTouched:Bool = false;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'tutorial':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
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
		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
		portraitLeft = new FlxSprite(-2, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(-28, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		box = new FlxSprite(-20, 45);
		}
		if (PlayState.SONG.song.toLowerCase() == 'ugh' || PlayState.SONG.song.toLowerCase() == 'guns')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('tankman');
		portraitLeft.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
	
		box = new FlxSprite(-20, 45);
		}
		if (PlayState.SONG.song.toLowerCase() == 'stress')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('tankman-angry');
		portraitLeft.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
		
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortrait-bruh');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		
		box = new FlxSprite(-20, 45);
		}
		if (PlayState.SONG.song.toLowerCase() == 'headache')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('gardialogue');
		portraitLeft.animation.addByPrefix('enter', 'gar Default instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
			
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
			
		box = new FlxSprite(-20, 45);
		}
		if (PlayState.SONG.song.toLowerCase() == 'nerves')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('gardialogue');
		portraitLeft.animation.addByPrefix('enter', 'gar Nervous Enter instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
				
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
			
		box = new FlxSprite(-20, 45);
			
	    }
		if (PlayState.SONG.song.toLowerCase() == 'release' || PlayState.SONG.song.toLowerCase() == 'fading')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('gardialogue');
		portraitLeft.animation.addByPrefix('enter', 'gar Ghost Enter instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
					
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		
		box = new FlxSprite(-20, 45);
		}
		if (PlayState.SONG.song.toLowerCase() == 'foolhardy' || PlayState.SONG.song.toLowerCase() == 'foolhardy-retrospecter')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('ZardyPort');
		portraitLeft.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
			
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		
		box = new FlxSprite(-20, 45);
		}
		if (PlayState.SONG.song.toLowerCase() == 'parish')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('sarvPort');
		portraitLeft.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
				
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortraitXgf');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
				
		box = new FlxSprite(-20, 45);
		}
		if (PlayState.SONG.song.toLowerCase() == 'worship')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('sarv-angryPort');
		portraitLeft.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
				
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
					
		box = new FlxSprite(-20, 45);
		}
		if (PlayState.SONG.song.toLowerCase() == 'zavodila')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('ruvPort');
		portraitLeft.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
				
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortrait-bruh');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
					
		box = new FlxSprite(-20, 45);
		}
		if (PlayState.SONG.song.toLowerCase() == 'gospel')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('sarvDemonPort');
		portraitLeft.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
					
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortraitXgf');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
					
		box = new FlxSprite(-20, 45);
		}
		if (PlayState.SONG.song.toLowerCase() == 'casanova')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('selPort');
		portraitLeft.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
						
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortraitXgf');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
					
		box = new FlxSprite(-20, 45);
		}
		if (PlayState.SONG.song.toLowerCase() == 'wocky' || PlayState.SONG.song.toLowerCase() == 'beathoven')
		{
		portraitLeft = new FlxSprite(-28, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('kapiPort');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
							
		portraitRight = new FlxSprite(20, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortraitXgf');
		portraitRight.animation.addByPrefix('enter', 'Zardy Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
						
		box = new FlxSprite(-20, 45);
		}
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'ugh':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'guns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'wocky':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
		    case 'beathoven':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'stress':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'speech bubble loud open', 24, false);
				box.animation.addByIndices('normal', 'AHH speech bubble', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'fading':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'parish':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'worship':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'zavodila':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'gospel':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'casanova':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'headache':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'nerves':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'release':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
			    box.height = 200;
			    box.x = -100;
			    box.y = 375;
			case 'foolhardy':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'foolhardy-retrospecter':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
			case 'tutorial':
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
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


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

		for (touch in FlxG.touches.list)
		{
			screenJustTouched = false;
			
			if (touch.justReleased){
				screenJustTouched = true;
			}
		}
			

		if (screenJustTouched || FlxG.keys.justPressed.ANY && dialogueStarted == true)
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
			case 'bf':
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
