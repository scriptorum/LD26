package ld26.node;

import ash.core.Node;
import ld26.component.Repeating;
import ld26.component.Image;
import ld26.component.Animation;
import ld26.component.Position;
import ld26.component.Grid;
import ld26.component.Tile;
import ld26.component.Subdivision;

class ImageNode extends Node<ImageNode>
{
	public var position:Position;
	public var image:Image;
}

class AnimationNode extends Node<AnimationNode>
{
	public var position:Position;
	public var animation:Animation;
}

class BackdropNode extends Node<BackdropNode>
{
	public var image:Image;
	public var repeating:Repeating;
}

class GridNode extends Node<GridNode>
{
	public var position:Position;
	public var grid:Grid;
	public var image:Image;
	public var subdivision:Subdivision;
}