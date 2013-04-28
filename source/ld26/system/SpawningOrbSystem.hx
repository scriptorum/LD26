package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Entity;

import ld26.service.EntityService;
import ld26.node.FiringNode;
import ld26.component.Orb;
import ld26.component.Tube;
import ld26.component.Scale;

class SpawningOrbSystem extends System
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
		for(node in engine.getNodeList(FiringNode))
		{
			// Find the spawning orb 
			var orb = node.firing.spawningOrb;
			if(orb == null)
				continue;

			// Find the orb this growing orb is paired with
			var sourceOrb = node.tube.orb;

			// Determine how much orb size leach
			var leach = node.firing.leachSpeed * time;

			// Leach from the firing orb to the spawning orb
			orb.get(Orb).add(leach);
			sourceOrb.get(Orb).add(-leach);
			// trace("Source " + sourceOrb.name + " of size " + sourceOrb.get(Orb).size + " leaching " + leach + " to " + 
			// 	orb.name + " of size " + orb.get(Orb).size);
		}
	}
}