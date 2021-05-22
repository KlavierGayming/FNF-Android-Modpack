package;

import ui.FlxVirtualPad;
import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.math.FlxPoint;

class Config {
    var save:FlxSave;

    public function new() 
    {
        save = new FlxSave();
    	save.bind("saveconrtol");
    }
//downscroll
    public function setdownscroll(?value:Bool):Bool {
		if (save.data.isdownscroll == null) save.data.isdownscroll = false;
		
		save.data.isdownscroll = !save.data.isdownscroll;
		save.flush();
        return save.data.isdownscroll;
	}

    public function getdownscroll():Bool {
        if (save.data.isdownscroll != null) return save.data.isdownscroll;
        return false;
    }

//practice
    public function setpractice(?value:Bool):Bool {
		if (save.data.ispractice == null) save.data.ispractice = false;
		
		save.data.ispractice = !save.data.ispractice;
		save.flush();
        return save.data.ispractice;
	}

    public function getpractice():Bool {
        if (save.data.ispractice != null) return save.data.ispractice;
        return false;
    }

//fc mode
    public function setfcmode(?value:Bool):Bool {
		if (save.data.isfcmode == null) save.data.isfcmode = false;
		
		save.data.isfcmode = !save.data.isfcmode;
		save.flush();
        return save.data.isfcmode;
	}

    public function getfcmode():Bool {
        if (save.data.isfcmode != null) return save.data.isfcmode;
        return false;
    }

    public function getcontrolmode():Int {
        // load control mode num from FlxSave
		if (save.data.buttonsmode != null) return save.data.buttonsmode[0];
        return 0;
    }

    public function setcontrolmode(mode:Int = 0):Int {
        // save control mode num from FlxSave
		if (save.data.buttonsmode == null) save.data.buttonsmode = new Array();
        save.data.buttonsmode[0] = mode;
        save.flush();

        return save.data.buttonsmode[0];
    }

    public function savecustom(_pad:FlxVirtualPad) {
		trace("saved");

		if (save.data.buttons == null)
		{
			save.data.buttons = new Array();

			for (buttons in _pad)
			{
				save.data.buttons.push(FlxPoint.get(buttons.x, buttons.y));
			}
		}else
		{
			var tempCount:Int = 0;
			for (buttons in _pad)
			{
				save.data.buttons[tempCount] = FlxPoint.get(buttons.x, buttons.y);
				tempCount++;
			}
		}
		save.flush();
	}

	public function loadcustom(_pad:FlxVirtualPad):FlxVirtualPad {
		//load pad
		if (save.data.buttons == null) return _pad;
		var tempCount:Int = 0;

		for(buttons in _pad)
		{
			buttons.x = save.data.buttons[tempCount].x;
			buttons.y = save.data.buttons[tempCount].y;
			tempCount++;
		}	
        return _pad;
	}
}