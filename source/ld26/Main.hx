package ld26;

import com.haxepunk.Engine;
import com.haxepunk.HXP;
import ld26.service.InputService;
import ld26.world.GameWorld;

class Main extends Engine
{
	private var progress:Int = 0;

	public function new()
	{
		super(600, 600);
	}

	override public function init()
	{
		#if debug
		#if flash
			if (flash.system.Capabilities.isDebugger)
		#end
				HXP.console.enable();
		#end

		InputService.init();
		nextWorld();
	}

	public function nextWorld()
	{
		switch(++progress)
		{
			case 1: HXP.world = new GameWorld();
			default: trace("WTF");
		}
	}

	public static function Main()
	{
		new Main();
	}
}