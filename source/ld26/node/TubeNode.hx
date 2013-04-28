package ld26.node;

import ash.core.Node;

import ld26.component.Tube;
import ld26.component.Rotation;
import ld26.component.Position;
import ld26.component.Scale;

class TubeNode extends Node<TubeNode>
{
	public var tube:Tube;
	public var rotation:Rotation;
	public var position:Position;
	public var scale:Scale;
}
