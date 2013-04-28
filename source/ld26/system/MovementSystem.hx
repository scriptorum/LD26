package ld26.system;

import ash.core.Engine;
import ash.core.System;

import ld26.node.MovementNode;
import ld26.service.EntityService;

class MovementSystem extends System
{
	public var factory:EntityService;
	public var engine:Engine;

	public function new(engine:Engine, factory:EntityService)
	{
		super();
		this.engine = engine;
		this.factory = factory;
	}

	override public function update(_)
	{
	 	for(node in engine.getNodeList(MovementNode))
	 	{
	 		node.position.x += node.velocity.x;
	 		node.position.y += node.velocity.y;
	 	}
	}
}