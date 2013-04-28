package ld26.component;

import ash.core.Entity;

class Firing
{
	public var start:Int;
	public var end:Int = 0;
	public var spawningOrb:Entity;
	public var leachSpeed:Float;

	public function new(start:Int)
	{
		this.start = start;
	}
}