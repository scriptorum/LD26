package ld26.component;

class Layer
{
	public static var BACK:Int = 60;
	public static var FIREWORK:Int = 50;
	public static var FIREWORK_TEXT:Int = 40;
	public static var TUBE:Int = 30;
	public static var ORB:Int = 20;
	public static var CROSSHAIR:Int = 10;

	public var layer:Int;

	public function new(layer:Int)
	{
		this.layer = layer;
	}
}