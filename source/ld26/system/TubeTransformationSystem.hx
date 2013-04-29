package ld26.system;

import ash.core.Engine;
import ash.core.System;

import ld26.node.TubeNode;
import ld26.service.EntityService;
import ld26.component.Position;
import ld26.component.Orb;
import ld26.component.Invisible;

class TubeTransformationSystem extends System
{
	public static var DEGREES_PER_SECOND:Float = 240.0; // Keep this value synched with FiringSystem
	public static var SIZE_TO_PIXELS:Float = 0.3;

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

	 		var mainOrbEnt = node.tube.orb;

	 		if(mainOrbEnt == null)
	 		{
	 			if(node.entity.has(Invisible))
	 			{
		 			var selected = ld26.system.FiringSystem.selectOrb(engine, node.tube);
		 			if(selected == null)
		 				continue;
		 			else node.entity.remove(Invisible);
	 			}
	 			else 
	 			{
	 				node.entity.add(Invisible);
	 				continue;
	 			}
	 		}

	 		var mainOrbPos = mainOrbEnt.get(Position);
			var radius = mainOrbEnt.get(Orb).size * SIZE_TO_PIXELS;
			var angle = node.rotation.angle * Math.PI / 180; // deg to rad

			node.position.x	= mainOrbPos.x + radius * Math.cos(angle);
			node.position.y	= mainOrbPos.y + radius * Math.sin(angle);
	 	}
	}
}