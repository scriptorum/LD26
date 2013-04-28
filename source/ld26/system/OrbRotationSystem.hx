package ld26.system;

import ash.core.Engine;
import ash.core.System;

import ld26.node.TubeNode;
import ld26.service.EntityService;

class OrbRotationSystem extends System
{
	public static var DEGREES_PER_SECOND:Float = 240.0; // Keep this value synched with FiringSystem

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
	 		node.rotation.angle += (time * DEGREES_PER_SECOND);
	 		if(node.rotation.angle > 360)
	 			node.rotation.angle %= 360;
	 	}
	}
}