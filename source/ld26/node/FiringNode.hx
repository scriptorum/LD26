package ld26.node;

import ash.core.Node;

import ld26.component.Tube;
import ld26.component.Firing;
import ld26.component.Rotation;

class FiringNode extends Node<FiringNode>
{
	public var tube:Tube;
	public var firing:Firing;
	public var rotation:Rotation;
}
