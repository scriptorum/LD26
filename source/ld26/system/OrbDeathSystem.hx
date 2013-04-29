package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Entity;

import ld26.service.EntityService;
import ld26.service.SoundService;

import ld26.node.OrbNode;

import ld26.component.Firing;
import ld26.component.Velocity;
import ld26.component.Orb;
import ld26.component.Tile;
import ld26.component.Tube;


class OrbDeathSystem extends System
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
		if(tube.has(Firing))
			return;

	 	for(node in engine.getNodeList(OrbNode))
	 	{
	 		if(node.entity.has(Velocity))
	 			continue;

	 		if(node.orb.size < Orb.MIN_SIZE)
	 		{
	 			node.entity.remove(Orb);
	 			var tile = node.entity.get(Tile);
	 			tile.tile = 1;
	 			node.entity.add(new Tile(tile.subdivision, 1));
	 			SoundService.play(SoundService.ORBDEATH);

	 			if(tube.get(Tube).orb == node.entity)
	 				tube.add(new Tube(null));
	 		}
	 	}
	}
}