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
import ld26.component.Friction;
import ld26.component.Velocity;
import ld26.service.EntityService;
import ld26.service.SoundService;

/*
 * Anything with a GridPosition and a GridVelocity will be touched by this turn-based system.
 * The velocity component is removed by this action bringing it to stop. It's turn-based after all.
 * TODO Rename to TurnMovementSystem
 */
class FiringSystem extends System
{
	public static var MAX_FIRE_MS:Int = 1500;
	public static var MIN_FIRE_MS:Int = 200;
	public static var MAX_ORB_SIZE:Int = 100;
	public static var MIN_ORB_SIZE:Int = 20;

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
	 		var now = nme.Lib.getTimer();
	 		var elapsed = now - node.firing.start;
	 		if(node.firing.end == 0)
	 		{
		 		if(elapsed >= MAX_FIRE_MS)
		 			node.firing.end = node.firing.start + MAX_FIRE_MS;
	 		}
	
	 		if(node.firing.end != 0)
	 		{
	 			elapsed = node.firing.end - node.firing.start;
				node.entity.remove(Firing); 					
	 			if(elapsed < MIN_FIRE_MS)
 					selectNextOrb(node);

 				else
 					fireOrb(node);
	 		}
	 		else if(node.firing.spawningOrb == null && elapsed >= MIN_FIRE_MS)
		 			spawnNewOrb(node);
	 	}
	}

	public function fireOrb(node:FiringNode)
	{
		// trace("Firing!");
		var orbEnt = node.firing.spawningOrb;
		if(orbEnt == null)
		{
			trace("Firing, but spawning orb not set");
			return;			
		}

		factory.removeFireControl();
		// TODO charging up sound effect
			
		var orb = orbEnt.get(Orb);
		var thrust = (MAX_ORB_SIZE - orb.size) / (MAX_ORB_SIZE - MIN_ORB_SIZE) * 400;
		var angle = node.rotation.angle * Math.PI / 180; // deg to rad
		var velocity = new Velocity(thrust * Math.cos(angle), thrust * Math.sin(angle));		
		orbEnt.add(velocity);
		orbEnt.add(new Friction(.1));

		SoundService.stopAll();
		SoundService.play(SoundService.FIRE);
	}

	public function spawnNewOrb(node:FiringNode)
	{
		SoundService.playRepeat(SoundService.CHARGE);

		var spawningEnt = factory.addOrb(0, 0, 0); // position and scale will be set by a later system
		node.firing.spawningOrb = spawningEnt;
		node.firing.leachSpeed = node.tube.orb.get(Orb).size * 1000 / MAX_FIRE_MS;
		// trace("Spawning! New orb is " + spawningEnt.name);
	}

	public function selectNextOrb(tubeNode:FiringNode)
	{
		var currentOrb = tubeNode.tube.orb;
		var nextOrbEnt:Entity = null;
		var useNextOrb:Bool = false;
		var cnt = 0;
		for(orbNode in engine.getNodeList(OrbNode))
		{
			if(nextOrbEnt == null)
				nextOrbEnt = orbNode.entity;
			if(useNextOrb)
			{
				nextOrbEnt = orbNode.entity;
				break;
			}
			if(orbNode.entity == currentOrb)
				useNextOrb = true;
		}
		tubeNode.tube.orb = nextOrbEnt;
		trace("Selecting! Next orb is " + nextOrbEnt.name);
	}

}