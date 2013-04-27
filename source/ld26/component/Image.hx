package ld26.component;

import nme.geom.Rectangle;

class Image
{
	public var path:String;
	public var clip:Rectangle;

	public function new(path:String, clip:Rectangle = null)
	{
		this.path = path;
		this.clip = clip;
	}
}