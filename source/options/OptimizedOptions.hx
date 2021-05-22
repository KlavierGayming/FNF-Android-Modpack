package options;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import ui.FlxVirtualPad;
import Config;

import flixel.util.FlxSave;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var insubstate:Bool = false;

	//var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = ['Remove gf: off', 'remove bgs: off', 'optimized character sprites: off', 'About'];
	var _pad:FlxVirtualPad;

	var UP_P:Bool;
	var DOWN_P:Bool;
	var BACK:Bool;
	var ACCEPT:Bool;

	var _saveconrtol:FlxSave;

	var config:Config = new Config();

	// optimization shit vars :RllyCool:
	public var gfdied:Bool = false;
	public var removedbgs:Bool = false;
	public var optichar:Bool = false;

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		//controlsStrings = CoolUtil.coolTextFile('assets/data/controls.txt');
		menuBG.color = FlxColor.fromRGB(68, 11, 99);
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		if (config.getdownscroll()){
			menuItems[menuItems.indexOf('downscroll: off')] = 'downscroll: on';
		}

		if (config.getpractice()){
		    menuItems[menuItems.indexOf('practice: off')] = 'practice: on';
		}

		if (config.getfcmode()){
		    menuItems[menuItems.indexOf('full combo mode: off')] = 'full combo mode: on';
		}

		for (i in 0...menuItems.length)
		{ 
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		_pad = new FlxVirtualPad(UP_DOWN, A_B);
		_pad.alpha = 0.75;
		this.add(_pad);
		
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!insubstate){
			UP_P = _pad.buttonUp.justReleased;
			DOWN_P = _pad.buttonDown.justReleased;

			#if android
			BACK = _pad.buttonB.justPressed || FlxG.android.justReleased.BACK;
			#else
			BACK = _pad.buttonB.justPressed;
			#end
			
			ACCEPT = _pad.buttonA.justReleased;
		}
		
		if (ACCEPT)
		{
			var daSelected:String = menuItems[curSelected];

			switch (daSelected)
			{	
				case "remove gf: on" | "remove gf: off":
					if (gfdied) {
					gfdied = false; }
					else {
					gfdied = true; }
					FlxG.resetState();

				case "remove bgs: on" | "remove bgs: off"
				    if (removedbgs) {
					removedbgs = false; }
					else {
					removedbgs = true; }
					FlxG.resetState();

				case "optimized character sprites: on" | "optimized character sprites: off"
				    if (optichar) {
					optichar = false; }
					else {
					optichar = true; }
					FlxG.resetState();

				case "About":
					FlxG.switchState(new options.AboutState());
			}
		}

		if (isSettingControl)
			waitingInput();
		else
		{
			if (BACK)
				FlxG.switchState(new MainMenuState());
			if (UP_P)
				changeSelection(-1);
			if (DOWN_P)
				changeSelection(1);
		}
	}

	function waitingInput():Void
	{
		if (false)// fix this FlxG.keys.getIsDown().length > 0
		{
			//PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxG.keys.getIsDown()[0].ID, null);
		}
		// PlayerSettings.player1.controls.replaceBinding(Control)
	}

	var isSettingControl:Bool = false;

	function changeBinding():Void
	{
		if (!isSettingControl)
		{
			isSettingControl = true;
		}
	}

	function changeSelection(change:Int = 0)
	{
		/* #if !switch
		NGio.logEvent('Fresh');
		#end
		*/
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
	override function closeSubState()
		{
			insubstate = false;
			super.closeSubState();
		}	
}
