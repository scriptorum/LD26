package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Entity;

import ld26.service.EntityService;
import ld26.node.OrbFrictionNode;
import ld26.component.Friction;
import ld26.component.Velocity;

class OrbFrictionSystem extends System
{
	public var factory:EntityService;
	public var engine:Engine;

	public function new(engine:Engine, factory:EntityService)
	{
		super();
		this.engine = engine;
		this.factory = factory;
	}

	override public function update(time:Float)
	{
	 	for(node in engine.getNodeList(OrbFrictionNode))
	 	{
	 		// Stop
	 		if(Math.abs(node.velocity.x) < 1 && Math.abs(node.velocity.y) < 1)
	 		{
	 			factory.addFireControl();
	 			node.entity.remove(Velocity);
	 			node.entity.remove(Friction);
		 		trace("STOP");
	 		}

	 		// Decrease velocity
	 		else
	 		{
	 			var friction = Math.pow(node.friction.amount, time);
	 			node.velocity.x *= friction;
	 			node.velocity.y *= friction;
		 		// trace(node.entity.name + " velocity:" + node.velocity.x + "," + node.velocity.y + " friction:" + friction + " time:" + time);
	 		}
	 	}
	}
}