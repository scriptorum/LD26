package ld26.node;

import ash.core.Node;

import ld26.component.Orb;
import ld26.component.Position;
import ld26.component.Velocity;

class MovingOrbNode extends Node<MovingOrbNode>
{
	public var orb:Orb;
	public var position:Position;
	public var velocity:Velocity;
}
