package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Entity;

import ld26.service.EntityService;
import ld26.node.FiringNode;
import ld26.component.Orb;
import ld26.component.Tube;
import ld26.component.Scale;
import ld26.component.Position;

class SpawningOrbSystem extends System
{
	public static var SIZE_TO_PIXELS:Float = 0.5;
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
			var orbEnt = node.firing.spawningOrb;
			if(orbEnt == null)
				continue;
			var orb = orbEnt.get(Orb);

			// Find the orb this growing orb is paired with
			var srcOrbEnt = node.tube.orb;
			var srcOrb = srcOrbEnt.get(Orb);

			// Leach from the firing orb to the spawning orb
			var leach = node.firing.leachSpeed * time;
			orb.add(leach);
			srcOrb.add(-leach);

			// Now adjust the position of the spawning orb to match the tube's true location
			var srcPos:Position = srcOrbEnt.get(Position);
			var pos:Position = new Position(srcPos.x, srcPos.y);
			var totalSize = orb.size + srcOrb.size;
			var radius = totalSize * SIZE_TO_PIXELS;
			var angle = node.rotation.angle * Math.PI / 180; // deg to rad
			pos.x += radius * Math.cos(angle);
			pos.y += radius * Math.sin(angle);
			
			orbEnt.add(pos);
		}
	}
}