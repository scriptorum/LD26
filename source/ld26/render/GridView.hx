package ld26.render;

import ld26.component.Subdivision;
import ld26.component.Image;
import ld26.component.Grid;

import com.haxepunk.graphics.Tilemap;

//  Should view classes such as this know about nodes?
class GridView extends View
{
	public var tileMap:Tilemap;
	public var tileWidth:Int;
	public var tileHeight:Int;

	override public function begin()	
	{
		var subdivision = getComponent(Subdivision);
		var image = getComponent(Image);
		var grid = getComponent(Grid);

		tileWidth = cast subdivision.plot.width;
		tileHeight = cast subdivision.plot.height;

		// TODO get standard tile dimensions from some other source than the image clipping rectangle??
		tileMap = new Tilemap(image, tileWidth * grid.width, tileHeight * grid.height,
			tileWidth, tileHeight);
		graphic = tileMap;

		// trace("Made a tilemap with tileDim:" + tileWidth + "x" + tileHeight + " gridDim:" + grid.width + "x" + grid.height +
		// 	" image:" + tiledImage.imagePath + " MapDim:" + tileMap.width + "x" + tileMap.height);
	}

	override public function nodeUpdate()
	{
		super.nodeUpdate();
		
		var g = getComponent(Grid);
		if(g.changed)
		{
			for(y in 0...g.height)
			for(x in 0...g.width)
			{
				var t = g.get(x,y);
				if(tileMap.getTile(x,y) != t)
					tileMap.setTile(x, y, g.get(x, y));
			}
			g.changed = false;
		}
	}
}