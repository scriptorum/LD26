package ld26.component;

class Layer
{
	public static var FAR:Int = 50;
	public static var MIDDLE:Int = 40;
	public static var NEAR:Int = 30;

	public var layer:Int;

	public function new(layer:Int)
	{
		this.layer = layer;
	}
}