package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Entity;

import ld26.service.EntityService;
import ld26.node.OrbNode;
import ld26.component.Orb;
import ld26.component.Tube;
import ld26.component.Scale;

class OrbSizingSystem extends System
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
		var tube:Entity = engine.getEntityByName("tube");
		var curOrb:Entity = tube.get(Tube).orb;

	 	for(node in engine.getNodeList(OrbNode))
	 	{
	 		if(!node.orb.changed)
	 			continue;

	 		node.orb.changed = false;
	 		
	 		var size:Float = node.orb.size / 200;
	 		var scale = node.entity.get(Scale);
	 		scale.x = scale.y = size;
	 	}
	}
}