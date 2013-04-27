package ld26.component;

import scriptorum.Array2D;

class Grid extends Array2D<Int>
{
	public var changed:Bool = true;

	override public function new(width:Int, height:Int, initValue:Dynamic = 0)
	{
		super(width, height, initValue);
	}

	public function load(str:String, delimiter:String = ",", eol = ";", x:Int = 0, y:Int = 0): Void
	{
		var _x = x;
		var _y = y;
		for(line in scriptorum.Util.split(str, eol))
		{
			for(n in scriptorum.Util.split(line, delimiter))
			{
				if(n != "")
					set(_x++, _y, Std.parseInt(n));
			}
			_y++;
			_x = x;
		}
	}
}