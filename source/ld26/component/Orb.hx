package ld26.component;

class Orb
{
	public var size(default, set_size):Float;
	public var changed:Bool = true;

	public function new(newSize:Float = 256)
	{
		this.size = newSize;
	}

	public function set_size(size:Float): Float
	{
		this.size = size;
		this.changed = true;
		return this.size;
	}
}