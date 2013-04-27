package ld26.component;

/*
 * This is for changing the transformation point of an Image. It does not change the center point!
 * To do that, use Offset.
 * 
 * Note that HaxePunk's notion of origin really means "transformation and center point." I dunlike.
 */
class Origin
{
	public var x:Float;
	public var y:Float;

	public function new(x:Float, y:Float)
	{
		this.x = x;
		this.y = y;
	}
}