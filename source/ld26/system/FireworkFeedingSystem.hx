package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Entity;
import ash.core.Node;

import nme.geom.Point;

import ld26.service.SoundService;
import ld26.service.EntityService;
import ld26.node.MovingOrbNode;
import ld26.node.FireworkNode;
import ld26.component.Tile;
import ld26.component.Parent;
import ld26.component.Firework;

class FireworkFeedingSystem extends System
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
	 	for(orbNode in engine.getNodeList(MovingOrbNode))
	 	{
	 		var orbRadius = 0;//orbNode.orb.size / 2;
	 		var orbPt = new Point(orbNode.position.x, orbNode.position.y);

		 	for(fwNode in engine.getNodeList(FireworkNode))
		 	{
		 		var range = fwNode.radius.amount + orbRadius;
	 			var fwPt = new Point(fwNode.position.x, fwNode.position.y);

		 		// check position + radius of firework node, see if it overlaps with position + radius of orb
		 		// If so, feed on orb!
		 		var distance = Point.distance(orbPt, fwPt);
		 		if(distance < range)
		 		{
		 			var size = orbNode.orb.size;
		 			var feed = Math.min(size, fwNode.firework.amount);
		 			fwNode.firework.amount -= feed;
		 			orbNode.orb.add(-feed);

		 			// Firework is full!
		 			if(fwNode.firework.amount <= 0)
		 			{
		 				var tile = fwNode.entity.get(Tile);
		 				fwNode.entity.add(new Tile(tile.subdivision, 0));
		 				fwNode.entity.remove(Firework);

		 				if(fwNode.entity.has(Child))
		 				{
		 					engine.removeEntity(fwNode.entity.get(Child).entity);
		 					fwNode.entity.remove(Child);
		 				}

	 					SoundService.play(SoundService.SATISFIED);
		 			}
		 			else SoundService.play(SoundService.EATEN);

	 				if(orbNode.orb.size <= 0) 
	 				{
		 				engine.removeEntity(orbNode.entity);
		 				// tube.add(new Tube(ld26.system.FiringSystem.selectOrb(engine, tube.get(Tube))));

		 				// factory.addFireControl();
	 				}
		 		}

		 	}
	 	}
	}
}