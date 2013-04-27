/*
 *  Handles real-time movement.
 */
package ld26.system;

import ash.core.Engine;
import ash.core.System;

import ld26.node.TubeNode;
import ld26.service.EntityService;

/*
 * Anything with a GridPosition and a GridVelocity will be touched by this turn-based system.
 * The velocity component is removed by this action bringing it to stop. It's turn-based after all.
 * TODO Rename to TurnMovementSystem
 */
class OrbRotationSystem extends System
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
	 	for(node in engine.getNodeList(TubeNode))
	 	{
	 		node.rotation.angle += (time * 240.0);
	 		if(node.rotation.angle > 360)
	 			node.rotation.angle %= 360;
	 	}
	}
}