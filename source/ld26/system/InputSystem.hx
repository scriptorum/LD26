package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Node;
import ash.core.Entity;

import com.haxepunk.utils.Key;

import ld26.node.ControlNode;
import ld26.service.EntityService;
import ld26.service.InputService;
import ld26.component.Firing;

#if profiler
	import ld26.service.ProfileService;
#end

class InputSystem extends System
{
	public var engine:Engine;
	public var factory:EntityService;

	public function new(engine:Engine, factory:EntityService)
	{
		super();
		this.engine = engine;
		this.factory = factory;
	}

	override public function update(_)
	{
		#if profiler
			handleProfileControl();
		#end

		handleFireControl();
	}

#if profiler
	public function handleProfileControl()
	{
	 	for(node in engine.getNodeList(ProfileControlNode))
	 	{
	 		if(InputService.lastKey() == Key.LEFT_SQUARE_BRACKET)
	 		{
	 			ProfileService.dump();
	 			ProfileService.reset();
	 			InputService.clearLastKey();
	 		}
	 	}
	}
#end

	public function handleFireControl()
	{
	 	for(node in engine.getNodeList(FireControlNode))
	 	{
	 		if(InputService.pressed(Key.SPACE))
	 		{
		 		var tube = engine.getEntityByName("tube");
		 		if(!tube.has(Firing))
	 				tube.add(new Firing(nme.Lib.getTimer()));
	 		}
	 		else if(InputService.released(Key.SPACE))
	 		{
		 		var tube = engine.getEntityByName("tube");
		 		if(tube.has(Firing))
	 				tube.get(Firing).end = nme.Lib.getTimer();
	 		}
	 	}
	}
}