package ld26.component;

// Add to an entity as-is to affix the entity's image to the camera's position
class ScrollFactor
{
	public var amount:Float;

	public function new(amount:Float = 0)
	{
		this.amount = amount;
	}
}