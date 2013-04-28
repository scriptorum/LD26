/*
 *  Handles real-time movement.
 */
package ld26.system;

import ash.core.Engine;
import ash.core.System;

import ld26.node.FiringNode;
import ld26.component.Firing;
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
	 		}
	
	 		if(node.firing.end != 0)
	 		{
	 			var elapsed = node.firing.end - node.firing.start;
				node.entity.remove(Firing); 					
	 			if(elapsed < MIN_FIRE_MS)
 				{
 					trace("Switch active orb! Elapsed:" + elapsed);
 				}
 				else
 				{
 					trace("Firing! Elapsed:" + elapsed);
 				}
	 		}
	 	}
	}
}