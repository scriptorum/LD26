package ld26.render;

import ld26.component.Tile;
import ld26.component.Image;
import nme.geom.Rectangle;

class ImageView extends View
{
	private var tile:Tile;
	private var image:Image;
	private var clip:Rectangle;
	private var gx:Int;
	private var gy:Int;

	override public function begin()
	{
		nodeUpdate();
	}

	private function setTile()
	{
		tile = getComponent(Tile);
		image = getComponent(Image);
		graphic = new com.haxepunk.graphics.Image(image.path, tile.rect());
	}

	private function setImage()
	{
		image = getComponent(Image);
		graphic = new com.haxepunk.graphics.Image(image.path, image.clip);
		clip = image.clip;
	}

	override public function nodeUpdate()
	{
		super.nodeUpdate();

		// Image with Tile
		if(hasComponent(Tile))
		{
			if(this.tile != getComponent(Tile) || this.image != getComponent(Image))
				setTile();
		}

		// Image only
		else
		{
			var nextImage = getComponent(Image);
			if(this.image != nextImage || nextImage.clip != this.clip)
				setImage();
		}
	}
}