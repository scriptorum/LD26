package ld26.component;

import nme.geom.Rectangle;
import ld26.component.Tile;
import ld26.component.Subdivision;

class Tile
{
	public var subdivision:Subdivision;
	public var tile:Int;

	public function new(subdivision:Subdivision, tile:Int)
	{
		this.subdivision = subdivision;
		this.tile = tile;
	}

	// Plot X
	public function x(): Int
	{
		return tile % subdivision.width;
	}

	// Plot Y
	public function y(): Int
	{
		return Math.floor(tile / subdivision.width);
	}

	public function rect(): Rectangle
	{
		return new Rectangle(x() * subdivision.plot.width, y() * subdivision.plot.height, 
			subdivision.plot.width, subdivision.plot.height);
	}
}