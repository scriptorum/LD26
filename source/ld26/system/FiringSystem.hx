/*
 *  Handles real-time movement.
 */
package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Entity;

import ld26.node.FiringNode;
import ld26.node.OrbNode;
import ld26.component.Firing;
import ld26.component.Position;
import ld26.component.Tube;
import ld26.component.Orb;
import ld26.component.Scale;
import ld26.service.EntityService;

/*
 * Anything with a GridPosition and a GridVelocity will be touched by this turn-based system.
 * The velocity component is removed by this action bringing it to stop. It's turn-based after all.
 * TODO Rename to TurnMovementSystem
 */
class FiringSystem extends System
{
	public static var MAX_FIRE_MS:Int = 1500;
	public static var MIN_FIRE_MS:Int = 200;

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
	 		// Force fire after max time
	 		if(node.firing.end == 0)
	 		{
		 		var now = nme.Lib.getTimer();
		 		if((now - node.firing.start) >= MAX_FIRE_MS)
		 			node.firing.end = node.firing.start + MAX_FIRE_MS;
		 		else if(node.firing.spawningOrb == null)
		 			spawnNewOrb(node);
	 		}
	
	 		if(node.firing.end != 0)
	 		{
	 			var elapsed = node.firing.end - node.firing.start;
				node.entity.remove(Firing); 					
	 			if(elapsed < MIN_FIRE_MS)
 					selectNextOrb(node);

 				else
 					fireOrb(node);
	 		}
	 	}
	}

	public function fireOrb(node:FiringNode)
	{
		trace("Firing!");
	}

	public function spawnNewOrb(node:FiringNode)
	{
		// var pos = node.tube.orb.get(Position);
		// var spawning = factory.addOrb(pos.x, pos.y, 0);
		var spawning = factory.addOrb(50, 50, 0);
		node.firing.spawningOrb = spawning;
		node.firing.leachSpeed = node.tube.orb.get(Orb).size * 1000 / MAX_FIRE_MS;
	}

	public function selectNextOrb(tubeNode:FiringNode)
	{
		var currentOrb = tubeNode.tube.orb;
		var nextOrb:Entity = null;
		var useNextOrb:Bool = false;
		var cnt = 0;
		for(orbNode in engine.getNodeList(OrbNode))
		{
			if(nextOrb == null)
				nextOrb = orbNode.entity;
			if(useNextOrb)
			{
				nextOrb = orbNode.entity;
				break;
			}
			if(orbNode.entity == currentOrb)
				useNextOrb = true;
		}
		tubeNode.tube.orb = nextOrb;

		// The tube should match the position and scale of the orb
		tubeNode.entity.add(nextOrb.get(Position));
		tubeNode.entity.add(nextOrb.get(Scale));
	}

}