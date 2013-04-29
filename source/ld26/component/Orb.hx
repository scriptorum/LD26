package ld26.component;

class Orb
{
	public static var MIN_SIZE:Float = 20;

	public var size:Float;
	public var changed:Bool = true; // If size changed

	public function new(size:Float = 100)
	{
		this.size = size;
	}

	public function change(size:Float)
	{
		this.size = size;
		this.changed = true;
	}

	public function add(size:Float)
	{
		change(this.size + size);
	}
}