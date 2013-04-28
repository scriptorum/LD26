package ld26.node;

import ash.core.Node;

import ld26.component.Radius;
import ld26.component.Position;
import ld26.component.Firework;

class FireworkNode extends Node<FireworkNode>
{
	public var firework:Firework;
	public var position:Position;
	public var radius:Radius;
}
